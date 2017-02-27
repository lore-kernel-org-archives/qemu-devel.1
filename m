Received: from eggs.gnu.org ([2001:4830:134:3::10]:43719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6u-0007wB-Ms
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ciO6q-0005C7-FI
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ciO6q-0005Bt-9Z
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:12 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Feb 2017 13:24:53 -0300
Message-Id: <20170227162501.29280-4-ehabkost@redhat.com>
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 03/11] i386: Rename X86CPU::host_features to
 X86CPU::max_features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

Rename the field and add a small comment to make its purpose
clearer.

Message-Id: <20170119210449.11991-4-ehabkost@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 2 +-
 target/i386/cpu.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8df124f332..5f75ab1b15 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1211,7 +1211,7 @@ struct X86CPU {
     bool enforce_cpuid;
     bool expose_kvm;
     bool migratable;
-    bool host_features;
+    bool max_features; /* Enable all supported features automatically */
     uint32_t apic_id;
 
     /* Enables publishing of TSC increment and Local APIC bus frequencies to
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8efe4de89e..87affbfcd6 100644
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
@@ -3101,12 +3101,12 @@ static void x86_cpu_load_features(X86CPU *cpu, Error **errp)
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
