Received: from eggs.gnu.org ([2001:4830:134:3::10]:54010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022g-OM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgP-0003KC-1P
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Jd-Rl
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:42 +0000
Message-Id: <20180215175044.8159-6-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] io: Add /dev/fdset/ support to
 QIOChannelFile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Add /dev/fdset/ support to QIOChannelFile by calling qemu_open() instead
of open() and qemu_close() instead of close(). There is a subtle
semantic change since qemu_open() automatically sets O_CLOEXEC, but this
doesn't affect any of the users of the function.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 1f2f710bf9..db948abc3e 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -50,7 +50,7 @@ qio_channel_file_new_path(const char *path,
 
     ioc = QIO_CHANNEL_FILE(object_new(TYPE_QIO_CHANNEL_FILE));
 
-    ioc->fd = open(path, flags, mode);
+    ioc->fd = qemu_open(path, flags, mode);
     if (ioc->fd < 0) {
         object_unref(OBJECT(ioc));
         error_setg_errno(errp, errno,
@@ -74,7 +74,7 @@ static void qio_channel_file_finalize(Object *obj)
 {
     QIOChannelFile *ioc = QIO_CHANNEL_FILE(obj);
     if (ioc->fd != -1) {
-        close(ioc->fd);
+        qemu_close(ioc->fd);
         ioc->fd = -1;
     }
 }
@@ -173,7 +173,7 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (close(fioc->fd) < 0) {
+    if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
         return -1;
-- 
2.14.3
