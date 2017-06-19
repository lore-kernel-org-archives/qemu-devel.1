Received: from eggs.gnu.org ([2001:4830:134:3::10]:42576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8n-00038t-Dp
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMw8m-0004rG-FB
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMw8l-0004qS-Ud
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 08:50:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1290811A9
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 12:50:46 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 19 Jun 2017 20:49:42 +0800
Message-Id: <1497876588-947-8-git-send-email-peterx@redhat.com>
In-Reply-To: <1497876588-947-1-git-send-email-peterx@redhat.com>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 07/13] tcg: use AccelState.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Let tcg use the new AccelState.global_props as well (used similar trick
for the kvm convertion in previous patch). Basically we are moving the
tcg_default_props into tcg codes, and link these compat properties onto
newly created AccelState.global_props.

This is much simpler than KVM.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel.c           | 15 +++++++++++++++
 target/i386/cpu.c | 28 ----------------------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/accel.c b/accel.c
index ca1d0f5..f4c2b10 100644
--- a/accel.c
+++ b/accel.c
@@ -38,9 +38,24 @@
 int tcg_tb_size;
 static bool tcg_allowed = true;
 
+static AccelPropValue x86_tcg_default_props[] = {
+    { "vme", "off" },
+    { NULL, NULL },
+};
+
+static void tcg_register_accel_props(AccelState *accel)
+{
+    AccelPropValue *entry;
+
+    for (entry = x86_tcg_default_props; entry->prop; entry++) {
+        accel_register_x86_cpu_props(accel, entry->prop, entry->value);
+    }
+}
+
 static int tcg_init(MachineState *ms)
 {
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
+    tcg_register_accel_props(ms->accelerator);
     return 0;
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5214fba..89f67b0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1480,17 +1480,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
     },
 };
 
-typedef struct PropValue {
-    const char *prop, *value;
-} PropValue;
-
-/* TCG-specific defaults that override all CPU models when using TCG
- */
-static PropValue tcg_default_props[] = {
-    { "vme", "off" },
-    { NULL, NULL },
-};
-
 static uint32_t x86_cpu_get_supported_feature_word(FeatureWord w,
                                                    bool migratable_only);
 
@@ -2262,18 +2251,6 @@ static void x86_cpu_report_filtered_features(X86CPU *cpu)
     }
 }
 
-static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
-{
-    PropValue *pv;
-    for (pv = props; pv->prop; pv++) {
-        if (!pv->value) {
-            continue;
-        }
-        object_property_parse(OBJECT(cpu), pv->value, pv->prop,
-                              &error_abort);
-    }
-}
-
 /* Load data from X86CPUDefinition into a X86CPU object
  */
 static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
@@ -2300,11 +2277,6 @@ static void x86_cpu_load_def(X86CPU *cpu, X86CPUDefinition *def, Error **errp)
         env->features[w] = def->features[w];
     }
 
-    /* Special cases not set in the X86CPUDefinition structs: */
-    if (tcg_enabled()) {
-        x86_cpu_apply_props(cpu, tcg_default_props);
-    }
-
     env->features[FEAT_1_ECX] |= CPUID_EXT_HYPERVISOR;
 
     /* sysenter isn't supported in compatibility mode on AMD,
-- 
2.7.4
