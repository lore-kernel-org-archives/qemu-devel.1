Received: from eggs.gnu.org ([2001:4830:134:3::10]:54607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ctyTa-0008HU-9E
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jhanley@dgtlrift.com>) id 1ctyTZ-0004D6-8J
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:28:34 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:33900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jhanley@dgtlrift.com>)
	id 1ctyTY-0004CP-Uw
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:28:33 -0400
Received: by mail-vk0-x244.google.com with SMTP id y16so11904207vky.1
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 08:28:32 -0700 (PDT)
MIME-Version: 1.0
From: James Hanley <jhanley@dgtlrift.com>
Date: Fri, 31 Mar 2017 11:28:31 -0400
Message-ID: <CAF++6AOLSd0SYyv_LmnjinEj-jHBbyNZv_hxvdksGqCoDcpmjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] MTD timeout on bootup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

When trying to bootup a pristine zync image from the zc702 tarball, it
would always fail with the MTD detection of the serial flash device type
command over the SPI.  I believe this section of code may have the logic
flipped.  Once I changed it to the following, I was able to detect the
flash type when booting the pristine image from Xilinx.
-Jim


>From baaaacca370c13526fd2b8c7b33c7d9e8a6d7b8d Mon Sep 17 00:00:00 2001
From: Jim Hanley <Jim.Hanley@LandisGyr.com>
Date: Thu, 23 Mar 2017 10:29:34 -0400
Subject: [PATCH] MTD writes from the SPI were never being dequeue...
Signed-off-by:

---
 hw/ssi/xilinx_spips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index da8adfa..a3af1f7 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -482,8 +482,8 @@ static void xilinx_spips_write(void *opaque, hwaddr
addr,
     s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
 no_reg_update:
     xilinx_spips_update_cs_lines(s);
-    if ((man_start_com && s->regs[R_CONFIG] & MAN_START_EN) ||
-            (fifo8_is_empty(&s->tx_fifo) && s->regs[R_CONFIG] &
MAN_START_EN)) {
+    if (!((man_start_com && s->regs[R_CONFIG] & MAN_START_EN) ||
+            (fifo8_is_empty(&s->tx_fifo) && s->regs[R_CONFIG] &
MAN_START_EN))) {
         xilinx_spips_flush_txfifo(s);
     }
     xilinx_spips_update_cs_lines(s);
-- 
2.7.4
