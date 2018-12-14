Received: from eggs.gnu.org ([2001:4830:134:3::10]:46098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omair.javaid@linaro.org>) id 1gXizE-0004O8-SE
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omair.javaid@linaro.org>) id 1gXizD-0003N4-P0
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:38:20 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <omair.javaid@linaro.org>)
	id 1gXizD-0003J0-E9
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 03:38:19 -0500
Received: by mail-qk1-x743.google.com with SMTP id q1so2767880qkf.13
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 00:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
In-Reply-To: <20181213115503.24188-2-alex.bennee@linaro.org>
From: Omair Javaid <omair.javaid@linaro.org>
Date: Fri, 14 Dec 2018 13:37:51 +0500
Message-ID: <CANW4E-1UmZOGHya4jHxj10O2Ki7MPGMqme7wT0jaCO8Ufrii6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: kvm64 make guest debug
 AA32 break point aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, 13 Dec 2018 at 16:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> When supported by the hardware we can run AA32 guests or even AA64 EL1
> code with AA32 EL0 mode code. Inserting a AA64 break point into AA32
> code tends to break things. This is especially acute with gdb as it
> inserts temporary breakpoints when stepping through code.

Hi Alex,

Are you expecting GDB to switch targets (from AArch64 to AArch32 or
vice versa) when there is mode switch for example a AArch64 binary
calling a AArch32 library function.
I think GDB will behave nicely when doing 1 type of debug but seamless
switching between modes is still tricky for GDB. There has been some
work in last few months on this but not sure where it has reached.

>
> The heuristic of checking the current mode works but it's not perfect.
> A user could be placing a break point in code after a mode switch and
> that will still fail. However there doesn't seem to be a way to force
> a hbreak by default. According to "set breakpoint auto-hw on":

On mode switch we ll have to switch target architecture on GDB side
and GDB may not be able to do that seamlessly. Have you tried
debugging such an example?

>
>   This is the default behavior. When GDB sets a breakpoint, it will try
>   to use the target memory map to decide if software or hardware
>   breakpoint must be used.
>
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
>  target/arm/kvm64.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 0a502091e7..dd564a59b7 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -989,14 +989,20 @@ int kvm_arch_get_registers(CPUState *cs)
>      return ret;
>  }
>
> -/* C6.6.29 BRK instruction */
> +/* BRK (A64) and BKPT (A32) instructions */
>  static const uint32_t brk_insn =3D 0xd4200000;
> +static const uint32_t bkpt_insn =3D 0xe1200070;
>
>  int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint=
 *bp)
>  {
> +    CPUARMState *env =3D &ARM_CPU(cs)->env;
> +    int el =3D arm_current_el(env);
> +    bool is_aa64 =3D arm_el_is_aa64(env, el);
> +    const uint32_t *bpi =3D is_aa64 ? &brk_insn : &bkpt_insn;
> +
>      if (have_guest_debug) {
>          if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, =
4, 0) ||
> -            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk_insn, 4, 1))=
 {
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)bpi, 4, 1)) {
>              return -EINVAL;
>          }
>          return 0;
> @@ -1012,7 +1018,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, str=
uct kvm_sw_breakpoint *bp)
>
>      if (have_guest_debug) {
>          if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&brk, 4, 0) ||
> -            brk !=3D brk_insn ||
> +            !(brk =3D=3D brk_insn || brk =3D=3D bkpt_insn) ||
>              cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, =
4, 1)) {
>              return -EINVAL;
>          }
> @@ -1055,6 +1061,7 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_=
debug_exit_arch *debug_exit)
>              return false;
>          }
>          break;
> +    case EC_AA32_BKPT:
>      case EC_AA64_BKPT:
>          if (kvm_find_sw_breakpoint(cs, env->pc)) {
>              return true;
> --
> 2.17.1
>
