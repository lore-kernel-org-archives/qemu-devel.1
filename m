Received: from eggs.gnu.org ([2001:4830:134:3::10]:42620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gWjAe-0006sj-8W
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gWjAW-0004lz-KK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gWjAW-0004jR-Da
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:37:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFAD6C04BD5F
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 14:37:49 +0000 (UTC)
Received: from natto.ory.fergeau.eu (unknown [10.48.0.207])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0ECF105706E
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 14:37:49 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Tue, 11 Dec 2018 15:37:45 +0100
Message-Id: <20181211143745.17342-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spice: Make logging printing go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since spice 0.14.1, it's possible to use g_log_set_default_handler() to
use a custom function to print spice-server's logs, which gives more
consistent log output.

With older spice versions, this is not going to work as expected, but
will not have any ill effect, so this call is not conditional on spice
version.

Since this added g_log_set_default_handler() will bridge glib logging
and QEMU logging, the call might fit better in a more generic place.

Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
---
 ui/spice-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/ui/spice-core.c b/ui/spice-core.c
index ebaae24643..443a2b3d32 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -632,6 +632,30 @@ static void vm_change_state_handler(void *opaque, in=
t running,
     }
 }
=20
+static void qemu_log_func(const gchar *log_domain,
+                          GLogLevelFlags log_level,
+                          const gchar *message,
+                          gpointer user_data)
+{
+    switch (log_level & G_LOG_LEVEL_MASK) {
+        case G_LOG_LEVEL_DEBUG:
+            break;
+        case G_LOG_LEVEL_INFO:
+            /* Fall through */
+        case G_LOG_LEVEL_MESSAGE:
+            info_report("%s", message);
+            break;
+        case G_LOG_LEVEL_WARNING:
+            /* Fall through */
+        case G_LOG_LEVEL_CRITICAL:
+            warn_report("%s", message);
+            break;
+        case G_LOG_LEVEL_ERROR:
+            error_report("%s", message);
+            break;
+    }
+}
+
 void qemu_spice_init(void)
 {
     QemuOpts *opts =3D QTAILQ_FIRST(&qemu_spice_opts.head);
@@ -647,6 +671,7 @@ void qemu_spice_init(void)
     spice_wan_compression_t wan_compr;
     bool seamless_migration;
=20
+    g_log_set_default_handler(qemu_log_func, NULL);
     qemu_thread_get_self(&me);
=20
     if (!opts) {
--=20
2.19.2
