Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimm-00058J-0I
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIif5-0005hx-LU
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif5-0005hg-Fg
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:47 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 22 Apr 2019 20:47:41 -0300
Message-Id: <20190422234742.15780-2-ehabkost@redhat.com>
In-Reply-To: <20190422234742.15780-1-ehabkost@redhat.com>
References: <20190422234742.15780-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] i386: x86_cpu_list_feature_names() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Extract feature name listing code from
x86_cpu_class_check_missing_features().  It will be reused to
return information about CPU filtered features at runtime.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..23e55a9ef2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3619,6 +3619,27 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 static int x86_cpu_filter_features(X86CPU *cpu);
 
+/* Build a list with the name of all features on a feature word array */
+static void x86_cpu_list_feature_names(FeatureWordArray features,
+                                       strList **feat_names)
+{
+    FeatureWord w;
+    strList **next = feat_names;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        uint32_t filtered = features[w];
+        int i;
+        for (i = 0; i < 32; i++) {
+            if (filtered & (1UL << i)) {
+                strList *new = g_new0(strList, 1);
+                new->value = g_strdup(x86_cpu_feature_name(w, i));
+                *next = new;
+                next = &new->next;
+            }
+        }
+    }
+}
+
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
  */
@@ -3626,7 +3647,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
                                                  strList **missing_feats)
 {
     X86CPU *xc;
-    FeatureWord w;
     Error *err = NULL;
     strList **next = missing_feats;
 
@@ -3653,18 +3673,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     x86_cpu_filter_features(xc);
 
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t filtered = xc->filtered_features[w];
-        int i;
-        for (i = 0; i < 32; i++) {
-            if (filtered & (1UL << i)) {
-                strList *new = g_new0(strList, 1);
-                new->value = g_strdup(x86_cpu_feature_name(w, i));
-                *next = new;
-                next = &new->next;
-            }
-        }
-    }
+    x86_cpu_list_feature_names(xc->filtered_features, next);
 
     object_unref(OBJECT(xc));
 }
-- 
2.18.0.rc1.1.g3f1ff2140
