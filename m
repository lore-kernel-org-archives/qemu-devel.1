Received: from eggs.gnu.org ([209.51.188.92]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLe-0003FI-8c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLd-00057T-2x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLb-00055s-9B
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:43 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Apr 2019 18:10:04 +0200
Message-Id: <20190409161009.6322-16-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 15/20] monitor: add qmp_return_get_monitor()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

If necessary, add an helper that can be used to retrieve the
associated monitor. This is useful for asynchronous commands that may
have to update cur_mon for various reasons.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h | 3 +++
 monitor.c                 | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..5f25cd2616 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -5,6 +5,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
+#include "qapi/qmp/dispatch.h"
=20
 extern __thread Monitor *cur_mon;
=20
@@ -51,4 +52,6 @@ int monitor_fdset_dup_fd_find(int dup_fd);
 void monitor_vfprintf(FILE *stream,
                       const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
=20
+Monitor *qmp_return_get_monitor(QmpReturn *qret);
+
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index b1c4647a37..76bc2f8c7c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -324,6 +324,12 @@ bool monitor_cur_is_qmp(void)
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
2.21.0.196.g041f5ea1cf
