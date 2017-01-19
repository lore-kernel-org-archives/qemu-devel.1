Received: from eggs.gnu.org ([2001:4830:134:3::10]:34934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtF-0004fC-C6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cUJtE-0001Iv-GR
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cUJtE-0001Hw-Ae
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 16:05:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C33385542
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 21:05:00 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 19 Jan 2017 19:04:46 -0200
Message-Id: <20170119210449.11991-4-ehabkost@redhat.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] i386: Rename X86CPU::host_features to
 X86CPU::max_features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Rename the field and add a small comment to make its purpose
clearer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 10c5a3538d..889363e120 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1211,7 +1211,7 @@ struct X86CPU {
     bool enforce_cpuid;
     bool expose_kvm;
     bool migratable;
-    bool host_features;
+    bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
     /* if true the CPUID code directly forward host cache leaves to the guest */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0c6d8d605e..006d0a8b70 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1583,7 +1583,7 @@ static void host_x86_cpu_initfn(Object *obj)
     /* We can't fill the features array here because we don't know yet if
      * "migratable" is true or false.
      */
-    cpu->host_features = true;
+    cpu->max_features = true;
 
     /* If KVM is disabled, x86_cpu_realizefn() will report an error later */
     if (kvm_enabled()) {
@@ -3102,12 +3102,12 @@ static void x86_cpu_load_features(X86CPU *cpu, Error **errp)
     GList *l;
     Error *local_err = NULL;
 
-    /*TODO: cpu->host_features incorrectly overwrites features
+    /*TODO: cpu->max_features incorrectly overwrites features
      * set using "feat=on|off". Once we fix this, we can convert
      * plus_features & minus_features to global properties
      * inside x86_cpu_parse_featurestr() too.
      */
-    if (cpu->host_features) {
+    if (cpu->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
             env->features[w] =
                 x86_cpu_get_supported_feature_word(w, cpu->migratable);
-- 
2.11.0.259.g40922b1
