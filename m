Received: from eggs.gnu.org ([2001:4830:134:3::10]:48297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFiKv-0002gK-Ad
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cFiKr-0003Y9-9h
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:09:13 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:63052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cFiKq-0003Xd-Vh
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:09:09 -0500
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-3-bobby.prani@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b9e2d333-db5c-4d68-c7a8-b518b7e4cbfb@vivier.eu>
Date: Sat, 10 Dec 2016 15:08:54 +0100
MIME-Version: 1.0
In-Reply-To: <20161201051433.17168-3-bobby.prani@gmail.com>
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
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rth@twiddle.net

Le 01/12/2016 à 06:14, Pranith Kumar a écrit :
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

You should not mix coding style update and fix: this hides what it is
done in the patch: one word change. I think checkpatch only requires
changes around the fix.

>         When emulating a target with a larger page-size than the hosts, we
>         may need to truncate file maps at EOF and add extra anonymous pages
>         up to the targets page boundary.  */
>  
> -    if ((qemu_real_host_page_size < TARGET_PAGE_SIZE)
> -        && !(flags & MAP_ANONYMOUS)) {
> -       struct stat sb;
> +    if ((qemu_real_host_page_size < qemu_host_page_size) &&

So it appears to be the fix :)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent
