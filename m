Received: from eggs.gnu.org ([2001:4830:134:3::10]:48991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjRU-00053I-Io
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSjRR-0005N7-CE
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSjRR-0005Mr-3u
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:06:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A0DD3154862
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 14:06:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 30 Nov 2018 14:06:09 +0000
Message-Id: <20181130140615.19937-6-berrange@redhat.com>
In-Reply-To: <20181130140615.19937-1-berrange@redhat.com>
References: <20181130140615.19937-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 05/11] hw/usb: switch MTP to use new inotify
 APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The internal inotify APIs allow a lot of conditional statements to be
cleared out, and provide a simpler callback for handling events.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c    | 271 +++++++++++++++++---------------------------
 hw/usb/trace-events |   2 +-
 2 files changed, 108 insertions(+), 165 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index ccbe25820b..b9d03244b8 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -11,17 +11,16 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include <wchar.h>
 #include <dirent.h>
=20
 #include <sys/statvfs.h>
-#ifdef CONFIG_INOTIFY1
-#include <sys/inotify.h>
-#include "qemu/main-loop.h"
-#endif
+
=20
 #include "qemu-common.h"
 #include "qemu/iov.h"
+#include "qemu/filemonitor.h"
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
@@ -124,7 +123,6 @@ enum {
     EP_EVENT,
 };
=20
-#ifdef CONFIG_INOTIFY1
 typedef struct MTPMonEntry MTPMonEntry;
=20
 struct MTPMonEntry {
@@ -133,7 +131,6 @@ struct MTPMonEntry {
=20
     QTAILQ_ENTRY(MTPMonEntry) next;
 };
-#endif
=20
 struct MTPControl {
     uint16_t     code;
@@ -162,10 +159,8 @@ struct MTPObject {
     char         *name;
     char         *path;
     struct stat  stat;
-#ifdef CONFIG_INOTIFY1
-    /* inotify watch cookie */
-    int          watchfd;
-#endif
+    /* file monitor watch id */
+    int          watchid;
     MTPObject    *parent;
     uint32_t     nchildren;
     QLIST_HEAD(, MTPObject) children;
@@ -188,11 +183,8 @@ struct MTPState {
     bool         readonly;
=20
     QTAILQ_HEAD(, MTPObject) objects;
-#ifdef CONFIG_INOTIFY1
-    /* inotify descriptor */
-    int          inotifyfd;
+    QFileMonitor *file_monitor;
     QTAILQ_HEAD(events, MTPMonEntry) events;
-#endif
     /* Responder is expecting a write operation */
     bool write_pending;
     struct {
@@ -380,6 +372,7 @@ static MTPObject *usb_mtp_object_alloc(MTPState *s, u=
int32_t handle,
         goto ignore;
     }
=20
+    o->watchid =3D -1;
     o->handle =3D handle;
     o->parent =3D parent;
     o->name =3D g_strdup(name);
@@ -426,6 +419,10 @@ static void usb_mtp_object_free(MTPState *s, MTPObje=
ct *o)
=20
     trace_usb_mtp_object_free(s->dev.addr, o->handle, o->path);
=20
+    if (o->watchid !=3D -1 && s->file_monitor) {
+        qemu_file_monitor_remove_watch(s->file_monitor, o->path, o->watc=
hid);
+    }
+
     QTAILQ_REMOVE(&s->objects, o, next);
     if (o->parent) {
         QLIST_REMOVE(o, list);
@@ -477,6 +474,10 @@ static MTPObject *usb_mtp_object_lookup_name(MTPObje=
ct *parent,
 {
     MTPObject *iter;
=20
+    if (len =3D=3D -1) {
+        len =3D strlen(name);
+    }
+
     QLIST_FOREACH(iter, &parent->children, list) {
         if (strncmp(iter->name, name, len) =3D=3D 0) {
             return iter;
@@ -486,13 +487,12 @@ static MTPObject *usb_mtp_object_lookup_name(MTPObj=
ect *parent,
     return NULL;
 }
=20
-#ifdef CONFIG_INOTIFY1
-static MTPObject *usb_mtp_object_lookup_wd(MTPState *s, int wd)
+static MTPObject *usb_mtp_object_lookup_id(MTPState *s, int id)
 {
     MTPObject *iter;
=20
     QTAILQ_FOREACH(iter, &s->objects, next) {
-        if (iter->watchfd =3D=3D wd) {
+        if (iter->watchid =3D=3D id) {
             return iter;
         }
     }
@@ -500,158 +500,99 @@ static MTPObject *usb_mtp_object_lookup_wd(MTPStat=
e *s, int wd)
     return NULL;
 }
=20
-static void inotify_watchfn(void *arg)
+static void file_monitor_event(int id,
+                               QFileMonitorEvent ev,
+                               const char *name,
+                               void *opaque)
 {
-    MTPState *s =3D arg;
-    ssize_t bytes;
-    /* From the man page: atleast one event can be read */
-    int pos;
-    char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
-
-    for (;;) {
-        bytes =3D read(s->inotifyfd, buf, sizeof(buf));
-        pos =3D 0;
-
-        if (bytes <=3D 0) {
-            /* Better luck next time */
+    MTPState *s =3D opaque;
+    MTPObject *parent =3D usb_mtp_object_lookup_id(s, id);
+    MTPMonEntry *entry =3D NULL;
+    MTPObject *o;
+
+    if (!parent) {
+        return;
+    }
+
+    switch (ev) {
+    case QFILE_MONITOR_EVENT_CREATED:
+        if (usb_mtp_object_lookup_name(parent, name, -1)) {
+            /* Duplicate create event */
             return;
         }
+        entry =3D g_new0(MTPMonEntry, 1);
+        entry->handle =3D s->next_handle;
+        entry->event =3D EVT_OBJ_ADDED;
+        o =3D usb_mtp_add_child(s, parent, name);
+        if (!o) {
+            g_free(entry);
+            return;
+        }
+        trace_usb_mtp_file_monitor_event(s->dev.addr, name, "Obj Added")=
;
+        break;
=20
+    case QFILE_MONITOR_EVENT_DELETED:
         /*
-         * TODO: Ignore initiator initiated events.
-         * For now we are good because the store is RO
+         * The kernel issues a IN_IGNORED event
+         * when a dir containing a watchpoint is
+         * deleted, so we don't have to delete the
+         * watchpoint
          */
-        while (bytes > 0) {
-            char *p =3D buf + pos;
-            struct inotify_event *event =3D (struct inotify_event *)p;
-            int watchfd =3D 0;
-            uint32_t mask =3D event->mask & (IN_CREATE | IN_DELETE |
-                                           IN_MODIFY | IN_IGNORED);
-            MTPObject *parent =3D usb_mtp_object_lookup_wd(s, event->wd)=
;
-            MTPMonEntry *entry =3D NULL;
-            MTPObject *o;
-
-            pos =3D pos + sizeof(struct inotify_event) + event->len;
-            bytes =3D bytes - pos;
-
-            if (!parent) {
-                continue;
-            }
-
-            switch (mask) {
-            case IN_CREATE:
-                if (usb_mtp_object_lookup_name
-                    (parent, event->name, event->len)) {
-                    /* Duplicate create event */
-                    continue;
-                }
-                entry =3D g_new0(MTPMonEntry, 1);
-                entry->handle =3D s->next_handle;
-                entry->event =3D EVT_OBJ_ADDED;
-                o =3D usb_mtp_add_child(s, parent, event->name);
-                if (!o) {
-                    g_free(entry);
-                    continue;
-                }
-                o->watchfd =3D watchfd;
-                trace_usb_mtp_inotify_event(s->dev.addr, event->name,
-                                            event->mask, "Obj Added");
-                break;
-
-            case IN_DELETE:
-                /*
-                 * The kernel issues a IN_IGNORED event
-                 * when a dir containing a watchpoint is
-                 * deleted, so we don't have to delete the
-                 * watchpoint
-                 */
-                o =3D usb_mtp_object_lookup_name(parent, event->name, ev=
ent->len);
-                if (!o) {
-                    continue;
-                }
-                entry =3D g_new0(MTPMonEntry, 1);
-                entry->handle =3D o->handle;
-                entry->event =3D EVT_OBJ_REMOVED;
-                trace_usb_mtp_inotify_event(s->dev.addr, o->path,
-                                      event->mask, "Obj Deleted");
-                usb_mtp_object_free(s, o);
-                break;
-
-            case IN_MODIFY:
-                o =3D usb_mtp_object_lookup_name(parent, event->name, ev=
ent->len);
-                if (!o) {
-                    continue;
-                }
-                entry =3D g_new0(MTPMonEntry, 1);
-                entry->handle =3D o->handle;
-                entry->event =3D EVT_OBJ_INFO_CHANGED;
-                trace_usb_mtp_inotify_event(s->dev.addr, o->path,
-                                      event->mask, "Obj Modified");
-                break;
-
-            case IN_IGNORED:
-                trace_usb_mtp_inotify_event(s->dev.addr, parent->path,
-                                      event->mask, "Obj parent dir ignor=
ed");
-                break;
-
-            default:
-                fprintf(stderr, "usb-mtp: failed to parse inotify event\=
n");
-                continue;
-            }
+        o =3D usb_mtp_object_lookup_name(parent, name, -1);
+        if (!o) {
+            return;
+        }
+        entry =3D g_new0(MTPMonEntry, 1);
+        entry->handle =3D o->handle;
+        entry->event =3D EVT_OBJ_REMOVED;
+        trace_usb_mtp_file_monitor_event(s->dev.addr, o->path, "Obj Dele=
ted");
+        usb_mtp_object_free(s, o);
+        break;
=20
-            if (entry) {
-                QTAILQ_INSERT_HEAD(&s->events, entry, next);
-            }
+    case QFILE_MONITOR_EVENT_MODIFIED:
+        o =3D usb_mtp_object_lookup_name(parent, name, -1);
+        if (!o) {
+            return;
         }
-    }
-}
+        entry =3D g_new0(MTPMonEntry, 1);
+        entry->handle =3D o->handle;
+        entry->event =3D EVT_OBJ_INFO_CHANGED;
+        trace_usb_mtp_file_monitor_event(s->dev.addr, o->path, "Obj Modi=
fied");
+        break;
=20
-static int usb_mtp_inotify_init(MTPState *s)
-{
-    int fd;
+    case QFILE_MONITOR_EVENT_IGNORED:
+        trace_usb_mtp_file_monitor_event(s->dev.addr, parent->path,
+                                    "Obj parent dir ignored");
+        break;
=20
-    fd =3D inotify_init1(IN_NONBLOCK);
-    if (fd =3D=3D -1) {
-        return 1;
+    default:
+        g_assert_not_reached();
     }
=20
-    QTAILQ_INIT(&s->events);
-    s->inotifyfd =3D fd;
-
-    qemu_set_fd_handler(fd, inotify_watchfn, NULL, s);
-
-    return 0;
+    if (entry) {
+        QTAILQ_INSERT_HEAD(&s->events, entry, next);
+    }
 }
=20
-static void usb_mtp_inotify_cleanup(MTPState *s)
+static void usb_mtp_file_monitor_cleanup(MTPState *s)
 {
     MTPMonEntry *e, *p;
=20
-    if (!s->inotifyfd) {
-        return;
-    }
-
-    qemu_set_fd_handler(s->inotifyfd, NULL, NULL, s);
-    close(s->inotifyfd);
-
     QTAILQ_FOREACH_SAFE(e, &s->events, next, p) {
         QTAILQ_REMOVE(&s->events, e, next);
         g_free(e);
     }
-}
-
-static int usb_mtp_add_watch(int inotifyfd, const char *path)
-{
-    uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY;
=20
-    return inotify_add_watch(inotifyfd, path, mask);
+    qemu_file_monitor_free(s->file_monitor);
+    s->file_monitor =3D NULL;
 }
-#endif
+
=20
 static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
 {
     struct dirent *entry;
     DIR *dir;
+    Error *err =3D NULL;
=20
     if (o->have_children) {
         return;
@@ -662,16 +603,21 @@ static void usb_mtp_object_readdir(MTPState *s, MTP=
Object *o)
     if (!dir) {
         return;
     }
-#ifdef CONFIG_INOTIFY1
-    int watchfd =3D usb_mtp_add_watch(s->inotifyfd, o->path);
-    if (watchfd =3D=3D -1) {
-        fprintf(stderr, "usb-mtp: failed to add watch for %s\n", o->path=
);
-    } else {
-        trace_usb_mtp_inotify_event(s->dev.addr, o->path,
-                                    0, "Watch Added");
-        o->watchfd =3D watchfd;
+
+    if (s->file_monitor) {
+        int id =3D qemu_file_monitor_add_watch(s->file_monitor, o->path,=
 NULL,
+                                             file_monitor_event, s, &err=
);
+        if (id =3D=3D -1) {
+            error_report("usb-mtp: failed to add watch for %s: %s", o->p=
ath,
+                         error_get_pretty(err));
+            error_free(err);
+        } else {
+            trace_usb_mtp_file_monitor_event(s->dev.addr, o->path,
+                                             "Watch Added");
+            o->watchid =3D id;
+        }
     }
-#endif
+
     while ((entry =3D readdir(dir)) !=3D NULL) {
         usb_mtp_add_child(s, o, entry->d_name);
     }
@@ -1179,13 +1125,11 @@ enum {
 /* Assumes that children, if any, have been already freed */
 static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
 {
-#ifndef CONFIG_INOTIFY1
     assert(o->nchildren =3D=3D 0);
     QTAILQ_REMOVE(&s->objects, o, next);
     g_free(o->name);
     g_free(o->path);
     g_free(o);
-#endif
 }
=20
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
@@ -1284,6 +1228,7 @@ static void usb_mtp_command(MTPState *s, MTPControl=
 *c)
     MTPData *data_in =3D NULL;
     MTPObject *o =3D NULL;
     uint32_t nres =3D 0, res0 =3D 0;
+    Error *err =3D NULL;
=20
     /* sanity checks */
     if (c->code >=3D CMD_CLOSE_SESSION && s->session =3D=3D 0) {
@@ -1311,19 +1256,21 @@ static void usb_mtp_command(MTPState *s, MTPContr=
ol *c)
         trace_usb_mtp_op_open_session(s->dev.addr);
         s->session =3D c->argv[0];
         usb_mtp_object_alloc(s, s->next_handle++, NULL, s->root);
-#ifdef CONFIG_INOTIFY1
-        if (usb_mtp_inotify_init(s)) {
-            fprintf(stderr, "usb-mtp: file monitoring init failed\n");
+
+        s->file_monitor =3D qemu_file_monitor_new(&err);
+        if (err) {
+            error_report("usb-mtp: file monitoring init failed: %s",
+                         error_get_pretty(err));
+            error_free(err);
+        } else {
+            QTAILQ_INIT(&s->events);
         }
-#endif
         break;
     case CMD_CLOSE_SESSION:
         trace_usb_mtp_op_close_session(s->dev.addr);
         s->session =3D 0;
         s->next_handle =3D 0;
-#ifdef CONFIG_INOTIFY1
-        usb_mtp_inotify_cleanup(s);
-#endif
+        usb_mtp_file_monitor_cleanup(s);
         usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
         assert(QTAILQ_EMPTY(&s->objects));
         break;
@@ -1536,9 +1483,7 @@ static void usb_mtp_handle_reset(USBDevice *dev)
=20
     trace_usb_mtp_reset(s->dev.addr);
=20
-#ifdef CONFIG_INOTIFY1
-    usb_mtp_inotify_cleanup(s);
-#endif
+    usb_mtp_file_monitor_cleanup(s);
     usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
     s->session =3D 0;
     usb_mtp_data_free(s->data_in);
@@ -1967,7 +1912,6 @@ static void usb_mtp_handle_data(USBDevice *dev, USB=
Packet *p)
         }
         break;
     case EP_EVENT:
-#ifdef CONFIG_INOTIFY1
         if (!QTAILQ_EMPTY(&s->events)) {
             struct MTPMonEntry *e =3D QTAILQ_LAST(&s->events, events);
             uint32_t handle;
@@ -1991,7 +1935,6 @@ static void usb_mtp_handle_data(USBDevice *dev, USB=
Packet *p)
             g_free(e);
             return;
         }
-#endif
         p->status =3D USB_RET_NAK;
         return;
     default:
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index 2c18770ca5..99b1e8b8ce 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -237,7 +237,7 @@ usb_mtp_op_unknown(int dev, uint32_t code) "dev %d, c=
ommand code 0x%x"
 usb_mtp_object_alloc(int dev, uint32_t handle, const char *path) "dev %d=
, handle 0x%x, path %s"
 usb_mtp_object_free(int dev, uint32_t handle, const char *path) "dev %d,=
 handle 0x%x, path %s"
 usb_mtp_add_child(int dev, uint32_t handle, const char *path) "dev %d, h=
andle 0x%x, path %s"
-usb_mtp_inotify_event(int dev, const char *path, uint32_t mask, const ch=
ar *s) "dev %d, path %s mask 0x%x event %s"
+usb_mtp_file_monitor_event(int dev, const char *path, const char *s) "de=
v %d, path %s event %s"
=20
 # hw/usb/host-libusb.c
 usb_host_open_started(int bus, int addr) "dev %d:%d"
--=20
2.19.2
