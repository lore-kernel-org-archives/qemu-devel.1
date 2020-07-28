Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DCBC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B7F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FCpMV570"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B7F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0E7b-00051S-D1
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD8-0003kL-7n
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krish.sadhukhan@oracle.com>)
 id 1k0DD2-0003TV-Lh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 20:11:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S07dWi098897;
 Tue, 28 Jul 2020 00:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=vXnj/gnqmHKObJdeOI0HW17ejiMSjp3dJmhAljiBIXo=;
 b=FCpMV570cbd+0qevU4Lup/EdxyBrxCdX91FMZf7h0MyjZzgEg0MbidehQALQGTZscbEZ
 Ka1afBr6vekJA/As/W0akfWe8PbVtjYptgm+aEyrO9T3leyOHRr6IAhhjRgVtLL/BDwR
 1Xc7XRMSU6tliuwXtedSO2ds2qxv4zcW1++ZQXQW3iIMrA4fCK2zVXAYuyRcy924P542
 HB4t6jxIbPSPJKtyI/7uQi/Vir5yJx8zNnuVPWJ1cXFw1EVF0NG8oRpg7GWFfVq/SB0+
 530QfBeI7uvRL1NcgK0qUmaw614LGqNg4toJq70KI94pcTZsjj4VK+WTVs2hhPF/L59A Bg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32hu1jcgnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Jul 2020 00:11:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06S08RQq040890;
 Tue, 28 Jul 2020 00:11:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 32hu5s4mnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2020 00:11:03 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06S0B1u4020224;
 Tue, 28 Jul 2020 00:11:01 GMT
Received: from nsvm-sadhukhan.osdevelopmeniad.oraclevcn.com (/100.100.231.196)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 27 Jul 2020 17:11:01 -0700
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
To: kvm@vger.kernel.org
Subject: [PATCH 5/6 v3] KVM: nVMX: Fill in conforming vmx_nested_ops via macro
Date: Tue, 28 Jul 2020 00:10:49 +0000
Message-Id: <1595895050-105504-6-git-send-email-krish.sadhukhan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
References: <1595895050-105504-1-git-send-email-krish.sadhukhan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=826 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=835
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
X-Mailman-Approved-At: Mon, 27 Jul 2020 21:08:18 -0400
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

The names of some of the vmx_nested_ops functions do not have a corresponding
'nested_vmx_' prefix. Generate the names using a macro so that the names are
conformant. Fixing the naming will help in better readability and
maintenance of the code.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
---
 arch/x86/kvm/vmx/nested.c | 24 +++++++++++++-----------
 arch/x86/kvm/vmx/nested.h |  2 +-
 arch/x86/kvm/vmx/vmx.c    |  4 ++--
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a898b53..fc09bb0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3105,7 +3105,7 @@ static int nested_vmx_check_vmentry_hw(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
+static bool nested_vmx_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -3295,7 +3295,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 	prepare_vmcs02_early(vmx, vmcs12);
 
 	if (from_vmentry) {
-		if (unlikely(!nested_get_vmcs12_pages(vcpu)))
+		if (unlikely(!nested_vmx_get_vmcs12_pages(vcpu)))
 			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
 
 		if (nested_vmx_check_vmentry_hw(vcpu)) {
@@ -3711,7 +3711,7 @@ static bool nested_vmx_preemption_timer_pending(struct kvm_vcpu *vcpu)
 	       to_vmx(vcpu)->nested.preemption_timer_expired;
 }
 
-static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
+static int nested_vmx_check_events(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long exit_qual;
@@ -5907,7 +5907,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
+static int nested_vmx_get_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				u32 user_data_size)
 {
@@ -6031,7 +6031,7 @@ void vmx_leave_nested(struct kvm_vcpu *vcpu)
 	free_nested(vcpu);
 }
 
-static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
+static int nested_vmx_set_state(struct kvm_vcpu *vcpu,
 				struct kvm_nested_state __user *user_kvm_nested_state,
 				struct kvm_nested_state *kvm_state)
 {
@@ -6448,7 +6448,7 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
 	msrs->vmcs_enum = VMCS12_MAX_FIELD_INDEX << 1;
 }
 
-void nested_vmx_hardware_unsetup(void)
+void nested_vmx_hardware_teardown(void)
 {
 	int i;
 
@@ -6473,7 +6473,7 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 			vmx_bitmap[i] = (unsigned long *)
 				__get_free_page(GFP_KERNEL);
 			if (!vmx_bitmap[i]) {
-				nested_vmx_hardware_unsetup();
+				nested_vmx_hardware_teardown();
 				return -ENOMEM;
 			}
 		}
@@ -6497,12 +6497,14 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 	return 0;
 }
 
+#define KVM_X86_NESTED_OP(name) .name = nested_vmx_##name
+
 struct kvm_x86_nested_ops vmx_nested_ops = {
-	.check_events = vmx_check_nested_events,
+	KVM_X86_NESTED_OP(check_events),
 	.hv_timer_pending = nested_vmx_preemption_timer_pending,
-	.get_state = vmx_get_nested_state,
-	.set_state = vmx_set_nested_state,
-	.get_vmcs12_pages = nested_get_vmcs12_pages,
+	KVM_X86_NESTED_OP(get_state),
+	KVM_X86_NESTED_OP(set_state),
+	KVM_X86_NESTED_OP(get_vmcs12_pages),
 	.enable_evmcs = nested_enable_evmcs,
 	.get_evmcs_version = nested_get_evmcs_version,
 };
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 758bccc..ac6b561 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -18,7 +18,7 @@ enum nvmx_vmentry_status {
 
 void vmx_leave_nested(struct kvm_vcpu *vcpu);
 void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps);
-void nested_vmx_hardware_unsetup(void);
+void nested_vmx_hardware_teardown(void);
 __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *));
 void nested_vmx_set_vmcs_shadowing_bitmap(void);
 void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6a6674..6512e6e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7830,7 +7830,7 @@ static void vmx_migrate_timers(struct kvm_vcpu *vcpu)
 static void vmx_hardware_teardown(void)
 {
 	if (nested)
-		nested_vmx_hardware_unsetup();
+		nested_vmx_hardware_teardown();
 
 	free_kvm_area();
 }
@@ -8144,7 +8144,7 @@ static __init int hardware_setup(void)
 
 	r = alloc_kvm_area();
 	if (r)
-		nested_vmx_hardware_unsetup();
+		nested_vmx_hardware_teardown();
 	return r;
 }
 
-- 
1.8.3.1


