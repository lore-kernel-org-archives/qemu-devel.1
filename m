Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOkC-0006LV-6i
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOk7-0005JC-9P
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:14:00 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFOk7-0005Ib-0n
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:13:55 -0500
Received: by mail-wm0-f42.google.com with SMTP id t79so33168367wmt.0
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 09:13:54 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-3-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-3-bobby.prani@gmail.com>
Date: Fri, 09 Dec 2016 17:12:52 +0000
Message-ID: <87mvg5xbzf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/19] linux-user: fix tcg/mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> tests/tcg/mmap test fails with values other than default target page
> size. When creating a map beyond EOF, extra anonymous pages are added up
> to the target page boundary. Currently, this operation is performed only
> when qemu_real_host_page_size < TARGET_PAGE_SIZE, but it should be
> performed if the configured page size (qemu -p) is larger than
> qemu_real_host_page_size too.
>
> (also fixes some style issues to please checkpatch)
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

but again doesn't really need to be in this series

> ---
>  linux-user/mmap.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 61685bf..0794a43 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -418,31 +418,32 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>      }
>
>      /* When mapping files into a memory area larger than the file, accesses
> -       to pages beyond the file size will cause a SIGBUS.
> +       to pages beyond the file size will cause a SIGBUS.
>
>         For example, if mmaping a file of 100 bytes on a host with 4K pages
>         emulating a target with 8K pages, the target expects to be able to
>         access the first 8K. But the host will trap us on any access beyond
> -       4K.
> +       4K.
>
>         When emulating a target with a larger page-size than the hosts, we
>         may need to truncate file maps at EOF and add extra anonymous pages
>         up to the targets page boundary.  */
>
> -    if ((qemu_real_host_page_size < TARGET_PAGE_SIZE)
> -        && !(flags & MAP_ANONYMOUS)) {
> -       struct stat sb;
> +    if ((qemu_real_host_page_size < qemu_host_page_size) &&
> +        !(flags & MAP_ANONYMOUS)) {
> +        struct stat sb;
>
> -       if (fstat (fd, &sb) == -1)
> -           goto fail;
> +        if (fstat(fd, &sb) == -1) {
> +            goto fail;
> +        }
>
>         /* Are we trying to create a map beyond EOF?.  */
> -       if (offset + len > sb.st_size) {
> -           /* If so, truncate the file map at eof aligned with
> -              the hosts real pagesize. Additional anonymous maps
> -              will be created beyond EOF.  */
> -           len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
> -       }
> +        if (offset + len > sb.st_size) {
> +            /* If so, truncate the file map at eof aligned with
> +               the hosts real pagesize. Additional anonymous maps
> +               will be created beyond EOF.  */
> +            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
> +        }
>      }
>
>      if (!(flags & MAP_FIXED)) {


--
Alex Bennée
