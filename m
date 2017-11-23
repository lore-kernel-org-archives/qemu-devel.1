Received: from eggs.gnu.org ([2001:4830:134:3::10]:47485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eHnBN-0002QN-QZ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eHnBH-0005uf-O3
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eHnBH-0005rs-0o
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:48:23 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Thu, 23 Nov 2017 16:47:52 +0800
Message-ID: <1511426872-13980-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] docs/devel/migration.txt: keep functions
 consistent with the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, weidong.huang@huawei.com, wangxinxin.wang@huawei.com, Jay Zhou <jianjay.zhou@huawei.com>

Since the commit 11808bb0c422134bf09119f4aa22c59b0ce84bf3 removed
the put_buffer callback and using an iovec based write handler instead,
the docs should be sync with the code too.

Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
---
 docs/devel/migration.txt | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/docs/devel/migration.txt b/docs/devel/migration.txt
index 4030703..e7b08c9 100644
--- a/docs/devel/migration.txt
+++ b/docs/devel/migration.txt
@@ -52,26 +52,31 @@ QEMU uses a QEMUFile abstraction to be able to do migration.  Any type
 of migration that wants to use QEMU infrastructure has to create a
 QEMUFile with:
 
-QEMUFile *qemu_fopen_ops(void *opaque,
-                         QEMUFilePutBufferFunc *put_buffer,
-                         QEMUFileGetBufferFunc *get_buffer,
-                         QEMUFileCloseFunc *close);
+typedef struct QEMUFileOps {
+    QEMUFileGetBufferFunc *get_buffer;
+    QEMUFileCloseFunc *close;
+    QEMUFileSetBlocking *set_blocking;
+    QEMUFileWritevBufferFunc *writev_buffer;
+    QEMURetPathFunc *get_return_path;
+    QEMUFileShutdownFunc *shut_down;
+} QEMUFileOps;
 
-The functions have the following functionality:
+QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
 
-This function writes a chunk of data to a file at the given position.
-The pos argument can be ignored if the file is only used for
-streaming.  The handler should try to write all of the data it can.
+The main functions of QEMUFileOps have the following functionality:
 
-typedef int (QEMUFilePutBufferFunc)(void *opaque, const uint8_t *buf,
-                                    int64_t pos, int size);
+This function writes an iovec to file. The handler must write all
+of the data or return a negative errno value.
+
+typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, struct iovec *iov,
+                                           int iovcnt, int64_t pos);
 
 Read a chunk of data from a file at the given position.  The pos argument
 can be ignored if the file is only be used for streaming.  The number of
 bytes actually read should be returned.
 
-typedef int (QEMUFileGetBufferFunc)(void *opaque, uint8_t *buf,
-                                    int64_t pos, int size);
+typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, uint8_t *buf,
+                                        int64_t pos, int size);
 
 Close a file and return an error code.
 
@@ -80,7 +85,7 @@ typedef int (QEMUFileCloseFunc)(void *opaque);
 You can use any internal state that you need using the opaque void *
 pointer that is passed to all functions.
 
-The important functions for us are put_buffer()/get_buffer() that
+The important functions for us are writev_buffer()/get_buffer() that
 allow to write/read a buffer into the QEMUFile.
 
 === How to save the state of one device ===
-- 
1.8.3.1
