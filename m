Received: from eggs.gnu.org ([209.51.188.92]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goBEF-00038N-Bs
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1goB8B-0005jK-R3
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:48 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:40374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1goB7z-0005Zb-Pm
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:55:26 -0500
Received: by mail-it1-x144.google.com with SMTP id h193so20646663ita.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:55:21 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Jan 2019 11:54:50 -0600
Message-Id: <20190128175458.27255-12-minyard@acm.org>
In-Reply-To: <20190128175458.27255-1-minyard@acm.org>
References: <20190128175458.27255-1-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v4 11/19] i2c:pm_smbus: Fix pm_smbus handling
 of I2C block read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

The I2C block read function of pm_smbus was completely broken.  It
required doing some direct I2C handling because it didn't have a
defined size, the OS code just reads bytes until it marks the
transaction finished.

This also required adjusting how the AMIBIOS workaround code worked,
the I2C block mode was setting STS_HOST_BUSY during a transaction,
so that bit could no longer be used to inform the host status read
code to start the transaction.  Create a explicit bool for that
operation.

Also, don't read the next byte from the device in byte-by-byte
mode unless the OS is actually clearing the byte done bit.  Just
assuming that's what the OS is doing is a bad idea.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/pm_smbus.c         | 86 ++++++++++++++++++++++++++++++---------
 include/hw/i2c/pm_smbus.h |  6 +++
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6cfb7eb1b3..81d2a425ec 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -118,19 +118,30 @@ static void smb_transaction(PMSMBus *s)
         }
         break;
     case PROT_I2C_BLOCK_READ:
-        if (read) {
-            int xfersize = s->smb_data0;
-            if (xfersize > sizeof(s->smb_data)) {
-                xfersize = sizeof(s->smb_data);
-            }
-            ret = smbus_read_block(bus, addr, s->smb_data1, s->smb_data,
-                                   xfersize, false, true);
-            goto data8;
-        } else {
-            /* The manual says the behavior is undefined, just set DEV_ERR. */
+        /* According to the Linux i2c-i801 driver:
+         *   NB: page 240 of ICH5 datasheet shows that the R/#W
+         *   bit should be cleared here, even when reading.
+         *   However if SPD Write Disable is set (Lynx Point and later),
+         *   the read will fail if we don't set the R/#W bit.
+         * So at least Linux may or may not set the read bit here.
+         * So just ignore the read bit for this command.
+         */
+        if (i2c_start_transfer(bus, addr, 0)) {
             goto error;
         }
-        break;
+        ret = i2c_send(bus, s->smb_data1);
+        if (ret) {
+            goto error;
+        }
+        if (i2c_start_transfer(bus, addr, 1)) {
+            goto error;
+        }
+        s->in_i2c_block_read = true;
+        s->smb_blkdata = i2c_recv(s->smbus);
+        s->op_done = false;
+        s->smb_stat |= STS_HOST_BUSY | STS_BYTE_DONE;
+        goto out;
+
     case PROT_BLOCK_DATA:
         if (read) {
             ret = smbus_read_block(bus, addr, cmd, s->smb_data,
@@ -208,6 +219,7 @@ static void smb_transaction_start(PMSMBus *s)
 {
     if (s->smb_ctl & CTL_INTREN) {
         smb_transaction(s);
+        s->start_transaction_on_status_read = false;
     } else {
         /* Do not execute immediately the command; it will be
          * executed when guest will read SMB_STAT register.  This
@@ -217,6 +229,7 @@ static void smb_transaction_start(PMSMBus *s)
          * checking for status.  If STS_HOST_BUSY doesn't get
          * set, it gets stuck. */
         s->smb_stat |= STS_HOST_BUSY;
+        s->start_transaction_on_status_read = true;
     }
 }
 
@@ -226,19 +239,38 @@ smb_irq_value(PMSMBus *s)
     return ((s->smb_stat & ~STS_HOST_BUSY) != 0) && (s->smb_ctl & CTL_INTREN);
 }
 
+static bool
+smb_byte_by_byte(PMSMBus *s)
+{
+    if (s->op_done) {
+        return false;
+    }
+    if (s->in_i2c_block_read) {
+        return true;
+    }
+    return !(s->smb_auxctl & AUX_BLK);
+}
+
 static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
     PMSMBus *s = opaque;
+    uint8_t clear_byte_done;
 
     SMBUS_DPRINTF("SMB writeb port=0x%04" HWADDR_PRIx
                   " val=0x%02" PRIx64 "\n", addr, val);
     switch(addr) {
     case SMBHSTSTS:
+        clear_byte_done = s->smb_stat & val & STS_BYTE_DONE;
         s->smb_stat &= ~(val & ~STS_HOST_BUSY);
-        if (!s->op_done && !(s->smb_auxctl & AUX_BLK)) {
+        if (clear_byte_done && smb_byte_by_byte(s)) {
             uint8_t read = s->smb_addr & 0x01;
 
+            if (s->in_i2c_block_read) {
+                /* See comment below PROT_I2C_BLOCK_READ above. */
+                read = 1;
+            }
+
             s->smb_index++;
             if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
                 s->smb_index = 0;
@@ -268,12 +300,23 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                 s->smb_stat |= STS_BYTE_DONE;
             } else if (s->smb_ctl & CTL_LAST_BYTE) {
                 s->op_done = true;
-                s->smb_blkdata = s->smb_data[s->smb_index];
+                if (s->in_i2c_block_read) {
+                    s->in_i2c_block_read = false;
+                    s->smb_blkdata = i2c_recv(s->smbus);
+                    i2c_nack(s->smbus);
+                    i2c_end_transfer(s->smbus);
+                } else {
+                    s->smb_blkdata = s->smb_data[s->smb_index];
+                }
                 s->smb_index = 0;
                 s->smb_stat |= STS_INTR;
                 s->smb_stat &= ~STS_HOST_BUSY;
             } else {
-                s->smb_blkdata = s->smb_data[s->smb_index];
+                if (s->in_i2c_block_read) {
+                    s->smb_blkdata = i2c_recv(s->smbus);
+                } else {
+                    s->smb_blkdata = s->smb_data[s->smb_index];
+                }
                 s->smb_stat |= STS_BYTE_DONE;
             }
         }
@@ -284,6 +327,10 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
             if (!s->op_done) {
                 s->smb_index = 0;
                 s->op_done = true;
+                if (s->in_i2c_block_read) {
+                    s->in_i2c_block_read = false;
+                    i2c_end_transfer(s->smbus);
+                }
             }
             smb_transaction_start(s);
         }
@@ -337,8 +384,9 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     switch(addr) {
     case SMBHSTSTS:
         val = s->smb_stat;
-        if (s->smb_stat & STS_HOST_BUSY) {
+        if (s->start_transaction_on_status_read) {
             /* execute command now */
+            s->start_transaction_on_status_read = false;
             s->smb_stat &= ~STS_HOST_BUSY;
             smb_transaction(s);
         }
@@ -359,10 +407,10 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         val = s->smb_data1;
         break;
     case SMBBLKDAT:
-        if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
-            s->smb_index = 0;
-        }
-        if (s->smb_auxctl & AUX_BLK) {
+        if (s->smb_auxctl & AUX_BLK && !s->in_i2c_block_read) {
+            if (s->smb_index >= PM_SMBUS_MAX_MSG_SIZE) {
+                s->smb_index = 0;
+            }
             val = s->smb_data[s->smb_index++];
             if (!s->op_done && s->smb_index == s->smb_data0) {
                 s->op_done = true;
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index 6dd5b7040b..7bcca97672 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -33,6 +33,12 @@ typedef struct PMSMBus {
     /* Set on block transfers after the last byte has been read, so the
        INTR bit can be set at the right time. */
     bool op_done;
+
+    /* Set during an I2C block read, so we know how to handle data. */
+    bool in_i2c_block_read;
+
+    /* Used to work around a bug in AMIBIOS, see smb_transaction_start() */
+    bool start_transaction_on_status_read;
 } PMSMBus;
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
-- 
2.17.1
