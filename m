Received: from eggs.gnu.org ([2001:4830:134:3::10]:35871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70JF-0000Fh-92
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70JE-0000ib-9l
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:08:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70JE-0000hB-3z
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:08:16 -0400
Received: by mail-oi0-x243.google.com with SMTP id l190-v6so8656448oig.9
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:08:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406151752.10854-3-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-3-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:07:55 +0100
Message-ID: <CAFEAcA9uRijXvB=zZpoqVP39DSh8QNtghRgf6AYfQTk4+JoBog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC 2/4] linux-user: ARM-FDPIC: Add support
 of FDPIC for ARM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
> Add FDPIC info into image_info structure since interpreter info is on
> stack and needs to be saved to be accessed later on.
>
> Co-Authored-By:  Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 7ba3795..363da67 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -287,6 +287,23 @@ static inline void init_thread(struct target_pt_regs=
 *regs,
>      /* For uClinux PIC binaries.  */
>      /* XXX: Linux does this only on ARM with no MMU (do we care ?) */
>      regs->uregs[10] =3D infop->start_data;
> +#ifdef CONFIG_USE_FDPIC
> +    /* Support ARM FDPIC.  */
> +    /* As described in the ABI document, r7 points to the loadmap info
> +     * prepared by the kernel. If an interpreter is needed, r8 points
> +     * to the interpreter loadmap and r9 points to the interpreter
> +     * PT_DYNAMIC info. If no interpreter is needed, r8 is zer0, and
> +     * r9 points to the main program PT_DYNAMIC info.  */
> +    regs->uregs[7] =3D infop->loadmap_addr;
> +    if (infop->interpreter_loadmap_addr) {
> +        /* Executable is dynamically loaded.  */
> +        regs->uregs[8] =3D infop->interpreter_loadmap_addr;
> +        regs->uregs[9] =3D infop->interpreter_pt_dynamic_addr;
> +    } else {
> +        regs->uregs[8] =3D 0;
> +        regs->uregs[9] =3D infop->pt_dynamic_addr;
> +    }

Is it really correct to set these registers always, and not only if
this is an FDPIC ELF ?

> +#endif
>  }

>  int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 19a0c03..90c8ee1 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -629,6 +629,12 @@ typedef struct CPUARMState {
>      const struct arm_boot_info *boot_info;
>      /* Store GICv3CPUState to access from this struct */
>      void *gicv3state;
> +
> +#if defined(CONFIG_USER_ONLY) && defined(CONFIG_USE_FDPIC)
> +    /* We need to know if we have an FDPIC binary to adapt signal
> +     * syscalls.  */
> +    int is_fdpic;

linux-user specific information shouldn't live in CPUARMState;
put it in the TaskState struct instead, perhaps.

> +#endif
>  } CPUARMState;
>
>  /**

thanks
-- PMM
