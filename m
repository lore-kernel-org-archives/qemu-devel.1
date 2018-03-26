Received: from eggs.gnu.org ([2001:4830:134:3::10]:54785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkd-00055V-LZ
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkc-0002hk-Nl
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkc-0002hK-K5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:43 +0200
Message-Id: <20180326150916.9602-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/38] monitor: further simplify previous
 patch
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

Move the resume code to the non-oob path. This patch could eventually
be squashed with the previous patch.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/monitor.c b/monitor.c
index 2428c7fcd4..a8dcfa283e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3957,16 +3957,14 @@ typedef struct QMPRequest QMPRequest;
  * Dispatch one single QMP request. The function will free the req_obj
  * and objects inside it before return.
  */
-static void monitor_qmp_dispatch_one(QMPRequest *req_obj, bool oob_cmd)
+static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
-    bool need_resume;
=20
     req =3D req_obj->req;
     mon =3D req_obj->mon;
     id =3D req_obj->id;
-    need_resume =3D !oob_cmd && !qmp_oob_enabled(mon);
=20
     g_free(req_obj);
=20
@@ -3986,11 +3984,6 @@ static void monitor_qmp_dispatch_one(QMPRequest *r=
eq_obj, bool oob_cmd)
     /* Respond if necessary */
     monitor_qmp_respond(mon, rsp, NULL, id);
=20
-    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
-    if (need_resume) {
-        monitor_resume(mon);
-    }
-
     qobject_decref(req);
 }
=20
@@ -4036,8 +4029,14 @@ static void monitor_qmp_bh_dispatcher(void *data)
     QMPRequest *req_obj =3D monitor_qmp_requests_pop_one();
=20
     if (req_obj) {
+        Monitor *mon =3D req_obj->mon;
+        bool need_resume =3D !qmp_oob_enabled(mon);
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
-        monitor_qmp_dispatch_one(req_obj, false);
+        monitor_qmp_dispatch_one(req_obj);
+        /* This pairs with the monitor_suspend() in handle_qmp_command()=
. */
+        if (need_resume) {
+            monitor_resume(mon);
+        }
         /* Reschedule instead of looping so the main loop stays responsi=
ve */
         qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
     }
@@ -4095,7 +4094,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d)
                                           ?: "");
-        monitor_qmp_dispatch_one(req_obj, true);
+        monitor_qmp_dispatch_one(req_obj);
         return;
     }
=20
--=20
2.17.0.rc1.1.g4c4f2b46a3
