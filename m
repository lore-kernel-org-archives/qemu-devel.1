Received: from eggs.gnu.org ([2001:4830:134:3::10]:37734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1f-0005WT-Aj
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00084a-Nk
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:12847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00081x-Gm
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:47 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 1 Nov 2017 14:25:26 +0000
Message-ID: <20171101142526.1006-5-ross.lagerwall@citrix.com>
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 4/4] io: Add /dev/fdset/ support to
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, "Daniel P. Berrange" <berrange@redhat.com>

Add /dev/fdset/ support to QIOChannelFile by calling qemu_open() instead
of open() and qemu_close() instead of close(). There is a subtle
semantic change since qemu_open() automatically sets O_CLOEXEC, but this
doesn't affect any of the users of the function.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
Changed in v2:
* Split into separate patch.

 io/channel-file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 1f2f710..db948ab 100644
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
2.9.5
