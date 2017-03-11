Received: from eggs.gnu.org ([2001:4830:134:3::10]:58857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh04-0002TH-Ts
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cmh04-0002jZ-6b
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cmh04-0002jQ-0V
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 08:24:00 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 11 Mar 2017 17:22:50 +0400
Message-Id: <20170311132256.22951-16-marcandre.lureau@redhat.com>
In-Reply-To: <20170311132256.22951-1-marcandre.lureau@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/21] qga: register event emit function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qga/main.c b/qga/main.c
index 1c39895baa..8e852bd556 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -39,6 +39,7 @@
 #define CONFIG_FSFREEZE
 #endif
 #endif
+#include "qapi/qmp-event.h"
=20
 #ifndef _WIN32
 #define QGA_VIRTIO_PATH_DEFAULT "/dev/virtio-ports/org.qemu.guest_agent.=
0"
@@ -1488,6 +1489,12 @@ end:
 #endif
 }
=20
+static void
+monitor_qapi_event_queue(qga_QAPIEvent event, QDict *qdict, Error **errp=
)
+{
+    send_response(ga_state, QOBJECT(qdict));
+}
+
 int main(int argc, char **argv)
 {
     int ret =3D EXIT_SUCCESS;
@@ -1496,6 +1503,7 @@ int main(int argc, char **argv)
     int listen_fd;
=20
     update_vmdump_info(s);
+    qmp_event_set_func_emit(monitor_qapi_event_queue);
=20
     config->log_level =3D G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL;
=20
--=20
2.12.0.191.gc5d8de91d
