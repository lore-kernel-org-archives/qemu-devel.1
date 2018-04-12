Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f6aef-0000Wn-Gs
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f6aec-0003ze-CE
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:44:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59438
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f6aec-0003yX-6E
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:44:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3CBdn62081713
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 07:44:36 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ha49g721x-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 07:44:35 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 12 Apr 2018 12:44:33 +0100
References: <20180412093521.2469-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 12 Apr 2018 13:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180412093521.2469-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <273d99e1-a9ba-a27b-8e11-07df2dd803cf@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] s390x/kvm: cleanup calls to
 cpu_synchronize_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>



On 04/12/2018 11:35 AM, David Hildenbrand wrote:
> We have a call to cpu_synchronize_state() on every kvm_arch_handle_exit().
> 
> Let's remove the ones that are no longer needed.
> 
> Remaining places (for s390x) are in
> - target/s390x/sigp.c, on the target CPU
> - target/s390x/cpu.c:s390_cpu_get_crash_info()
> 
> While at it, use kvm_cpu_synchronize_state() instead of
> cpu_synchronize_state() in KVM code. (suggested by Thomas Huth)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


> ---
>  hw/s390x/s390-pci-inst.c |  8 --------
>  target/s390x/kvm.c       | 20 +-------------------
>  2 files changed, 1 insertion(+), 27 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 3fcc330fe3..02a815fd31 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -155,8 +155,6 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
>      S390pciState *s = s390_get_phb();
>      int i;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
>          return 0;
> @@ -389,8 +387,6 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>      uint32_t fh;
>      uint8_t pcias;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
>          return 0;
> @@ -487,8 +483,6 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>      uint32_t fh;
>      uint8_t pcias;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
>          return 0;
> @@ -620,8 +614,6 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
>      S390IOTLBEntry entry;
>      hwaddr start, end;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      if (env->psw.mask & PSW_MASK_PSTATE) {
>          s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
>          return 0;
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index fb59d92def..12b90cf5c5 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1081,7 +1081,6 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>      uint32_t code;
>      int r = 0;
> 
> -    cpu_synchronize_state(CPU(cpu));
>      sccb = env->regs[ipbh0 & 0xf];
>      code = env->regs[(ipbh0 & 0xf0) >> 4];
> 
> @@ -1101,8 +1100,6 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
>      int rc = 0;
>      uint16_t ipbh0 = (run->s390_sieic.ipb & 0xffff0000) >> 16;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      switch (ipa1) {
>      case PRIV_B2_XSCH:
>          ioinst_handle_xsch(cpu, env->regs[1], RA_IGNORED);
> @@ -1248,7 +1245,6 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t ar;
> 
>      if (s390_has_feat(S390_FEAT_ZPCI)) {
> -        cpu_synchronize_state(CPU(cpu));
>          fiba = get_base_disp_rxy(cpu, run, &ar);
> 
>          return stpcifc_service_call(cpu, r1, fiba, ar, RA_IGNORED);
> @@ -1266,7 +1262,6 @@ static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint16_t mode;
>      int r;
> 
> -    cpu_synchronize_state(CPU(cpu));
>      mode = env->regs[r1] & 0xffff;
>      isc = (env->regs[r3] >> 27) & 0x7;
>      r = css_do_sic(env, isc, mode);
> @@ -1297,7 +1292,6 @@ static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t ar;
> 
>      if (s390_has_feat(S390_FEAT_ZPCI)) {
> -        cpu_synchronize_state(CPU(cpu));
>          gaddr = get_base_disp_rsy(cpu, run, &ar);
> 
>          return pcistb_service_call(cpu, r1, r3, gaddr, ar, RA_IGNORED);
> @@ -1313,7 +1307,6 @@ static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
>      uint8_t ar;
> 
>      if (s390_has_feat(S390_FEAT_ZPCI)) {
> -        cpu_synchronize_state(CPU(cpu));
>          fiba = get_base_disp_rxy(cpu, run, &ar);
> 
>          return mpcifc_service_call(cpu, r1, fiba, ar, RA_IGNORED);
> @@ -1401,7 +1394,6 @@ static int handle_hypercall(S390CPU *cpu, struct kvm_run *run)
>      CPUS390XState *env = &cpu->env;
>      int ret;
> 
> -    cpu_synchronize_state(CPU(cpu));
>      ret = s390_virtio_hypercall(env);
>      if (ret == -EINVAL) {
>          kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> @@ -1416,7 +1408,6 @@ static void kvm_handle_diag_288(S390CPU *cpu, struct kvm_run *run)
>      uint64_t r1, r3;
>      int rc;
> 
> -    cpu_synchronize_state(CPU(cpu));
>      r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
>      r3 = run->s390_sieic.ipa & 0x000f;
>      rc = handle_diag_288(&cpu->env, r1, r3);
> @@ -1429,7 +1420,6 @@ static void kvm_handle_diag_308(S390CPU *cpu, struct kvm_run *run)
>  {
>      uint64_t r1, r3;
> 
> -    cpu_synchronize_state(CPU(cpu));
>      r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
>      r3 = run->s390_sieic.ipa & 0x000f;
>      handle_diag_308(&cpu->env, r1, r3, RA_IGNORED);
> @@ -1440,8 +1430,6 @@ static int handle_sw_breakpoint(S390CPU *cpu, struct kvm_run *run)
>      CPUS390XState *env = &cpu->env;
>      unsigned long pc;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      pc = env->psw.addr - sw_bp_ilen;
>      if (kvm_find_sw_breakpoint(CPU(cpu), pc)) {
>          env->psw.addr = pc;
> @@ -1493,8 +1481,6 @@ static int kvm_s390_handle_sigp(S390CPU *cpu, uint8_t ipa1, uint32_t ipb)
>      int ret;
>      uint8_t order;
> 
> -    cpu_synchronize_state(CPU(cpu));
> -
>      /* get order code */
>      order = decode_basedisp_rs(env, ipb, NULL) & SIGP_ORDER_MASK;
> 
> @@ -1556,7 +1542,6 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
>      CPUState *cs = CPU(cpu);
>      PSW oldpsw, newpsw;
> 
> -    cpu_synchronize_state(cs);
>      newpsw.mask = ldq_phys(cs->as, cpu->env.psa +
>                             offsetof(LowCore, program_new_psw));
>      newpsw.addr = ldq_phys(cs->as, cpu->env.psa +
> @@ -1609,7 +1594,6 @@ static int handle_intercept(S390CPU *cpu)
>              break;
>          case ICPT_WAITPSW:
>              /* disabled wait, since enabled wait is handled in kernel */
> -            cpu_synchronize_state(cs);
>              s390_handle_wait(cpu);
>              r = EXCP_HALTED;
>              break;
> @@ -1651,8 +1635,6 @@ static int handle_tsch(S390CPU *cpu)
>      struct kvm_run *run = cs->kvm_run;
>      int ret;
> 
> -    cpu_synchronize_state(cs);
> -
>      ret = ioinst_handle_tsch(cpu, cpu->env.regs[1], run->s390_tsch.ipb,
>                               RA_IGNORED);
>      if (ret < 0) {
> @@ -1778,7 +1760,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> 
>      qemu_mutex_lock_iothread();
> 
> -    cpu_synchronize_state(cs);
> +    kvm_cpu_synchronize_state(cs);
> 
>      switch (run->exit_reason) {
>          case KVM_EXIT_S390_SIEIC:
> 
