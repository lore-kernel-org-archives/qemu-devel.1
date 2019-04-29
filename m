Received: from eggs.gnu.org ([209.51.188.92]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8yD-0006QE-P6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8yB-00029n-HB
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:33 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8y6-0001n6-L9
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:17:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id v23so8606795oif.8
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 09:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-4-richard.henderson@linaro.org>
In-Reply-To: <20190330005900.17282-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:17:01 +0100
Message-ID: <CAFEAcA-3qrQXk9iMY_9VZSLzdnn=EzzYOqhe61UQKYn-w__3Zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-user: Parse
 NT_GNU_PROPERTY_TYPE_0 notes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On Sat, 30 Mar 2019 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
> which indicates that the image should be mapped with guarded pages.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 79 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 11 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..12ee96e5d4 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -116,6 +116,10 @@ typedef abi_uint        target_gid_t;
>  #endif
>  typedef abi_int         target_pid_t;
>
> +
> +#define TARGET_NT_GNU_PROPERTY_TYPE_0  5
> +
> +
>  #ifdef TARGET_I386
>
>  #define ELF_PLATFORM get_elf_platform()
> @@ -543,6 +547,10 @@ static const char *get_elf_platform(void)
>  # define ELF_PLATFORM    "aarch64"
>  #endif
>
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_AND  0xc0000000
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_BTI  (1u << 0)
> +#define TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_PAC  (1u << 1)
> +
>  static inline void init_thread(struct target_pt_regs *regs,
>                                 struct image_info *infop)
>  {
> @@ -2252,7 +2260,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>      struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
>      struct elf_phdr *phdr;
>      abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
> -    int i, retval;
> +    int i, retval, prot_exec = PROT_EXEC;
>      const char *errmsg;
>
>      /* First of all, some simple consistency checks */
> @@ -2287,17 +2295,66 @@ static void load_elf_image(const char *image_name, int image_fd,
>      loaddr = -1, hiaddr = 0;
>      info->alignment = 0;
>      for (i = 0; i < ehdr->e_phnum; ++i) {
> -        if (phdr[i].p_type == PT_LOAD) {
> -            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
> -            if (a < loaddr) {
> -                loaddr = a;
> +        struct elf_phdr *eppnt = phdr + i;
> +
> +        switch (eppnt->p_type) {
> +        case PT_LOAD:
> +            {

I think you have an extra layer of indent here that we usually
don't do for switch statement cases.


> +#ifdef BSWAP_NEEDED
> +                for (i = 0; i < ARRAY_SIZE(note); ++i) {
> +                    bswap32s(note + i);
> +                }
> +#endif
> +#ifdef HOST_WORDS_BIGENDIAN
> +                gnu0 = 'G' << 24 | 'N' << 16 | 'U' << 8;
> +#else
> +                gnu0 = 'G' | 'N' << 8 | 'U' << 16;
> +#endif

#define GNU0_MAGIC const_le32('G' | 'N' << 8 | 'U' << 16)

and then you can avoid the #ifdef HOST_WORDS_BIGENDIAN?

> +
> +                if (note[0] != 4 ||     /* namesz */
> +                    note[1] < 12 ||     /* descsz -- may include padding */
> +                    note[2] != TARGET_NT_GNU_PROPERTY_TYPE_0 ||  /* type */
> +                    note[3] != gnu0) {  /* name */
> +                    break;
> +                }
> +#ifdef TARGET_AARCH64
> +                if (note[4] == TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
> +                    note[5] == 4 &&
> +                    (note[6] & TARGET_GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> +                    prot_exec |= TARGET_PROT_BTI;
> +                }
> +#endif
>              }
> -            ++info->nsegs;
> -            info->alignment |= phdr[i].p_align;
> +            break;
>          }
>      }
>
> @@ -2359,7 +2416,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>
>              if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
>              if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
> -            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
> +            if (eppnt->p_flags & PF_X) elf_prot |= prot_exec;
>
>              vaddr = load_bias + eppnt->p_vaddr;
>              vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
> --
> 2.17.1

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
