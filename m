Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA56-0002a7-W1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007EF-Vo
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4o-00075O-Au
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wr1-x42d.google.com with SMTP id k5-v6so4944984wre.10
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:37 +0200
Message-Id: <1534870966-9287-66-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 65/74] i2c: pm_smbus: Add block transfer
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

There was no block transfer code in pm_smbus.c, and it is needed
for some devices.  So add it.

This adds both byte-by-byte block transfers and buffered block
transfers.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1534796770-10295-5-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c         | 151 ++++++++++++++++++++++++++++++++++++++++++----
 hw/i2c/smbus_ich9.c       |   8 ++-
 include/hw/i2c/pm_smbus.h |  20 +++++-
 3 files changed, 164 insertions(+), 15 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index dc61f2c..32132be 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -29,6 +29,7 @@
 #define SMBHSTDAT0      0x05
 #define SMBHSTDAT1      0x06
 #define SMBBLKDAT       0x07
+#define SMBAUXCTL       0x0d
 
 #define STS_HOST_BUSY   (1 << 0)
 #define STS_INTR        (1 << 1)
@@ -57,6 +58,10 @@
 #define PROT_BLOCK_DATA     5
 #define PROT_I2C_BLOCK_READ 6
 
+#define AUX_PEC       (1 << 0)
+#define AUX_BLK       (1 << 1)
+#define AUX_MASK      0x3
+
 /*#define DEBUG*/
 
 #ifdef DEBUG
@@ -129,6 +134,51 @@ static void smb_transaction(PMSMBus *s)
             goto error;
         }
         break;
+    case PROT_BLOCK_DATA:
+        if (read) {
+            ret = smbus_read_block(bus, addr, cmd, s->smb_data,
+                                   sizeof(s->smb_data), !s->i2c_enable,
+                                   !s->i2c_enable);
+            if (ret < 0) {
+                goto error;
+            }
+            s->smb_index = 0;
+            s->op_done = false;
+            if (s->smb_auxctl & AUX_BLK) {
+                s->smb_stat |= STS_INTR;
+            } else {
+                s->smb_blkdata = s->smb_data[0];
+                s->smb_stat |= STS_HOST_BUSY | STS_BYTE_DONE;
+            }
+            s->smb_data0 = ret;
+            goto out;
+        } else {
+            if (s->smb_auxctl & AUX_BLK) {
+                if (s->smb_index != s->smb_data0) {
+                    s->smb_index = 0;
+                    goto error;
+                }
+                /* Data is already all written to the queue, just do
+                   the operation. */
+                s->smb_index = 0;
+                ret = smbus_write_block(bus, addr, cmd, s->smb_data,
+                                        s->smb_data0, !s->i2c_enable);
+                if (ret < 0) {
+                    goto error;
+                }
+                s->op_done = true;
+                s->smb_stat |= STS_INTR;
+                s->smb_stat &= ~STS_HOST_BUSY;
+            } else {
+                s->op_done = false;
+                s->smb_stat |= STS_HOST_BUSY | STS_BYTE_DONE;
+                s->smb_data[0] = s->smb_blkdata;
+                s->smb_index = 0;
+                ret = 0;
+            }
+            goto out;
+        }
+        break;
     default:
         goto error;
     }
@@ -148,13 +198,13 @@ done:
     if (ret < 0) {
         goto error;
     }
-    s->smb_stat |= STS_BYTE_DONE | STS_INTR;
+    s->smb_stat |= STS_INTR;
+out:
     return;
 
 error:
     s->smb_stat |= STS_DEV_ERR;
     return;
-
 }
 
 static void smb_transaction_start(PMSMBus *s)
@@ -173,14 +223,61 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                   " val=0x%02" PRIx64 "\n", addr, val);
     switch(addr) {
     case SMBHSTSTS:
-        s->smb_stat = (~(val & 0xff)) & s->smb_stat;
-        s->smb_index = 0;
+        s->smb_stat &= ~(val & ~STS_HOST_BUSY);
+        if (!s->op_done && !(s->smb_auxctl & AUX_BLK)) {
+            uint8_t read = s->smb_addr & 0x01;
+
+            s->smb_index++;
+            if (!read && s->smb_index == s->smb_data0) {
+                uint8_t prot = (s->smb_ctl >> 2) & 0x07;
+                uint8_t cmd = s->smb_cmd;
+                uint8_t addr = s->smb_addr >> 1;
+                int ret;
+
+                if (prot == PROT_I2C_BLOCK_READ) {
+                    s->smb_stat |= STS_DEV_ERR;
+                    goto out;
+                }
+
+                ret = smbus_write_block(s->smbus, addr, cmd, s->smb_data,
+                                        s->smb_data0, !s->i2c_enable);
+                if (ret < 0) {
+                    s->smb_stat |= STS_DEV_ERR;
+                    goto out;
+                }
+                s->op_done = true;
+                s->smb_stat |= STS_INTR;
+                s->smb_stat &= ~STS_HOST_BUSY;
+            } else if (!read) {
+                s->smb_data[s->smb_index] = s->smb_blkdata;
+                s->smb_stat |= STS_BYTE_DONE;
+            } else if (s->smb_ctl & CTL_LAST_BYTE) {
+                s->op_done = true;
+                s->smb_blkdata = s->smb_data[s->smb_index];
+                s->smb_index = 0;
+                s->smb_stat |= STS_INTR;
+                s->smb_stat &= ~STS_HOST_BUSY;
+            } else {
+                s->smb_blkdata = s->smb_data[s->smb_index];
+                s->smb_stat |= STS_BYTE_DONE;
+            }
+        }
         break;
     case SMBHSTCNT:
-        s->smb_ctl = val;
-        if (s->smb_ctl & CTL_START) {
+        s->smb_ctl = val & ~CTL_START; /* CTL_START always reads 0 */
+        if (val & CTL_START) {
+            if (!s->op_done) {
+                s->smb_index = 0;
+                s->op_done = true;
+            }
             smb_transaction_start(s);
         }
+        if (s->smb_ctl & CTL_KILL) {
+            s->op_done = true;
+            s->smb_index = 0;
+            s->smb_stat |= STS_FAILED;
+            s->smb_stat &= ~STS_HOST_BUSY;
+        }
         break;
     case SMBHSTCMD:
         s->smb_cmd = val;
@@ -195,13 +292,24 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
         s->smb_data1 = val;
         break;
     case SMBBLKDAT:
-        s->smb_data[s->smb_index++] = val;
-        if (s->smb_index > 31)
+        if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
             s->smb_index = 0;
+        }
+        if (s->smb_auxctl & AUX_BLK) {
+            s->smb_data[s->smb_index++] = val;
+        } else {
+            s->smb_blkdata = val;
+        }
+        break;
+    case SMBAUXCTL:
+        s->smb_auxctl = val & AUX_MASK;
         break;
     default:
         break;
     }
+
+ out:
+    return;
 }
 
 static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
@@ -218,7 +326,6 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         }
         break;
     case SMBHSTCNT:
-        s->smb_index = 0;
         val = s->smb_ctl & CTL_RETURN_MASK;
         break;
     case SMBHSTCMD:
@@ -234,9 +341,22 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         val = s->smb_data1;
         break;
     case SMBBLKDAT:
-        val = s->smb_data[s->smb_index++];
-        if (s->smb_index > 31)
+        if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
             s->smb_index = 0;
+        }
+        if (s->smb_auxctl & AUX_BLK) {
+            val = s->smb_data[s->smb_index++];
+            if (!s->op_done && s->smb_index == s->smb_data0) {
+                s->op_done = true;
+                s->smb_index = 0;
+                s->smb_stat &= ~STS_HOST_BUSY;
+            }
+        } else {
+            val = s->smb_blkdata;
+        }
+        break;
+    case SMBAUXCTL:
+        val = s->smb_auxctl;
         break;
     default:
         val = 0;
@@ -248,6 +368,13 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     return val;
 }
 
+static void pm_smbus_reset(PMSMBus *s)
+{
+    s->op_done = true;
+    s->smb_index = 0;
+    s->smb_stat = 0;
+}
+
 static const MemoryRegionOps pm_smbus_ops = {
     .read = smb_ioport_readb,
     .write = smb_ioport_writeb,
@@ -258,6 +385,8 @@ static const MemoryRegionOps pm_smbus_ops = {
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb)
 {
+    smb->op_done = true;
+    smb->reset = pm_smbus_reset;
     smb->smbus = i2c_init_bus(parent, "i2c");
     memory_region_init_io(&smb->io, OBJECT(parent), &pm_smbus_ops, smb,
                           "pm-smbus", 64);
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 007cb67..a66a114 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -61,12 +61,16 @@ static void ich9_smbus_write_config(PCIDevice *d, uint32_t address,
     pci_default_write_config(d, address, val, len);
     if (range_covers_byte(address, len, ICH9_SMB_HOSTC)) {
         uint8_t hostc = s->dev.config[ICH9_SMB_HOSTC];
-        if ((hostc & ICH9_SMB_HOSTC_HST_EN) &&
-            !(hostc & ICH9_SMB_HOSTC_I2C_EN)) {
+        if (hostc & ICH9_SMB_HOSTC_HST_EN) {
             memory_region_set_enabled(&s->smb.io, true);
         } else {
             memory_region_set_enabled(&s->smb.io, false);
         }
+        s->smb.i2c_enable = (hostc & ICH9_SMB_HOSTC_I2C_EN) != 0;
+        if (hostc & ICH9_SMB_HOSTC_SSRESET) {
+            s->smb.reset(&s->smb);
+            s->dev.config[ICH9_SMB_HOSTC] &= ~ICH9_SMB_HOSTC_SSRESET;
+        }
     }
 }
 
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 2a837af..99d5489 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -1,6 +1,8 @@
 #ifndef PM_SMBUS_H
 #define PM_SMBUS_H
 
+#define PM_SMBUS_MAX_MSG_SIZE 32
+
 typedef struct PMSMBus {
     I2CBus *smbus;
     MemoryRegion io;
@@ -11,8 +13,22 @@ typedef struct PMSMBus {
     uint8_t smb_addr;
     uint8_t smb_data0;
     uint8_t smb_data1;
-    uint8_t smb_data[32];
-    uint8_t smb_index;
+    uint8_t smb_data[PM_SMBUS_MAX_MSG_SIZE];
+    uint8_t smb_blkdata;
+    uint8_t smb_auxctl;
+    uint32_t smb_index;
+
+    /* Set by pm_smbus.c */
+    void (*reset)(struct PMSMBus *s);
+
+    /* Set by the user. */
+    bool i2c_enable;
+
+    /* Internally used by pm_smbus. */
+
+    /* Set on block transfers after the last byte has been read, so the
+       INTR bit can be set at the right time. */
+    bool op_done;
 } PMSMBus;
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb);
-- 
1.8.3.1
