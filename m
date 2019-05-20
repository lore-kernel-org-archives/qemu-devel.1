Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E027C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66165217D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 08:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66165217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49397 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT0ao-00055x-Jr
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 04:57:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hT0WD-0001Nd-Sm
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hT0WC-0000fv-JQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:1689)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
	id 1hT0WC-0000dP-8W
	for qemu-devel@nongnu.org; Tue, 21 May 2019 04:53:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 May 2019 01:53:07 -0700
X-ExtLoop1: 1
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.98])
	by fmsmga007.fm.intel.com with ESMTP; 21 May 2019 01:53:05 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 00:50:56 +0800
Message-Id: <20190520165056.175475-6-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520165056.175475-1-like.xu@linux.intel.com>
References: <20190520165056.175475-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] [PATCH v2 5/5] target/i386: Add CPUID.1F generation
 support for multi-die PCMachine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Peter Crosthwaite <crosthwaite.peter@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Brice Goglin <Brice.Goglin@inria.fr>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPUID.1F as Intel V2 Extended Topology Enumeration Leaf would be exposed
if guests want to emulate multiple software-visible die within each package.
Per Intel's SDM, the 0x1f is a superset of 0xb, thus they can be generated
by almost same code as 0xb except die_offset setting.

If the number of dies per package is less than 2, the qemu will not expose
CPUID.1F regardless of whether the host supports CPUID.1F, and in any case,
cpuid.0.eax would store the maximum input value for **guest** basic CPUID.

If users do want to expose CPUID.1F by passing dies > 1 for simulation without
host support, there will be a smp topology warning but it is not blocking.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 target/i386/cpu.c | 37 +++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 target/i386/kvm.c | 30 ++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3222bd3254..cd6c9933c3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4417,6 +4417,42 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
         }
 
+        assert(!(*eax & ~0x1f));
+        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
+        break;
+    case 0x1F:
+        /* V2 Extended Topology Enumeration Leaf */
+        if (env->nr_dies < 2 || !cpu->enable_cpuid_0x1f) {
+            *eax = *ebx = *ecx = *edx = 0;
+            break;
+        }
+
+        *ecx = count & 0xff;
+        *edx = cpu->apic_id;
+        switch (count) {
+        case 0:
+            *eax = apicid_core_offset(env->nr_dies, cs->nr_cores,
+                                                    cs->nr_threads);
+            *ebx = cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            break;
+        case 1:
+            *eax = apicid_die_offset(env->nr_dies, cs->nr_cores,
+                                                   cs->nr_threads);
+            *ebx = cs->nr_cores * cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            break;
+        case 2:
+            *eax = apicid_pkg_offset(env->nr_dies, cs->nr_cores,
+                                                   cs->nr_threads);
+            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
+            break;
+        default:
+            *eax = 0;
+            *ebx = 0;
+            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+        }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
@@ -5864,6 +5900,7 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
     DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
     DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
+    DEFINE_PROP_BOOL("cpuid-0x1f", X86CPU, enable_cpuid_0x1f, true),
     DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
     DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
     DEFINE_PROP_BOOL("kvm-no-smi-migration", X86CPU, kvm_no_smi_migration,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d5f2a60ff5..9b54c646e7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -735,6 +735,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
 #define CPUID_TOPOLOGY_LEVEL_INVALID  (0U << 8)
 #define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
 #define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
+#define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
 
 /* MSR Feature Bits */
 #define MSR_ARCH_CAP_RDCL_NO    (1U << 0)
@@ -1455,6 +1456,9 @@ struct X86CPU {
     /* Compatibility bits for old machine types: */
     bool enable_cpuid_0xb;
 
+    /* V2 Compatibility bits for old machine types: */
+    bool enable_cpuid_0x1f;
+
     /* Enable auto level-increase for all CPUID leaves */
     bool full_cpuid_auto_level;
 
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 3b29ce5c0d..d8b8bd5c9e 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -931,12 +931,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
-    int r;
+    int r, cpuid_0_entry, cpuid_min_level;
     Error *local_err = NULL;
 
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
-    cpuid_i = 0;
+    cpuid_i = cpuid_0_entry = cpuid_min_level = 0;
 
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
@@ -1050,6 +1050,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
 
+    if (limit < 0x1f && env->nr_dies > 1 && cpu->enable_cpuid_0x1f) {
+        limit = env->cpuid_level = env->cpuid_min_level = 0x1f;
+        warn_report("CPU topology: the CPUID.1F isn't supported on the host.");
+    }
+
     for (i = 0; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
             fprintf(stderr, "unsupported level value: 0x%x\n", limit);
@@ -1081,6 +1086,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
             }
             break;
         }
+        case 0x1f:
+            if (env->nr_dies < 2 || !cpu->enable_cpuid_0x1f) {
+                break;
+            }
         case 4:
         case 0xb:
         case 0xd:
@@ -1088,6 +1097,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 if (i == 0xd && j == 64) {
                     break;
                 }
+
+                if (i == 0x1f && j == 64) {
+                    break;
+                }
+
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
@@ -1099,6 +1113,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
                 if (i == 0xb && !(c->ecx & 0xff00)) {
                     break;
                 }
+                if (i == 0x1f && !(c->ecx & 0xff00)) {
+                    break;
+                }
                 if (i == 0xd && c->eax == 0) {
                     continue;
                 }
@@ -1139,8 +1156,17 @@ int kvm_arch_init_vcpu(CPUState *cs)
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             break;
         }
+
+        cpuid_0_entry = (i == 0) ? (cpuid_i - 1) : cpuid_0_entry;
+        cpuid_min_level =
+                ((c->eax | c->ebx | c->ecx | c->edx | c->flags | c->index) &&
+                                (i > cpuid_min_level)) ? i : cpuid_min_level;
     }
 
+    env->cpuid_level = env->cpuid_min_level = cpuid_min_level;
+    c = &cpuid_data.entries[cpuid_0_entry];
+    cpu_x86_cpuid(env, 0, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
     if (limit >= 0x0a) {
         uint32_t eax, edx;
 
-- 
2.21.0


