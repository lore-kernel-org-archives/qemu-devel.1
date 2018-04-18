Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8ivN-0005J1-2Z
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8ivM-0003uQ-2C
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:58:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f8ivL-0003u0-Sy
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 04:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 680E781A88B4
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 08:58:43 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 18 Apr 2018 16:58:30 +0800
Message-Id: <20180418085831.12058-3-peterx@redhat.com>
In-Reply-To: <20180418085831.12058-1-peterx@redhat.com>
References: <20180418085831.12058-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] monitor: take mon_lock where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com

Went through all the montior.h APIs to make sure existing Monitor
related APIs will always take the new monitor lock when necessary.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/monitor.c b/monitor.c
index c93aa4e22b..f4951cafbc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -306,16 +306,20 @@ void monitor_read_command(Monitor *mon, int show_prompt)
     if (!mon->rs)
         return;
 
+    qemu_mutex_lock(&mon->mon_lock);
     readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
     if (show_prompt)
         readline_show_prompt(mon->rs);
+    qemu_mutex_unlock(&mon->mon_lock);
 }
 
 int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
                           void *opaque)
 {
     if (mon->rs) {
+        qemu_mutex_lock(&mon->mon_lock);
         readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
+        qemu_mutex_unlock(&mon->mon_lock);
         /* prompt is printed on return from the command handler */
         return 0;
     } else {
@@ -1308,8 +1312,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
     cur_mon->qmp.commands = &qmp_commands;
 }
 
-/* set the current CPU defined by the user */
-int monitor_set_cpu(int cpu_index)
+static int monitor_set_cpu_locked(Monitor *mon, int cpu_index)
 {
     CPUState *cpu;
 
@@ -1317,15 +1320,28 @@ int monitor_set_cpu(int cpu_index)
     if (cpu == NULL) {
         return -1;
     }
-    g_free(cur_mon->mon_cpu_path);
-    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(mon->mon_cpu_path);
+    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
+/* set the current CPU defined by the user */
+int monitor_set_cpu(int cpu_index)
+{
+    int ret;
+
+    qemu_mutex_lock(&cur_mon->mon_lock);
+    ret = monitor_set_cpu_locked(cur_mon, cpu_index);
+    qemu_mutex_unlock(&cur_mon->mon_lock);
+
+    return ret;
+}
+
 static CPUState *mon_get_cpu_sync(bool synchronize)
 {
     CPUState *cpu;
 
+    qemu_mutex_lock(&cur_mon->mon_lock);
     if (cur_mon->mon_cpu_path) {
         cpu = (CPUState *) object_resolve_path_type(cur_mon->mon_cpu_path,
                                                     TYPE_CPU, NULL);
@@ -1336,11 +1352,14 @@ static CPUState *mon_get_cpu_sync(bool synchronize)
     }
     if (!cur_mon->mon_cpu_path) {
         if (!first_cpu) {
+            qemu_mutex_unlock(&cur_mon->mon_lock);
             return NULL;
         }
-        monitor_set_cpu(first_cpu->cpu_index);
+        monitor_set_cpu_locked(cur_mon, first_cpu->cpu_index);
         cpu = first_cpu;
     }
+    qemu_mutex_unlock(&cur_mon->mon_lock);
+
     if (synchronize) {
         cpu_synchronize_state(cpu);
     }
@@ -2239,6 +2258,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
 
+    qemu_mutex_lock(&mon->mon_lock);
     QLIST_FOREACH(monfd, &mon->fds, next) {
         int fd;
 
@@ -2252,9 +2272,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
         QLIST_REMOVE(monfd, next);
         g_free(monfd->name);
         g_free(monfd);
-
+        qemu_mutex_unlock(&mon->mon_lock);
         return fd;
     }
+    qemu_mutex_unlock(&mon->mon_lock);
 
     error_setg(errp, "File descriptor named '%s' has not been found", fdname);
     return -1;
-- 
2.14.3
