Received: from eggs.gnu.org ([209.51.188.92]:37282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAt-00067C-Ry
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAs-000716-Sz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:38406)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEvAs-0006zQ-Et
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:20:54 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 12 Apr 2019 15:20:26 +0300
Message-Id: <20190412122028.7067-2-yury-kotov@yandex-team.ru>
In-Reply-To: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
References: <20190412122028.7067-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] monitor: Add monitor_recv_fd function to
 work with sent fds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 include/monitor/monitor.h |  1 +
 monitor.c                 | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..9b9e593fb3 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -25,6 +25,7 @@ void monitor_cleanup(void);
 int monitor_suspend(Monitor *mon);
 void monitor_resume(Monitor *mon);
=20
+int monitor_recv_fd(Monitor *mon, Error **errp);
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
=20
diff --git a/monitor.c b/monitor.c
index 4807bbe811..3ebbc08e5c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2206,9 +2206,8 @@ void qmp_getfd(const char *fdname, Error **errp)
     mon_fd_t *monfd;
     int fd, tmp_fd;
=20
-    fd =3D qemu_chr_fe_get_msgfd(&cur_mon->chr);
+    fd =3D monitor_recv_fd(cur_mon, errp);
     if (fd =3D=3D -1) {
-        error_setg(errp, QERR_FD_NOT_SUPPLIED);
         return;
     }
=20
@@ -2266,6 +2265,15 @@ void qmp_closefd(const char *fdname, Error **errp)
     error_setg(errp, QERR_FD_NOT_FOUND, fdname);
 }
=20
+int monitor_recv_fd(Monitor *mon, Error **errp)
+{
+    int fd =3D qemu_chr_fe_get_msgfd(&cur_mon->chr);
+    if (fd =3D=3D -1) {
+        error_setg(errp, QERR_FD_NOT_SUPPLIED);
+    }
+    return fd;
+}
+
 int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 {
     mon_fd_t *monfd;
@@ -2335,9 +2343,8 @@ AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fd=
set_id, bool has_opaque,
     Monitor *mon =3D cur_mon;
     AddfdInfo *fdinfo;
=20
-    fd =3D qemu_chr_fe_get_msgfd(&mon->chr);
+    fd =3D monitor_recv_fd(mon, errp);
     if (fd =3D=3D -1) {
-        error_setg(errp, QERR_FD_NOT_SUPPLIED);
         goto error;
     }
=20
--=20
2.21.0
