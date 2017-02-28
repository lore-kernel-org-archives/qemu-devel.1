Received: from eggs.gnu.org ([2001:4830:134:3::10]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6j-0001Yt-3b
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cin6d-0006rk-PH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cin6d-0006rJ-JK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:06:39 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FF5C8047D
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DFB2B15A80
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 19:06:38 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Feb 2017 20:06:12 +0100
Message-Id: <1488308796-28832-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1488308796-28832-1-git-send-email-armbru@redhat.com>
References: <1488308796-28832-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 02/26] libqtest: Work around a "QMP wants a
 newline" bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The next commit is going to add a test that calls qmp("null").
Curiously, this hangs.  Here's why.

qmp_fd_sendv() doesn't send newlines.  Not even when @fmt contains
some.  At first glance, the QMP parser seems to be fine with that.
However, it turns out that it fails to react to input until it sees
either a newline, an object or an array.  To reproduce, feed to a QMP
monitor like this:

    $ echo -n 'null' | socat UNIX:/work/armbru/images/test-qmp STDIO
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2}, "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}

No output after the greeting.

Add a newline:

    $ echo 'null' | socat UNIX:/work/armbru/images/test-qmp STDIO
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2}, "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
    {"error": {"class": "GenericError", "desc": "Expected 'object' in QMP input"}}

Correct output for input 'null'.

Add an object instead:

    $ echo -n 'null { "execute": "qmp_capabilities" }' | socat UNIX:qmp-socket STDIO
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 8, "major": 2}, "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
    {"error": {"class": "GenericError", "desc": "Expected 'object' in QMP input"}}
    {"return": {}}

Also correct output.

Work around this QMP bug by having qmp_fd_sendv() append a newline.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <1488303560-18803-3-git-send-email-armbru@redhat.com>
---
 tests/libqtest.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index e54354d..ad23ce9 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -442,14 +442,20 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     if (qobj) {
         int log = getenv("QTEST_LOG") != NULL;
         QString *qstr = qobject_to_json(qobj);
-        const char *str = qstring_get_str(qstr);
-        size_t size = qstring_get_length(qstr);
+        const char *str;
+
+        /*
+         * BUG: QMP doesn't react to input until it sees a newline, an
+         * object, or an array.  Work-around: give it a newline.
+         */
+        qstring_append_chr(qstr, '\n');
+        str = qstring_get_str(qstr);
 
         if (log) {
             fprintf(stderr, "%s", str);
         }
         /* Send QMP request */
-        socket_send(fd, str, size);
+        socket_send(fd, str, qstring_get_length(qstr));
 
         QDECREF(qstr);
         qobject_decref(qobj);
-- 
2.7.4
