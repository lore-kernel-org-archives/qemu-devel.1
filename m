Received: from eggs.gnu.org ([2001:4830:134:3::10]:46022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rR4-0001W7-Mi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rR3-0003km-Cb
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3rR3-0003kE-3j
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02CCF80492
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 21:58:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 27 Apr 2017 16:58:21 -0500
Message-Id: <20170427215821.19397-11-eblake@redhat.com>
In-Reply-To: <20170427215821.19397-1-eblake@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/10] test-qga: Actually test 0xff sync
 bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Commit 62c39b3 introduced test-qga, and at face value, appears
to be testing the 'guest-sync' behavior that is recommended for
guests in sending 0xff to QGA to force the parser to reset.  But
this aspect of the test has never actually done anything: the
qmp_fd() call chain converts its string argument into QObject,
then converts that QObject back to the actual string that is
sent over the wire - and the conversion process silently drops
the 0xff byte from the string sent to QGA, thus never resetting
the QGA parser.

An upcoming patch will get rid of the wasteful round trip
through QObject, at which point the string in test-qga will be
directly sent over the wire.

But fixing qmp_fd() to actually send 0xff over the wire is not
all we have to do - the actual QMP parser loudly complains that
0xff is not valid JSON, and sends an error message _prior_ to
actually parsing the 'guest-sync' or 'guest-sync-delimited'
command.  With 'guest-sync', we cannot easily tell if this error
message is a result of our command - which is WHY we invented
the 'guest-sync-delimited' command.  So for the testsuite, fix
things to only check 0xff behavior on 'guest-sync-delimited',
and to loop until we've consumed all garbage prior to the
requested delimiter, which matches the documented actions that
a real QGA client is supposed to do.

Ideally, we'd fix the QGA JSON parser to silently ignore 0xff
rather than sending an error message back, at which point we
could enhance this test for 'guest-sync' as well as for
'guest-sync-delimited'.  But for the sake of this patch, our
testing of 'guest-sync' is no worse than it was pre-patch,
because we have never been sending 0xff over the wire in the
first place.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---
v5: add R-b
v4: no change
v3: use inline \xff byte rather than %c, add comment
---
 tests/libqtest.c |  8 ++++++++
 tests/test-qga.c | 34 +++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 512c150..84ecbd2 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -446,6 +446,14 @@ void qmp_fd_sendv(int fd, const char *fmt, va_list ap)
     va_list ap_copy;
     QObject *qobj;

+    /* qobject_from_jsonv() silently eats leading 0xff as invalid
+     * JSON, but we want to test sending them over the wire to force
+     * resyncs */
+    if (*fmt == '\377') {
+        socket_send(fd, fmt, 1);
+        fmt++;
+    }
+
     /* Going through qobject ensures we escape strings properly.
      * This seemingly unnecessary copy is required in case va_list
      * is an array type.
diff --git a/tests/test-qga.c b/tests/test-qga.c
index c780f00..438c2e7 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -146,14 +146,23 @@ static void test_qga_sync_delimited(gconstpointer fix)
     QDict *ret;
     gchar *cmd;

-    cmd = g_strdup_printf("%c{'execute': 'guest-sync-delimited',"
-                          " 'arguments': {'id': %u } }", 0xff, r);
+    cmd = g_strdup_printf("\xff{'execute': 'guest-sync-delimited',"
+                          " 'arguments': {'id': %u } }", r);
     qmp_fd_send(fixture->fd, cmd);
     g_free(cmd);

-    v = read(fixture->fd, &c, 1);
-    g_assert_cmpint(v, ==, 1);
-    g_assert_cmpint(c, ==, 0xff);
+    /*
+     * Read and ignore garbage until resynchronized.
+     *
+     * TODO: The server shouldn't emit so much garbage (among other
+     * things, it loudly complains about the client's \xff being
+     * invalid JSON, even though it is a documented part of the
+     * handshake.
+     */
+    do {
+        v = read(fixture->fd, &c, 1);
+        g_assert_cmpint(v, ==, 1);
+    } while (c != 0xff);

     ret = qmp_fd_receive(fixture->fd);
     g_assert_nonnull(ret);
@@ -172,8 +181,19 @@ static void test_qga_sync(gconstpointer fix)
     QDict *ret;
     gchar *cmd;

-    cmd = g_strdup_printf("%c{'execute': 'guest-sync',"
-                          " 'arguments': {'id': %u } }", 0xff, r);
+    /*
+     * TODO guest-sync is inherently limited: we cannot distinguish
+     * failure caused by reacting to garbage on the wire prior to this
+     * command, from failure of this actual command. Clients are
+     * supposed to be able to send a raw '\xff' byte to at least
+     * re-synchronize the server's parser prior to this command, but
+     * we are not in a position to test that here because (at least
+     * for now) it causes the server to issue an error message about
+     * invalid JSON. Testing of '\xff' handling is done in
+     * guest-sync-delimited instead.
+     */
+    cmd = g_strdup_printf("{'execute': 'guest-sync',"
+                          " 'arguments': {'id': %u } }", r);
     ret = qmp_fd(fixture->fd, cmd);
     g_free(cmd);

-- 
2.9.3
