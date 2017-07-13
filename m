Received: from eggs.gnu.org ([2001:4830:134:3::10]:51291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3U-00013z-SV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf3T-0002Wf-Kg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:24 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf3T-0002WI-DT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:23 -0400
Received: by mail-wm0-x241.google.com with SMTP id j85so5439879wmj.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:23 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:21 +0200
Message-Id: <1499955874-10954-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/41] chardev: fix parallel device can't be
 reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peng Hao <peng.hao2@zte.com.cn>

From: Peng Hao <peng.hao2@zte.com.cn>

Parallel device don't register be->chr_can_read function, but remote
disconnect event is handled in chr_read.So connected parallel device
can not detect remote disconnect event. The chardevs with chr_can_read=NULL
has the same problem.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Message-Id: <1499874119-67558-1-git-send-email-peng.hao2@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/parallel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 055789f..f79dc76 100644
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
+                             NULL, NULL, s, NULL, true);
     if (qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_PP_READ_STATUS, &dummy) == 0) {
         s->hw_driver = 1;
         s->status = dummy;
-- 
1.8.3.1
