Received: from eggs.gnu.org ([2001:4830:134:3::10]:50807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u7-0003UB-OR
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u6-0000kI-Sj
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3u6-0000k3-N4
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6451C87A70
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  1 Sep 2018 13:17:16 +0200
Message-Id: <20180901111716.1675-7-armbru@redhat.com>
In-Reply-To: <20180901111716.1675-1-armbru@redhat.com>
References: <20180901111716.1675-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] monitor: no need to save need_resume
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

There is no need for per-command need_resume granularity, it should
resume after running an non-oob command on oob-disabled monitor.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180829134043.31706-5-marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 25f656bf8a..cf3b629cf7 100644
--- a/monitor.c
+++ b/monitor.c
@@ -256,12 +256,6 @@ struct QMPRequest {
      */
     QObject *req;
     Error *err;
-    /*
-     * Whether we need to resume the monitor afterward.  This flag is
-     * used to emulate the old QMP server behavior that the current
-     * command must be completed before execution of the next one.
-     */
-    bool need_resume;
 };
 typedef struct QMPRequest QMPRequest;
=20
@@ -4131,11 +4125,14 @@ static void monitor_qmp_bh_dispatcher(void *data)
 {
     QMPRequest *req_obj =3D monitor_qmp_requests_pop_any();
     QDict *rsp;
+    bool need_resume;
=20
     if (!req_obj) {
         return;
     }
=20
+    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
+    need_resume =3D !qmp_oob_enabled(req_obj->mon);
     if (req_obj->req) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
         monitor_qmp_dispatch(req_obj->mon, req_obj->req, req_obj->id);
@@ -4147,7 +4144,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
         qobject_unref(rsp);
     }
=20
-    if (req_obj->need_resume) {
+    if (need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
         monitor_resume(req_obj->mon);
     }
@@ -4195,7 +4192,6 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
     req_obj->id =3D id;
     req_obj->req =3D req;
     req_obj->err =3D err;
-    req_obj->need_resume =3D false;
=20
     /* Protect qmp_requests and fetching its length. */
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
@@ -4208,7 +4204,6 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
      */
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
-        req_obj->need_resume =3D true;
     } else {
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
--=20
2.17.1
