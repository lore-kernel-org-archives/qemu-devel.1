Received: from eggs.gnu.org ([2001:4830:134:3::10]:44556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqok-0007cy-4f
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fXqof-0000Q7-EQ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59512 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fXqof-0000Px-9k
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:27:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2FCF7A7E8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:27:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Jun 2018 18:27:35 +0200
Message-Id: <20180626162736.9749-3-kraxel@redhat.com>
In-Reply-To: <20180626162736.9749-1-kraxel@redhat.com>
References: <20180626162736.9749-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] ramfb: fix overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

> CID 1393621:    (OVERFLOW_BEFORE_WIDEN)
> Potentially overflowing expression "stride * s->height" with type "unsigned
> int" (32 bits, unsigned) is evaluated using +32-bit arithmetic, and then used
> in a context that expects an expression of type "hwaddr" (64 bits, unsigned).

Fix by changing stride from uint32_t to hwaddr.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20180626083120.19515-1-kraxel@redhat.com
---
 hw/display/ramfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 6867bce8ae..30f5c8da20 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -36,8 +36,8 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 {
     RAMFBState *s = dev;
     void *framebuffer;
-    uint32_t stride, fourcc, format;
-    hwaddr addr, length;
+    uint32_t fourcc, format;
+    hwaddr stride, addr, length;
 
     s->width  = be32_to_cpu(s->cfg.width);
     s->height = be32_to_cpu(s->cfg.height);
-- 
2.9.3
