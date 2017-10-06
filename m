Received: from eggs.gnu.org ([2001:4830:134:3::10]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYE-0003r5-R5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e0aYE-0001cm-2d
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e0aYD-0001by-T8
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 17:52:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE9B420271
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 21:52:56 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  6 Oct 2017 18:52:39 -0300
Message-Id: <20171006215244.27104-3-ehabkost@redhat.com>
In-Reply-To: <20171006215244.27104-1-ehabkost@redhat.com>
References: <20171006215244.27104-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] target/i386: x86_cpu_expand_feature()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

x86_cpu_expand_features() needs to ensure it won't touch
user-configured features when changing cpu->features.  Make a
helper for that, and use it when handling cpu->max_features.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 98732cd65f..90c969363e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3486,6 +3486,25 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
  *   any CPUID data based on host capabilities.
  */
 
+/**
+ * x86_cpu_expand_feature:
+ *
+ * Change cpu->features, being careful to not override features explicitly
+ * configured bv the user.
+ *
+ * @w: the feature word to be changed
+ * @mask: the bits to be changed in cpu->features[w]
+ * @value: the new value for the bits in (cpu->features[w] & @mask)
+ */
+static void x86_cpu_expand_feature(X86CPU *cpu, FeatureWord w,
+                                   uint32_t mask, uint32_t value)
+{
+    assert((value & mask) == value);
+    mask &= ~cpu->env.user_features[w];
+    cpu->env.features[w] &= ~mask;
+    cpu->env.features[w] |= value & mask;
+}
+
 /* Expand CPU configuration data, based on configured features
  * and host/accelerator capabilities when appropriate.
  */
@@ -3503,12 +3522,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
      */
     if (cpu->max_features) {
         for (w = 0; w < FEATURE_WORDS; w++) {
-            /* Override only features that weren't set explicitly
-             * by the user.
-             */
-            env->features[w] |=
-                x86_cpu_get_supported_feature_word(w, cpu->migratable) &
-                ~env->user_features[w];
+            uint32_t f = x86_cpu_get_supported_feature_word(w, cpu->migratable);
+            x86_cpu_expand_feature(cpu, w, ~0, f);
         }
     }
 
-- 
2.13.6
