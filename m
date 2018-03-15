Received: from eggs.gnu.org ([2001:4830:134:3::10]:53197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ewYIE-0005xR-6J
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ewYIB-0001aK-0k
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:12:02 -0400
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 15 Mar 2018 12:11:41 -0700
Message-Id: <20180315191141.6789-2-andrew.smirnov@gmail.com>
In-Reply-To: <20180315191141.6789-1-andrew.smirnov@gmail.com>
References: <20180315191141.6789-1-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] char: i.MX: Add support for "TX complete"
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Bill Paul <wpaul@windriver.com>

Add support for "TX complete"/TXDC interrupt generate by real HW since
it is needed to support guests other than Linux.

Based on the patch by Bill Paul as found here:
https://bugs.launchpad.net/qemu/+bug/1753314

Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Cc: Bill Paul <wpaul@windriver.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Bill:

I only tested this with i.MX7/Linux guest combo and am hoping you can
take this and previous patch and give it a try on your VxWorks setup.

Peter:

Bill is the author of original code, so I am not sure how to handle
Signed-off-by from him. I'd like to add it to this patch, but since
his original submission to launchpad didn't have one it is currently
omitted.

 include/hw/char/imx_serial.h |  3 +++
 hw/char/imx_serial.c         | 20 +++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
index baeec3183f..5b99cee7cf 100644
--- a/include/hw/char/imx_serial.h
+++ b/include/hw/char/imx_serial.h
@@ -67,6 +67,8 @@
 #define UCR2_RXEN       (1<<1)    /* Receiver enable */
 #define UCR2_SRST       (1<<0)    /* Reset complete */
 
+#define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
+
 #define UTS1_TXEMPTY    (1<<6)
 #define UTS1_RXEMPTY    (1<<5)
 #define UTS1_TXFULL     (1<<4)
@@ -95,6 +97,7 @@ typedef struct IMXSerialState {
     uint32_t ubmr;
     uint32_t ubrc;
     uint32_t ucr3;
+    uint32_t ucr4;
 
     qemu_irq irq;
     CharBackend chr;
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index d1e8586280..1e5540472b 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -37,8 +37,8 @@
 
 static const VMStateDescription vmstate_imx_serial = {
     .name = TYPE_IMX_SERIAL,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(readbuff, IMXSerialState),
         VMSTATE_UINT32(usr1, IMXSerialState),
@@ -50,6 +50,7 @@ static const VMStateDescription vmstate_imx_serial = {
         VMSTATE_UINT32(ubmr, IMXSerialState),
         VMSTATE_UINT32(ubrc, IMXSerialState),
         VMSTATE_UINT32(ucr3, IMXSerialState),
+        VMSTATE_UINT32(ucr4, IMXSerialState),
         VMSTATE_END_OF_LIST()
     },
 };
@@ -71,6 +72,11 @@ static void imx_update(IMXSerialState *s)
      * unfortunately.
      */
     mask = (s->ucr1 & UCR1_TXMPTYEN) ? USR2_TXFE : 0;
+    /*
+     * TCEN and TXDC are both bit 3
+     */
+    mask |= s->ucr4 & UCR4_TCEN;
+
     usr2 = s->usr2 & mask;
 
     qemu_set_irq(s->irq, usr1 || usr2);
@@ -163,6 +169,8 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
         return s->ucr3;
 
     case 0x23: /* UCR4 */
+        return s->ucr4;
+
     case 0x29: /* BRM Incremental */
         return 0x0; /* TODO */
 
@@ -191,8 +199,10 @@ static void imx_serial_write(void *opaque, hwaddr offset,
              * qemu_chr_fe_write and background I/O callbacks */
             qemu_chr_fe_write_all(&s->chr, &ch, 1);
             s->usr1 &= ~USR1_TRDY;
+            s->usr2 &= ~USR2_TXDC;
             imx_update(s);
             s->usr1 |= USR1_TRDY;
+            s->usr2 |= USR2_TXDC;
             imx_update(s);
         }
         break;
@@ -265,8 +275,12 @@ static void imx_serial_write(void *opaque, hwaddr offset,
         s->ucr3 = value & 0xffff;
         break;
 
-    case 0x2d: /* UTS1 */
     case 0x23: /* UCR4 */
+        s->ucr4 = value & 0xffff;
+        imx_update(s);
+        break;
+
+    case 0x2d: /* UTS1 */
         qemu_log_mask(LOG_UNIMP, "[%s]%s: Unimplemented reg 0x%"
                       HWADDR_PRIx "\n", TYPE_IMX_SERIAL, __func__, offset);
         /* TODO */
-- 
2.14.3
