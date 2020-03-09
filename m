Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC7C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00B22146E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 23:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZExoTwHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00B22146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSG5-00034Q-1D
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 19:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCk-0005x8-PC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSCj-0006ym-Ox
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSCj-0006xj-Gs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 19:53:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NhFXD016965;
 Mon, 9 Mar 2020 23:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CZple/MNn1m0Ap+EilGNEJvBr/MWvXgtRAyz9gI0rvA=;
 b=ZExoTwHrM8TsurelaychaA75yh1IWwV4i9fobTGBrwYYPUoxV+7TFG3WPMtS8RPlJkO2
 aeD61tmYAMBl65hUZ1UGYYnqGkgklCsq67rl2mWZ5RWm8fGb5mfQZwSgK3SMKp8xUOAw
 e4ugAZl/OhktGYyJAMLs71UNlgibPLNnP52sVoNLCIrRWRK+KnVWAshADIY6eXPP7tCv
 ZVh9oDv7AYlGBQ0KHdBvQsNco0h5VqqGATyiQsL/SM8DLICE1lGSYaG6vdUy7lqJiql7
 7ckwPTj4U6R/vCl57VatsOQmXcPcjZQFtxvffodNFW70yDupi1jJBVdWRdDVhX7ygza+ qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2ym48st188-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029NqxpT095582;
 Mon, 9 Mar 2020 23:52:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2ymnb1karr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 09 Mar 2020 23:52:59 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 029NqiWu008509;
 Mon, 9 Mar 2020 23:52:44 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 16:52:43 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] i386/cpu: Store LAPIC bus frequency in CPU structure
Date: Tue, 10 Mar 2020 01:54:09 +0200
Message-Id: <20200309235411.76587-13-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309235411.76587-1-liran.alon@oracle.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=1 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 impostorscore=0
 mlxlogscore=999 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090143
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 linux-headers/asm-x86/kvm.h | 4 ++++
 target/i386/cpu.h           | 1 +
 target/i386/kvm.c           | 6 +++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 503d3f42da16..99eeaaf2f0b4 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -446,4 +446,8 @@ struct kvm_pmu_event_filter {
 #define KVM_PMU_EVENT_ALLOW 0
 #define KVM_PMU_EVENT_DENY 1
 
+/* From arch/x86/kvm/lapic.h */
+#define KVM_APIC_BUS_CYCLE_NS       1
+#define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
+
 #endif /* _ASM_X86_KVM_H */
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
index 69eb43d796e6..00917196dffb 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1496,6 +1496,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
+    env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
+
     /* Paravirtualization CPUIDs */
     r = hyperv_handle_properties(cs, cpuid_data.entries);
     if (r < 0) {
@@ -1800,9 +1802,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
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


