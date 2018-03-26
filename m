Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tm0-0006Wy-EC
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tls-0003VM-Oo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:11:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tls-0003V3-Jo
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:10:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:09:10 +0200
Message-Id: <20180326150916.9602-33-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 32/38] monitor: add qmp_return_get_monitor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If necessary, add an helper that can be used to retrieve the
associated monitor. This is useful for asynchronous commands that may
have to update cur_mon for various reasons.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h | 3 +++
 monitor.c                 | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 0cb0538a31..2052a6b4e4 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -5,6 +5,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
+#include "qapi/qmp/dispatch.h"
=20
 extern Monitor *cur_mon;
=20
@@ -46,4 +47,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_=
fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int monitor_fdset_dup_fd_find(int dup_fd);
=20
+Monitor *qmp_return_get_monitor(QmpReturn *qret);
+
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index 73a06d4156..f7826f5626 100644
--- a/monitor.c
+++ b/monitor.c
@@ -281,6 +281,12 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
=20
+Monitor *qmp_return_get_monitor(QmpReturn *qret)
+{
+    return qret->session ?
+        container_of(qret->session, Monitor, qmp.session) : NULL;
+}
+
 void monitor_read_command(Monitor *mon, int show_prompt)
 {
     if (!mon->rs)
--=20
2.17.0.rc1.1.g4c4f2b46a3
