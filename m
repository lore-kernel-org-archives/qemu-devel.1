Received: from eggs.gnu.org ([2001:4830:134:3::10]:52258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhvz9-0008UM-Ml
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhvz4-0003J6-UW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fhvz4-0003Ie-Qm
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:00:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDACD401EF05
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:00:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Jul 2018 14:00:02 +0200
Message-Id: <20180724120003.27053-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: do not migrate MSR_SMI_COUNT on machine
 types <2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

MSR_SMI_COUNT started being migrated in QEMU 2.12.  Do not migrate it
on older machine types, or the subsection causes a load failure for
guests that use SMM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h  | 4 ++++
 target/i386/cpu.c     | 2 ++
 target/i386/cpu.h     | 1 +
 target/i386/machine.c | 2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 654003f44c..6894f37df1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -317,6 +317,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 #define PC_COMPAT_2_11 \
     HW_COMPAT_2_11 \
     {\
+        .driver   = TYPE_X86_CPU,\
+        .property = "x-migrate-smi-count",\
+        .value    = "off",\
+    },{\
         .driver   = "Skylake-Server" "-" TYPE_X86_CPU,\
         .property = "clflushopt",\
         .value    = "off",\
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e0e2f2eea1..92732ef1a0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5435,6 +5435,8 @@ static Property x86_cpu_properties[] = {
                      false),
     DEFINE_PROP_BOOL("vmware-cpuid-freq", X86CPU, vmware_cpuid_freq, true),
     DEFINE_PROP_BOOL("tcg-cpuid", X86CPU, expose_tcg, true),
+    DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
+                     false),
     /*
      * lecacy_cache defaults to true unless the CPU model provides its
      * own cache information (see x86_cpu_load_def()).
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c5a0d90a6..bcda6197a8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1379,6 +1379,7 @@ struct X86CPU {
     bool expose_kvm;
     bool expose_tcg;
     bool migratable;
+    bool migrate_smi_count;
     bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 8b64dff487..084c2c73a8 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -400,7 +400,7 @@ static bool msr_smi_count_needed(void *opaque)
     X86CPU *cpu = opaque;
     CPUX86State *env = &cpu->env;
 
-    return env->msr_smi_count != 0;
+    return cpu->migrate_smi_count && env->msr_smi_count != 0;
 }
 
 static const VMStateDescription vmstate_msr_smi_count = {
-- 
2.17.1
