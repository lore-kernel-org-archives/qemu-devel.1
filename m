Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36E8C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8242075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k66b4ThW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8242075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heRGM-0004B4-2n
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 17:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47590)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1heRE6-0002sd-22
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1heRE4-0001n6-3Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:37:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1heRE1-0001lE-1Q
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:37:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLZ7wo070584;
 Fri, 21 Jun 2019 21:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mbp56QULTjJn+kLkBsD2OXcTeD+xe6Pzz2lTqaOV5tU=;
 b=k66b4ThWEGUiZ51VOmx+QkWfNSqaqIK6mqzHBHvQmLcktUwQmXcTzYc49IJpLBa7nkqj
 UVGTy4JG6KwobuGFvxGKBZqdMSKDLPpFVf8WLCY6GMmjS9Ce7FV752M6kDdLyc3pDXCb
 FYpHif+FXzY5KY3cO2XU8fm5pn4+P4kqYI7NGWPm7mnJMvLtGQs1P88PBrEPtLGuzRxN
 0I4mtQ3r40Jd7iDOLOoEBNKN6xEdVWnYtt7CUvtibY+PxgR+MUOPcOjRVoO//w0zYw2X
 rXkgIzsB3DOZ9VfVqoFDE4HeDKgslqhgJtRW9gRl+xDtNzZnLSRutRGx3FpO1Ie9Qu1j bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2t7809rety-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 21:37:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LLaZgl186242;
 Fri, 21 Jun 2019 21:37:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2t77yq5n83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2019 21:37:33 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LLbWWM020889;
 Fri, 21 Jun 2019 21:37:32 GMT
Received: from Lirans-MBP.Home (/109.64.216.174)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 21 Jun 2019 14:37:32 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Sat, 22 Jun 2019 00:37:11 +0300
Message-Id: <20190621213712.16222-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621213712.16222-1-liran.alon@oracle.com>
References: <20190621213712.16222-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906210164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210164
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x5LLZ7wo070584
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [PATCH 1/2] target/i386: kvm: Block migration on vCPU
 exposed with SVM when kernel lacks caps to save/restore nested state
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
Cc: maran.wilson@oracle.com, dgilbert@redhat.com,
 Liran Alon <liran.alon@oracle.com>, pbonzini@redhat.com,
 Karl Heubaum <karl.heubaum@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 18ab37ba1cee ("target/i386: kvm: Block migration for vCPUs exposed=
 with nested virtualization")
was originally suppose to block migration for vCPUs exposed with nested v=
irtualization, either Intel VMX
or AMD SVM. However, during merge to upstream, commit was changed such th=
at it doesn't even compile...

This was done unintentionally in an attempt to modify submitted patch-ser=
ies such that commit
12604092e26c ("target/i386: kvm: Add nested migration blocker only when k=
ernel lacks required capabilities")
will only block migration of vCPU exposed with VMX but still allow migrat=
ion of vCPU exposed
with SVM.

However, since QEMU commit 75d373ef9729 ("target-i386: Disable SVM by def=
ault in KVM mode"),
an AMD vCPU that is virtualized by KVM doesn=E2=80=99t expose SVM by defa=
ult, even if you use "-cpu host".
Therefore, it is unlikely that vCPU expose SVM CPUID flag when user is no=
t running an SVM
workload inside guest.

Therefore, change code back to original intent to block migration in
case of vCPU exposed with SVM if kernel does not support required
capabilities to save/restore nested-state.

Fixes: 12604092e26c ("target/i386: kvm: Add nested migration blocker only=
 when kernel lacks required capabilities")
Reviewed-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h     | 10 ++++++++++
 target/i386/kvm.c     |  2 +-
 target/i386/machine.c |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 93345792f4cb..cbe904beeb25 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1867,6 +1867,16 @@ static inline bool cpu_has_vmx(CPUX86State *env)
     return env->features[FEAT_1_ECX] & CPUID_EXT_VMX;
 }
=20
+static inline bool cpu_has_svm(CPUX86State *env)
+{
+    return env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM;
+}
+
+static inline bool cpu_has_nested_virt(CPUX86State *env)
+{
+    return (cpu_has_vmx(env) || cpu_has_svm(env));
+}
+
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index e4b4f5756a34..c2bae6a3023a 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1640,7 +1640,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
=20
-    if (cpu_has_vmx(env) && !nested_virt_mig_blocker &&
+    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker &&
         ((kvm_max_nested_state_length() <=3D 0) || !has_exception_payloa=
d)) {
         error_setg(&nested_virt_mig_blocker,
                    "Kernel do not provide required capabilities for "
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 851b249d1a39..f4d502386df4 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -233,7 +233,7 @@ static int cpu_pre_save(void *opaque)
=20
 #ifdef CONFIG_KVM
     /* Verify we have nested virtualization state from kernel if require=
d */
-    if (kvm_enabled() && cpu_has_vmx(env) && !env->nested_state) {
+    if (kvm_enabled() && cpu_has_nested_virt(env) && !env->nested_state)=
 {
         error_report("Guest enabled nested virtualization but kernel "
                 "does not support saving of nested state");
         return -EINVAL;
--=20
2.20.1


