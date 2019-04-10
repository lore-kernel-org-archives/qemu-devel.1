Received: from eggs.gnu.org ([209.51.188.92]:39281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VZ-0008Kv-6X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VY-00014A-5q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:05 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:38784)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hE9VX-0000xk-G2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:27:04 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Wed, 10 Apr 2019 12:26:52 +0300
Message-Id: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: yc-core@yandex-team.ru, qemu-devel@nongnu.org

Currently such case is possible for incoming:
QMP: add-fd (fdset =3D 0, fd of some file):
    adds fd to fdset 0 and returns QEMU's fd (e.g. 33)
QMP: migrate-incoming (uri =3D "fd:33"): fd is stored in QIOChannel *ioc
...
Incoming migration completes and unrefs ioc -> close(33)
QMP: remove-fd (fdset =3D 0, fd =3D 33):
    removes fd from fdset 0 and qemu_close() -> close(33) =3D> double clo=
se

For outgoing migration the case is the same but getfd instead of add-fd.
Fix it by duping client's fd.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/fd.c         | 39 +++++++++++++++++++++++++++++++--------
 migration/trace-events |  4 ++--
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/migration/fd.c b/migration/fd.c
index a7c13df4ad..c9ff07ac41 100644
--- a/migration/fd.c
+++ b/migration/fd.c
@@ -15,6 +15,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "channel.h"
 #include "fd.h"
 #include "migration.h"
@@ -26,15 +27,27 @@
 void fd_start_outgoing_migration(MigrationState *s, const char *fdname, =
Error **errp)
 {
     QIOChannel *ioc;
-    int fd =3D monitor_get_fd(cur_mon, fdname, errp);
+    int fd, dup_fd;
+
+    fd =3D monitor_get_fd(cur_mon, fdname, errp);
     if (fd =3D=3D -1) {
         return;
     }
=20
-    trace_migration_fd_outgoing(fd);
-    ioc =3D qio_channel_new_fd(fd, errp);
+    /* fd is previously created by qmp command 'getfd',
+     * so client is responsible to close it. Dup it to save original val=
ue from
+     * QIOChannel's destructor */
+    dup_fd =3D qemu_dup(fd);
+    if (dup_fd =3D=3D -1) {
+        error_setg(errp, "Cannot dup fd %s: %s (%d)", fdname, strerror(e=
rrno),
+                   errno);
+        return;
+    }
+
+    trace_migration_fd_outgoing(fd, dup_fd);
+    ioc =3D qio_channel_new_fd(dup_fd, errp);
     if (!ioc) {
-        close(fd);
+        close(dup_fd);
         return;
     }
=20
@@ -55,14 +68,24 @@ static gboolean fd_accept_incoming_migration(QIOChann=
el *ioc,
 void fd_start_incoming_migration(const char *infd, Error **errp)
 {
     QIOChannel *ioc;
-    int fd;
+    int fd, dup_fd;
=20
     fd =3D strtol(infd, NULL, 0);
-    trace_migration_fd_incoming(fd);
=20
-    ioc =3D qio_channel_new_fd(fd, errp);
+    /* fd is previously created by qmp command 'add-fd' or something els=
e,
+     * so client is responsible to close it. Dup it to save original val=
ue from
+     * QIOChannel's destructor */
+    dup_fd =3D qemu_dup(fd);
+    if (dup_fd =3D=3D -1) {
+        error_setg(errp, "Cannot dup fd %d: %s (%d)", fd, strerror(errno=
),
+                   errno);
+        return;
+    }
+
+    trace_migration_fd_incoming(fd, dup_fd);
+    ioc =3D qio_channel_new_fd(dup_fd, errp);
     if (!ioc) {
-        close(fd);
+        close(dup_fd);
         return;
     }
=20
diff --git a/migration/trace-events b/migration/trace-events
index de2e136e57..d2d30a6b3c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -258,8 +258,8 @@ migration_exec_outgoing(const char *cmd) "cmd=3D%s"
 migration_exec_incoming(const char *cmd) "cmd=3D%s"
=20
 # fd.c
-migration_fd_outgoing(int fd) "fd=3D%d"
-migration_fd_incoming(int fd) "fd=3D%d"
+migration_fd_outgoing(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
+migration_fd_incoming(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
=20
 # socket.c
 migration_socket_incoming_accepted(void) ""
--=20
2.21.0
