Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmV-0000rK-C0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fqDmM-0005E3-Fu
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57658 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fqDmF-00059h-CJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:37:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97200F2B53
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7386E7C54
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:37:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 16 Aug 2018 10:37:01 +0200
Message-Id: <20180816083701.3932-26-armbru@redhat.com>
In-Reply-To: <20180816083701.3932-1-armbru@redhat.com>
References: <20180816083701.3932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/25] libqtest: Improve error reporting for bad
 read from QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When read() from the qtest socket or the QMP socket fails or EOFs, we
report "Broken pipe" and exit(1).  This commonly happens when QEMU
crashes.  It also happens when QEMU refuses to run because the test
passed it bad arguments.  Sadly, we neglect to report either.

Improve this by calling abort() instead of exit(1), so kill_qemu()
runs, and reports how QEMU died.  This improves error reporting to
something like

    /x86_64/device/introspect/list: Broken pipe
    tests/libqtest.c:129: kill_qemu() detected QEMU death from signal 6 (=
Aborted) (dumped core)

Three exit() remain in libqtest.c:

* In qmp_response(), when we can't parse a QMP reply read from the QMP
  socket.  Change to abort() for consistency.

* In qtest_qemu_binary(), when QTEST_QEMU_BINARY isn't in the
  environment.  This can only happen before we start QEMU.  Leave
  alone.

* In qtest_init_without_qmp_handshake(), when the fork()ed child fails
  to execlp().  Leave alone.

exit() elsewhere are unlikely due to QEMU dying on us.  If that should
turn out to be wrong, we can move kill_qemu() from @abrt_hooks to
atexit() or something.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180815141945.10457-2-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
[Commit message tweaked slightly]
---
 tests/libqtest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index b703fca26d..852ccff1ce 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -367,7 +367,7 @@ static GString *qtest_recv_line(QTestState *s)
=20
         if (len =3D=3D -1 || len =3D=3D 0) {
             fprintf(stderr, "Broken pipe\n");
-            exit(1);
+            abort();
         }
=20
         g_string_append_len(s->rx, buffer, len);
@@ -454,7 +454,7 @@ static void qmp_response(JSONMessageParser *parser, G=
Queue *tokens)
     obj =3D json_parser_parse(tokens, NULL);
     if (!obj) {
         fprintf(stderr, "QMP JSON response parsing failed\n");
-        exit(1);
+        abort();
     }
=20
     g_assert(!qmp->response);
@@ -480,7 +480,7 @@ QDict *qmp_fd_receive(int fd)
=20
         if (len =3D=3D -1 || len =3D=3D 0) {
             fprintf(stderr, "Broken pipe\n");
-            exit(1);
+            abort();
         }
=20
         if (log) {
--=20
2.17.1
