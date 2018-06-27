Received: from eggs.gnu.org ([2001:4830:134:3::10]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJnT-0002tR-AT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJnS-0007NH-61
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:24:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:23:27 +0200
Message-Id: <20180627232334.14142-4-laurent@vivier.eu>
In-Reply-To: <20180627232334.14142-1-laurent@vivier.eu>
References: <20180627232334.14142-1-laurent@vivier.eu>
Subject: [Qemu-devel] [C v2 03/10] escc: introduce a selector for the
 register bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

On Sparc and PowerMac, the bit 0 of the address
selects the register type (control or data) and
bit 1 selects the channel (B or A).

On m68k Macintosh, the bit 0 selects the channel and
bit 1 the register type.

This patch introduces a new parameter (bit_swap) to
the device interface to indicate bits usage must
be swapped between registers and channels.

For the moment all the machines use the bit 0,
but this change will be needed to emulate Quadra 800.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/char/escc.c         | 30 ++++++++++++++++++++++++------
 include/hw/char/escc.h |  1 +
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/char/escc.c b/hw/char/escc.c
index 628f5f81f7..cec75b06f9 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -42,14 +42,21 @@
  * mouse and keyboard ports don't implement all functions and they are
  * only asynchronous. There is no DMA.
  *
- * Z85C30 is also used on PowerMacs. There are some small differences
- * between Sparc version (sunzilog) and PowerMac (pmac):
+ * Z85C30 is also used on PowerMacs and m68k Macs.
+ *
+ * There are some small differences between Sparc version (sunzilog)
+ * and PowerMac (pmac):
  *  Offset between control and data registers
  *  There is some kind of lockup bug, but we can ignore it
  *  CTS is inverted
  *  DMA on pmac using DBDMA chip
  *  pmac can do IRDA and faster rates, sunzilog can only do 38400
  *  pmac baud rate generator clock is 3.6864 MHz, sunzilog 4.9152 MHz
+ *
+ * Linux driver for m68k Macs is the same as for PowerMac (pmac_zilog),
+ * but registers are grouped by type and not by channel:
+ * channel is selected by bit 0 of the address (instead of bit 1)
+ * and register is selected by bit 1 of the address (instead of bit 0).
  */
 
 /*
@@ -169,6 +176,16 @@ static void handle_kbd_command(ESCCChannelState *s, int val);
 static int serial_can_receive(void *opaque);
 static void serial_receive_byte(ESCCChannelState *s, int ch);
 
+static int reg_shift(ESCCState *s)
+{
+    return s->bit_swap ? s->it_shift + 1 : s->it_shift;
+}
+
+static int chn_shift(ESCCState *s)
+{
+    return s->bit_swap ? s->it_shift : s->it_shift + 1;
+}
+
 static void clear_queue(void *opaque)
 {
     ESCCChannelState *s = opaque;
@@ -433,8 +450,8 @@ static void escc_mem_write(void *opaque, hwaddr addr,
     int newreg, channel;
 
     val &= 0xff;
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -537,8 +554,8 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
     uint32_t ret;
     int channel;
 
-    saddr = (addr >> serial->it_shift) & 1;
-    channel = (addr >> (serial->it_shift + 1)) & 1;
+    saddr = (addr >> reg_shift(serial)) & 1;
+    channel = (addr >> chn_shift(serial)) & 1;
     s = &serial->chn[channel];
     switch (saddr) {
     case SERIAL_CTRL:
@@ -822,6 +839,7 @@ static void escc_realize(DeviceState *dev, Error **errp)
 static Property escc_properties[] = {
     DEFINE_PROP_UINT32("frequency", ESCCState, frequency,   0),
     DEFINE_PROP_UINT32("it_shift",  ESCCState, it_shift,    0),
+    DEFINE_PROP_BOOL("bit_swap",    ESCCState, bit_swap,    false),
     DEFINE_PROP_UINT32("disabled",  ESCCState, disabled,    0),
     DEFINE_PROP_UINT32("chnBtype",  ESCCState, chn[0].type, 0),
     DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 42aca83611..8762f61c14 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -50,6 +50,7 @@ typedef struct ESCCState {
 
     struct ESCCChannelState chn[2];
     uint32_t it_shift;
+    bool bit_swap;
     MemoryRegion mmio;
     uint32_t disabled;
     uint32_t frequency;
-- 
2.14.4
