Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F5C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE12121783
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 16:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2y9zWccH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE12121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdddJ-0005Y8-QY
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 12:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liran.alon@oracle.com>) id 1hddME-0002hM-3C
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1hddMD-00070t-21
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1hddM4-0006vU-BM
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 12:22:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGE3Hm031298;
 Wed, 19 Jun 2019 16:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=1GmbOAxbteTLbo8yPsg654GIHeNPBlXklMYNzYSRJGI=;
 b=2y9zWccHfH3kWAQzAcrFYezZMN1DDpfHfK31m8W9DQ17db+iIkhhFjukMgU80VsnsiYh
 CUuT0gpJwZxwu6mZ4AjkqGke67VbGHtZT+XvCUggxr56lRmdHrrN4fc+gT5NXLetKhAm
 5cbIyCW2iy4kveC1fh3JJgK2F4WGobuCTxO4MmZu8A84A3fk7LcNaNRnq23nMkALK21z
 gi7XFj1zB86Rk4JgoU2rFBVeY2OTQOG8g1LhlCSBogSqxVxdKylJWufQ4wKNC4Tvv8Nx
 Bf6kxUHyHIdzCSKxaEL3AoW0vDOliC/jLM7iKdOjzcaJXjdrbnF3AqJ6CKjmg5mhb7PF 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 2t7809ceng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JGLbuv133107;
 Wed, 19 Jun 2019 16:22:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2t77yn6q1n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jun 2019 16:22:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JGMUhF000913;
 Wed, 19 Jun 2019 16:22:31 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 19 Jun 2019 09:22:30 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 19:21:40 +0300
Message-Id: <20190619162140.133674-11-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619162140.133674-1-liran.alon@oracle.com>
References: <20190619162140.133674-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=895
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=937 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190131
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [QEMU PATCH v4 10/10] target/i386: kvm: Add nested
 migration blocker only when kernel lacks required capabilities
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

Previous commits have added support for migration of nested virtualization
workloads. This was done by utilising two new KVM capabilities:
KVM_CAP_NESTED_STATE and KVM_CAP_EXCEPTION_PAYLOAD. Both which are
required in order to correctly migrate such workloads.

Therefore, change code to add a migration blocker for vCPUs exposed with
Intel VMX or AMD SVM in case one of these kernel capabilities is
missing.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/kvm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 99480a52ad33..a3d0fbed3b35 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1313,9 +1313,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
-    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker) {
+    if (cpu_has_nested_virt(env) && !nested_virt_mig_blocker &&
+        ((kvm_max_nested_state_length() <= 0) || !has_exception_payload)) {
         error_setg(&nested_virt_mig_blocker,
-                   "Nested virtualization does not support live migration yet");
+                   "Kernel do not provide required capabilities for "
+                   "nested virtualization migration. "
+                   "(CAP_NESTED_STATE=%d, CAP_EXCEPTION_PAYLOAD=%d)",
+                   kvm_max_nested_state_length() > 0,
+                   has_exception_payload);
         r = migrate_add_blocker(nested_virt_mig_blocker, &local_err);
         if (local_err) {
             error_report_err(local_err);
-- 
2.20.1


