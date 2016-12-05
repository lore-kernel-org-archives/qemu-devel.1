Received: from eggs.gnu.org ([2001:4830:134:3::10]:47259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007V9-Ck
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOD-0006vD-9J
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOD-0006uj-0K
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:17 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 238C13D96D
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:06 +0100
Message-Id: <1480956313-31322-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] test-qga: Avoid
 qobject_from_jsonv("%"PRId64)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The qobject_from_jsonv() function implements a pseudo-printf
language for creating a QObject; however, it is hard-coded to
only parse a subset of formats understood by -Wformat, and is
not a straight synonym to bare printf().  In particular, any
use of an int64_t integer works only if the system's
definition of PRId64 matches what the parser expects; which
works on glibc (%lld or %ld depending on 32- vs. 64-bit) and
mingw (%I64d), but not on Mac OS (%qd).  Rather than enhance
the parser, it is just as easy to use normal printf() for
this particular conversion, matching what is done elsewhere
in this file [1], which is safe in this instance because the
format does not contain any of the problematic differences
(bare '%' or the '%s' format).

The use of PRId64 for a variable named 'pid' is gross, but it
is a sad reality of the 64-bit mingw environment, which
mistakenly defines pid_t as a 64-bit type even though getpid()
returns 'int' on that platform [2].  Our definition of the
QGA GuestExec type defines 'pid' as a 64-bit entity, and we
can't tighten it to 'int32' unless the mingw header is fixed.
Using 'long long' instead of 'int64_t' just so that we can
stick with qobject_from_jsonv("%lld") instead of printf() is
not any prettier, since we may have later type churn anyways.

[1] see 'git grep -A2 strdup_printf tests/test-qga.c'
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1397787

Reported by: G 3 <programmingkidx@gmail.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <1479922617-4400-3-git-send-email-eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qga.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 40af649..868b02a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -837,6 +837,7 @@ static void test_qga_guest_exec(gconstpointer fix)
     int64_t pid, now, exitcode;
     gsize len;
     bool exited;
+    char *cmd;
 
     /* exec 'echo foo bar' */
     ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec', 'arguments': {"
@@ -851,9 +852,10 @@ static void test_qga_guest_exec(gconstpointer fix)
 
     /* wait for completion */
     now = g_get_monotonic_time();
+    cmd = g_strdup_printf("{'execute': 'guest-exec-status',"
+                          " 'arguments': { 'pid': %" PRId64 " } }", pid);
     do {
-        ret = qmp_fd(fixture->fd, "{'execute': 'guest-exec-status',"
-                     " 'arguments': { 'pid': %" PRId64 "  } }", pid);
+        ret = qmp_fd(fixture->fd, cmd);
         g_assert_nonnull(ret);
         val = qdict_get_qdict(ret, "return");
         exited = qdict_get_bool(val, "exited");
@@ -863,6 +865,7 @@ static void test_qga_guest_exec(gconstpointer fix)
     } while (!exited &&
              g_get_monotonic_time() < now + 5 * G_TIME_SPAN_SECOND);
     g_assert(exited);
+    g_free(cmd);
 
     /* check stdout */
     exitcode = qdict_get_int(val, "exitcode");
-- 
2.5.5
