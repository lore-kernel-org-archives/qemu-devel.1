Received: from eggs.gnu.org ([2001:4830:134:3::10]:58457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vRY-000588-Oo
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e2vRT-0003Ua-PU
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:44 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:56336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e2vRT-0003Tn-K4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:35:39 -0400
Received: from player773.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 26863140016
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 10:35:38 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 13 Oct 2017 10:35:31 +0200
Message-ID: <150788373123.25736.7359515819699182906.stgit@bahia>
In-Reply-To: <150788370618.25736.8030708425923435364.stgit@bahia>
References: <150788370618.25736.8030708425923435364.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2/2] monitor: add proper reference counting of
 the current CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>

If a CPU selected with the "cpu" command is hot-unplugged then "info cpus"
causes QEMU to exit:

(qemu) device_del cpu1
(qemu) info cpus
qemu:qemu_cpu_kick_thread: No such process

This happens because "cpu" stores the pointer to the selected CPU into
the monitor structure. When the CPU is hot-unplugged, we end up with a
dangling pointer. The "info cpus" command then does:

hmp_info_cpus()
 monitor_get_cpu_index()
  mon_get_cpu()
   cpu_synchronize_state() <--- called with dangling pointer

This could cause a QEMU crash as well.

This patch switches the monitor to use object_ref() to ensure the
CPU object doesn't vanish unexpectedly. The reference is dropped
either when "cpu" is used to switch to another CPU, or when the
selected CPU is unrealized and cpu_list_remove() sets its cpu_index
back to UNASSIGNED_CPU_INDEX.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 monitor.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/monitor.c b/monitor.c
index fe0d1bdbb461..1c0b9a2c3ad3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -579,6 +579,9 @@ static void monitor_data_init(Monitor *mon)
 
 static void monitor_data_destroy(Monitor *mon)
 {
+    if (mon->mon_cpu) {
+        object_unref((Object *) mon->mon_cpu);
+    }
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
         json_message_parser_destroy(&mon->qmp.parser);
@@ -1047,12 +1050,21 @@ int monitor_set_cpu(int cpu_index)
     if (cpu == NULL) {
         return -1;
     }
+    if (cur_mon->mon_cpu) {
+        object_unref((Object *) cur_mon->mon_cpu);
+    }
     cur_mon->mon_cpu = cpu;
+    object_ref((Object *) cpu);
     return 0;
 }
 
 CPUState *mon_get_cpu(void)
 {
+    if (cur_mon->mon_cpu &&
+        cur_mon->mon_cpu->cpu_index == UNASSIGNED_CPU_INDEX) {
+        object_unref((Object *) cur_mon->mon_cpu);
+        cur_mon->mon_cpu = NULL;
+    }
     if (!cur_mon->mon_cpu) {
         if (!first_cpu) {
             return NULL;
