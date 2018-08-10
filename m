Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fo4my-0000cG-7A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fo4mt-00084v-O3
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:37:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fo4mt-00084f-HY
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:36:55 -0400
Date: Fri, 10 Aug 2018 11:36:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180810103650.GA2391@work-vm>
References: <cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

* Simon Ruderich (simon@ruderich.org) wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
> 
>     I found this could be useful to have qemu-softmmu as a cross
>     debugger (launch with -s -S command line option), then if we can
>     have a command to load guest physical memory, we can use cross gdb
>     to do some target debug which gdb cannot do directly.
> 
> pmemload is necessary to directly write physical memory which is not
> possible with gdb alone as it uses only logical addresses.
> 
> The QAPI for pmemload uses "val" as parameter name for the physical
> address. This name is not very descriptive but is consistent with the
> existing pmemsave. Changing the parameter name of pmemsave is not
> possible without breaking the existing API.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html
> 
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  cpus.c          | 41 +++++++++++++++++++++++++++++++++++++++++
>  hmp-commands.hx | 14 ++++++++++++++
>  hmp.c           | 12 ++++++++++++
>  hmp.h           |  1 +
>  qapi/misc.json  | 20 ++++++++++++++++++++
>  5 files changed, 88 insertions(+)
> 
> diff --git a/cpus.c b/cpus.c
> index 49d4d44916..9b105336af 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2367,6 +2367,47 @@ exit:
>      qemu_close(fd);
>  }
>  
> +void qmp_pmemload(int64_t addr, int64_t size, int64_t offset,
> +                  const char *filename, Error **errp)
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
> +    if (offset > 0) {
> +        if (lseek(fd, offset, SEEK_SET) != offset) {
> +            error_setg_errno(errp, errno,
> +                             "could not seek to offset %" PRIx64, offset);
> +            goto exit;
> +        }
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
> +        }
> +        l = r; /* in case of short read */
> +        cpu_physical_memory_write(addr, buf, l);
> +        addr += l;
> +        size -= l;
> +    }
> +
> +exit:
> +    qemu_close(fd);
> +}
> +
>  void qmp_inject_nmi(Error **errp)
>  {
>      nmi_monitor_handle(monitor_get_cpu_index(), errp);
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 0734fea931..84647c7c1d 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -822,6 +822,20 @@ STEXI
>  @item pmemsave @var{addr} @var{size} @var{file}
>  @findex pmemsave
>  save to disk physical memory dump starting at @var{addr} of size @var{size}.
> +ETEXI
> +
> +    {
> +        .name       = "pmemload",
> +        .args_type  = "val:l,size:i,offset:i,filename:s",
> +        .params     = "addr size offset file",
> +        .help       = "load from disk physical memory dump starting at 'addr' of size 'size' at file offset 'offset'",
> +        .cmd        = hmp_pmemload,
> +    },
> +

I'm guessing that size and offset should be 'l' to allow large
sizes and offsets, and there's an 'F' type for filenames
(see monitor.c which has a big comment table near the start).

Also, had you considered rearranging and making them optional,
for example if you do:

val:l,filename:F,offset:i?,size:i?

I think that would mean you can do the fairly obvious:
  pmemload addr "myfile"

with the assumption that loads the whole file.

Dave

> +STEXI
> +@item pmemload @var{addr} @var{size} @var{offset} @var{file}
> +@findex pmemload
> +load from disk physical memory dump starting at @var{addr} of size @var{size} at file offset @var{offset}.
>  ETEXI
>  
>      {
> diff --git a/hmp.c b/hmp.c
> index a4d28913bb..b85c943b63 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1105,6 +1105,18 @@ void hmp_pmemsave(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +void hmp_pmemload(Monitor *mon, const QDict *qdict)
> +{
> +    uint64_t size = qdict_get_int(qdict, "size");
> +    uint64_t offset = qdict_get_int(qdict, "offset");
> +    const char *filename = qdict_get_str(qdict, "filename");
> +    uint64_t addr = qdict_get_int(qdict, "val");
> +    Error *err = NULL;
> +
> +    qmp_pmemload(addr, size, offset, filename, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict)
>  {
>      const char *chardev = qdict_get_str(qdict, "device");
> diff --git a/hmp.h b/hmp.h
> index 20f27439d3..31767ea4a8 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -47,6 +47,7 @@ void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_cpu(Monitor *mon, const QDict *qdict);
>  void hmp_memsave(Monitor *mon, const QDict *qdict);
>  void hmp_pmemsave(Monitor *mon, const QDict *qdict);
> +void hmp_pmemload(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_write(Monitor *mon, const QDict *qdict);
>  void hmp_ringbuf_read(Monitor *mon, const QDict *qdict);
>  void hmp_cont(Monitor *mon, const QDict *qdict);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index f5988cc0b5..b4c0065b02 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -1219,6 +1219,26 @@
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
> +# @size: the size of memory region to load
> +#
> +# @offset: the offset in the file to start from
> +#
> +# @filename: the file to load the memory from as binary data
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.13
> +##
> +{ 'command': 'pmemload',
> +  'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'} }
> +
>  ##
>  # @cont:
>  #
> -- 
> 2.15.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
