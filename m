Received: from eggs.gnu.org ([2001:4830:134:3::10]:48495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHu6-0003Pd-Oq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqHu3-0001QC-GZ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqHu1-0001Mr-9u
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:01:27 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 16 Aug 2018 14:01:08 +0100
Message-Id: <20180816130118.31841-2-berrange@redhat.com>
In-Reply-To: <20180816130118.31841-1-berrange@redhat.com>
References: <20180816130118.31841-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 01/11] util: add helper APIs for dealing
 with inotify in portable manner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The inotify userspace API for reading events is quite horrible, so it is
useful to wrap it in a more friendly API to avoid duplicating code
across many users in QEMU. Wrapping it also allows introduction of a
platform portability layer, so that we can add impls for non-Linux based
equivalents in future.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 MAINTAINERS                |   6 +
 include/qemu/filemonitor.h | 117 ++++++++++++++
 util/Makefile.objs         |   1 +
 util/filemonitor.c         | 315 +++++++++++++++++++++++++++++++++++++
 util/trace-events          |   9 ++
 5 files changed, 448 insertions(+)
 create mode 100644 include/qemu/filemonitor.h
 create mode 100644 util/filemonitor.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 666e936812..1284bb3443 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1803,6 +1803,12 @@ F: include/qemu/sockets.h
 F: util/qemu-sockets.c
 F: qapi/sockets.json
=20
+File monitor
+M: Daniel P. Berrange <berrange@redhat.com>
+S: Odd fixes
+F: util/filemonitor.c
+F: include/qemu/filemonitor.h
+
 Throttling infrastructure
 M: Alberto Garcia <berto@igalia.com>
 S: Supported
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
new file mode 100644
index 0000000000..1326272f0a
--- /dev/null
+++ b/include/qemu/filemonitor.h
@@ -0,0 +1,117 @@
+/*
+ * QEMU file monitor helper
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#ifndef QEMU_FILE_MONITOR_H
+#define QEMU_FILE_MONITOR_H
+
+#include "qemu-common.h"
+
+
+typedef struct QFileMonitor QFileMonitor;
+
+typedef enum {
+    /* File has been created in a dir */
+    QFILE_MONITOR_EVENT_CREATED,
+    /* File has been modified in a dir */
+    QFILE_MONITOR_EVENT_MODIFIED,
+    /* File has been deleted in a dir */
+    QFILE_MONITOR_EVENT_DELETED,
+    /* Dir is no longer being monitored (due to deletion) */
+    QFILE_MONITOR_EVENT_IGNORED,
+} QFileMonitorEvent;
+
+
+/**
+ * QFileMonitorHandler:
+ * @id: id from qemu_file_monitor_add_watch()
+ * @event: the file change that occurred
+ * @filename: the name of the file affected
+ * @opaque: opaque data provided to qemu_file_monitor_add_watch()
+ *
+ * Invoked whenever a file changes. If @event is
+ * QFILE_MONITOR_EVENT_IGNORED, @filename will be
+ * empty.
+ *
+ */
+typedef void (*QFileMonitorHandler)(int id,
+                                    QFileMonitorEvent event,
+                                    const char *filename,
+                                    void *opaque);
+
+/**
+ * qemu_file_monitor_get_instance:
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Acquire a handle to the shared file monitoring object.
+ *
+ * This object does locking internally to enable it to be
+ * safe to use from multiple threads
+ *
+ * If the platform does not support file monitoring, an
+ * error will be reported. Likewise if file monitoring
+ * is supported, but cannot be initialized
+ *
+ * Currently this is implemented on Linux platforms with
+ * the inotify subsystem.
+ *
+ * Returns: the shared monitoring object, or NULL on error
+ */
+QFileMonitor *qemu_file_monitor_get_instance(Error **errp);
+
+/**
+ * qemu_file_monitor_add_watch:
+ * @mon: the file monitor context
+ * @dirpath: the directory whose contents to watch
+ * @filename: optional filename to filter on
+ * @cb: the function to invoke when @dirpath has changes
+ * @opaque: data to pass to @cb
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Register to receive notifications of changes
+ * in the directory @dirpath. All files in the
+ * directory will be monitored. If the caller is
+ * only interested in one specific file, @filename
+ * can be used to filter events.
+ *
+ * Returns: a positive integer watch ID, or -1 on error
+ */
+int qemu_file_monitor_add_watch(QFileMonitor *mon,
+                                const char *dirpath,
+                                const char *filename,
+                                QFileMonitorHandler cb,
+                                void *opaque,
+                                Error **errp);
+
+/**
+ * qemu_file_monitor_remove_watch:
+ * @mon: the file monitor context
+ * @dirpath: the directory whose contents to unwatch
+ * @id: id of the watch to remove
+ *
+ * Removes the file monitoring watch @id, associated
+ * with the directory @dirpath. This must never be
+ * called from a QFileMonitorHandler callback, or a
+ * deadlock will result.
+ */
+void qemu_file_monitor_remove_watch(QFileMonitor *mon,
+                                    const char *dirpath,
+                                    int id);
+
+#endif /* QEMU_FILE_MONITOR_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index e1c3fed4dc..769d295a27 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -48,4 +48,5 @@ util-obj-y +=3D range.o
 util-obj-y +=3D stats64.o
 util-obj-y +=3D systemd.o
 util-obj-y +=3D iova-tree.o
+util-obj-y +=3D filemonitor.o
 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
diff --git a/util/filemonitor.c b/util/filemonitor.c
new file mode 100644
index 0000000000..67d7aedbe0
--- /dev/null
+++ b/util/filemonitor.c
@@ -0,0 +1,315 @@
+/*
+ * QEMU file_monitor helper
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/filemonitor.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+struct QFileMonitor {
+    QemuMutex lock;
+    int fd;
+
+    GHashTable *dirs; /* dirname =3D> QFileMonitorDir */
+    GHashTable *idmap; /* inotify ID =3D> dirname */
+};
+
+
+typedef struct {
+    int id; /* watch ID */
+    char *filename; /* optional filter */
+    QFileMonitorHandler cb;
+    void *opaque;
+} QFileMonitorWatch;
+
+
+typedef struct {
+    char *path;
+    int id; /* inotify ID */
+    int nextid; /* watch ID counter */
+    gsize nwatches;
+    QFileMonitorWatch *watches;
+} QFileMonitorDir;
+
+
+#ifdef CONFIG_INOTIFY1
+#include <sys/inotify.h>
+
+static void qemu_file_monitor_watch(void *arg)
+{
+    QFileMonitor *mon =3D arg;
+    char buf[4096]
+        __attribute__ ((aligned(__alignof__(struct inotify_event))));
+    int used =3D 0;
+    int len =3D read(mon->fd, buf, sizeof(buf));
+
+    qemu_mutex_lock(&mon->lock);
+
+    if (len < 0) {
+        if (errno !=3D EAGAIN) {
+            error_report("Failure monitoring inotify FD, disabling event=
s");
+            goto cleanup;
+        }
+
+        /* no more events right now */
+        goto cleanup;
+    }
+
+    /* Loop over all events in the buffer */
+    while (used < len) {
+        struct inotify_event *ev =3D
+            (struct inotify_event *)(buf + used);
+        const char *name =3D ev->len ? ev->name : "";
+        QFileMonitorDir *dir =3D g_hash_table_lookup(mon->idmap,
+                                                   GINT_TO_POINTER(ev->w=
d));
+        uint32_t iev =3D ev->mask &
+            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
+             IN_MOVED_TO | IN_MOVED_FROM);
+        int qev;
+        gsize i;
+
+        used +=3D sizeof(struct inotify_event) + ev->len;
+
+        if (!dir) {
+            continue;
+        }
+
+        /*
+         * During a rename operation, the old name gets
+         * IN_MOVED_FROM and the new name gets IN_MOVED_TO.
+         * To simplify life for callers, we turn these into
+         * DELETED and CREATED events
+         */
+        switch (iev) {
+        case IN_CREATE:
+        case IN_MOVED_TO:
+            qev =3D QFILE_MONITOR_EVENT_CREATED;
+            break;
+        case IN_MODIFY:
+            qev =3D QFILE_MONITOR_EVENT_MODIFIED;
+            break;
+        case IN_DELETE:
+        case IN_MOVED_FROM:
+            qev =3D QFILE_MONITOR_EVENT_DELETED;
+            break;
+        case IN_IGNORED:
+            qev =3D QFILE_MONITOR_EVENT_IGNORED;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        trace_qemu_file_monitor_event(mon, dir->path, name, ev->mask, di=
r->id);
+        for (i =3D 0; i < dir->nwatches; i++) {
+            QFileMonitorWatch *watch =3D &dir->watches[i];
+
+            if (watch->filename =3D=3D NULL ||
+                (name && g_str_equal(watch->filename, name))) {
+                trace_qemu_file_monitor_dispatch(mon, dir->path, name,
+                                                 qev, watch->cb,
+                                                 watch->opaque, watch->i=
d);
+                watch->cb(watch->id, qev, name, watch->opaque);
+            }
+        }
+    }
+
+ cleanup:
+    qemu_mutex_unlock(&mon->lock);
+}
+
+static void
+qemu_file_monitor_dir_free(void *data)
+{
+    QFileMonitorDir *dir =3D data;
+
+    g_free(dir->watches);
+    g_free(dir);
+}
+
+#endif
+
+static QFileMonitor *
+qemu_file_monitor_new(Error **errp)
+{
+#ifdef CONFIG_INOTIFY1
+    int fd;
+    QFileMonitor *mon;
+
+    fd =3D inotify_init1(IN_NONBLOCK);
+    if (fd < 0) {
+        error_setg_errno(errp, errno,
+                         "Unable to initialize inotify");
+        return NULL;
+    }
+
+    mon =3D g_new0(QFileMonitor, 1);
+    qemu_mutex_init(&mon->lock);
+    mon->fd =3D fd;
+
+    mon->dirs =3D g_hash_table_new_full(g_str_hash, g_str_equal, NULL,
+                                      qemu_file_monitor_dir_free);
+    mon->idmap =3D g_hash_table_new(g_direct_hash, g_direct_equal);
+
+    trace_qemu_file_monitor_new(mon, mon->fd);
+
+    return mon;
+#else
+    error_setg(errp, "File monitoring not available on this platform");
+    return NULL;
+#endif
+}
+
+
+QFileMonitor *qemu_file_monitor_get_instance(Error **errp)
+{
+    static QFileMonitor *global;
+
+    if (!global) {
+        global =3D qemu_file_monitor_new(errp);
+    }
+
+    return global;
+}
+
+
+#ifdef CONFIG_INOTIFY1
+int
+qemu_file_monitor_add_watch(QFileMonitor *mon,
+                            const char *dirpath,
+                            const char *filename,
+                            QFileMonitorHandler cb,
+                            void *opaque,
+                            Error **errp)
+{
+    QFileMonitorDir *dir;
+    int ret =3D -1;
+
+    qemu_mutex_lock(&mon->lock);
+    dir =3D g_hash_table_lookup(mon->dirs, dirpath);
+    if (!dir) {
+        int rv =3D inotify_add_watch(mon->fd, dirpath,
+                                   IN_CREATE | IN_DELETE | IN_MODIFY |
+                                   IN_MOVED_TO | IN_MOVED_FROM);
+
+        if (rv < 0) {
+            error_setg_errno(errp, errno, "Unable to watch '%s'", dirpat=
h);
+            goto cleanup;
+        }
+
+        trace_qemu_file_monitor_enable_watch(mon, dirpath, rv);
+
+        dir =3D g_new0(QFileMonitorDir, 1);
+        dir->path =3D g_strdup(dirpath);
+        dir->id =3D rv;
+
+        g_hash_table_insert(mon->dirs, dir->path, dir);
+        g_hash_table_insert(mon->idmap, GINT_TO_POINTER(rv), dir);
+
+        if (g_hash_table_size(mon->dirs) =3D=3D 1) {
+            qemu_set_fd_handler(mon->fd, qemu_file_monitor_watch, NULL, =
mon);
+        }
+    }
+
+    dir->watches =3D g_renew(QFileMonitorWatch, dir->watches, dir->nwatc=
hes + 1);
+
+    dir->watches[dir->nwatches].id =3D ++dir->nextid;
+    dir->watches[dir->nwatches].filename =3D filename ? g_strdup(filenam=
e) : NULL;
+    dir->watches[dir->nwatches].cb =3D cb;
+    dir->watches[dir->nwatches].opaque =3D opaque;
+    dir->nwatches++;
+
+    trace_qemu_file_monitor_add_watch(mon, dirpath,
+                                      filename ? filename : "<none>",
+                                      cb, opaque,
+                                      dir->watches[dir->nwatches - 1].id=
);
+
+    ret =3D 0;
+
+ cleanup:
+    qemu_mutex_unlock(&mon->lock);
+    return ret;
+}
+
+
+void qemu_file_monitor_remove_watch(QFileMonitor *mon,
+                                    const char *dirpath,
+                                    int id)
+{
+    QFileMonitorDir *dir;
+    gsize i;
+
+    qemu_mutex_lock(&mon->lock);
+
+    trace_qemu_file_monitor_remove_watch(mon, dirpath, id);
+
+    dir =3D g_hash_table_lookup(mon->dirs, dirpath);
+    if (!dir) {
+        goto cleanup;
+    }
+
+    for (i =3D 0; i < dir->nwatches; i++) {
+        if (dir->watches[i].id =3D=3D id) {
+            if (i < (dir->nwatches - 1)) {
+                memmove(dir->watches + i,
+                        dir->watches + i + 1,
+                        sizeof(QFileMonitorWatch) *
+                        (dir->nwatches - (i + 1)));
+                dir->watches =3D g_renew(QFileMonitorWatch, dir->watches=
,
+                                       dir->nwatches - 1);
+                dir->nwatches--;
+            }
+            break;
+        }
+    }
+
+    if (dir->nwatches =3D=3D 0) {
+        inotify_rm_watch(mon->fd, dir->id);
+        trace_qemu_file_monitor_disable_watch(mon, dir->path, dir->id);
+
+        g_hash_table_remove(mon->idmap, GINT_TO_POINTER(dir->id));
+        g_hash_table_remove(mon->dirs, dir->path);
+    }
+
+ cleanup:
+    qemu_mutex_lock(&mon->lock);
+}
+
+#else
+int
+qemu_file_monitor_add_watch(QFileMonitor *mon,
+                            const char *dirpath,
+                            const char *filename,
+                            QFileMonitorHandler cb,
+                            void *opaque,
+                            Error **errp)
+{
+    error_setg(errp, "File monitoring not available on this platform");
+    return -1;
+}
+
+void qemu_file_monitor_remove_watch(QFileMonitor *mon,
+                                    const char *dirpath,
+                                    int id)
+{
+}
+#endif
+
diff --git a/util/trace-events b/util/trace-events
index 4822434c89..1a429f5525 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -21,6 +21,15 @@ buffer_move_empty(const char *buf, size_t len, const c=
har *from) "%s: %zd bytes
 buffer_move(const char *buf, size_t len, const char *from) "%s: %zd byte=
s from %s"
 buffer_free(const char *buf, size_t len) "%s: capacity %zd"
=20
+# util/filemonitor.c
+qemu_file_monitor_add_watch(void *mon, const char *dirpath, const char *=
filename, void *cb, void *opaque, int id) "File monitor %p add watch dir=3D=
'%s' file=3D'%s' cb=3D%p opaque=3D%p id=3D%u"
+qemu_file_monitor_remove_watch(void *mon, const char *dirpath, int id) "=
File monitor %p remove watch dir=3D'%s' id=3D%u"
+qemu_file_monitor_new(void *mon, int fd) "File monitor %p created fd=3D%=
d"
+qemu_file_monitor_enable_watch(void *mon, const char *dirpath, int id) "=
File monitor %p enable watch dir=3D'%s' id=3D%u"
+qemu_file_monitor_disable_watch(void *mon, const char *dirpath, int id) =
"Fle monitor %p disable watch dir=3D'%s' id=3D%u"
+qemu_file_monitor_event(void *mon, const char *dirpath, const char *file=
name, int mask, unsigned int id) "File monitor %p event dir=3D'%s' file=3D=
'%s' mask=3D0x%x id=3D%u"
+qemu_file_monitor_dispatch(void *mon, const char *dirpath, const char *f=
ilename, int ev, void *cb, void *opaque, unsigned int id) "File monitor %=
p dispatch dir=3D'%s' file=3D'%s' ev=3D%d cb=3D%p opaque=3D%p id=3D%u"
+
 # util/qemu-coroutine.c
 qemu_aio_coroutine_enter(void *ctx, void *from, void *to, void *opaque) =
"ctx %p from %p to %p opaque %p"
 qemu_coroutine_yield(void *from, void *to) "from %p to %p"
--=20
2.17.1
