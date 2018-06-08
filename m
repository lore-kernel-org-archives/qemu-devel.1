Received: from eggs.gnu.org ([2001:4830:134:3::10]:39282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtU-00078C-WF
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRKtT-0008L6-6A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:09:44 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri,  8 Jun 2018 18:09:27 +0100
Message-Id: <20180608170933.9137-3-berrange@redhat.com>
In-Reply-To: <20180608170933.9137-1-berrange@redhat.com>
References: <20180608170933.9137-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/8] hw/usb: switch MTP to use new inotify APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>

The internal inotify APIs allow alot of conditional statements to be
cleared out, and provide a simpler callback for handling events.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 238 +++++++++++++++++++----------------------------
 1 file changed, 97 insertions(+), 141 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 560c61c7c1..d7188b2b62 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -15,13 +15,11 @@
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
+#include "qemu/inotify.h"
 #include "trace.h"
 #include "hw/usb.h"
 #include "desc.h"
@@ -123,7 +121,6 @@ enum {
     EP_EVENT,
 };
=20
-#ifdef CONFIG_INOTIFY1
 typedef struct MTPMonEntry MTPMonEntry;
=20
 struct MTPMonEntry {
@@ -132,7 +129,6 @@ struct MTPMonEntry {
=20
     QTAILQ_ENTRY(MTPMonEntry) next;
 };
-#endif
=20
 struct MTPControl {
     uint16_t     code;
@@ -158,10 +154,8 @@ struct MTPObject {
     char         *name;
     char         *path;
     struct stat  stat;
-#ifdef CONFIG_INOTIFY1
     /* inotify watch cookie */
     int          watchfd;
-#endif
     MTPObject    *parent;
     uint32_t     nchildren;
     QLIST_HEAD(, MTPObject) children;
@@ -184,11 +178,8 @@ struct MTPState {
     bool         readonly;
=20
     QTAILQ_HEAD(, MTPObject) objects;
-#ifdef CONFIG_INOTIFY1
-    /* inotify descriptor */
-    int          inotifyfd;
+    QInotify *inotify;
     QTAILQ_HEAD(events, MTPMonEntry) events;
-#endif
     /* Responder is expecting a write operation */
     bool write_pending;
     struct {
@@ -368,7 +359,7 @@ static const USBDesc desc =3D {
 /* ---------------------------------------------------------------------=
-- */
=20
 static MTPObject *usb_mtp_object_alloc(MTPState *s, uint32_t handle,
-                                       MTPObject *parent, char *name)
+                                       MTPObject *parent, const char *na=
me)
 {
     MTPObject *o =3D g_new0(MTPObject, 1);
=20
@@ -450,7 +441,7 @@ static MTPObject *usb_mtp_object_lookup(MTPState *s, =
uint32_t handle)
 }
=20
 static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
-                                    char *name)
+                                    const char *name)
 {
     MTPObject *child =3D
         usb_mtp_object_alloc(s, s->next_handle++, o, name);
@@ -469,10 +460,14 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MT=
PObject *o,
 }
=20
 static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
-                                             char *name, int len)
+                                             const char *name, int len)
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
@@ -482,7 +477,6 @@ static MTPObject *usb_mtp_object_lookup_name(MTPObjec=
t *parent,
     return NULL;
 }
=20
-#ifdef CONFIG_INOTIFY1
 static MTPObject *usb_mtp_object_lookup_wd(MTPState *s, int wd)
 {
     MTPObject *iter;
@@ -496,126 +490,100 @@ static MTPObject *usb_mtp_object_lookup_wd(MTPSta=
te *s, int wd)
     return NULL;
 }
=20
-static void inotify_watchfn(void *arg)
+static void inotify_watchfn(int wd,
+                            uint32_t mask,
+                            const char *name,
+                            void *opaque)
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
+    int watchfd =3D 0;
+    MTPObject *parent =3D usb_mtp_object_lookup_wd(s, wd);
+    MTPMonEntry *entry =3D NULL;
+    MTPObject *o;
+
+    mask &=3D (IN_CREATE | IN_DELETE |
+             IN_MODIFY | IN_IGNORED);
+
+    if (!parent) {
+        return;
+    }
+
+    switch (mask) {
+    case IN_CREATE:
+        if (usb_mtp_object_lookup_name(parent, name, -1)) {
+            /* Duplicate create event */
+            return;
+        }
+        entry =3D g_new0(MTPMonEntry, 1);
+        entry->handle =3D s->next_handle;
+        entry->event =3D EVT_OBJ_ADDED;
+        o =3D usb_mtp_add_child(s, parent, name);
+        if (!o) {
+            g_free(entry);
             return;
         }
+        o->watchfd =3D watchfd;
+        trace_usb_mtp_inotify_event(s->dev.addr, name,
+                                    mask, "Obj Added");
+        break;
=20
+    case IN_DELETE:
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
+        trace_usb_mtp_inotify_event(s->dev.addr, o->path,
+                                    mask, "Obj Deleted");
+        usb_mtp_object_free(s, o);
+        break;
=20
-            if (entry) {
-                QTAILQ_INSERT_HEAD(&s->events, entry, next);
-            }
+    case IN_MODIFY:
+        o =3D usb_mtp_object_lookup_name(parent, name, -1);
+        if (!o) {
+            return;
         }
+        entry =3D g_new0(MTPMonEntry, 1);
+        entry->handle =3D o->handle;
+        entry->event =3D EVT_OBJ_INFO_CHANGED;
+        trace_usb_mtp_inotify_event(s->dev.addr, o->path,
+                                    mask, "Obj Modified");
+        break;
+
+    case IN_IGNORED:
+        trace_usb_mtp_inotify_event(s->dev.addr, parent->path,
+                                    mask, "Obj parent dir ignored");
+        break;
+
+    default:
+        fprintf(stderr, "usb-mtp: failed to parse inotify event\n");
+        return;
+    }
+
+    if (entry) {
+        QTAILQ_INSERT_HEAD(&s->events, entry, next);
     }
 }
=20
 static int usb_mtp_inotify_init(MTPState *s)
 {
-    int fd;
-
-    fd =3D inotify_init1(IN_NONBLOCK);
-    if (fd =3D=3D -1) {
+    s->inotify =3D qemu_inotify_new(inotify_watchfn,
+                                  s,
+                                  NULL,
+                                  &error_abort);
+    if (!s->inotify) {
         return 1;
     }
=20
     QTAILQ_INIT(&s->events);
-    s->inotifyfd =3D fd;
-
-    qemu_set_fd_handler(fd, inotify_watchfn, NULL, s);
-
     return 0;
 }
=20
@@ -623,12 +591,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
 {
     MTPMonEntry *e, *p;
=20
-    if (!s->inotifyfd) {
-        return;
-    }
-
-    qemu_set_fd_handler(s->inotifyfd, NULL, NULL, s);
-    close(s->inotifyfd);
+    qemu_inotify_free(s->inotify);
=20
     QTAILQ_FOREACH_SAFE(e, &s->events, next, p) {
         QTAILQ_REMOVE(&s->events, e, next);
@@ -636,14 +599,17 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
     }
 }
=20
-static int usb_mtp_add_watch(int inotifyfd, char *path)
+static int usb_mtp_add_watch(MTPState *s, char *path)
 {
+#ifdef CONFIG_INOTIFY1
     uint32_t mask =3D IN_CREATE | IN_DELETE | IN_MODIFY |
         IN_ISDIR;
=20
-    return inotify_add_watch(inotifyfd, path, mask);
-}
+    return qemu_inotify_add_watch(s->inotify, path, mask, NULL);
+#else
+    return -1;
 #endif
+}
=20
 static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
 {
@@ -659,8 +625,8 @@ static void usb_mtp_object_readdir(MTPState *s, MTPOb=
ject *o)
     if (!dir) {
         return;
     }
-#ifdef CONFIG_INOTIFY1
-    int watchfd =3D usb_mtp_add_watch(s->inotifyfd, o->path);
+
+    int watchfd =3D usb_mtp_add_watch(s, o->path);
     if (watchfd =3D=3D -1) {
         fprintf(stderr, "usb-mtp: failed to add watch for %s\n", o->path=
);
     } else {
@@ -668,7 +634,7 @@ static void usb_mtp_object_readdir(MTPState *s, MTPOb=
ject *o)
                                     0, "Watch Added");
         o->watchfd =3D watchfd;
     }
-#endif
+
     while ((entry =3D readdir(dir)) !=3D NULL) {
         usb_mtp_add_child(s, o, entry->d_name);
     }
@@ -1172,13 +1138,11 @@ enum {
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
@@ -1304,19 +1268,15 @@ static void usb_mtp_command(MTPState *s, MTPContr=
ol *c)
         trace_usb_mtp_op_open_session(s->dev.addr);
         s->session =3D c->argv[0];
         usb_mtp_object_alloc(s, s->next_handle++, NULL, s->root);
-#ifdef CONFIG_INOTIFY1
         if (usb_mtp_inotify_init(s)) {
             fprintf(stderr, "usb-mtp: file monitoring init failed\n");
         }
-#endif
         break;
     case CMD_CLOSE_SESSION:
         trace_usb_mtp_op_close_session(s->dev.addr);
         s->session =3D 0;
         s->next_handle =3D 0;
-#ifdef CONFIG_INOTIFY1
         usb_mtp_inotify_cleanup(s);
-#endif
         usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
         assert(QTAILQ_EMPTY(&s->objects));
         break;
@@ -1529,9 +1489,7 @@ static void usb_mtp_handle_reset(USBDevice *dev)
=20
     trace_usb_mtp_reset(s->dev.addr);
=20
-#ifdef CONFIG_INOTIFY1
     usb_mtp_inotify_cleanup(s);
-#endif
     usb_mtp_object_free(s, QTAILQ_FIRST(&s->objects));
     s->session =3D 0;
     usb_mtp_data_free(s->data_in);
@@ -1891,7 +1849,6 @@ static void usb_mtp_handle_data(USBDevice *dev, USB=
Packet *p)
         }
         break;
     case EP_EVENT:
-#ifdef CONFIG_INOTIFY1
         if (!QTAILQ_EMPTY(&s->events)) {
             struct MTPMonEntry *e =3D QTAILQ_LAST(&s->events, events);
             uint32_t handle;
@@ -1915,7 +1872,6 @@ static void usb_mtp_handle_data(USBDevice *dev, USB=
Packet *p)
             g_free(e);
             return;
         }
-#endif
         p->status =3D USB_RET_NAK;
         return;
     default:
--=20
2.17.0
