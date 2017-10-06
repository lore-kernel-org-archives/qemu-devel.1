Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOy-0007QL-Ne
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOx-00058a-JJ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:11 -0300
Message-Id: <20171006235023.11952-17-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 16/88] Main loop: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more uses in vl.c (fixed const char * cast),
      squashed cpus-common and changes in util/qemu-timer]
---
 include/qemu/timer.h |  2 +-
 cpus-common.c        |  4 ++--
 util/main-loop.c     |  2 +-
 util/qemu-timer.c    |  2 +-
 vl.c                 | 12 ++++++------
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 1b518bca30..dfc028259c 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -518,7 +518,7 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
                                       QEMUTimerCB *cb,
                                       void *opaque)
 {
-    QEMUTimer *ts = g_malloc0(sizeof(QEMUTimer));
+    QEMUTimer *ts = g_new0(QEMUTimer, 1);
     timer_init_tl(ts, timer_list, scale, cb, opaque);
     return ts;
 }
diff --git a/cpus-common.c b/cpus-common.c
index 59f751ecf9..e613cc33ef 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -158,7 +158,7 @@ void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     struct qemu_work_item *wi;
 
-    wi = g_malloc0(sizeof(struct qemu_work_item));
+    wi = g_new0(struct qemu_work_item, 1);
     wi->func = func;
     wi->data = data;
     wi->free = true;
@@ -301,7 +301,7 @@ void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func,
 {
     struct qemu_work_item *wi;
 
-    wi = g_malloc0(sizeof(struct qemu_work_item));
+    wi = g_new0(struct qemu_work_item, 1);
     wi->func = func;
     wi->data = data;
     wi->free = true;
diff --git a/util/main-loop.c b/util/main-loop.c
index 7558eb5f53..ef784bcda0 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -279,7 +279,7 @@ static PollingEntry *first_polling_entry;
 int qemu_add_polling_cb(PollingFunc *func, void *opaque)
 {
     PollingEntry **ppe, *pe;
-    pe = g_malloc0(sizeof(PollingEntry));
+    pe = g_new0(PollingEntry, 1);
     pe->func = func;
     pe->opaque = opaque;
     for(ppe = &first_polling_entry; *ppe != NULL; ppe = &(*ppe)->next);
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 82d56507a2..2f4e21c482 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -102,7 +102,7 @@ QEMUTimerList *timerlist_new(QEMUClockType type,
     QEMUTimerList *timer_list;
     QEMUClock *clock = qemu_clock_ptr(type);
 
-    timer_list = g_malloc0(sizeof(QEMUTimerList));
+    timer_list = g_new0(QEMUTimerList, 1);
     qemu_event_init(&timer_list->timers_done_ev, true);
     timer_list->clock = clock;
     timer_list->notify_cb = cb;
diff --git a/vl.c b/vl.c
index 3fed457921..9f82a375b3 100644
--- a/vl.c
+++ b/vl.c
@@ -1416,7 +1416,7 @@ static int add_semihosting_arg(void *opaque,
     if (strcmp(name, "arg") == 0) {
         s->argc++;
         /* one extra element as g_strjoinv() expects NULL-terminated array */
-        s->argv = g_realloc(s->argv, (s->argc + 1) * sizeof(void *));
+        s->argv = g_renew(const char *, s->argv, s->argc + 1);
         s->argv[s->argc - 1] = val;
         s->argv[s->argc] = NULL;
     }
@@ -1589,7 +1589,7 @@ MachineInfoList *qmp_query_machines(Error **errp)
         MachineInfoList *entry;
         MachineInfo *info;
 
-        info = g_malloc0(sizeof(*info));
+        info = g_new0(MachineInfo, 1);
         if (mc->is_default) {
             info->has_is_default = true;
             info->is_default = true;
@@ -1604,7 +1604,7 @@ MachineInfoList *qmp_query_machines(Error **errp)
         info->cpu_max = !mc->max_cpus ? 1 : mc->max_cpus;
         info->hotpluggable_cpus = mc->has_hotpluggable_cpus;
 
-        entry = g_malloc0(sizeof(*entry));
+        entry = g_new0(MachineInfoList, 1);
         entry->value = info;
         entry->next = mach_list;
         mach_list = entry;
@@ -1657,7 +1657,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
 {
     VMChangeStateEntry *e;
 
-    e = g_malloc0(sizeof (*e));
+    e = g_new0(VMChangeStateEntry, 1);
 
     e->cb = cb;
     e->opaque = opaque;
@@ -2546,7 +2546,7 @@ static void add_device_config(int type, const char *cmdline)
 {
     struct device_config *conf;
 
-    conf = g_malloc0(sizeof(*conf));
+    conf = g_new0(struct device_config, 1);
     conf->type = type;
     conf->cmdline = cmdline;
     loc_save(&conf->loc);
@@ -3047,7 +3047,7 @@ static int global_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     GlobalProperty *g;
 
-    g = g_malloc0(sizeof(*g));
+    g = g_new0(GlobalProperty, 1);
     g->driver   = qemu_opt_get(opts, "driver");
     g->property = qemu_opt_get(opts, "property");
     g->value    = qemu_opt_get(opts, "value");
-- 
2.14.2
