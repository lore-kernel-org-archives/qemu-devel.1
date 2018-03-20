Received: from eggs.gnu.org ([2001:4830:134:3::10]:41261)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <fl@n621.de>)
	id 1eyKbN-0006LA-Ec
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fl@n621.de>) id 1eyKbM-0005YV-J4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:59:09 -0400
Received: from nyx.n621.de ([2a01:4f8:151:8ffd:2::1]:60634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fl@n621.de>) id 1eyKbM-0005Xo-CH
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:59:08 -0400
From: Florian Larysch <fl@n621.de>
Date: Tue, 20 Mar 2018 17:58:55 +0100
Message-Id: <20180320165855.23258-1-fl@n621.de>
Subject: [Qemu-devel] [PATCH v2] os: truncate pidfile on creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, Florian Larysch <fl@n621.de>

qemu_create_pidfile does not truncate the pidfile when it creates it,
but rather overwrites its contents with the new pid. This works fine as
long as the length of the pid doesn't decrease, but this might happen in
case of wraparounds, causing pidfiles to contain trailing garbage which
breaks operations such as 'kill $(cat pidfile)'.

Instead, always truncate the file before writing it.

Note that the order is important here: We cannot simply use O_TRUNC in
the open() call because another qemu process might truncate the pidfile
of a process that is still running before reaching the lockf() barrier.

The Windows version suffers from a similar problem, but as it does not
provide effective mutual exclusion anyway (because the file handle is
closed immediately after writing to it), adopting this behavior still
seems to be an improvement, as it at least prevents garbeled pidfiles.

Signed-off-by: Florian Larysch <fl@n621.de>
---
 os-posix.c | 6 ++++++
 os-win32.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index b9c2343b1e..f2318aef55 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -309,6 +309,12 @@ int qemu_create_pidfile(const char *filename)
         close(fd);
         return -1;
     }
+
+    if (ftruncate(fd, 0)) {
+        close(fd);
+        return -1;
+    }
+
     len = snprintf(buffer, sizeof(buffer), FMT_pid "\n", getpid());
     if (write(fd, buffer, len) != len) {
         close(fd);
diff --git a/os-win32.c b/os-win32.c
index 586a7c7d49..85dbad7af8 100644
--- a/os-win32.c
+++ b/os-win32.c
@@ -108,7 +108,7 @@ int qemu_create_pidfile(const char *filename)
     memset(&overlap, 0, sizeof(overlap));
 
     file = CreateFile(filename, GENERIC_WRITE, FILE_SHARE_READ, NULL,
-                      OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+                      CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
 
     if (file == INVALID_HANDLE_VALUE) {
         return -1;
-- 
2.16.2
