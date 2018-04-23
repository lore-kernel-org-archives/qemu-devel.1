Received: from eggs.gnu.org ([2001:4830:134:3::10]:46874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAaPX-0003Px-P2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:17:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAaPR-0006YE-Ub
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:17:35 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42432)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAaPR-0006Xw-OT
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:17:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id t27-v6so14007270oij.9
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:17:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423075215.4572-3-christophe.lyon@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-3-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 13:17:08 +0100
Message-ID: <CAFEAcA9tnh9j=QMxZm7RTMzaRVxh10oEGDCYYO5TL5TvAuvLXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 2/4] linux-user: ARM-FDPIC: Identify
 ARM FDPIC binaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 08:51, Christophe Lyon <christophe.lyon@st.com> wrote:
> Define an ARM-specific version of elf_is_fdpic:
> FDPIC ELF objects are identified with e_ident[EI_OSABI] =3D=3D
> ELFOSABI_ARM_FDPIC.
>
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>
> diff --git a/include/elf.h b/include/elf.h
> index c0dc9bb..934dbbd 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -1483,6 +1483,7 @@ typedef struct elf64_shdr {
>  #define ELFOSABI_TRU64          10      /* Compaq TRU64 UNIX.  */
>  #define ELFOSABI_MODESTO        11      /* Novell Modesto.  */
>  #define ELFOSABI_OPENBSD        12      /* OpenBSD.  */
> +#define ELFOSABI_ARM_FDPIC      65      /* ARM FDPIC */
>  #define ELFOSABI_ARM            97      /* ARM */
>  #define ELFOSABI_STANDALONE     255     /* Standalone (embedded) applica=
tion */
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index bbe93b0..76d7718 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1681,11 +1681,18 @@ static void zero_bss(abi_ulong elf_bss, abi_ulong=
 last_bss, int prot)
>      }
>  }
>
> +#ifdef TARGET_ARM
> +static int elf_is_fdpic(struct elfhdr *exec)
> +{
> +    return exec->e_ident[EI_OSABI] =3D=3D ELFOSABI_ARM_FDPIC;
> +}
> +#else
>  /* Default implementation, always false.  */
>  static int elf_is_fdpic(struct elfhdr *exec)
>  {
>      return 0;
>  }
> +#endif

I have a strong dislike for per-target ifdef ladders. Can we instead
put the target's implementation of elf_is_fdpic() into
linux-user/$ARCH/target_elf.h
and also have that header do
#define TARGET_HAS_ELF_FDPIC

and then in the generic code we can protect the default elf_is_fdpic()
with #ifndef TARGET_HAS_ELF_FDPIC.

thanks
-- PMM
