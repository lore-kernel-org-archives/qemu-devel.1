Received: from eggs.gnu.org ([2001:4830:134:3::10]:49960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpj-0006ZA-7Z
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g9rpf-00030j-8Q
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g9rpf-000305-2P
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70AA01152E
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 13:13:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 Oct 2018 17:12:50 +0400
Message-Id: <20181009131251.721-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181009131251.721-1-marcandre.lureau@redhat.com>
References: <20181009131251.721-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] monitor: prevent inserting new monitors
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, peterx@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a monitor_destroyed global to check if monitor_cleanup() has been
already called. In this case, don't insert the new monitor in the
list, but free it instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index c175cf6f0d..90b7867ed4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -262,10 +262,11 @@ typedef struct QMPRequest QMPRequest;
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
@@ -4526,8 +4527,16 @@ void error_vprintf_unless_qmp(const char *fmt, va_=
list ap)
 static void monitor_list_append(Monitor *mon)
 {
     qemu_mutex_lock(&monitor_lock);
-    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
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
@@ -4620,6 +4629,7 @@ void monitor_cleanup(void)
=20
     /* Flush output buffers and destroy monitors */
     qemu_mutex_lock(&monitor_lock);
+    monitor_destroyed =3D true;
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
         monitor_flush(mon);
--=20
2.19.0.271.gfe8321ec05
