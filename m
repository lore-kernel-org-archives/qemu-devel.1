Received: from eggs.gnu.org ([2001:4830:134:3::10]:52371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e2c9R-0004qa-R7
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e2c9O-00028H-KJ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:59:45 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:41620)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e2c9O-000276-7y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:59:42 -0400
Received: from www1.hostfission.com (www1.hostfission.com [139.99.139.52])
	by mail1.hostfission.com (Postfix) with ESMTP id EC2B2422DE
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 22:59:32 +1100 (AEDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2017 22:59:32 +1100
From: geoff@hostfission.com
Message-ID: <e333cefa48caf7fde033edc20d2d7793@hostfission.com>
Subject: [Qemu-devel] [PATCH] [pckbd] Prevent IRQs when the guest disables
 the mouse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When the guest OS needs to send the mouse commands it will at least in 
the case
of Windows 10 set the KBD_MODE_DISABLE_MOUSE bit to prevent interrupts 
from
causing stream desynchronisation.

Here is Windows 10 attempting to issue a PS/2 mouse reset without this 
fix where
you can see the mouse positional data was returned as the answer to the 
get type
command.

     KBD: kbd: write cmd=0xd4  // write next cmd to the aux port
     KBD: kbd: read status=0x1c
     KBD: kbd: read status=0x1c
     KBD: kbd: read status=0x1c
     KBD: kbd: write data=0xff
     kbd: write mouse 0xff     // reset
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0xfa  // ack
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0xaa  // self-test good
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x00  // the device type
     KBD: kbd: read status=0x3d
     KBD: kbd: write cmd=0xd4  // write cmd to the aux port
     KBD: kbd: read status=0x3d
     KBD: kbd: write data=0xf2
     kbd: write mouse 0xf2     // get type
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x08  // mouse data byte 1
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x00  // mouse data byte 2
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x00  // mouse data byte 3
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0xfa  // the ack for the get type above
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x00  // the device type
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x08  // mouse data byte 1
     KBD: kbd: read status=0x3d
     KBD: kbd: read status=0x3d
     KBD: kbd: read data=0x00  // mouse data byte 2

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
  hw/input/pckbd.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index c479f827b6..78d5356817 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -168,7 +168,8 @@ static void kbd_update_irq(KBDState *s)
          if (s->pending == KBD_PENDING_AUX) {
              s->status |= KBD_STAT_MOUSE_OBF;
              s->outport |= KBD_OUT_MOUSE_OBF;
-            if (s->mode & KBD_MODE_MOUSE_INT)
+            if ((s->mode & KBD_MODE_MOUSE_INT) &&
+                !(s->mode & KBD_MODE_DISABLE_MOUSE))
                  irq_mouse_level = 1;
          } else {
              if ((s->mode & KBD_MODE_KBD_INT) &&
-- 
2.11.0
