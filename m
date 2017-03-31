Received: from eggs.gnu.org ([2001:4830:134:3::10]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctvnS-0000ky-8A
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctvnR-0002aQ-C6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:36:54 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ctvnR-0002Wh-5h
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:36:53 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Mar 2017 13:36:41 +0100
Message-Id: <1490963801-27870-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/libqtest.c: Delete possible stale unix
 sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Occasionally if a test crashes or is interrupted by the user
at the wrong moment it could leave behind a stale UNIX
socket in /tmp/. This will then cause a subsequent test
run to fail spuriously with
 tests/libqtest.c:70:init_socket: assertion failed (ret != -1): (-1 != -1)
if it happens to reuse the same PID.

Defend against this by deleting any stray stale socket before
trying to open the new ones for this test.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This seems like an easy way to shut up this infrequent but irritating
error case...

 tests/libqtest.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index a5c3d2b..99b1195 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -167,6 +167,14 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
     qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
 
+    /* It's possible that if an earlier test run crashed it might
+     * have left a stale unix socket lying around. Delete any
+     * stale old socket to avoid spurious test failures with
+     * tests/libqtest.c:70:init_socket: assertion failed (ret != -1): (-1 != -1)
+     */
+    unlink(socket_path);
+    unlink(qmp_socket_path);
+
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-- 
2.7.4
