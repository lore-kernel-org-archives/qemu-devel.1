Received: from eggs.gnu.org ([2001:4830:134:3::10]:49011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ue-0000u3-Ni
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Uc-0003MZ-7i
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1Ub-0003Lg-Ue
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:50 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F1232D7E4
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:40 +0100
Message-Id: <20181212101145.3496-7-armbru@redhat.com>
In-Reply-To: <20181212101145.3496-1-armbru@redhat.com>
References: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/11] monitor: prevent inserting new monitors
 after cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

monitor_cleanup() is one of the last things main() calls before it
returns.  In the following patch, monitor_cleanup() will release the
monitor_lock during flushing. There may be pending commands to insert
new monitors, which would modify the mon_list during iteration, and
the clean-up could thus miss those new insertions.

Add a monitor_destroyed global to check if monitor_cleanup() has been
already called. In this case, don't insert the new monitor in the
list, but free it instead. A cleaner solution would involve the main
thread telling other threads to terminate, waiting for their
termination.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20181205203737.9011-7-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index a1329d8a86..d353c0e645 100644
--- a/monitor.c
+++ b/monitor.c
@@ -263,10 +263,11 @@ typedef struct QMPRequest QMPRequest;
 /* QMP checker flags */
 #define QMP_ACCEPT_UNKNOWNS 1
=20
-/* Protects mon_list, monitor_qapi_event_state.  */
+/* Protects mon_list, monitor_qapi_event_state, monitor_destroyed.  */
 static QemuMutex monitor_lock;
 static GHashTable *monitor_qapi_event_state;
 static QTAILQ_HEAD(mon_list, Monitor) mon_list;
+static bool monitor_destroyed;
=20
 /* Protects mon_fdsets */
 static QemuMutex mon_fdsets_lock;
@@ -4538,8 +4539,21 @@ void error_vprintf_unless_qmp(const char *fmt, va_=
list ap)
 static void monitor_list_append(Monitor *mon)
 {
     qemu_mutex_lock(&monitor_lock);
-    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
+    /*
+     * This prevents inserting new monitors during monitor_cleanup().
+     * A cleaner solution would involve the main thread telling other
+     * threads to terminate, waiting for their termination.
+     */
+    if (!monitor_destroyed) {
+        QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
+        mon =3D NULL;
+    }
     qemu_mutex_unlock(&monitor_lock);
+
+    if (mon) {
+        monitor_data_destroy(mon);
+        g_free(mon);
+    }
 }
=20
 static void monitor_qmp_setup_handlers_bh(void *opaque)
@@ -4634,6 +4648,7 @@ void monitor_cleanup(void)
=20
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
+    monitor_destroyed =3D true;
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
         monitor_flush(mon);
--=20
2.17.2
