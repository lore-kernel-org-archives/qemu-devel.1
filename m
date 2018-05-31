Received: from eggs.gnu.org ([2001:4830:134:3::10]:34672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHt-0001em-Md
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHq-0007lp-Q0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOIHq-0007le-LE
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E5A081663CC
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:46:18 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 31 May 2018 09:45:59 +0200
Message-Id: <20180531074601.10647-2-slp@redhat.com>
In-Reply-To: <20180531074601.10647-1-slp@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] io: Implement QIO_CHANNEL_ERR_BROKEN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>

QIO_CHANNEL_ERR_BROKEN is used to identify a potentially unrecoverable
error in the channel, like EPIPE.
---
 include/io/channel.h | 1 +
 io/channel-file.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index e8cdadb..bbe45f6 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -38,6 +38,7 @@ typedef struct QIOChannel QIOChannel;
 typedef struct QIOChannelClass QIOChannelClass;
 
 #define QIO_CHANNEL_ERR_BLOCK -2
+#define QIO_CHANNEL_ERR_BROKEN -3
 
 typedef enum QIOChannelFeature QIOChannelFeature;
 
diff --git a/io/channel-file.c b/io/channel-file.c
index db948ab..a990f67 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -124,6 +124,9 @@ static ssize_t qio_channel_file_writev(QIOChannel *ioc,
         if (errno == EAGAIN) {
             return QIO_CHANNEL_ERR_BLOCK;
         }
+        if (errno == EPIPE) {
+            return QIO_CHANNEL_ERR_BROKEN;
+        }
         if (errno == EINTR) {
             goto retry;
         }
-- 
1.8.3.1
