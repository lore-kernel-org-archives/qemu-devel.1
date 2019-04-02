Received: from eggs.gnu.org ([209.51.188.92]:41543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJRH-0002z0-K3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJRG-0003Yv-FT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJRG-0003YB-6x
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:26:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:26:50 +0200
Message-Id: <20190402132650.23095-2-armbru@redhat.com>
In-Reply-To: <20190402132650.23095-1-armbru@redhat.com>
References: <20190402132650.23095-1-armbru@redhat.com>
In-Reply-To: <20190311060823.18360-1-richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
Subject: [Qemu-devel] [PATCH 4/4] vl: Simplify machine_parse()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richardw.yang@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

Exploit that argument @name is nerver null.  Check is_help_option()
first, because that's what we do elsewhere.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 6a31e5bfac..da1af3e10d 100644
--- a/vl.c
+++ b/vl.c
@@ -2573,19 +2573,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
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
@@ -2597,9 +2588,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
                    mc->is_default ? " (default)" : "",
                    mc->deprecation_reason ? " (deprecated)" : "");
         }
+        exit(0);
     }
-
-    exit(!name || !is_help_option(name));
+        
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
2.17.2
