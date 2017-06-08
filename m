Received: from eggs.gnu.org ([2001:4830:134:3::10]:39551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIylI-0000fB-Mt
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIylE-0008Cf-PJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIylE-0008AJ-Fj
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 10:50:08 -0400
References: <20170607190132.5460-1-bobby.prani@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <57860393-335f-6df1-25d8-72ec77ec3050@redhat.com>
Date: Thu, 8 Jun 2017 16:50:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170607190132.5460-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND] mttcg/i386: Patch instruction using
 async_safe_* framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>



On 07/06/2017 21:01, Pranith Kumar wrote:
> In mttcg, calling pause_all_vcpus() during execution from the
> generated TBs causes a deadlock if some vCPU is waiting for exclusive
> execution in start_exclusive(). Fix this by using the aync_safe_*
> framework instead of pausing vcpus for patching instructions.
>=20
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  hw/i386/kvmvapic.c | 82 ++++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 52 insertions(+), 30 deletions(-)
>=20
> diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
> index 82a49556af..11b0d494eb 100644
> --- a/hw/i386/kvmvapic.c
> +++ b/hw/i386/kvmvapic.c
> @@ -383,8 +383,7 @@ static void patch_byte(X86CPU *cpu, target_ulong ad=
dr, uint8_t byte)
>      cpu_memory_rw_debug(CPU(cpu), addr, &byte, 1, 1);
>  }
> =20
> -static void patch_call(VAPICROMState *s, X86CPU *cpu, target_ulong ip,
> -                       uint32_t target)
> +static void patch_call(X86CPU *cpu, target_ulong ip, uint32_t target)
>  {
>      uint32_t offset;
> =20
> @@ -393,23 +392,24 @@ static void patch_call(VAPICROMState *s, X86CPU *=
cpu, target_ulong ip,
>      cpu_memory_rw_debug(CPU(cpu), ip + 1, (void *)&offset, sizeof(offs=
et), 1);
>  }
> =20
> -static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ul=
ong ip)
> +struct PatchInfo {
> +    VAPICHandlers *handler;
> +    target_ulong ip;
> +};
> +
> +static void do_patch_instruction(CPUState *cs, run_on_cpu_data data)
>  {
> -    CPUState *cs =3D CPU(cpu);
> -    CPUX86State *env =3D &cpu->env;
> -    VAPICHandlers *handlers;
> +    X86CPU *x86_cpu =3D X86_CPU(cs);
> +    CPUX86State *env =3D &x86_cpu->env;
> +    struct PatchInfo *info =3D (struct PatchInfo *) data.host_ptr;
> +    VAPICHandlers *handlers =3D info->handler;
> +    target_ulong ip =3D info->ip;
>      uint8_t opcode[2];
>      uint32_t imm32 =3D 0;
>      target_ulong current_pc =3D 0;
>      target_ulong current_cs_base =3D 0;
>      uint32_t current_flags =3D 0;
> =20
> -    if (smp_cpus =3D=3D 1) {
> -        handlers =3D &s->rom_state.up;
> -    } else {
> -        handlers =3D &s->rom_state.mp;
> -    }
> -
>      if (!kvm_enabled()) {
>          cpu_get_tb_cpu_state(env, &current_pc, &current_cs_base,
>                               &current_flags);
> @@ -421,48 +421,70 @@ static void patch_instruction(VAPICROMState *s, X=
86CPU *cpu, target_ulong ip)
>          }
>      }
> =20
> -    pause_all_vcpus();
> -
>      cpu_memory_rw_debug(cs, ip, opcode, sizeof(opcode), 0);
> =20
>      switch (opcode[0]) {
>      case 0x89: /* mov r32 to r/m32 */
> -        patch_byte(cpu, ip, 0x50 + modrm_reg(opcode[1]));  /* push reg=
 */
> -        patch_call(s, cpu, ip + 1, handlers->set_tpr);
> +        patch_byte(x86_cpu, ip, 0x50 + modrm_reg(opcode[1]));  /* push=
 reg */
> +        patch_call(x86_cpu, ip + 1, handlers->set_tpr);
>          break;
>      case 0x8b: /* mov r/m32 to r32 */
> -        patch_byte(cpu, ip, 0x90);
> -        patch_call(s, cpu, ip + 1, handlers->get_tpr[modrm_reg(opcode[=
1])]);
> +        patch_byte(x86_cpu, ip, 0x90);
> +        patch_call(x86_cpu, ip + 1, handlers->get_tpr[modrm_reg(opcode=
[1])]);
>          break;
>      case 0xa1: /* mov abs to eax */
> -        patch_call(s, cpu, ip, handlers->get_tpr[0]);
> +        patch_call(x86_cpu, ip, handlers->get_tpr[0]);
>          break;
>      case 0xa3: /* mov eax to abs */
> -        patch_call(s, cpu, ip, handlers->set_tpr_eax);
> +        patch_call(x86_cpu, ip, handlers->set_tpr_eax);
>          break;
>      case 0xc7: /* mov imm32, r/m32 (c7/0) */
> -        patch_byte(cpu, ip, 0x68);  /* push imm32 */
> +        patch_byte(x86_cpu, ip, 0x68);  /* push imm32 */
>          cpu_memory_rw_debug(cs, ip + 6, (void *)&imm32, sizeof(imm32),=
 0);
>          cpu_memory_rw_debug(cs, ip + 1, (void *)&imm32, sizeof(imm32),=
 1);
> -        patch_call(s, cpu, ip + 5, handlers->set_tpr);
> +        patch_call(x86_cpu, ip + 5, handlers->set_tpr);
>          break;
>      case 0xff: /* push r/m32 */
> -        patch_byte(cpu, ip, 0x50); /* push eax */
> -        patch_call(s, cpu, ip + 1, handlers->get_tpr_stack);
> +        patch_byte(x86_cpu, ip, 0x50); /* push eax */
> +        patch_call(x86_cpu, ip + 1, handlers->get_tpr_stack);
>          break;
>      default:
>          abort();
>      }
> =20
> -    resume_all_vcpus();
> +    g_free(info);
> +}
> +
> +static void patch_instruction(VAPICROMState *s, X86CPU *cpu, target_ul=
ong ip)
> +{
> +    CPUState *cs =3D CPU(cpu);
> +    VAPICHandlers *handlers;
> +    struct PatchInfo *info;
> +
> +    if (smp_cpus =3D=3D 1) {
> +        handlers =3D &s->rom_state.up;
> +    } else {
> +        handlers =3D &s->rom_state.mp;
> +    }
> +
> +    info  =3D g_new(struct PatchInfo, 1);
> +    info->handler =3D handlers;
> +    info->ip =3D ip;
> =20
>      if (!kvm_enabled()) {
> -        /* Both tb_lock and iothread_mutex will be reset when
> -         *  longjmps back into the cpu_exec loop. */
> -        tb_lock();
> -        tb_gen_code(cs, current_pc, current_cs_base, current_flags, 1)=
;
> -        cpu_loop_exit_noexc(cs);
> +        const run_on_cpu_func fn =3D do_patch_instruction;
> +
> +        async_safe_run_on_cpu(cs, fn, RUN_ON_CPU_HOST_PTR(info));
> +        cs->exception_index =3D EXCP_INTERRUPT;
> +        cpu_loop_exit(cs);

Sorry I forgot about this.

I think these two lines should be a cpu_exit(cpu).  In addition, there
is a patch on list "kvm-all: make async_safe_run_on_cpu safe on kvm too"
that let you do this more easily.

Paolo

>      }
> +
> +    pause_all_vcpus();
> +
> +    do_patch_instruction(cs, RUN_ON_CPU_HOST_PTR(info));
> +
> +    resume_all_vcpus();
> +    g_free(info);
>  }
> =20
>  void vapic_report_tpr_access(DeviceState *dev, CPUState *cs, target_ul=
ong ip,
>=20
