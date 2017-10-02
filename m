Received: from eggs.gnu.org ([2001:4830:134:3::10]:47145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywic-0002Iu-O8
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiW-0006As-Pm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiW-0006AF-GN
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:48 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:08:03 +0200
Message-Id: <1506935300-132598-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 21/38] sh4: remove SuperHCPUClass::name field
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, aurelien@aurel32.net
List-ID: <qemu-devel.nongnu.org>

the field contains upper-cased cpu model name and is used
for printing supported cpu model names for '-cpu help'.

Considering that cpu model lookup in superh_cpu_class_by_name()
is case-insensitive, we can drop upper-casing when
printing supported cpus list and use cpu type directly
to do the same by cutting out SUPERH_CPU_TYPE_SUFFIX from
typename.

It allows to remove SuperHCPUClass::name, which practically
duplicates names defined by TYPE_SH*_CPU definitions and
simplify sh*_class_init()/SuperHCPUClass a bit.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: aurelien@aurel32.net
---
 target/sh4/cpu-qom.h |  2 --
 target/sh4/cpu.c     | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 17deeb6..0f9fb4d 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -39,7 +39,6 @@
  * SuperHCPUClass:
  * @parent_realize: The parent class' realize handler.
  * @parent_reset: The parent class' reset handler.
- * @name: The name.
  * @pvr: Processor Version Register
  * @prr: Processor Revision Register
  * @cvr: Cache Version Register
@@ -54,7 +53,6 @@ typedef struct SuperHCPUClass {
     DeviceRealize parent_realize;
     void (*parent_reset)(CPUState *cpu);
 
-    const char *name;
     uint32_t pvr;
     uint32_t prr;
     uint32_t cvr;
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index b71ff01..8dfbdeb 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -98,12 +98,11 @@ static gint superh_cpu_list_compare(gconstpointer a, gconstpointer b)
 
 static void superh_cpu_list_entry(gpointer data, gpointer user_data)
 {
-    ObjectClass *oc = data;
-    SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
     SuperHCPUListState *s = user_data;
+    const char *typename = object_class_get_name(OBJECT_CLASS(data));
+    int len = strlen(typename) - strlen(SUPERH_CPU_TYPE_SUFFIX);
 
-    (*s->cpu_fprintf)(s->file, "%s\n",
-                      scc->name);
+    (*s->cpu_fprintf)(s->file, "%.*s\n", len, typename);
 }
 
 void sh4_cpu_list(FILE *f, fprintf_function cpu_fprintf)
@@ -156,7 +155,6 @@ static void sh7750r_class_init(ObjectClass *oc, void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
-    scc->name = "SH7750R";
     scc->pvr = 0x00050000;
     scc->prr = 0x00000100;
     scc->cvr = 0x00110000;
@@ -175,7 +173,6 @@ static void sh7751r_class_init(ObjectClass *oc, void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
-    scc->name = "SH7751R";
     scc->pvr = 0x04050005;
     scc->prr = 0x00000113;
     scc->cvr = 0x00110000; /* Neutered caches, should be 0x20480000 */
@@ -194,7 +191,6 @@ static void sh7785_class_init(ObjectClass *oc, void *data)
 {
     SuperHCPUClass *scc = SUPERH_CPU_CLASS(oc);
 
-    scc->name = "SH7785";
     scc->pvr = 0x10300700;
     scc->prr = 0x00000200;
     scc->cvr = 0x71440211;
-- 
2.7.4
