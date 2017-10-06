Received: from eggs.gnu.org ([2001:4830:134:3::10]:41609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPo-0008IJ-4a
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPl-0005pl-1f
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:26 -0300
Message-Id: <20171006235023.11952-32-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 31/88] QMP: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: more changes]
---
 monitor.c                 | 14 +++++++-------
 qmp.c                     | 14 +++++++-------
 tests/test-qmp-commands.c | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/monitor.c b/monitor.c
index fe0d1bdbb4..ea6a485f11 100644
--- a/monitor.c
+++ b/monitor.c
@@ -906,7 +906,7 @@ static void query_commands_cb(QmpCommand *cmd, void *opaque)
         return;
     }
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(CommandInfoList, 1);
     info->value = g_malloc0(sizeof(*info->value));
     info->value->name = g_strdup(cmd->name);
     info->next = *list;
@@ -1799,7 +1799,7 @@ static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     int nchannels = qdict_get_try_int(qdict, "nchannels", -1);
     CaptureState *s;
 
-    s = g_malloc0 (sizeof (*s));
+    s = g_new0(CaptureState, 1);
 
     freq = has_freq ? freq : 44100;
     bits = has_bits ? bits : 16;
@@ -1947,7 +1947,7 @@ void qmp_getfd(const char *fdname, Error **errp)
         return;
     }
 
-    monfd = g_malloc0(sizeof(mon_fd_t));
+    monfd = g_new0(mon_fd_t, 1);
     monfd->name = g_strdup(fdname);
     monfd->fd = fd;
 
@@ -2110,7 +2110,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
         QLIST_FOREACH(mon_fdset_fd, &mon_fdset->fds, next) {
             FdsetFdInfoList *fdsetfd_info;
 
-            fdsetfd_info = g_malloc0(sizeof(*fdsetfd_info));
+            fdsetfd_info = g_new0(FdsetFdInfoList, 1);
             fdsetfd_info->value = g_malloc0(sizeof(*fdsetfd_info->value));
             fdsetfd_info->value->fd = mon_fdset_fd->fd;
             if (mon_fdset_fd->opaque) {
@@ -2199,7 +2199,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
         }
     }
 
-    mon_fdset_fd = g_malloc0(sizeof(*mon_fdset_fd));
+    mon_fdset_fd = g_new0(MonFdsetFd, 1);
     mon_fdset_fd->fd = fd;
     mon_fdset_fd->removed = false;
     if (has_opaque) {
@@ -2207,7 +2207,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     }
     QLIST_INSERT_HEAD(&mon_fdset->fds, mon_fdset_fd, next);
 
-    fdinfo = g_malloc0(sizeof(*fdinfo));
+    fdinfo = g_new0(AddfdInfo, 1);
     fdinfo->fdset_id = mon_fdset->id;
     fdinfo->fd = mon_fdset_fd->fd;
 
@@ -4102,7 +4102,7 @@ void monitor_init(Chardev *chr, int flags)
         is_first_init = 0;
     }
 
-    mon = g_malloc(sizeof(*mon));
+    mon = g_new(Monitor, 1);
     monitor_data_init(mon);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
diff --git a/qmp.c b/qmp.c
index e8c303116a..e965020e37 100644
--- a/qmp.c
+++ b/qmp.c
@@ -232,7 +232,7 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
     while ((prop = object_property_iter_next(&iter))) {
         ObjectPropertyInfoList *entry = g_malloc0(sizeof(*entry));
 
-        entry->value = g_malloc0(sizeof(ObjectPropertyInfo));
+        entry->value = g_new0(ObjectPropertyInfo, 1);
         entry->next = props;
         props = entry;
 
@@ -432,7 +432,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
     ObjectTypeInfo *info;
     ObjectClass *parent = object_class_get_parent(klass);
 
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(ObjectTypeInfo, 1);
     info->name = g_strdup(object_class_get_name(klass));
     info->has_abstract = info->abstract = object_class_is_abstract(klass);
     if (parent) {
@@ -440,7 +440,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
         info->parent = g_strdup(object_class_get_name(parent));
     }
 
-    e = g_malloc0(sizeof(*e));
+    e = g_new0(ObjectTypeInfoList, 1);
     e->value = info;
     e->next = *pret;
     *pret = e;
@@ -490,7 +490,7 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
                 return NULL;           /* no way to set it, don't show */
             }
 
-            info = g_malloc0(sizeof(*info));
+            info = g_new0(DevicePropertyInfo, 1);
             info->name = g_strdup(prop->name);
             info->type = default_type ? g_strdup(default_type)
                                       : g_strdup(prop->info->name);
@@ -502,7 +502,7 @@ static DevicePropertyInfo *make_device_property_info(ObjectClass *klass,
     } while (klass != object_class_by_name(TYPE_DEVICE));
 
     /* Not a qdev property, use the default type */
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(DevicePropertyInfo, 1);
     info->name = g_strdup(name);
     info->type = g_strdup(default_type);
     info->has_description = !!description;
@@ -568,7 +568,7 @@ DevicePropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        entry = g_malloc0(sizeof(*entry));
+        entry = g_new0(DevicePropertyInfoList, 1);
         entry->value = info;
         entry->next = prop_list;
         prop_list = entry;
@@ -712,7 +712,7 @@ ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
 
 MemoryInfo *qmp_query_memory_size_summary(Error **errp)
 {
-    MemoryInfo *mem_info = g_malloc0(sizeof(MemoryInfo));
+    MemoryInfo *mem_info = g_new0(MemoryInfo, 1);
 
     mem_info->base_memory = ram_size;
 
diff --git a/tests/test-qmp-commands.c b/tests/test-qmp-commands.c
index 904c89d4d4..e715c45a23 100644
--- a/tests/test-qmp-commands.c
+++ b/tests/test-qmp-commands.c
@@ -28,8 +28,8 @@ UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
                               Error **errp)
 {
     UserDefTwo *ret;
-    UserDefOne *ud1c = g_malloc0(sizeof(UserDefOne));
-    UserDefOne *ud1d = g_malloc0(sizeof(UserDefOne));
+    UserDefOne *ud1c = g_new0(UserDefOne, 1);
+    UserDefOne *ud1d = g_new0(UserDefOne, 1);
 
     ud1c->string = strdup(ud1a->string);
     ud1c->integer = ud1a->integer;
@@ -209,23 +209,23 @@ static void test_dealloc_types(void)
     UserDefOne *ud1test, *ud1a, *ud1b;
     UserDefOneList *ud1list;
 
-    ud1test = g_malloc0(sizeof(UserDefOne));
+    ud1test = g_new0(UserDefOne, 1);
     ud1test->integer = 42;
     ud1test->string = g_strdup("hi there 42");
 
     qapi_free_UserDefOne(ud1test);
 
-    ud1a = g_malloc0(sizeof(UserDefOne));
+    ud1a = g_new0(UserDefOne, 1);
     ud1a->integer = 43;
     ud1a->string = g_strdup("hi there 43");
 
-    ud1b = g_malloc0(sizeof(UserDefOne));
+    ud1b = g_new0(UserDefOne, 1);
     ud1b->integer = 44;
     ud1b->string = g_strdup("hi there 44");
 
-    ud1list = g_malloc0(sizeof(UserDefOneList));
+    ud1list = g_new0(UserDefOneList, 1);
     ud1list->value = ud1a;
-    ud1list->next = g_malloc0(sizeof(UserDefOneList));
+    ud1list->next = g_new0(UserDefOneList, 1);
     ud1list->next->value = ud1b;
 
     qapi_free_UserDefOneList(ud1list);
-- 
2.14.2
