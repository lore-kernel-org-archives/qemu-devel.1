Received: from eggs.gnu.org ([2001:4830:134:3::10]:48827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDrp-0001gM-RI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fgDri-0007oN-L4
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fgDri-0007ny-FV
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 14:41:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DF0587A84
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 18:41:26 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Jul 2018 20:40:58 +0200
Message-Id: <20180719184111.5129-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180719184111.5129-1-marcandre.lureau@redhat.com>
References: <20180719184111.5129-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/18] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

There is no need for per-command need_resume granularity, it should
resume after running an non-oob command on oob-disabled monitor.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 46d98010f7..961779032a 100644
--- a/monitor.c
+++ b/monitor.c
@@ -257,12 +257,6 @@ struct QMPRequest {
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
@@ -4079,11 +4073,14 @@ static void monitor_qmp_bh_dispatcher(void *data)
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
@@ -4095,7 +4092,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
         qobject_unref(rsp);
     }
=20
-    if (req_obj->need_resume) {
+    if (need_resume) {
         /* Pairs with the monitor_suspend() in handle_qmp_command() */
         monitor_resume(req_obj->mon);
     }
@@ -4147,7 +4144,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
     req_obj->id =3D id;
     req_obj->req =3D req;
     req_obj->err =3D err;
-    req_obj->need_resume =3D false;
=20
     /* Protect qmp_requests and fetching its length. */
     qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
@@ -4160,7 +4156,6 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
      */
     if (!qmp_oob_enabled(mon)) {
         monitor_suspend(mon);
-        req_obj->need_resume =3D true;
     } else {
         /* Drop the request if queue is full. */
         if (mon->qmp.qmp_requests->length >=3D QMP_REQ_QUEUE_LEN_MAX) {
--=20
2.18.0.129.ge3331758f1
