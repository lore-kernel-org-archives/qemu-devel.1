Received: from eggs.gnu.org ([2001:4830:134:3::10]:33651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5Z-0003ay-Kn
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1e5W-0006bg-U0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:51:45 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  9 Oct 2017 21:51:04 +0200
Message-Id: <1507578671-158758-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/24] ppc: move ppc_cpu_lookup_alias()
 before its first user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>

next commit will drop ppc_cpu_lookup_alias() declaration from header
and make it static which will break its last user ppc_cpu_class_by_name()
since ppc_cpu_class_by_name() defined before ppc_cpu_lookup_alias().

To avoid this move ppc_cpu_lookup_alias() right before
ppc_cpu_class_by_name().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - split from "ppc: spapr: use generic cpu_model parsing"
    were asked by David, it makes the next patch a little
    smaller
---
 target/ppc/translate_init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 3d16481..17ac95b 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10060,6 +10060,19 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr)
     return pcc;
 }
 
+const char *ppc_cpu_lookup_alias(const char *alias)
+{
+    int ai;
+
+    for (ai = 0; ppc_cpu_aliases[ai].alias != NULL; ai++) {
+        if (strcmp(ppc_cpu_aliases[ai].alias, alias) == 0) {
+            return ppc_cpu_aliases[ai].model;
+        }
+    }
+
+    return NULL;
+}
+
 static ObjectClass *ppc_cpu_class_by_name(const char *name)
 {
     char *cpu_model, *typename;
@@ -10152,19 +10165,6 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
     pcc->parent_parse_features(type, features, errp);
 }
 
-const char *ppc_cpu_lookup_alias(const char *alias)
-{
-    int ai;
-
-    for (ai = 0; ppc_cpu_aliases[ai].alias != NULL; ai++) {
-        if (strcmp(ppc_cpu_aliases[ai].alias, alias) == 0) {
-            return ppc_cpu_aliases[ai].model;
-        }
-    }
-
-    return NULL;
-}
-
 PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
 {
     ObjectClass *oc = OBJECT_CLASS(pcc);
-- 
2.7.4
