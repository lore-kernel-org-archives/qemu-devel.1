Received: from eggs.gnu.org ([2001:4830:134:3::10]:37728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1f-0005WP-9f
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00084L-Ck
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:12847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=47103a974=ross.lagerwall@citrix.com>)
	id 1e9u1b-00081x-4L
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 10:29:47 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Wed, 1 Nov 2017 14:25:25 +0000
Message-ID: <20171101142526.1006-4-ross.lagerwall@citrix.com>
In-Reply-To: <20171101142526.1006-1-ross.lagerwall@citrix.com>
References: <20171101142526.1006-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 3/4] io: Don't call close multiple times in
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

If the file descriptor underlying QIOChannelFile is closed in the
io_close() method, don't close it again in the finalize() method since
the file descriptor number may have been reused in the meantime.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
New in v2.

 io/channel-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index 16bf7ed..1f2f710 100644
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
2.9.5
