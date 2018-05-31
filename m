Received: from eggs.gnu.org ([2001:4830:134:3::10]:34670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHt-0001ek-MP
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1fOIHs-0007mS-75
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1fOIHs-0007mJ-3g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 03:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A81647DAC1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:46:19 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
Date: Thu, 31 May 2018 09:46:00 +0200
Message-Id: <20180531074601.10647-3-slp@redhat.com>
In-Reply-To: <20180531074601.10647-1-slp@redhat.com>
References: <20180531074601.10647-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] chardev: On QIO_CHANNEL_ERR_BROKEN set
 errno to EPIPE
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

This allows callers to identify this potentially unrecoverable error.
---
 chardev/char-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index f810524..f934eb9 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -168,6 +168,9 @@ int io_channel_send_full(QIOChannel *ioc,
 
             errno = EAGAIN;
             return -1;
+        } else if (ret == QIO_CHANNEL_ERR_BROKEN) {
+            errno = EPIPE;
+            return -1;
         } else if (ret < 0) {
             errno = EINVAL;
             return -1;
-- 
1.8.3.1
