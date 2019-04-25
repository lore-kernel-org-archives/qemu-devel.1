Received: from eggs.gnu.org ([209.51.188.92]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicT-0000Lf-SZ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicS-00050K-T6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicS-0004zy-Lc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Apr 2019 14:56:53 -0300
Message-Id: <20190425175659.24876-6-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] vl: Simplify machine_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>

From: Markus Armbruster <armbru@redhat.com>

Exploit that argument @name is nerver null.  Check is_help_option()
first, because that's what we do elsewhere.  If we (foolishly!)
defined a machine named "help", -machine help would now print help
instead of selecting the machine named "help".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190405064121.23662-5-richardw.yang@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 69c530a920..4c794f2bf6 100644
--- a/vl.c
+++ b/vl.c
@@ -2576,19 +2576,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
 static MachineClass *machine_parse(const char *name, GSList *machines)
 {
-    MachineClass *mc = NULL;
+    MachineClass *mc;
     GSList *el;
 
-    if (name) {
-        mc = find_machine(name, machines);
-    }
-    if (mc) {
-        return mc;
-    }
-    if (name && !is_help_option(name)) {
-        error_report("unsupported machine type");
-        error_printf("Use -machine help to list supported machines\n");
-    } else {
+    if (is_help_option(name)) {
         printf("Supported machines are:\n");
         machines = g_slist_sort(machines, machine_class_cmp);
         for (el = machines; el; el = el->next) {
@@ -2600,9 +2591,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
                    mc->is_default ? " (default)" : "",
                    mc->deprecation_reason ? " (deprecated)" : "");
         }
+        exit(0);
     }
 
-    exit(!name || !is_help_option(name));
+    mc = find_machine(name, machines);
+    if (!mc) {
+        error_report("unsupported machine type");
+        error_printf("Use -machine help to list supported machines\n");
+        exit(1);
+    }
+    return mc;
 }
 
 void qemu_add_exit_notifier(Notifier *notify)
-- 
2.18.0.rc1.1.g3f1ff2140
