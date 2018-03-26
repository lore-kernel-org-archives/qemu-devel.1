Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkc-00054y-Hr
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1f0Tkb-0002gp-67
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1f0Tkb-0002gd-0Z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 11:09:33 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 17:08:42 +0200
Message-Id: <20180326150916.9602-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180326150916.9602-1-marcandre.lureau@redhat.com>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 04/38] monitor: no need to save need_resume
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

There is no need for per-command need_resume granularity, it should
resume after running an non-oob command on oob-disabled monitor.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/monitor.c b/monitor.c
index 59920ea872..2428c7fcd4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3950,12 +3950,6 @@ struct QMPRequest {
     QObject *id;
     /* Request object to be handled */
     QObject *req;
-    /*
-     * Whether we need to resume the monitor afterward.  This flag is
-     * used to emulate the old QMP server behavior that the current
-     * command must be completed before execution of the next one.
-     */
-    bool need_resume;
 };
 typedef struct QMPRequest QMPRequest;
=20
@@ -3963,7 +3957,7 @@ typedef struct QMPRequest QMPRequest;
  * Dispatch one single QMP request. The function will free the req_obj
  * and objects inside it before return.
  */
-static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
+static void monitor_qmp_dispatch_one(QMPRequest *req_obj, bool oob_cmd)
 {
     Monitor *mon, *old_mon;
     QObject *req, *rsp =3D NULL, *id;
@@ -3972,7 +3966,7 @@ static void monitor_qmp_dispatch_one(QMPRequest *re=
q_obj)
     req =3D req_obj->req;
     mon =3D req_obj->mon;
     id =3D req_obj->id;
-    need_resume =3D req_obj->need_resume;
+    need_resume =3D !oob_cmd && !qmp_oob_enabled(mon);
=20
     g_free(req_obj);
=20
@@ -4043,7 +4037,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
=20
     if (req_obj) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
-        monitor_qmp_dispatch_one(req_obj);
+        monitor_qmp_dispatch_one(req_obj, false);
         /* Reschedule instead of looping so the main loop stays responsi=
ve */
         qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
     }
@@ -4096,13 +4090,12 @@ static void handle_qmp_command(JSONMessageParser =
*parser, GQueue *tokens)
     req_obj->mon =3D mon;
     req_obj->id =3D id;
     req_obj->req =3D req;
-    req_obj->need_resume =3D false;
=20
     if (qmp_is_oob(qdict)) {
         /* Out-Of-Band (OOB) requests are executed directly in parser. *=
/
         trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_obj->i=
d)
                                           ?: "");
-        monitor_qmp_dispatch_one(req_obj);
+        monitor_qmp_dispatch_one(req_obj, true);
         return;
     }
=20
@@ -4117,7 +4110,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
      */
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
-        req_obj->need_resume =3D true;
     } else {
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
--=20
2.17.0.rc1.1.g4c4f2b46a3
