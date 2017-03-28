Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cspH1-0003U2-Nv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cspGy-00013I-FL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:44391)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cspGy-00012s-55
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 07:26:48 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 28 Mar 2017 13:27:06 +0200
Message-Id: <1490700426-222115-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH v2] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

KVM has a feature bitmap of CPUID bits that it knows works for guests.
QEMU removes bits that are not part of that bitmap automatically on VM
start.

However, some times we just don't list features in that list because
they don't make sense for normal scenarios, but may be useful in specific,
targeted workloads.

For that purpose, add a new =force option to all CPUID feature flags in
the CPU property. With that we can override the accel filtering and give
users full control over the CPUID feature bits exposed into guests.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - Base on "i386: Replace uint32_t* with FeatureWord on feature getter/setter"
---
 target/i386/cpu.c | 25 ++++++++++++++++++++++---
 target/i386/cpu.h |  3 +++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985..6105fc5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2229,7 +2229,7 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     g_slist_foreach(list, x86_cpu_list_entry, &s);
     g_slist_free(list);
 
-    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
+    (*cpu_fprintf)(f, "\nRecognized CPUID flags (=on|=off|=force):\n");
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw = &feature_word_info[i];
 
@@ -3464,6 +3464,7 @@ static int x86_cpu_filter_features(X86CPU *cpu)
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
         env->features[w] &= host_feat;
+        env->features[w] |= cpu->forced_features[w];
         cpu->filtered_features[w] = requested_features & ~env->features[w];
         if (cpu->filtered_features[w]) {
             rv = 1;
@@ -3706,8 +3707,17 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
     uint32_t f = cpu->env.features[fp->w];
+    uint32_t ff = cpu->forced_features[fp->w];
     bool value = (f & fp->mask) == fp->mask;
-    visit_type_bool(v, name, &value, errp);
+    bool forced = (ff & fp->mask) == fp->mask;
+    char str[] = "force";
+    char *strval = str;
+
+    if (forced) {
+        visit_type_str(v, name, &strval, errp);
+    } else {
+        visit_type_bool(v, name, &value, errp);
+    }
 }
 
 static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -3717,6 +3727,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
     Error *local_err = NULL;
+    char *strval = NULL;
     bool value;
 
     if (dev->realized) {
@@ -3724,7 +3735,15 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
+    visit_type_str(v, name, &strval, &local_err);
+    if (!local_err && !strcmp(strval, "force")) {
+        value = true;
+        cpu->forced_features[fp->w] |= fp->mask;
+    } else {
+        local_err = NULL;
+        visit_type_bool(v, name, &value, &local_err);
+    }
+
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c4602ca..69efe6c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1230,6 +1230,9 @@ struct X86CPU {
     /* Features that were filtered out because of missing host capabilities */
     uint32_t filtered_features[FEATURE_WORDS];
 
+    /* Features that are force enabled despite incompatible accel */
+    uint32_t forced_features[FEATURE_WORDS];
+
     /* Enable PMU CPUID bits. This can't be enabled by default yet because
      * it doesn't have ABI stability guarantees, as it passes all PMU CPUID
      * bits returned by GET_SUPPORTED_CPUID (that depend on host CPU and kernel
-- 
1.8.5.6
