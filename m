Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38703C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08740208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzltViBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08740208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcw2r-0006uE-91
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52218)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hcvtE-0005mO-Jn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hcvtD-0003et-EA
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hcvtB-0003cb-0N
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:57:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHrn7e137680;
 Mon, 17 Jun 2019 17:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=0RSntdRx6QqqhsqLWe/RLsVDuGaRBLAt8N9sd8tE1S4=;
 b=HzltViBkoKXPyI5dR4BHq1DuVsys/ffSnBvmKF006kBEtZwfdQI70LUJBhVeh6Sp7dD+
 /m7vxx0rFqGTIAv1BuT5yCK2h4EYPOU8oBQ4J8iaByUBFR4YneJAEtTSVZI/R4uKOvOg
 YnkjcpwJmLdO2j2I4UjOSBUyyEIqtUJiwfk7wAOZg7PVd942yE7PUL8JFLqrICi+nJRX
 fmOb1RjN2jDeDgHTODy9FzuDdTZfOxyPTk3NFOFgzV/vBAYHhPHEXNiKRUJj2TiHuN4E
 oMLoSIwd6XK9n7SWVao+I7Y2K4XB01Ry8t47S7OtcoahDceGScge7a8v3whe6FWCnhas cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2t4r3tg0j0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HHvhWB130990;
 Mon, 17 Jun 2019 17:57:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t59gdc0nw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 17:57:49 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HHvmdT017551;
 Mon, 17 Jun 2019 17:57:48 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 10:57:48 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:56:58 +0300
Message-Id: <20190617175658.135869-10-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617175658.135869-1-liran.alon@oracle.com>
References: <20190617175658.135869-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=978
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170160
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [QEMU PATCH v3 9/9] KVM: i386: Remove VMX migration
 blocker
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, dgilbert@redhat.com, Liran Alon <liran.alon@oracle.com>,
 pbonzini@redhat.com, rth@twiddle.net, jmattson@google.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This effectively reverts d98f26073beb ("target/i386: kvm: add VMX migration blocker").
This can now be done because previous commits added support for Intel VMX migration.

AMD SVM migration is still blocked. This is because kernel
KVM_CAP_{GET,SET}_NESTED_STATE in case of AMD SVM is not
implemented yet. Therefore, required vCPU nested state is still
missing in order to perform valid migration for vCPU exposed with SVM.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 797f8ac46435..772c8619efc4 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -948,7 +948,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 }
 
 static Error *invtsc_mig_blocker;
-static Error *nested_virt_mig_blocker;
+static Error *svm_mig_blocker;
 
 #define KVM_MAX_CPUID_ENTRIES  100
 
@@ -1313,13 +1313,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
-        error_setg(&nested_virt_mig_blocker,
-                   "Nested virtualization does not support live migration yet");
-        r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
+    if (cpu_has_svm(env) && !svm_mig_blocker) {
+        error_setg(&svm_mig_blocker,
+                   "AMD SVM does not support live migration yet");
+        r = migrate_add_blocker(svm_mig_blocker, &local_err);
         if (local_err) {
             error_report_err(local_err);
-            error_free(nested_virt_mig_blocker);
+            error_free(svm_mig_blocker);
             return r;
         }
     }
-- 
2.20.1


