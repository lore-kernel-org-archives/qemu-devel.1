Received: from eggs.gnu.org ([2001:4830:134:3::10]:51783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSIEL-0008D1-JC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSIEH-0004H3-IJ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:26:41 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58783)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dSIEG-0004AO-VF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:26:37 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 5 Jul 2017 07:44:27 +0800
Message-Id: <1499211867-3126-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] audio: st_rate_flow exist a dead loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, wang.yechao255@zte.com.cn, Hao Peng <peng.hao2@zte.com.cn>

From: Hao Peng <peng.hao2@zte.com.cn>

if audio device is opend for a long time in windows vm, there is a uint32_t varaible reversal.
It will result to a dead loop.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Liu Yun <liu.yunh@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 audio/rate_template.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/audio/rate_template.h b/audio/rate_template.h
index bd4b1c7..1aa6c43 100644
--- a/audio/rate_template.h
+++ b/audio/rate_template.h
@@ -71,6 +71,11 @@ void NAME (void *opaque, struct st_sample *ibuf, struct st_sample *obuf,
         while (rate->ipos <= (rate->opos >> 32)) {
             ilast = *ibuf++;
             rate->ipos++;
+            /* if ipos reversal, there is  a dead loop */
+            if (rate->ipos == 0xffffffff) {
+                rate->ipos = 1;
+                rate->opos = rate->opos & 0xffffffff;
+            }
             /* See if we finished the input buffer yet */
             if (ibuf >= iend) {
                 goto the_end;
-- 
1.8.3.1
