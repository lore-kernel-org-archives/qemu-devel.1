Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVC4X-0007C4-4f
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVC4U-0003kd-1j
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:28:33 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:47577)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dVC4T-0003Hy-BB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 03:28:29 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 12 Jul 2017 23:41:59 +0800
Message-Id: <1499874119-67558-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V3] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, wang.yechao255@zte.com.cn, jiang.biao2@zte.com.cn, Peng Hao <peng.hao2@zte.com.cn>

Parallel device don't register be->chr_can_read function, but remote
disconnect event is handled in chr_read.So connected parallel device
can not detect remote disconnect event. The chardevs with chr_can_read=NULL
has the same problem.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 hw/char/parallel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 75a1a2f..b33bbb8 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -503,6 +503,10 @@ static const VMStateDescription vmstate_parallel_isa = {
     }
 };
 
+static int parallel_can_receive(void *opaque)
+{
+     return 1;
+}
 
 static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
 {
@@ -535,6 +539,8 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
     isa_init_irq(isadev, &s->irq, isa->isairq);
     qemu_register_reset(parallel_reset, s);
 
+    qemu_chr_fe_set_handlers(&s->chr, parallel_can_receive, NULL,
+                             NULL, s, NULL, true);
     if (qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_READ_STATUS, &dummy) == 0) {
         s->hw_driver = 1;
         s->status = dummy;
-- 
1.8.3.1
