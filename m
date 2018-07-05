Received: from eggs.gnu.org ([2001:4830:134:3::10]:37640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fb7Kg-0005DO-L5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fb7Kd-0003PO-Ik
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:42:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41094 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fb7Kd-0003Oo-Df
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCE27818A6B9
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 16:42:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jul 2018 18:42:01 +0200
Message-Id: <20180705164201.9853-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] monitor: fix double-free of request error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

qmp_error_response() will free the given error. Fix double-free in
later qmp_request_free().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor.c b/monitor.c
index 3c9c97b73f..7af1f18d13 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4186,6 +4186,7 @@ static void monitor_qmp_bh_dispatcher(void *data)
     } else {
         assert(req_obj->err);
         rsp =3D qmp_error_response(req_obj->err);
+        req_obj->err =3D NULL;
         monitor_qmp_respond(req_obj->mon, rsp, NULL);
         qobject_unref(rsp);
     }
--=20
2.18.0.rc1
