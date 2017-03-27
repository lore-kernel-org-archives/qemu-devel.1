Received: from eggs.gnu.org ([2001:4830:134:3::10]:55677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVwW-00040x-Kn
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1csVwU-0005lh-NS
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1csVwU-0005lI-Ev
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:48:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 27 Mar 2017 11:48:14 -0300
Message-Id: <20170327144815.8043-2-ehabkost@redhat.com>
In-Reply-To: <20170327144815.8043-1-ehabkost@redhat.com>
References: <20170327144815.8043-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 v2 1/2] i386: Replace uint32_t* with
 FeatureWord on feature getter/setter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, "Collin L . Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>

Instead of passing a pointer to the feature property getter and
setter functions, pass a FeatureWord enum so they can perform
other actions related to the feature flag.

This will be used to add a new "user_features" field to keep
track of features that were explicitly set by the user.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7aa762245a..feefa5b8a4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3692,15 +3692,17 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 }
 
 typedef struct BitProperty {
-    uint32_t *ptr;
+    FeatureWord w;
     uint32_t mask;
 } BitProperty;
 
 static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
+    X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    bool value = (*fp->ptr & fp->mask) == fp->mask;
+    uint32_t f = cpu->env.features[fp->w];
+    bool value = (f & fp->mask) == fp->mask;
     visit_type_bool(v, name, &value, errp);
 }
 
@@ -3708,6 +3710,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
+    X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
     Error *local_err = NULL;
     bool value;
@@ -3724,9 +3727,9 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
-        *fp->ptr |= fp->mask;
+        cpu->env.features[fp->w] |= fp->mask;
     } else {
-        *fp->ptr &= ~fp->mask;
+        cpu->env.features[fp->w] &= ~fp->mask;
     }
 }
 
@@ -3745,7 +3748,7 @@ static void x86_cpu_release_bit_prop(Object *obj, const char *name,
  */
 static void x86_cpu_register_bit_prop(X86CPU *cpu,
                                       const char *prop_name,
-                                      uint32_t *field,
+                                      FeatureWord w,
                                       int bitnr)
 {
     BitProperty *fp;
@@ -3755,11 +3758,11 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
     op = object_property_find(OBJECT(cpu), prop_name, NULL);
     if (op) {
         fp = op->opaque;
-        assert(fp->ptr == field);
+        assert(fp->w == w);
         fp->mask |= mask;
     } else {
         fp = g_new0(BitProperty, 1);
-        fp->ptr = field;
+        fp->w = w;
         fp->mask = mask;
         object_property_add(OBJECT(cpu), prop_name, "bool",
                             x86_cpu_get_bit_prop,
@@ -3787,7 +3790,7 @@ static void x86_cpu_register_feature_bit_props(X86CPU *cpu,
     /* aliases don't use "|" delimiters anymore, they are registered
      * manually using object_property_add_alias() */
     assert(!strchr(name, '|'));
-    x86_cpu_register_bit_prop(cpu, name, &cpu->env.features[w], bitnr);
+    x86_cpu_register_bit_prop(cpu, name, w, bitnr);
 }
 
 static GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs)
-- 
2.11.0.259.g40922b1
