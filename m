Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47r-0001pm-KT
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47p-0007wd-Mo
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47p-0007wW-Gq
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23106402347E
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EF8132156893
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:14 +0200
Message-Id: <20180716140514.1490-6-armbru@redhat.com>
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] monitor: Fix tracepoint crash on JSON
 syntax error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When tracepoint handle_qmp_command is enabled, we crash on JSON syntax
errors.  Broken in commit 1cc37471525.  Fix by skipping the tracepoint
on JSON syntax error.  Before the flawed commit, we skipped it by
returning early.

Fixes: CID 1394216
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180716091012.29510-1-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 7af1f18d13..be29634a00 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4224,7 +4224,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
         qdict_del(qdict, "id");
     } /* else will fail qmp_dispatch() */
=20
-    if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
+    if (req && trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND))=
 {
         QString *req_json =3D qobject_to_json(req);
         trace_handle_qmp_command(mon, qstring_get_str(req_json));
         qobject_unref(req_json);
--=20
2.17.1
