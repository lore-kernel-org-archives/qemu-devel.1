Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304B620714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTiFTXid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304B620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0E92-0007De-Fh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD4-0003jc-EV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD0-0003Se-MZ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S07acF098851;
 Tue, 28 Jul 2020 00:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gzG26fUgybyS8dix7buhvOlYBPA8wprnYlxU/Q8JmzY=;
 b=JTiFTXidXKVs3NeSuNTGVDF+YdBGoQSxmwIJVr+4+/F9o82pxhYyfIYcFYxoJhpQp3Ei
 ohkuDRkrV2NFbcr+QKeKBkxSOcOh+a6GXsNrNG596+3lOhsK7Y7LkUF8Dqpli1ANhITW
 40Ca211UBG/kBlJCE1mLlh+rzzapAsYxLH6zReHncpfwaw4LGhi5ehgSUcRxz4TjyRxB
 k0M2V3zS/q/+3g7/noE2RrNvk9RU6EWKIx3VNQHIOsVEd3eXA7wHkOLb/t20RrVdNrj1
 ESljplQcUn3B8gEwvhLPzu3P7FI9pOsMjQqX59BA+JVt8/lgkBdTC0jHAgX6P7amWtbZ ew== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 32hu1jcgnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Jul 2020 00:11:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08elK157415;
 Tue, 28 Jul 2020 00:11:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 32hu5rvkmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 00:11:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06S0B0kE020208;
 Tue, 28 Jul 2020 00:11:00 GMT
Received: from nsvm-sadhukhan.osdevelopmeniad.oraclevcn.com (/100.100.231.196)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 17:10:59 -0700
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
To: kvm@vger.kernel.org
Subject: [PATCH 1/6 v3] KVM: x86: Change names of some of the kvm_x86_ops
 functions to make them more semantical and readable
Date: Tue, 28 Jul 2020 00:10:45 +0000
Message-Id: <1595895050-105504-2-git-send-email-krish.sadhukhan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=4 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=4 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
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
X-Mailman-Approved-At: Mon, 27 Jul 2020 21:08:14 -0400
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

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
---
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/kvm-s390.c            |  2 +-
 arch/x86/include/asm/kvm_host.h     | 12 ++++++------
 arch/x86/kvm/svm/svm.c              | 12 ++++++------
 arch/x86/kvm/vmx/vmx.c              |  8 ++++----
 arch/x86/kvm/x86.c                  | 28 ++++++++++++++--------------
 include/linux/kvm_host.h            |  2 +-
 include/uapi/linux/kvm.h            |  6 +++---
 tools/include/uapi/linux/kvm.h      |  6 +++---
 virt/kvm/kvm_main.c                 |  4 ++--
 12 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c3e6fcc6..f5be4fa 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -545,7 +545,7 @@ static inline bool kvm_arch_requires_vhe(void)
 
 void kvm_arm_vcpu_ptrauth_trap(struct kvm_vcpu *vcpu);
 
-static inline void kvm_arch_hardware_unsetup(void) {}
+static inline void kvm_arch_hardware_teardown(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 363e7a89..95cea05 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -1178,7 +1178,7 @@ extern int kvm_mips_trans_mtc0(union mips_instruction inst, u32 *opc,
 extern int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
 			     struct kvm_mips_interrupt *irq);
 
-static inline void kvm_arch_hardware_unsetup(void) {}
+static inline void kvm_arch_hardware_teardown(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 					 struct kvm_memory_slot *slot) {}
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 7e2d061..892b0e2 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -856,7 +856,7 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_CREATE_DEVICE
 
 static inline void kvm_arch_hardware_disable(void) {}
-static inline void kvm_arch_hardware_unsetup(void) {}
+static inline void kvm_arch_hardware_teardown(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d47c197..5cdddd9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -312,7 +312,7 @@ int kvm_arch_hardware_setup(void *opaque)
 	return 0;
 }
 
-void kvm_arch_hardware_unsetup(void)
+void kvm_arch_hardware_teardown(void)
 {
 	gmap_unregister_pte_notifier(&gmap_notifier);
 	gmap_unregister_pte_notifier(&vsie_gmap_notifier);
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index be5363b..ccad66d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1080,7 +1080,7 @@ static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
 struct kvm_x86_ops {
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
-	void (*hardware_unsetup)(void);
+	void (*hardware_teardown)(void);
 	bool (*cpu_has_accelerated_tpr)(void);
 	bool (*has_emulated_msr)(u32 index);
 	void (*cpuid_update)(struct kvm_vcpu *vcpu);
@@ -1141,7 +1141,7 @@ struct kvm_x86_ops {
 	 */
 	void (*tlb_flush_guest)(struct kvm_vcpu *vcpu);
 
-	enum exit_fastpath_completion (*run)(struct kvm_vcpu *vcpu);
+	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
@@ -1150,8 +1150,8 @@ struct kvm_x86_ops {
 	u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
 	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
 				unsigned char *hypercall_addr);
-	void (*set_irq)(struct kvm_vcpu *vcpu);
-	void (*set_nmi)(struct kvm_vcpu *vcpu);
+	void (*inject_irq)(struct kvm_vcpu *vcpu);
+	void (*inject_nmi)(struct kvm_vcpu *vcpu);
 	void (*queue_exception)(struct kvm_vcpu *vcpu);
 	void (*cancel_injection)(struct kvm_vcpu *vcpu);
 	int (*interrupt_allowed)(struct kvm_vcpu *vcpu, bool for_injection);
@@ -1258,8 +1258,8 @@ struct kvm_x86_ops {
 	void (*enable_smi_window)(struct kvm_vcpu *vcpu);
 
 	int (*mem_enc_op)(struct kvm *kvm, void __user *argp);
-	int (*mem_enc_reg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
-	int (*mem_enc_unreg_region)(struct kvm *kvm, struct kvm_enc_region *argp);
+	int (*mem_enc_register_region)(struct kvm *kvm, struct kvm_enc_region *argp);
+	int (*mem_enc_unregister_region)(struct kvm *kvm, struct kvm_enc_region *argp);
 
 	int (*get_msr_feature)(struct kvm_msr_entry *entry);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c0da4dd..24755eb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3969,7 +3969,7 @@ static int svm_vm_init(struct kvm *kvm)
 }
 
 static struct kvm_x86_ops svm_x86_ops __initdata = {
-	.hardware_unsetup = svm_hardware_teardown,
+	.hardware_teardown = svm_hardware_teardown,
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
 	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
@@ -4016,15 +4016,15 @@ static int svm_vm_init(struct kvm *kvm)
 	.tlb_flush_gva = svm_flush_tlb_gva,
 	.tlb_flush_guest = svm_flush_tlb,
 
-	.run = svm_vcpu_run,
+	.vcpu_run = svm_vcpu_run,
 	.handle_exit = handle_exit,
 	.skip_emulated_instruction = skip_emulated_instruction,
 	.update_emulated_instruction = NULL,
 	.set_interrupt_shadow = svm_set_interrupt_shadow,
 	.get_interrupt_shadow = svm_get_interrupt_shadow,
 	.patch_hypercall = svm_patch_hypercall,
-	.set_irq = svm_set_irq,
-	.set_nmi = svm_inject_nmi,
+	.inject_irq = svm_set_irq,
+	.inject_nmi = svm_inject_nmi,
 	.queue_exception = svm_queue_exception,
 	.cancel_injection = svm_cancel_injection,
 	.interrupt_allowed = svm_interrupt_allowed,
@@ -4080,8 +4080,8 @@ static int svm_vm_init(struct kvm *kvm)
 	.enable_smi_window = enable_smi_window,
 
 	.mem_enc_op = svm_mem_enc_op,
-	.mem_enc_reg_region = svm_register_enc_region,
-	.mem_enc_unreg_region = svm_unregister_enc_region,
+	.mem_enc_register_region = svm_register_enc_region,
+	.mem_enc_unregister_region = svm_unregister_enc_region,
 
 	.need_emulation_on_page_fault = svm_need_emulation_on_page_fault,
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cb22f33..90d91524 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7844,7 +7844,7 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 }
 
 static struct kvm_x86_ops vmx_x86_ops __initdata = {
-	.hardware_unsetup = hardware_unsetup,
+	.hardware_teardown = hardware_unsetup,
 
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
@@ -7889,15 +7889,15 @@ static bool vmx_check_apicv_inhibit_reasons(ulong bit)
 	.tlb_flush_gva = vmx_flush_tlb_gva,
 	.tlb_flush_guest = vmx_flush_tlb_guest,
 
-	.run = vmx_vcpu_run,
+	.vcpu_run = vmx_vcpu_run,
 	.handle_exit = vmx_handle_exit,
 	.skip_emulated_instruction = vmx_skip_emulated_instruction,
 	.update_emulated_instruction = vmx_update_emulated_instruction,
 	.set_interrupt_shadow = vmx_set_interrupt_shadow,
 	.get_interrupt_shadow = vmx_get_interrupt_shadow,
 	.patch_hypercall = vmx_patch_hypercall,
-	.set_irq = vmx_inject_irq,
-	.set_nmi = vmx_inject_nmi,
+	.inject_irq = vmx_inject_irq,
+	.inject_nmi = vmx_inject_nmi,
 	.queue_exception = vmx_queue_exception,
 	.cancel_injection = vmx_cancel_injection,
 	.interrupt_allowed = vmx_interrupt_allowed,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3b92db4..7cc164b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5256,13 +5256,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
-	case KVM_MEMORY_ENCRYPT_OP: {
+	case KVM_MEM_ENC_OP: {
 		r = -ENOTTY;
 		if (kvm_x86_ops.mem_enc_op)
 			r = kvm_x86_ops.mem_enc_op(kvm, argp);
 		break;
 	}
-	case KVM_MEMORY_ENCRYPT_REG_REGION: {
+	case KVM_MEM_ENC_REGISTER_REGION: {
 		struct kvm_enc_region region;
 
 		r = -EFAULT;
@@ -5270,11 +5270,11 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			goto out;
 
 		r = -ENOTTY;
-		if (kvm_x86_ops.mem_enc_reg_region)
-			r = kvm_x86_ops.mem_enc_reg_region(kvm, &region);
+		if (kvm_x86_ops.mem_enc_register_region)
+			r = kvm_x86_ops.mem_enc_register_region(kvm, &region);
 		break;
 	}
-	case KVM_MEMORY_ENCRYPT_UNREG_REGION: {
+	case KVM_MEM_ENC_UNREGISTER_REGION: {
 		struct kvm_enc_region region;
 
 		r = -EFAULT;
@@ -5282,8 +5282,8 @@ long kvm_arch_vm_ioctl(struct file *filp,
 			goto out;
 
 		r = -ENOTTY;
-		if (kvm_x86_ops.mem_enc_unreg_region)
-			r = kvm_x86_ops.mem_enc_unreg_region(kvm, &region);
+		if (kvm_x86_ops.mem_enc_unregister_region)
+			r = kvm_x86_ops.mem_enc_unregister_region(kvm, &region);
 		break;
 	}
 	case KVM_HYPERV_EVENTFD: {
@@ -7788,10 +7788,10 @@ static void inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit
 	 */
 	else if (!vcpu->arch.exception.pending) {
 		if (vcpu->arch.nmi_injected) {
-			kvm_x86_ops.set_nmi(vcpu);
+			kvm_x86_ops.inject_nmi(vcpu);
 			can_inject = false;
 		} else if (vcpu->arch.interrupt.injected) {
-			kvm_x86_ops.set_irq(vcpu);
+			kvm_x86_ops.inject_irq(vcpu);
 			can_inject = false;
 		}
 	}
@@ -7867,7 +7867,7 @@ static void inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit
 		if (r) {
 			--vcpu->arch.nmi_pending;
 			vcpu->arch.nmi_injected = true;
-			kvm_x86_ops.set_nmi(vcpu);
+			kvm_x86_ops.inject_nmi(vcpu);
 			can_inject = false;
 			WARN_ON(kvm_x86_ops.nmi_allowed(vcpu, true) < 0);
 		}
@@ -7881,7 +7881,7 @@ static void inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit
 			goto busy;
 		if (r) {
 			kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu), false);
-			kvm_x86_ops.set_irq(vcpu);
+			kvm_x86_ops.inject_irq(vcpu);
 			WARN_ON(kvm_x86_ops.interrupt_allowed(vcpu, true) < 0);
 		}
 		if (kvm_cpu_has_injectable_intr(vcpu))
@@ -8517,7 +8517,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_RELOAD;
 	}
 
-	exit_fastpath = kvm_x86_ops.run(vcpu);
+	exit_fastpath = kvm_x86_ops.vcpu_run(vcpu);
 
 	/*
 	 * Do this here before restoring debug registers on the host.  And
@@ -9793,9 +9793,9 @@ int kvm_arch_hardware_setup(void *opaque)
 	return 0;
 }
 
-void kvm_arch_hardware_unsetup(void)
+void kvm_arch_hardware_teardown(void)
 {
-	kvm_x86_ops.hardware_unsetup();
+	kvm_x86_ops.hardware_teardown();
 }
 
 int kvm_arch_check_processor_compat(void *opaque)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d564855..b49312c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -894,7 +894,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 int kvm_arch_hardware_enable(void);
 void kvm_arch_hardware_disable(void);
 int kvm_arch_hardware_setup(void *opaque);
-void kvm_arch_hardware_unsetup(void);
+void kvm_arch_hardware_teardown(void);
 int kvm_arch_check_processor_compat(void *opaque);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu);
 bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4fdf303..cb6f153 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1469,15 +1469,15 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 /* Memory Encryption Commands */
-#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+#define KVM_MEM_ENC_OP	            _IOWR(KVMIO, 0xba, unsigned long)
 
 struct kvm_enc_region {
 	__u64 addr;
 	__u64 size;
 };
 
-#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
-#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
+#define KVM_MEM_ENC_REGISTER_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
+#define KVM_MEM_ENC_UNREGISTER_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
 
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 4fdf303..c341b2c 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1469,15 +1469,15 @@ struct kvm_s390_ucas_mapping {
 #define KVM_S390_GET_CMMA_BITS      _IOWR(KVMIO, 0xb8, struct kvm_s390_cmma_log)
 #define KVM_S390_SET_CMMA_BITS      _IOW(KVMIO, 0xb9, struct kvm_s390_cmma_log)
 /* Memory Encryption Commands */
-#define KVM_MEMORY_ENCRYPT_OP      _IOWR(KVMIO, 0xba, unsigned long)
+#define KVM_MEM_ENC_OP              _IOWR(KVMIO, 0xba, unsigned long)
 
 struct kvm_enc_region {
 	__u64 addr;
 	__u64 size;
 };
 
-#define KVM_MEMORY_ENCRYPT_REG_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
-#define KVM_MEMORY_ENCRYPT_UNREG_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
+#define KVM_MEM_ENC_REGISTER_REGION    _IOR(KVMIO, 0xbb, struct kvm_enc_region)
+#define KVM_MEM_ENC_UNREGISTER_REGION  _IOR(KVMIO, 0xbc, struct kvm_enc_region)
 
 /* Available with KVM_CAP_HYPERV_EVENTFD */
 #define KVM_HYPERV_EVENTFD        _IOW(KVMIO,  0xbd, struct kvm_hyperv_eventfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a852af5..4625f3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4786,7 +4786,7 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
 out_free_2:
-	kvm_arch_hardware_unsetup();
+	kvm_arch_hardware_teardown();
 out_free_1:
 	free_cpumask_var(cpus_hardware_enabled);
 out_free_0:
@@ -4808,7 +4808,7 @@ void kvm_exit(void)
 	unregister_reboot_notifier(&kvm_reboot_notifier);
 	cpuhp_remove_state_nocalls(CPUHP_AP_KVM_STARTING);
 	on_each_cpu(hardware_disable_nolock, NULL, 1);
-	kvm_arch_hardware_unsetup();
+	kvm_arch_hardware_teardown();
 	kvm_arch_exit();
 	kvm_irqfd_exit();
 	free_cpumask_var(cpus_hardware_enabled);
-- 
1.8.3.1


