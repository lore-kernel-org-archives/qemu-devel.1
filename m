Received: from eggs.gnu.org ([209.51.188.92]:39446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWfr-0001DO-R6
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMWfq-0003T5-O1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:19 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMWfq-0003ST-IK
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:48:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id l1so4197393oib.0
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 04:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190418153631.rl3lgadzrqqof72p@debian>
In-Reply-To: <20190418153631.rl3lgadzrqqof72p@debian>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 12:48:06 +0100
Message-ID: <CAFEAcA_MfK0i0QUq0V_e8hz+gHQv5Fx8yq7_OtWg0_ZE+tdV1Q@mail.gmail.com>
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
To: Giuseppe Musacchio <thatlemon@gmail.com>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 18 Apr 2019 at 17:46, Giuseppe Musacchio <thatlemon@gmail.com> wrote:
>
> Some PT_LOAD sections may be completely zeroed out and their p_filesize
> is zero, in that case the loader should just allocate a page that's at
> least p_memsz bytes large (plus eventual alignment padding).

Thanks for this patch -- codewise it looks good, so I just have
a couple of minor tweaks I think we should make to the comment
and commit message:

The things we're iterating through here are segments, not
sections (an ELF section is a different sort of data structure):
could you fix the text in your commit message and comment, please?

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

Our coding style says that multi-line comments should be
 /*
  * like this, with the start and
  * end markers on lines of their own
  */

(if you run your patch through scripts/checkpatch.pl it ought
to detect this sort of minor coding style nit).

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

Other than those minor things:
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

so if you fix them and send out a v2 patch you can include
my Reviewed-by: tag in the commit message (under your
signed-off-by) in that patch email.

thanks
-- PMM
