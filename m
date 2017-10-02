Received: from eggs.gnu.org ([2001:4830:134:3::10]:47058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiR-00029H-PT
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dywiL-00065a-SW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dywiL-00065A-Ms
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 05:08:37 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon,  2 Oct 2017 11:07:54 +0200
Message-Id: <1506935300-132598-13-git-send-email-imammedo@redhat.com>
In-Reply-To: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 12/38] moxie: fix qemu-system-moxie failing to
 start with CLI "-cpu MoxieLite"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, green@moxielogic.com
List-ID: <qemu-devel.nongnu.org>

It 'works' with default CPU only because of bug in
moxie_cpu_class_by_name() where it treats cpu_model
as type name and default cpu_model also happens to be
type name. But specifying explicitly cpu on CLI,
ex: '-cpu MoxieLite', makes QEMU fail since
moxie_cpu_class_by_name() doesn't traslate cpu_model
to cpu type and fails to find corresponding object class.

Fix moxie_cpu_class_by_name() to do proper
   cpu_model -> cpu type
translation and fix default cpu_model to be cpu_model
instead of being typename.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: green@moxielogic.com
---
 hw/moxie/moxiesim.c | 2 +-
 target/moxie/cpu.c  | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 5ea8dd3..01b9f34 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -116,7 +116,7 @@ static void moxiesim_init(MachineState *machine)
 
     /* Init CPUs. */
     if (cpu_model == NULL) {
-        cpu_model = "MoxieLite-moxie-cpu";
+        cpu_model = "MoxieLite";
     }
     cpu = MOXIE_CPU(cpu_generic_init(TYPE_MOXIE_CPU, cpu_model));
     env = &cpu->env;
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 30bd44f..d4626a1 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -89,7 +89,12 @@ static void moxie_cpu_initfn(Object *obj)
 
 static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc = object_class_by_name(cpu_model);
+    ObjectClass *oc;
+    char *typename;
+
+    typename = g_strdup_printf("%s-" TYPE_MOXIE_CPU, cpu_model);
+    oc = object_class_by_name(typename);
+    g_free(typename);
     if (oc != NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) ||
                        object_class_is_abstract(oc))) {
         return NULL;
-- 
2.7.4
