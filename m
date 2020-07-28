Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99882C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E9120714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pwYREKJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E9120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ECD-0002ny-JG
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DEy-0003vc-Au
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:13:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DEw-0003cY-0F
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:13:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08qIp099510;
 Tue, 28 Jul 2020 00:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=MsD4vCZcp4Gq6Mao/DDqu5aEmgjQO67N4u9DdlODuzA=;
 b=pwYREKJpXNq/tAPfnzIEdu0oqgRXnSthXei2uySp/4Xdp16OS3zXbbUpBCsmHawKVk03
 a4C23jY4leu7w7Mi3Nn9KUsFEK0uvFPB1j+wYJzvmr6FsT9tP8Avum3k/Kjp8bY3pILm
 6aCZcY+m2Fuz6S8oi6b6AbKak1D040meimhrnoIRrYYoXvf6MYfs+hzvuWSyt2PQ1KbA
 53h6O7/QzdUTzGl4VGelR5IWylq7R73cBFc0UBVSJepif1XkFXX5n3DRuAsOv0RQk7R+
 aFjQiQtgjI6OgFfuElkm0uSxRQMzmAzk1wYLDXUagwOHPShBalVc4ePS6N5CqPsRaA6n 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32hu1jcgs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Jul 2020 00:13:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08R6E040923;
 Tue, 28 Jul 2020 00:11:02 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 32hu5s4mm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 00:11:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06S0B1Ek016703;
 Tue, 28 Jul 2020 00:11:01 GMT
Received: from nsvm-sadhukhan.osdevelopmeniad.oraclevcn.com (/100.100.231.196)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 17:11:01 -0700
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
To: kvm@vger.kernel.org
Subject: [PATCH 4/6 v3] KVM: VMX: Fill in conforming vmx_x86_ops via macro
Date: Tue, 28 Jul 2020 00:10:48 +0000
Message-Id: <1595895050-105504-5-git-send-email-krish.sadhukhan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=986 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=995
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=3 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=krish.sadhukhan@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 20:11:04
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2020 21:08:21 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, vkuznets@redhat.com, qemu-devel@nongnu.org,
 sean.j.christopherson@intel.com, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The names of some of the vmx_x86_ops functions do not have a corresponding
'vmx_' prefix. Generate the names using a macro so that the names are
conformant. Fixing the naming will help in better readability and
maintenance of the code.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
---
 arch/x86/kvm/vmx/nested.c |   2 +-
 arch/x86/kvm/vmx/vmx.c    | 234 +++++++++++++++++++++++-----------------------
 arch/x86/kvm/vmx/vmx.h    |   2 +-
 3 files changed, 120 insertions(+), 118 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index d1af20b..a898b53 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3016,7 +3016,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
-	vmx_prepare_switch_to_guest(vcpu);
+	vmx_prepare_guest_switch(vcpu);
 
 	/*
 	 * Induce a consistency check VMExit by clearing bit 1 in GUEST_RFLAGS,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 90d91524..f6a6674 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1125,7 +1125,7 @@ void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
 	}
 }
 
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
+void vmx_prepare_guest_switch(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs_host_state *host_state;
@@ -2317,7 +2317,7 @@ static int kvm_cpu_vmxon(u64 vmxon_pointer)
 	return -EFAULT;
 }
 
-static int hardware_enable(void)
+static int vmx_hardware_enable(void)
 {
 	int cpu = raw_smp_processor_id();
 	u64 phys_addr = __pa(per_cpu(vmxarea, cpu));
@@ -2366,7 +2366,7 @@ static void kvm_cpu_vmxoff(void)
 	cr4_clear_bits(X86_CR4_VMXE);
 }
 
-static void hardware_disable(void)
+static void vmx_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 	kvm_cpu_vmxoff();
@@ -2911,7 +2911,7 @@ static void exit_lmode(struct kvm_vcpu *vcpu)
 
 #endif
 
-static void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
+static void vmx_tlb_flush_all(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -2934,7 +2934,7 @@ static void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
+static void vmx_tlb_flush_current(struct kvm_vcpu *vcpu)
 {
 	u64 root_hpa = vcpu->arch.mmu->root_hpa;
 
@@ -2950,16 +2950,16 @@ static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(nested_get_vpid02(vcpu));
 }
 
-static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+static void vmx_tlb_flush_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	/*
 	 * vpid_sync_vcpu_addr() is a nop if vmx->vpid==0, see the comment in
-	 * vmx_flush_tlb_guest() for an explanation of why this is ok.
+	 * vmx_tlb_flush_guest() for an explanation of why this is ok.
 	 */
 	vpid_sync_vcpu_addr(to_vmx(vcpu)->vpid, addr);
 }
 
-static void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
+static void vmx_tlb_flush_guest(struct kvm_vcpu *vcpu)
 {
 	/*
 	 * vpid_sync_context() is a nop if vmx->vpid==0, e.g. if enable_vpid==0
@@ -4455,16 +4455,16 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 		vmx_clear_hlt(vcpu);
 }
 
-static void enable_irq_window(struct kvm_vcpu *vcpu)
+static void vmx_enable_irq_window(struct kvm_vcpu *vcpu)
 {
 	exec_controls_setbit(to_vmx(vcpu), CPU_BASED_INTR_WINDOW_EXITING);
 }
 
-static void enable_nmi_window(struct kvm_vcpu *vcpu)
+static void vmx_enable_nmi_window(struct kvm_vcpu *vcpu)
 {
 	if (!enable_vnmi ||
 	    vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_STI) {
-		enable_irq_window(vcpu);
+		vmx_enable_irq_window(vcpu);
 		return;
 	}
 
@@ -6173,7 +6173,7 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		: "eax", "ebx", "ecx", "edx");
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
+static void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	int tpr_threshold;
@@ -6261,7 +6261,7 @@ static void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 		return;
 
 	vmcs_write64(APIC_ACCESS_ADDR, page_to_phys(page));
-	vmx_flush_tlb_current(vcpu);
+	vmx_tlb_flush_current(vcpu);
 
 	/*
 	 * Do not pin apic access page in memory, the MMU notifier
@@ -6837,7 +6837,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	return exit_fastpath;
 }
 
-static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
+static void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6848,7 +6848,7 @@ static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
 	free_loaded_vmcs(vmx->loaded_vmcs);
 }
 
-static int vmx_create_vcpu(struct kvm_vcpu *vcpu)
+static int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx;
 	unsigned long *msr_bitmap;
@@ -7802,7 +7802,7 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
 	return 0;
 }
 
-static void enable_smi_window(struct kvm_vcpu *vcpu)
+static void vmx_enable_smi_window(struct kvm_vcpu *vcpu)
 {
 	/* RSM will cause a vmexit anyway.  */
 }
@@ -7827,7 +7827,7 @@ static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 	}
 }
 
-static void hardware_unsetup(void)
+static void vmx_hardware_teardown(void)
 {
 	if (nested)
 		nested_vmx_hardware_unsetup();
@@ -7843,134 +7843,136 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 	return supported & BIT(bit);
 }
 
+#define KVM_X86_OP(name) .name = vmx_##name
+
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.hardware_teardown = hardware_unsetup,
+	KVM_X86_OP(hardware_teardown),
 
-	.hardware_enable = hardware_enable,
-	.hardware_disable = hardware_disable,
+	KVM_X86_OP(hardware_enable),
+	KVM_X86_OP(hardware_disable),
 	.cpu_has_accelerated_tpr = report_flexpriority,
-	.has_emulated_msr = vmx_has_emulated_msr,
+	KVM_X86_OP(has_emulated_msr),
 
 	.vm_size = sizeof(struct kvm_vmx),
-	.vm_init = vmx_vm_init,
+	KVM_X86_OP(vm_init),
 
-	.vcpu_create = vmx_create_vcpu,
-	.vcpu_free = vmx_free_vcpu,
-	.vcpu_reset = vmx_vcpu_reset,
+	KVM_X86_OP(vcpu_create),
+	KVM_X86_OP(vcpu_free),
+	KVM_X86_OP(vcpu_reset),
 
-	.prepare_guest_switch = vmx_prepare_switch_to_guest,
-	.vcpu_load = vmx_vcpu_load,
-	.vcpu_put = vmx_vcpu_put,
+	KVM_X86_OP(prepare_guest_switch),
+	KVM_X86_OP(vcpu_load),
+	KVM_X86_OP(vcpu_put),
 
 	.update_bp_intercept = update_exception_bitmap,
-	.get_msr_feature = vmx_get_msr_feature,
-	.get_msr = vmx_get_msr,
-	.set_msr = vmx_set_msr,
-	.get_segment_base = vmx_get_segment_base,
-	.get_segment = vmx_get_segment,
-	.set_segment = vmx_set_segment,
-	.get_cpl = vmx_get_cpl,
-	.get_cs_db_l_bits = vmx_get_cs_db_l_bits,
-	.set_cr0 = vmx_set_cr0,
-	.set_cr4 = vmx_set_cr4,
-	.set_efer = vmx_set_efer,
-	.get_idt = vmx_get_idt,
-	.set_idt = vmx_set_idt,
-	.get_gdt = vmx_get_gdt,
-	.set_gdt = vmx_set_gdt,
-	.set_dr7 = vmx_set_dr7,
-	.sync_dirty_debug_regs = vmx_sync_dirty_debug_regs,
-	.cache_reg = vmx_cache_reg,
-	.get_rflags = vmx_get_rflags,
-	.set_rflags = vmx_set_rflags,
-
-	.tlb_flush_all = vmx_flush_tlb_all,
-	.tlb_flush_current = vmx_flush_tlb_current,
-	.tlb_flush_gva = vmx_flush_tlb_gva,
-	.tlb_flush_guest = vmx_flush_tlb_guest,
-
-	.vcpu_run = vmx_vcpu_run,
-	.handle_exit = vmx_handle_exit,
-	.skip_emulated_instruction = vmx_skip_emulated_instruction,
-	.update_emulated_instruction = vmx_update_emulated_instruction,
-	.set_interrupt_shadow = vmx_set_interrupt_shadow,
-	.get_interrupt_shadow = vmx_get_interrupt_shadow,
-	.patch_hypercall = vmx_patch_hypercall,
-	.inject_irq = vmx_inject_irq,
-	.inject_nmi = vmx_inject_nmi,
-	.queue_exception = vmx_queue_exception,
-	.cancel_injection = vmx_cancel_injection,
-	.interrupt_allowed = vmx_interrupt_allowed,
-	.nmi_allowed = vmx_nmi_allowed,
-	.get_nmi_mask = vmx_get_nmi_mask,
-	.set_nmi_mask = vmx_set_nmi_mask,
-	.enable_nmi_window = enable_nmi_window,
-	.enable_irq_window = enable_irq_window,
-	.update_cr8_intercept = update_cr8_intercept,
-	.set_virtual_apic_mode = vmx_set_virtual_apic_mode,
-	.set_apic_access_page_addr = vmx_set_apic_access_page_addr,
-	.refresh_apicv_exec_ctrl = vmx_refresh_apicv_exec_ctrl,
-	.load_eoi_exitmap = vmx_load_eoi_exitmap,
-	.apicv_post_state_restore = vmx_apicv_post_state_restore,
-	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
-	.hwapic_irr_update = vmx_hwapic_irr_update,
-	.hwapic_isr_update = vmx_hwapic_isr_update,
-	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
-	.sync_pir_to_irr = vmx_sync_pir_to_irr,
-	.deliver_posted_interrupt = vmx_deliver_posted_interrupt,
-	.dy_apicv_has_pending_interrupt = vmx_dy_apicv_has_pending_interrupt,
-
-	.set_tss_addr = vmx_set_tss_addr,
-	.set_identity_map_addr = vmx_set_identity_map_addr,
-	.get_tdp_level = vmx_get_tdp_level,
-	.get_mt_mask = vmx_get_mt_mask,
-
-	.get_exit_info = vmx_get_exit_info,
-
-	.cpuid_update = vmx_cpuid_update,
+	KVM_X86_OP(get_msr_feature),
+	KVM_X86_OP(get_msr),
+	KVM_X86_OP(set_msr),
+	KVM_X86_OP(get_segment_base),
+	KVM_X86_OP(get_segment),
+	KVM_X86_OP(set_segment),
+	KVM_X86_OP(get_cpl),
+	KVM_X86_OP(get_cs_db_l_bits),
+	KVM_X86_OP(set_cr0),
+	KVM_X86_OP(set_cr4),
+	KVM_X86_OP(set_efer),
+	KVM_X86_OP(get_idt),
+	KVM_X86_OP(set_idt),
+	KVM_X86_OP(get_gdt),
+	KVM_X86_OP(set_gdt),
+	KVM_X86_OP(set_dr7),
+	KVM_X86_OP(sync_dirty_debug_regs),
+	KVM_X86_OP(cache_reg),
+	KVM_X86_OP(get_rflags),
+	KVM_X86_OP(set_rflags),
+
+	KVM_X86_OP(tlb_flush_all),
+	KVM_X86_OP(tlb_flush_current),
+	KVM_X86_OP(tlb_flush_gva),
+	KVM_X86_OP(tlb_flush_guest),
+
+	KVM_X86_OP(vcpu_run),
+	KVM_X86_OP(handle_exit),
+	KVM_X86_OP(skip_emulated_instruction),
+	KVM_X86_OP(update_emulated_instruction),
+	KVM_X86_OP(set_interrupt_shadow),
+	KVM_X86_OP(get_interrupt_shadow),
+	KVM_X86_OP(patch_hypercall),
+	KVM_X86_OP(inject_irq),
+	KVM_X86_OP(inject_nmi),
+	KVM_X86_OP(queue_exception),
+	KVM_X86_OP(cancel_injection),
+	KVM_X86_OP(interrupt_allowed),
+	KVM_X86_OP(nmi_allowed),
+	KVM_X86_OP(get_nmi_mask),
+	KVM_X86_OP(set_nmi_mask),
+	KVM_X86_OP(enable_nmi_window),
+	KVM_X86_OP(enable_irq_window),
+	KVM_X86_OP(update_cr8_intercept),
+	KVM_X86_OP(set_virtual_apic_mode),
+	KVM_X86_OP(set_apic_access_page_addr),
+	KVM_X86_OP(refresh_apicv_exec_ctrl),
+	KVM_X86_OP(load_eoi_exitmap),
+	KVM_X86_OP(apicv_post_state_restore),
+	KVM_X86_OP(check_apicv_inhibit_reasons),
+	KVM_X86_OP(hwapic_irr_update),
+	KVM_X86_OP(hwapic_isr_update),
+	KVM_X86_OP(guest_apic_has_interrupt),
+	KVM_X86_OP(sync_pir_to_irr),
+	KVM_X86_OP(deliver_posted_interrupt),
+	KVM_X86_OP(dy_apicv_has_pending_interrupt),
+
+	KVM_X86_OP(set_tss_addr),
+	KVM_X86_OP(set_identity_map_addr),
+	KVM_X86_OP(get_tdp_level),
+	KVM_X86_OP(get_mt_mask),
+
+	KVM_X86_OP(get_exit_info),
+
+	KVM_X86_OP(cpuid_update),
 
 	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
 
-	.write_l1_tsc_offset = vmx_write_l1_tsc_offset,
+	KVM_X86_OP(write_l1_tsc_offset),
 
-	.load_mmu_pgd = vmx_load_mmu_pgd,
+	KVM_X86_OP(load_mmu_pgd),
 
-	.check_intercept = vmx_check_intercept,
-	.handle_exit_irqoff = vmx_handle_exit_irqoff,
+	KVM_X86_OP(check_intercept),
+	KVM_X86_OP(handle_exit_irqoff),
 
-	.request_immediate_exit = vmx_request_immediate_exit,
+	KVM_X86_OP(request_immediate_exit),
 
-	.sched_in = vmx_sched_in,
+	KVM_X86_OP(sched_in),
 
-	.slot_enable_log_dirty = vmx_slot_enable_log_dirty,
-	.slot_disable_log_dirty = vmx_slot_disable_log_dirty,
-	.flush_log_dirty = vmx_flush_log_dirty,
-	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
+	KVM_X86_OP(slot_enable_log_dirty),
+	KVM_X86_OP(slot_disable_log_dirty),
+	KVM_X86_OP(flush_log_dirty),
+	KVM_X86_OP(enable_log_dirty_pt_masked),
 	.write_log_dirty = vmx_write_pml_buffer,
 
-	.pre_block = vmx_pre_block,
-	.post_block = vmx_post_block,
+	KVM_X86_OP(pre_block),
+	KVM_X86_OP(post_block),
 
 	.pmu_ops = &intel_pmu_ops,
 	.nested_ops = &vmx_nested_ops,
 
-	.update_pi_irte = vmx_update_pi_irte,
+	KVM_X86_OP(update_pi_irte),
 
 #ifdef CONFIG_X86_64
-	.set_hv_timer = vmx_set_hv_timer,
-	.cancel_hv_timer = vmx_cancel_hv_timer,
+	KVM_X86_OP(set_hv_timer),
+	KVM_X86_OP(cancel_hv_timer),
 #endif
 
-	.setup_mce = vmx_setup_mce,
+	KVM_X86_OP(setup_mce),
 
-	.smi_allowed = vmx_smi_allowed,
-	.pre_enter_smm = vmx_pre_enter_smm,
-	.pre_leave_smm = vmx_pre_leave_smm,
-	.enable_smi_window = enable_smi_window,
+	KVM_X86_OP(smi_allowed),
+	KVM_X86_OP(pre_enter_smm),
+	KVM_X86_OP(pre_leave_smm),
+	KVM_X86_OP(enable_smi_window),
 
-	.need_emulation_on_page_fault = vmx_need_emulation_on_page_fault,
-	.apic_init_signal_blocked = vmx_apic_init_signal_blocked,
-	.migrate_timers = vmx_migrate_timers,
+	KVM_X86_OP(need_emulation_on_page_fault),
+	KVM_X86_OP(apic_init_signal_blocked),
+	KVM_X86_OP(migrate_timers),
 };
 
 static __init int hardware_setup(void)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 639798e..8084ce0 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -325,7 +325,7 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
 int allocate_vpid(void);
 void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
-void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
+void vmx_prepare_guest_switch(struct kvm_vcpu *vcpu);
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
 			unsigned long fs_base, unsigned long gs_base);
 int vmx_get_cpl(struct kvm_vcpu *vcpu);
-- 
1.8.3.1


