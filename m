Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqlC-0002pX-Uk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frql0-0002SA-FW
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:45 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqkw-0002HZ-Ji
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:30 -0400
Received: by mail-oi0-x22f.google.com with SMTP id y207-v6so28125416oie.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:28 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:01 -0500
Message-Id: <1534796770-10295-2-git-send-email-minyard@acm.org>
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 01/10] i2c:pm_smbus: Clean up some style
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Fix some spacing issues, remove extraneous comments, add some
defines instead of hard-coding numbers.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c | 58 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 0d26e0f..83c2377 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -22,8 +22,6 @@
 #include "hw/i2c/pm_smbus.h"
 #include "hw/i2c/smbus.h"
 
-/* no save/load? */
-
 #define SMBHSTSTS       0x00
 #define SMBHSTCNT       0x02
 #define SMBHSTCMD       0x03
@@ -32,19 +30,34 @@
 #define SMBHSTDAT1      0x06
 #define SMBBLKDAT       0x07
 
-#define STS_HOST_BUSY   (1)
-#define STS_INTR        (1<<1)
-#define STS_DEV_ERR     (1<<2)
-#define STS_BUS_ERR     (1<<3)
-#define STS_FAILED      (1<<4)
-#define STS_SMBALERT    (1<<5)
-#define STS_INUSE_STS   (1<<6)
-#define STS_BYTE_DONE   (1<<7)
+#define STS_HOST_BUSY   (1 << 0)
+#define STS_INTR        (1 << 1)
+#define STS_DEV_ERR     (1 << 2)
+#define STS_BUS_ERR     (1 << 3)
+#define STS_FAILED      (1 << 4)
+#define STS_SMBALERT    (1 << 5)
+#define STS_INUSE_STS   (1 << 6)
+#define STS_BYTE_DONE   (1 << 7)
 /* Signs of successfully transaction end :
 *  ByteDoneStatus = 1 (STS_BYTE_DONE) and INTR = 1 (STS_INTR )
 */
 
-//#define DEBUG
+#define CTL_INTREN      (1 << 0)
+#define CTL_KILL        (1 << 1)
+#define CTL_LAST_BYTE   (1 << 5)
+#define CTL_START       (1 << 6)
+#define CTL_PEC_EN      (1 << 7)
+#define CTL_RETURN_MASK 0x1f
+
+#define PROT_QUICK          0
+#define PROT_BYTE           1
+#define PROT_BYTE_DATA      2
+#define PROT_WORD_DATA      3
+#define PROT_PROC_CALL      4
+#define PROT_BLOCK_DATA     5
+#define PROT_I2C_BLOCK_DATA 6
+
+/*#define DEBUG*/
 
 #ifdef DEBUG
 # define SMBUS_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
@@ -70,11 +83,12 @@ static void smb_transaction(PMSMBus *s)
     if ((s->smb_stat & STS_DEV_ERR) != 0)  {
         goto error;
     }
+
     switch(prot) {
-    case 0x0:
+    case PROT_QUICK:
         ret = smbus_quick_command(bus, addr, read);
         goto done;
-    case 0x1:
+    case PROT_BYTE:
         if (read) {
             ret = smbus_receive_byte(bus, addr);
             goto data8;
@@ -82,7 +96,7 @@ static void smb_transaction(PMSMBus *s)
             ret = smbus_send_byte(bus, addr, cmd);
             goto done;
         }
-    case 0x2:
+    case PROT_BYTE_DATA:
         if (read) {
             ret = smbus_read_byte(bus, addr, cmd);
             goto data8;
@@ -91,16 +105,17 @@ static void smb_transaction(PMSMBus *s)
             goto done;
         }
         break;
-    case 0x3:
+    case PROT_WORD_DATA:
         if (read) {
             ret = smbus_read_word(bus, addr, cmd);
             goto data16;
         } else {
-            ret = smbus_write_word(bus, addr, cmd, (s->smb_data1 << 8) | s->smb_data0);
+            ret = smbus_write_word(bus, addr, cmd,
+                                   (s->smb_data1 << 8) | s->smb_data0);
             goto done;
         }
         break;
-    case 0x5:
+    case PROT_I2C_BLOCK_DATA:
         if (read) {
             ret = smbus_read_block(bus, addr, cmd, s->smb_data);
             goto data8;
@@ -158,8 +173,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
         break;
     case SMBHSTCNT:
         s->smb_ctl = val;
-        if (val & 0x40)
+        if (s->smb_ctl & CTL_START) {
             smb_transaction_start(s);
+        }
         break;
     case SMBHSTCMD:
         s->smb_cmd = val;
@@ -198,7 +214,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         break;
     case SMBHSTCNT:
         s->smb_index = 0;
-        val = s->smb_ctl & 0x1f;
+        val = s->smb_ctl & CTL_RETURN_MASK;
         break;
     case SMBHSTCMD:
         val = s->smb_cmd;
@@ -221,7 +237,9 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         val = 0;
         break;
     }
-    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n", addr, val);
+    SMBUS_DPRINTF("SMB readb port=0x%04" HWADDR_PRIx " val=0x%02x\n",
+                  addr, val);
+
     return val;
 }
 
-- 
2.7.4
