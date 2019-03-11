Received: from eggs.gnu.org ([209.51.188.92]:37114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3EI1-0003ss-Bl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3E7N-0005Ne-Nu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:08:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:64405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3E7N-0005Mj-Db
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 02:08:57 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Mon, 11 Mar 2019 14:08:23 +0800
Message-Id: <20190311060823.18360-3-richardw.yang@linux.intel.com>
In-Reply-To: <20190311060823.18360-1-richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] vl.c: allocate TYPE_MACHINE list once
 during bootup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

Now all the functions used to select machine is local and the call flow
looks like below:

    select_machine()
        find_default_machine()
        machine_parse()
            find_machine()

All these related function will need a GSList for TYPE_MACHINE.
Currently we allocate this list each time we use it, while this is not
necessary to do so because we don't need to modify this.

This patch make the TYPE_MACHINE list allocation in select_machine and
pass this to its child for use.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 vl.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/vl.c b/vl.c
index 3688e2bc98..cf08d96ce4 100644
--- a/vl.c
+++ b/vl.c
@@ -1418,9 +1418,9 @@ static int usb_parse(const char *cmdline)
 
 MachineState *current_machine;
 
-static MachineClass *find_machine(const char *name)
+static MachineClass *find_machine(const char *name, GSList *machines)
 {
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
     MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
@@ -1437,13 +1437,12 @@ static MachineClass *find_machine(const char *name)
         }
     }
 
-    g_slist_free(machines);
     return mc;
 }
 
-static MachineClass *find_default_machine(void)
+static MachineClass *find_default_machine(GSList *machines)
 {
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
     MachineClass *mc = NULL;
 
     for (el = machines; el; el = el->next) {
@@ -1455,7 +1454,6 @@ static MachineClass *find_default_machine(void)
         }
     }
 
-    g_slist_free(machines);
     return mc;
 }
 
@@ -2538,16 +2536,15 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
                   object_class_get_name(OBJECT_CLASS(mc1)));
 }
 
-static MachineClass *machine_parse(const char *name)
+static MachineClass *machine_parse(const char *name, GSList *machines)
 {
     MachineClass *mc = NULL;
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el;
 
     if (name) {
-        mc = find_machine(name);
+        mc = find_machine(name, machines);
     }
     if (mc) {
-        g_slist_free(machines);
         return mc;
     }
     if (name && !is_help_option(name)) {
@@ -2567,7 +2564,6 @@ static MachineClass *machine_parse(const char *name)
         }
     }
 
-    g_slist_free(machines);
     exit(!name || !is_help_option(name));
 }
 
@@ -2659,7 +2655,8 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
 
 static MachineClass *select_machine(void)
 {
-    MachineClass *machine_class = find_default_machine();
+    GSList *machines = object_class_get_list(TYPE_MACHINE, false);
+    MachineClass *machine_class = find_default_machine(machines);
     const char *optarg;
     QemuOpts *opts;
     Location loc;
@@ -2671,7 +2668,7 @@ static MachineClass *select_machine(void)
 
     optarg = qemu_opt_get(opts, "type");
     if (optarg) {
-        machine_class = machine_parse(optarg);
+        machine_class = machine_parse(optarg, machines);
     }
 
     if (!machine_class) {
@@ -2681,6 +2678,7 @@ static MachineClass *select_machine(void)
     }
 
     loc_pop(&loc);
+    g_slist_free(machines);
     return machine_class;
 }
 
-- 
2.19.1
