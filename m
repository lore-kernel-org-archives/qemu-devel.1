Received: from eggs.gnu.org ([2001:4830:134:3::10]:34866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUc-0000C4-28
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUb-0006ec-CR
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9lUb-0006dU-6K
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1032D5D66B
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 06:27:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 Oct 2018 14:27:14 +0800
Message-Id: <20181009062718.1914-3-peterx@redhat.com>
In-Reply-To: <20181009062718.1914-1-peterx@redhat.com>
References: <20181009062718.1914-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 2/6] monitor: resume the monitor earlier if
 needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Currently when QMP request queue full we won't resume the monitor until
we have completely handled the current command.  It's not necessary
since even before it's handled the queue is already non-full.  Moving
the resume logic earlier before the command execution.

Note that now monitor_resume() is heavy weighted after 8af6bb14a3a8 and
it's even possible (as pointed out by Marc-Andr=C3=A9) that the function
itself may try to take the monitor lock again, so let's do the resume
after the monitor lock is released to avoid possible dead lock.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1f83775fff..f5911399d8 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4149,6 +4149,12 @@ static void monitor_qmp_bh_dispatcher(void *data)
     need_resume =3D !qmp_oob_enabled(mon) ||
         mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
     qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
+
+    if (need_resume) {
+        /* Pairs with the monitor_suspend() in handle_qmp_command() */
+        monitor_resume(mon);
+    }
+
     if (req_obj->req) {
         trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj->id) ?=
: "");
         monitor_qmp_dispatch(mon, req_obj->req, req_obj->id);
@@ -4160,10 +4166,6 @@ static void monitor_qmp_bh_dispatcher(void *data)
         qobject_unref(rsp);
     }
=20
-    if (need_resume) {
-        /* Pairs with the monitor_suspend() in handle_qmp_command() */
-        monitor_resume(mon);
-    }
     qmp_request_free(req_obj);
=20
     /* Reschedule instead of looping so the main loop stays responsive *=
/
--=20
2.17.1
