Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cscyw-00058G-Ut
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cscyt-0007Oy-Iq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:19:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cscyt-0007Oa-8l
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 18:19:19 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 28 Mar 2017 00:19:37 +0200
Message-Id: <1490653177-131484-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] i386: Allow cpuid bit override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

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
 target/i386/cpu.c | 30 ++++++++++++++++++++++++++----
 target/i386/cpu.h |  3 +++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7aa7622..5a22f9a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2229,7 +2229,7 @@ void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf)
     g_slist_foreach(list, x86_cpu_list_entry, &s);
     g_slist_free(list);
 
-    (*cpu_fprintf)(f, "\nRecognized CPUID flags:\n");
+    (*cpu_fprintf)(f, "\nRecognized CPUID flags (=on|=off|=force):\n");
     for (i = 0; i < ARRAY_SIZE(feature_word_info); i++) {
         FeatureWordInfo *fw = &feature_word_info[i];
 
@@ -3460,6 +3460,7 @@ static int x86_cpu_filter_features(X86CPU *cpu)
             x86_cpu_get_supported_feature_word(w, false);
         uint32_t requested_features = env->features[w];
         env->features[w] &= host_feat;
+        env->features[w] |= cpu->forced_features[w];
         cpu->filtered_features[w] = requested_features & ~env->features[w];
         if (cpu->filtered_features[w]) {
             rv = 1;
@@ -3693,6 +3694,7 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 
 typedef struct BitProperty {
     uint32_t *ptr;
+    uint32_t *force_ptr;
     uint32_t mask;
 } BitProperty;
 
@@ -3701,7 +3703,15 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 {
     BitProperty *fp = opaque;
     bool value = (*fp->ptr & fp->mask) == fp->mask;
-    visit_type_bool(v, name, &value, errp);
+    bool forced = (*fp->force_ptr & fp->mask) == fp->mask;
+    char str[] = "force";
+    char *strval = str;
+
+    if (!forced) {
+        strcpy(str, value ? "on" : "off");
+    }
+
+    visit_type_str(v, name, &strval, errp);
 }
 
 static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
@@ -3710,6 +3720,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     BitProperty *fp = opaque;
     Error *local_err = NULL;
+    char *strval = NULL;
     bool value;
 
     if (dev->realized) {
@@ -3717,7 +3728,15 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
+    visit_type_str(v, name, &strval, &local_err);
+    if (!local_err && !strcmp(strval, "force")) {
+        value = true;
+        *fp->force_ptr |= fp->mask;
+    } else {
+        local_err = NULL;
+        visit_type_bool(v, name, &value, &local_err);
+    }
+
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -3746,6 +3765,7 @@ static void x86_cpu_release_bit_prop(Object *obj, const char *name,
 static void x86_cpu_register_bit_prop(X86CPU *cpu,
                                       const char *prop_name,
                                       uint32_t *field,
+                                      uint32_t *force_field,
                                       int bitnr)
 {
     BitProperty *fp;
@@ -3760,6 +3780,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
     } else {
         fp = g_new0(BitProperty, 1);
         fp->ptr = field;
+        fp->force_ptr = force_field;
         fp->mask = mask;
         object_property_add(OBJECT(cpu), prop_name, "bool",
                             x86_cpu_get_bit_prop,
@@ -3787,7 +3808,8 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
     /* aliases don't use "|" delimiters anymore, they are registered
      * manually using object_property_add_alias() */
     assert(!strchr(name, '|'));
-    x86_cpu_register_bit_prop(cpu, name, &cpu->env.features[w], bitnr);
+    x86_cpu_register_bit_prop(cpu, name, &cpu->env.features[w],
+                              &cpu->forced_features[w], bitnr);
 }
 
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 07401ad..128530e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1228,6 +1228,9 @@ struct X86CPU {
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
