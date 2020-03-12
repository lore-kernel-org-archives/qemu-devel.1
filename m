Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C7C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BFBD2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xZdo4U+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFBD2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRRk-0005sQ-NW
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jCR50-0003Uv-Qp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jCR4w-0000oo-AI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57510)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jCR4w-0000o4-2U
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:53:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGmjxn012017;
 Thu, 12 Mar 2020 16:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Y+xng8xGIGilSa0d/6zOW6qU5eyKDrqFR+ferzQsKk8=;
 b=xZdo4U+b5CWwImymMTBc3d7t4AFlHkgmPP4hwWhZTCb7ypL3GNTyqk5kl3q3skoP06wQ
 iR/9FugCw+8JdJm+ui2+UolIcqqjUrJ+DophCPjG9EIUm+XQRSmsCznqy4wNd/ZAHTIZ
 3UMEq8yE5CYAcSKMPbxewHAfBW69LJXDM1c9AO2z2JV1vb7TzXAacNFWAhzQdXHnz7+k
 3fy8bkpSQd01wbQ6qwyDdi/KVxoKUP4VZcZ9U3pPN0x5nBtmRppv8dGeIwYBgQAQHIvM
 rc84OqPwNbnRJBhhOClVY7h/LyTmWz/HbCd9zIHYjYeC+ejqHkskkOyOGTa0+vDocDKr 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ym31utt4t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:53:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CGoEal053965;
 Thu, 12 Mar 2020 16:53:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2yqgvdb18j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 16:52:59 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CGqxX2032450;
 Thu, 12 Mar 2020 16:52:59 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 09:52:58 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/16] i386/cpu: Store LAPIC bus frequency in CPU structure
Date: Thu, 12 Mar 2020 18:54:29 +0200
Message-Id: <20200312165431.82118-15-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312165431.82118-1-liran.alon@oracle.com>
References: <20200312165431.82118-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: ehabkost@redhat.com, mst@redhat.com, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No functional change.
This information will be used by following patches.

Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbfc8..9c7cd7cde107 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1580,6 +1580,7 @@ typedef struct CPUX86State {
     bool tsc_valid;
     int64_t tsc_khz;
     int64_t user_tsc_khz; /* for sanity check only */
+    uint64_t apic_bus_freq;
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 69eb43d796e6..8534ca9760d7 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -60,6 +60,10 @@
     do { } while (0)
 #endif
 
+/* From arch/x86/kvm/lapic.h */
+#define KVM_APIC_BUS_CYCLE_NS       1
+#define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
+
 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
 
@@ -1496,6 +1500,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
+
     /* Paravirtualization CPUIDs */
     r = hyperv_handle_properties(cs, cpuid_data.entries);
     if (r < 0) {
@@ -1800,9 +1806,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_SIGNATURE | 0x10;
         c->eax = env->tsc_khz;
-        /* LAPIC resolution of 1ns (freq: 1GHz) is hardcoded in KVM's
-         * APIC_BUS_CYCLE_NS */
-        c->ebx = 1000000;
+        c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
         c->ecx = c->edx = 0;
 
         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
-- 
2.20.1


