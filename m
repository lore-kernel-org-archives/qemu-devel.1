Received: from eggs.gnu.org ([2001:4830:134:3::10]:47849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LN-0001NE-7H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gr-Ly
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX2LI-0003gK-Gq
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:29:28 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 11:29:21 +0200
Message-Id: <20170717092923.12317-2-kraxel@redhat.com>
In-Reply-To: <20170717092923.12317-1-kraxel@redhat.com>
References: <20170717092923.12317-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] audio: st_rate_flow exist a infinite loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>, Wang Yechao <wang.yechao255@zte.com.cn>, Gerd Hoffmann <kraxel@redhat.com>

From: Peng Hao <peng.hao2@zte.com.cn>

If a voice recording equipment is opened for a long time(several days)
in windows guest, rate->ipos will overflow and rate->opos will never
have a chance to change. It will result to a infinite loop.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Message-id: 1500128061-20849-1-git-send-email-peng.hao2@zte.com.cn
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/rate_template.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/audio/rate_template.h b/audio/rate_template.h
index bd4b1c7685..6e93588877 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -71,6 +71,12 @@ void NAME (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
         while (rate->ipos <= (rate->opos >> 32)) {
             ilast = *ibuf++;
             rate->ipos++;
+
+            /* if ipos overflow, there is  a infinite loop */
+            if (rate->ipos == 0xffffffff) {
+                rate->ipos = 1;
+                rate->opos = rate->opos & 0xffffffff;
+            }
             /* See if we finished the input buffer yet */
             if (ibuf >= iend) {
                 goto the_end;
-- 
2.9.3
