Received: from eggs.gnu.org ([2001:4830:134:3::10]:54007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgT-00022e-MO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1emNgO-0003K2-UM
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:51:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1emNgO-0003Je-QJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:50:56 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 15 Feb 2018 17:50:41 +0000
Message-Id: <20180215175044.8159-5-berrange@redhat.com>
In-Reply-To: <20180215175044.8159-1-berrange@redhat.com>
References: <20180215175044.8159-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] io: Don't call close multiple times in
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

If the file descriptor underlying QIOChannelFile is closed in the
io_close() method, don't close it again in the finalize() method since
the file descriptor number may have been reused in the meantime.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index 16bf7ed270..1f2f710bf9 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -178,6 +178,7 @@ static int qio_channel_file_close(QIOChannel *ioc,
                          "Unable to close file");
         return -1;
     }
+    fioc->fd = -1;
     return 0;
 }
 
-- 
2.14.3
