Received: from eggs.gnu.org ([2001:4830:134:3::10]:54016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022o-Qa
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003KO-0H
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Ji-Rg
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:43 +0000
Message-Id: <20180215175044.8159-7-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] io/channel-command: Do not kill the child
 process after closing the pipe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Thomas Huth <thuth@redhat.com>

We are currently facing some migration failure on s390x when running
certain avocado-vt tests, e.g. when running the test
type_specific.io-github-autotest-qemu.migrate.with_reboot.exec.gzip_exec.
This test is using 'migrate -d "exec:nc localhost 5200"' for the migratio=
n.
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
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 io/channel-command.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/io/channel-command.c b/io/channel-command.c
index 319c5ed50c..3e7eb17eff 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -301,6 +301,9 @@ static int qio_channel_command_close(QIOChannel *ioc,
 {
     QIOChannelCommand *cioc =3D QIO_CHANNEL_COMMAND(ioc);
     int rv =3D 0;
+#ifndef WIN32
+    pid_t wp;
+#endif
=20
     /* We close FDs before killing, because that
      * gives a better chance of clean shutdown
@@ -315,11 +318,18 @@ static int qio_channel_command_close(QIOChannel *io=
c,
         rv =3D -1;
     }
     cioc->writefd =3D cioc->readfd =3D -1;
+
 #ifndef WIN32
-    if (qio_channel_command_abort(cioc, errp) < 0) {
+    do {
+        wp =3D waitpid(cioc->pid, NULL, 0);
+    } while (wp =3D=3D (pid_t)-1 && errno =3D=3D EINTR);
+    if (wp =3D=3D (pid_t)-1) {
+        error_setg_errno(errp, errno, "Failed to wait for pid %llu",
+                         (unsigned long long)cioc->pid);
         return -1;
     }
 #endif
+
     if (rv < 0) {
         error_setg_errno(errp, errno, "%s",
                          "Unable to close command");
--=20
2.14.3
