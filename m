Received: from eggs.gnu.org ([2001:4830:134:3::10]:58211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXVcJ-0004GA-Al
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXVcH-0000WF-Sq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:44:59 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1500395194-21455-3-git-send-email-peter.maydell@linaro.org>
References: <1500395194-21455-1-git-send-email-peter.maydell@linaro.org>
	<1500395194-21455-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 13:44:53 -0300
Message-ID: <CAAdtpL4d7F+rAWQuw2hvbTK6vEwr_VDB5xn+PWTJnBWRQzzd-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.10 2/4]
 bsd-user/elfload.c: Fix set-but-not-used warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, patches@linaro.org

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Le 18 juil. 2017 1:32 PM, "Peter Maydell" <peter.maydell@linaro.org> a
=C3=A9crit :

> Fix various warnings about set-but-not-used variables on OpenBSD:
>
> bsd-user/elfload.c:1158:15: warning: variable 'mapped_addr' set but not
> used [-Wunused-but-set-variable]
> bsd-user/elfload.c:1165:9: warning: variable 'status' set but not used
> [-Wunused-but-set-variable]
> bsd-user/elfload.c:1168:15: warning: variable 'elf_stack' set but not use=
d
> [-Wunused-but-set-variable]
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  bsd-user/elfload.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> index 41a1309..7cccf3e 100644
> --- a/bsd-user/elfload.c
> +++ b/bsd-user/elfload.c
> @@ -1155,21 +1155,20 @@ int load_elf_binary(struct linux_binprm * bprm,
> struct target_pt_regs * regs,
>      unsigned int interpreter_type =3D INTERPRETER_NONE;
>      unsigned char ibcs2_interpreter;
>      int i;
> -    abi_ulong mapped_addr;
>      struct elf_phdr * elf_ppnt;
>      struct elf_phdr *elf_phdata;
>      abi_ulong elf_bss, k, elf_brk;
>      int retval;
>      char * elf_interpreter;
>      abi_ulong elf_entry, interp_load_addr =3D 0;
> -    int status;
>      abi_ulong start_code, end_code, start_data, end_data;
>      abi_ulong reloc_func_desc =3D 0;
> -    abi_ulong elf_stack;
> +#ifdef LOW_ELF_STACK
> +    abi_ulong elf_stack =3D ~((abi_ulong)0UL);
> +#endif
>      char passed_fileno[6];
>
>      ibcs2_interpreter =3D 0;
> -    status =3D 0;
>      load_addr =3D 0;
>      load_bias =3D 0;
>      elf_ex =3D *((struct elfhdr *) bprm->buf);          /* exec-header *=
/
> @@ -1221,7 +1220,6 @@ int load_elf_binary(struct linux_binprm * bprm,
> struct target_pt_regs * regs,
>      elf_brk =3D 0;
>
>
> -    elf_stack =3D ~((abi_ulong)0UL);
>      elf_interpreter =3D NULL;
>      start_code =3D ~((abi_ulong)0UL);
>      end_code =3D 0;
> @@ -1546,7 +1544,7 @@ int load_elf_binary(struct linux_binprm * bprm,
> struct target_pt_regs * regs,
>                 and some applications "depend" upon this behavior.
>                 Since we do not have the power to recompile these, we
>                 emulate the SVr4 behavior.  Sigh.  */
> -            mapped_addr =3D target_mmap(0, qemu_host_page_size, PROT_REA=
D |
> PROT_EXEC,
> +            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
>                                        MAP_FIXED | MAP_PRIVATE, -1, 0);
>      }
>
> --
> 2.7.4
>
>
>
