Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5A9C10F25
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664DA2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 00:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/Qeqwgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664DA2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBSvP-0000fS-JB
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 20:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBSuZ-000805-P2
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBSuY-00059D-6d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBSuX-00057r-U1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 20:38:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0We7I023879;
 Tue, 10 Mar 2020 00:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=fRLOQ0i2fa3f5CcKlbY/dGaHuzyDTPmiV0AbAqY4DZE=;
 b=X/QeqwgvYReMPzOjLUs8on/9ZIG6BBQfXf6P2Me6SxrhZEEEL7Y8BNPhUnhmbqxBMRVt
 XUbhaqwLEuHlBGa73irfvtMFy5QD/oapmcJhKcajzyXEhiWN7W1lrNwjiLnjQJhsBHw3
 KhV5FccCmytoHkIQUm/nv76PFnQKNcd0cZ86uu16EctijpPXVE9wS6AjlGOy3gS4IARI
 rz68OZiXpcZB4sZ3SjOEDN3uRqGk/sgsnnXJSK2H8Vh3oydozjlAk1oGCB6lRBHiamjK
 u1g0mH0m+058ryQFR7ubuHxTlEOMMoUUwOazaqHwGgb7hRl4DLmjYbwQxEU+eNvv7tze eQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ym3jqj91w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:38:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A0VRHn173226;
 Tue, 10 Mar 2020 00:38:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 2ymun85jt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 00:38:14 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02A0cDDL001873;
 Tue, 10 Mar 2020 00:38:13 GMT
Received: from spark.ravello.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 09 Mar 2020 17:38:12 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386/kvm: Add CPU property to expose VMware CPUID signature
Date: Tue, 10 Mar 2020 02:40:17 +0200
Message-Id: <20200310004017.100484-1-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Cc: pbonzini@redhat.com, mtosatti@redhat.com,
 Liran Alon <liran.alon@oracle.com>, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some guests are only familiar with VMware PV interface. Therefore, in
order for these guests to run properly on KVM, we need to be able to
expose VMware main CPUID leaf. i.e. leaf 0x40000000.

E.g. Without exposing this VMware CPUID leaf, some guests will fail to boot.
For example, because of guest attempt to calibrate TSC.

Signed-off-by: Liran Alon <liran.alon@oracle.com>
---
 target/i386/cpu.c |  1 +
 target/i386/cpu.h |  1 +
 target/i386/kvm.c | 35 +++++++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 92fafa265914..694766d45a9b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7127,6 +7127,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
                      false),
+    DEFINE_PROP_BOOL("vmware-cpuid", X86CPU, expose_vmware, false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
     DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c7cd7cde107..bca626963e25 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1647,6 +1647,7 @@ struct X86CPU {
      */
     bool force_features;
     bool expose_kvm;
+    bool expose_vmware;
     bool expose_tcg;
     bool migratable;
     bool migrate_smi_count;
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 00917196dffb..2656258b96b3 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1187,6 +1187,15 @@ static int hyperv_handle_properties(CPUState *cs,
     if (!hyperv_enabled(cpu))
         return 0;
 
+    /*
+     * VMware & Hyper-V conflicts in CPUID leafs.
+     * Therefore, they cannot exists together.
+     */
+    if (cpu->expose_vmware) {
+        error_report("vmware-cpuid not compatible with hyperv options");
+        return -ENOTSUP;
+    }
+
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ||
         cpu->hyperv_passthrough) {
         uint16_t evmcs_version;
@@ -1508,6 +1517,18 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_hv_hypercall = true;
     }
 
+    if (cpu->expose_vmware) {
+        c = &cpuid_data.entries[cpuid_i++];
+        c->function = KVM_CPUID_SIGNATURE;
+        memcpy(signature, "VMwareVMware", 12);
+        c->eax = KVM_CPUID_SIGNATURE;
+        c->ebx = signature[0];
+        c->ecx = signature[1];
+        c->edx = signature[2];
+
+        kvm_base = KVM_CPUID_SIGNATURE_NEXT;
+    }
+
     if (cpu->expose_kvm) {
         memcpy(signature, "KVMKVMKVM\0\0\0", 12);
         c = &cpuid_data.entries[cpuid_i++];
@@ -1791,11 +1812,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    if (cpu->vmware_cpuid_freq
-        /* Guests depend on 0x40000000 to detect this feature, so only expose
-         * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
-        && cpu->expose_kvm
-        && kvm_base == KVM_CPUID_SIGNATURE
+    if (cpu->vmware_cpuid_freq &&
+        (cpu->expose_vmware ||
+         /*
+          * Guests depend on 0x40000000 to detect this feature, so only expose
+          * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V)
+          */
+          (cpu->expose_kvm && kvm_base == KVM_CPUID_SIGNATURE))
         /* TSC clock must be stable and known for this feature. */
         && tsc_is_stable_and_known(env)) {
 
@@ -1805,7 +1828,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
         c->ecx = c->edx = 0;
 
-        c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
+        c = cpuid_find_entry(&cpuid_data.cpuid, KVM_CPUID_SIGNATURE, 0);
         c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
     }
 
-- 
2.20.1


