Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8942CC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8C0206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 21:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4y9JJvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8C0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnVEH-0002Jc-6H
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 17:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.kanda@oracle.com>) id 1hnVE0-0001P3-Oq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.kanda@oracle.com>) id 1hnVDz-00057Y-Pm
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.kanda@oracle.com>)
 id 1hnVDz-000576-JP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 17:43:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL98jA147642;
 Tue, 16 Jul 2019 21:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ET7rfOnI5o/CGDTO//9HRJJX0G0WIxDMPYPS3OmtRO0=;
 b=Q4y9JJvMzP5Z/aLP6dZvebq4pVPKyuAy7hXh1sgSi2KIkZ+lMdbBT0YIu5c6afzHQmtp
 PoHC5zekW7CEMz2sogaMF7Ayccs+8NcB16Yg9Fm0ODTX1owlxGDTgi00Z0oRfC+Uq2Nz
 e4FmXAd2qTdIz5m5/NnWpw8riW/ah8ZEafqHyhTaBL9FUQ9zcqMHHCaSCBtIUoHINZDK
 yRW5faauMztBQtuI2KEN/Aoia3fxHRdmv+IC7cfnysc4PklxdnlZiKyUxYac2SS6//O+
 pa4lSL5abM5+gdLbFZr87seMCdnVNyMmTTYv0TRGA5K6DFRA5geqPBkV0i9fgPc2fq1v EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2tq78pq1m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 21:43:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GL8Mum122045;
 Tue, 16 Jul 2019 21:43:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2tq5bcn3wd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2019 21:43:01 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GLh1Nx011684;
 Tue, 16 Jul 2019 21:43:01 GMT
Received: from mhkanda-aus-1.us.oracle.com (/10.135.188.192)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 16 Jul 2019 21:43:01 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 16:44:11 -0500
Message-Id: <1563313451-19861-2-git-send-email-mark.kanda@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563313451-19861-1-git-send-email-mark.kanda@oracle.com>
References: <1563313451-19861-1-git-send-email-mark.kanda@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160259
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160259
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [PATCH-for-4.2 1/1] Only enable the halt poll control
 MSR if it is supported by the host
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The halt poll control MSR should only be enabled on hosts which
support it.

Fixes: ("kvm: i386: halt poll control MSR support")

Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
---
 target/i386/cpu.c     | 8 +++++++-
 target/i386/kvm.c     | 2 --
 target/i386/machine.c | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a8bafdb8b9..dacbf7a9fe 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2838,7 +2838,6 @@ static PropValue kvm_default_props[] = {
     { "kvm-asyncpf", "on" },
     { "kvm-steal-time", "on" },
     { "kvm-pv-eoi", "on" },
-    { "kvm-poll-control", "on" },
     { "kvmclock-stable-bit", "on" },
     { "x2apic", "on" },
     { "acpi", "off" },
@@ -5109,6 +5108,13 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
 
+    /* Enable the halt poll control MSR if it is supported by the host */
+    if (x86_cpu_get_supported_feature_word(FEAT_KVM, cpu->migratable) &
+        (1 << KVM_FEATURE_POLL_CONTROL)) {
+        env->features[FEAT_KVM] |= 1 << KVM_FEATURE_POLL_CONTROL;
+        env->poll_control_msr = 1;
+    }
+
 out:
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index cb22684139..81dd5d2c1b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1796,8 +1796,6 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
 
         hyperv_x86_synic_reset(cpu);
     }
-    /* enabled by default */
-    env->poll_control_msr = 1;
 }
 
 void kvm_arch_do_init_vcpu(X86CPU *cpu)
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 20077a8a5a..9d6095b264 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -394,7 +394,6 @@ static bool steal_time_msr_needed(void *opaque)
     return cpu->env.steal_time_msr != 0;
 }
 
-/* Poll control MSR enabled by default */
 static bool poll_control_msr_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
-- 
2.21.0


