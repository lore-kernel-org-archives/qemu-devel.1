Received: from eggs.gnu.org ([2001:4830:134:3::10]:52229)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <fl@n621.de>)
	id 1eyDcY-0001v6-0b
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fl@n621.de>) id 1eyDcX-0004Am-3f
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:31:54 -0400
Received: from nyx.n621.de ([2a01:4f8:151:8ffd:2::1]:57725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fl@n621.de>) id 1eyDcW-00048d-TO
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:31:53 -0400
From: Florian Larysch <fl@n621.de>
Date: Tue, 20 Mar 2018 10:31:35 +0100
Message-Id: <20180320093135.26422-1-fl@n621.de>
Subject: [Qemu-devel] [PATCH] os: truncate pidfile on creation
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

Signed-off-by: Florian Larysch <fl@n621.de>
---
 os-posix.c | 2 +-
 os-win32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/os-posix.c b/os-posix.c
index b9c2343b1e..9a6b874180 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -301,7 +301,7 @@ int qemu_create_pidfile(const char *filename)
     int len;
     int fd;
 
-    fd = qemu_open(filename, O_RDWR | O_CREAT, 0600);
+    fd = qemu_open(filename, O_RDWR | O_CREAT | O_TRUNC, 0600);
     if (fd == -1) {
         return -1;
     }
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
