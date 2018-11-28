Received: from eggs.gnu.org ([2001:4830:134:3::10]:36860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRz5y-0007Ga-09
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRz5u-0001f1-Pe
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:37:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gRz5u-0001aA-Hr
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 07:37:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1542290622.git.simon@ruderich.org>
	<0e061333411f8e64a6e53f14c4c067e5e3e1c91e.1542290622.git.simon@ruderich.org>
Date: Wed, 28 Nov 2018 13:37:22 +0100
In-Reply-To: <0e061333411f8e64a6e53f14c4c067e5e3e1c91e.1542290622.git.simon@ruderich.org>
	(Simon Ruderich's message of "Thu, 15 Nov 2018 15:07:17 +0100")
Message-ID: <87r2f5fke5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 6/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Simon Ruderich <simon@ruderich.org> writes:

> Adapted patch from Baojun Wang [1] with the following commit message:
>
>     I found this could be useful to have qemu-softmmu as a cross
>     debugger (launch with -s -S command line option), then if we can
>     have a command to load guest physical memory, we can use cross gdb
>     to do some target debug which gdb cannot do directly.
>
> This patch contains only the qmp changes of the original patch.
>
> pmemload is necessary to directly write physical memory which is not
> possible with gdb alone as it uses only logical addresses.
>
> The QAPI for pmemload uses "val" as parameter name for the physical
> address. This name is not very descriptive but is consistent with the
> existing pmemsave. Changing the parameter name of pmemsave is not
> possible without breaking the existing API.

As much as I dislike the name "val" for a base address, I agree with you
to prioritize consistency.

> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html
>
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  cpus.c         | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json | 20 ++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/cpus.c b/cpus.c
> index ee54595733..b80f331596 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2445,6 +2445,61 @@ exit:
>      qemu_close(fd);
>  }
>  
> +void qmp_pmemload(int64_t addr, const char *filename,

I first parameter is called @val in the schema, and @addr here.  I hate
that, but it also matches memsave.

> +                  bool has_size, int64_t size,
> +                  bool has_offset, int64_t offset,
> +                  Error **errp)
> +{
> +    int fd;
> +    size_t l;
> +    ssize_t r;
> +    uint8_t buf[1024];
> +
> +    fd = qemu_open(filename, O_RDONLY | O_BINARY);
> +    if (fd < 0) {
> +        error_setg_file_open(errp, errno, filename);
> +        return;
> +    }
> +    if (has_offset && offset > 0) {
> +        if (lseek(fd, offset, SEEK_SET) != offset) {
> +            error_setg_errno(errp, errno,
> +                             "could not seek to offset %" PRIx64, offset);

I think the value of @filename is more interesting than the value of
@offset here.

> +            goto exit;
> +        }
> +    }
> +    if (!has_size) {
> +        struct stat s;
> +        if (fstat(fd, &s)) {
> +            error_setg_errno(errp, errno, "could not fstat fd to get size");
> +            goto exit;
> +        }

TOCTTOU: the size can change while you read the file.  I figure nothing
truly terrible can happen here that way, but it does set a bad example.

> +        if (S_ISCHR(s.st_mode) || S_ISBLK(s.st_mode)) {
> +            error_setg(errp, "pmemload doesn't support char/block devices");
> +            goto exit;
> +        }

Any particular reason for rejecting character and block devices when
@size is absent, yet accepting them when @size is present?

> +        size = s.st_size;
> +    }
> +
> +    while (size != 0) {
> +        l = sizeof(buf);
> +        if (l > size) {
> +            l = size;
> +        }
> +        r = read(fd, buf, l);
> +        if (r <= 0) {
> +            error_setg(errp, QERR_IO_ERROR);
> +            goto exit;

Please avoid the QERR_ macros, as requested by qerror.h.

Two ways to get r == 0:

* If has_size: the file is shorter than the user's size value.

* If !has_size: the file has shrunk since fstat().

In both cases, reporting an I/O error is not nice.

> +        }
> +        l = r; /* in case of short read */
> +        cpu_physical_memory_write(addr, buf, l);
> +        addr += l;
> +        size -= l;
> +    }

This reads and copies in chunks of at most 1KiB.  Feels rather small.  I
figure 4KiB would still be conservative enough, and at least matches
common page and block sizes.  Paolo, what do you think?

> +
> +exit:
> +    qemu_close(fd);
> +}
> +

Here's my (compile-tested) attempt to sidestep TOCTTOU:

    int fd;
    uint64_t limit, ofs;
    ssize_t n;
    uint8_t buf[4096];

    fd = qemu_open(filename, O_RDONLY | O_BINARY);
    if (fd < 0) {
        error_setg_file_open(errp, errno, filename);
        return;
    }

    if (has_offset && offset > 0) {
        if (lseek(fd, offset, SEEK_SET) != offset) {
            error_setg_errno(errp, errno, "could not seek '%s'", filename);
            goto exit;
        }
    }

    limit = has_size ? size : UINT64_MAX;
    ofs = 0;
    while (ofs < limit) {
        n = MIN(sizeof(buf), limit - ofs);
        n = read(fd, buf, n);
        if (n < 0) {
            error_setg_errno(errp, errno, "could not read from '%s'",
                             filename);
            goto exit;
        }
        if (n == 0) {
            break;
        }
        cpu_physical_memory_write(addr + ofs, buf, n);
        ofs += n;
    }

exit:
    qemu_close(fd);

Note that this *silently* reads less than @size when the file isn't big
enough.  If we decide that's what we want, then the command's contract
in misc.json has to be updated accordingly.

If it isn't, we can turn the break into an error_setg(); goto exit.  Not
terribly satisfying, since we already changed the physical memory.

>  void qmp_inject_nmi(Error **errp)
>  {
>      nmi_monitor_handle(monitor_get_cpu_index(), errp);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6c1c5c0a37..e4f39e31e5 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1186,6 +1186,26 @@
>  { 'command': 'pmemsave',
>    'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>  
> +##
> +# @pmemload:
> +#
> +# Load a portion of guest physical memory from a file.
> +#
> +# @val: the physical address of the guest to start from
> +#
> +# @filename: the file to load the memory from as binary data
> +#
> +# @size: the size of memory region to load (defaults to whole file)
> +#
> +# @offset: the offset in the file to start from (defaults to 0)
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 4.0
> +##
> +{ 'command': 'pmemload',
> +  'data': {'val': 'int', 'filename': 'str', '*size': 'int', '*offset': 'int'} }
> +
>  ##
>  # @cont:
>  #

Using 'int' for a physical address is problematic, because it requires
users to express the upper half of the 64-bit address space as negative
numbers.  I started to fix up these things some time ago, but got stuck.
Here's the relevant part:

    Message-ID: <87fud26pfi.fsf@dusky.pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01114.html

Perhaps we should cherry-pick just that patch from the series into this
series, with the format string bug David pointed out fixed.

@offset and @size feel a bit like overengineering to me.  If this work
was still at the design stage, I'd advise to start without them, then
see whether there's a genuine need.  At v5, I'm li
