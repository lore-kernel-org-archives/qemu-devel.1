Received: from eggs.gnu.org ([209.51.188.92]:50017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMVSU-0002gA-45
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thatlemon@gmail.com>) id 1hMVSS-0004bK-Au
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:30:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <thatlemon@gmail.com>) id 1hMVSS-0004YK-4C
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:30:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id b67so8531855wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 03:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190418153631.rl3lgadzrqqof72p@debian>
In-Reply-To: <20190418153631.rl3lgadzrqqof72p@debian>
From: Giuseppe Musacchio <thatlemon@gmail.com>
Date: Fri, 3 May 2019 12:29:42 +0200
Message-ID: <CA+pVVBLt4t3dzmE9fgMzWVM4mbuepVyK6ggog8c+QHbtB=Q4Dg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: elf: Map empty PT_LOAD sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

Friendly inactivity ping.

On Thu, 18 Apr 2019 at 17:42, Giuseppe Musacchio <thatlemon@gmail.com> wrote:
>
> Some PT_LOAD sections may be completely zeroed out and their p_filesize
> is zero, in that case the loader should just allocate a page that's at
> least p_memsz bytes large (plus eventual alignment padding).
>
> Calling zero_bss does this job for us, all we have to do is make sure we
> don't try to mmap a zero-length page.
>
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  linux-user/elfload.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a2602..e9a0951 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2366,11 +2366,17 @@ static void load_elf_image(const char *image_name, int image_fd,
>              vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
>              vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
>
> -            error = target_mmap(vaddr_ps, vaddr_len,
> -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
> -                                image_fd, eppnt->p_offset - vaddr_po);
> -            if (error == -1) {
> -                goto exit_perror;
> +            /* Some sections may be completely empty without any backing file
> +             * segment, in that case just let zero_bss allocate an empty buffer
> +             * for it. */
> +            if (eppnt->p_filesz != 0) {
> +                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
> +                                    MAP_PRIVATE | MAP_FIXED,
> +                                    image_fd, eppnt->p_offset - vaddr_po);
> +
> +                if (error == -1) {
> +                    goto exit_perror;
> +                }
>              }
>
>              vaddr_ef = vaddr + eppnt->p_filesz;
> --
> 2.20.1
>
