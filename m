Received: from eggs.gnu.org ([2001:4830:134:3::10]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elzcs-00047Y-8l
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elzco-0008G2-98
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elzco-0008FU-4T
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A29D40201A0
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 16:09:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 14 Feb 2018 17:09:35 +0100
Message-Id: <1518624575-7048-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] io/channel-command: Do not kill the child
 process after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>

We are currently facing some migration failure on s390x when running
certain avocado-vt tests, e.g. when running the test
type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.gzip_exec.
This test is using 'migrate -d "exec:nc localhost 5200"' for the migration.
The problem is detected at the receiving side, where the migration stream
apparently ends too early. However, the cause for the problem is at the
sending side: After writing the migration stream into the pipe to netcat,
the source QEMU calls qio_channel_command_close() which closes the pipe
and immediately (!) kills the child process afterwards (via the function
qio_channel_command_abort()). So if the  sending netcat did not read the
final bytes from the pipe yet, or  if it did not manage to send out all
its buffers yet, it is killed before the whole migration stream is passed
to the destination side.

QEMU can not know how much time is required by the child process to send
over all migration data, so we should not kill it, neither directly nor
after a delay. Let's simply wait for the child process to exit gracefully
instead (this was also the behaviour of pclose() that was used in "exec:"
migration before the QIOChannel rework).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 io/channel-command.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/io/channel-command.c b/io/channel-command.c
index 319c5ed..3e7eb17 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -301,6 +301,9 @@ static int qio_channel_command_close(QIOChannel *ioc,
 {
     QIOChannelCommand *cioc = QIO_CHANNEL_COMMAND(ioc);
     int rv = 0;
+#ifndef WIN32
+    pid_t wp;
+#endif
 
     /* We close FDs before killing, because that
      * gives a better chance of clean shutdown
@@ -315,11 +318,18 @@ static int qio_channel_command_close(QIOChannel *ioc,
         rv = -1;
     }
     cioc->writefd = cioc->readfd = -1;
+
 #ifndef WIN32
-    if (qio_channel_command_abort(cioc, errp) < 0) {
+    do {
+        wp = waitpid(cioc->pid, NULL, 0);
+    } while (wp == (pid_t)-1 && errno == EINTR);
+    if (wp == (pid_t)-1) {
+        error_setg_errno(errp, errno, "Failed to wait for pid %llu",
+                         (unsigned long long)cioc->pid);
         return -1;
     }
 #endif
+
     if (rv < 0) {
         error_setg_errno(errp, errno, "%s",
                          "Unable to close command");
-- 
1.8.3.1
