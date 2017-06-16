Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP8-0004UJ-AZ
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP6-0006Ws-NU
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:34 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1dLwP6-0006WZ-JG
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:32 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so12325155qtb.1
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:55:32 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 16 Jun 2017 14:55:15 -0400
Message-Id: <1497639316-22202-3-git-send-email-gsomlo@gmail.com>
In-Reply-To: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
References: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 2/3] applesmc: implement error status port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

As of release 10.12.4, OS X (Sierra) refuses to boot unless the
AppleSMC supports an additional I/O port, expected to provide an
error status code.

Update the [cmd|data]_write() and data_read() methods to implement
the required state machine, and add I/O region & methods to handle
access to the error port.

Originally proposed by Eric Shelton <eshelton@pobox.com> based in
part on FakeSMC (git://git.assembla.com/fakesmc.git).

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/applesmc.c | 141 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 115 insertions(+), 26 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 6381197..0d882e8 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -43,6 +43,7 @@
 enum {
     APPLESMC_DATA_PORT               = 0x00,
     APPLESMC_CMD_PORT                = 0x04,
+    APPLESMC_ERR_PORT                = 0x1e,
     APPLESMC_NUM_PORTS               = 0x20,
 };
 
@@ -53,6 +54,24 @@ enum {
     APPLESMC_GET_KEY_TYPE_CMD        = 0x13,
 };
 
+enum {
+    APPLESMC_ST_CMD_DONE             = 0x00,
+    APPLESMC_ST_DATA_READY           = 0x01,
+    APPLESMC_ST_BUSY                 = 0x02,
+    APPLESMC_ST_ACK                  = 0x04,
+    APPLESMC_ST_NEW_CMD              = 0x08,
+};
+
+enum {
+    APPLESMC_ST_1E_CMD_INTRUPTED     = 0x80,
+    APPLESMC_ST_1E_STILL_BAD_CMD     = 0x81,
+    APPLESMC_ST_1E_BAD_CMD           = 0x82,
+    APPLESMC_ST_1E_NOEXIST           = 0x84,
+    APPLESMC_ST_1E_WRITEONLY         = 0x85,
+    APPLESMC_ST_1E_READONLY          = 0x86,
+    APPLESMC_ST_1E_BAD_INDEX         = 0xb8,
+};
+
 #ifdef DEBUG_SMC
 #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
 #else
@@ -77,9 +96,12 @@ struct AppleSMCState {
 
     MemoryRegion io_data;
     MemoryRegion io_cmd;
+    MemoryRegion io_err;
     uint32_t iobase;
     uint8_t cmd;
     uint8_t status;
+    uint8_t status_1e;
+    uint8_t last_ret;
     char key[4];
     uint8_t read_pos;
     uint8_t data_len;
@@ -93,89 +115,138 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
                                   unsigned size)
 {
     AppleSMCState *s = opaque;
+    uint8_t status = s->status & 0x0f;
 
-    smc_debug("CMD Write B: %#x = %#x\n", addr, val);
+    smc_debug("CMD received: 0x%02x\n", (uint8_t)val);
     switch (val) {
     case APPLESMC_READ_CMD:
-        s->status = 0x0c;
+        /* did last command run through OK? */
+        if (status == APPLESMC_ST_CMD_DONE || status == APPLESMC_ST_NEW_CMD) {
+            s->cmd = val;
+            s->status = APPLESMC_ST_NEW_CMD | APPLESMC_ST_ACK;
+        } else {
+            smc_debug("ERROR: previous command interrupted!\n");
+            s->status = APPLESMC_ST_NEW_CMD;
+            s->status_1e = APPLESMC_ST_1E_CMD_INTRUPTED;
+        }
         break;
+    default:
+        smc_debug("UNEXPECTED CMD 0x%02x\n", (uint8_t)val);
+        s->status = APPLESMC_ST_NEW_CMD;
+        s->status_1e = APPLESMC_ST_1E_BAD_CMD;
     }
-    s->cmd = val;
     s->read_pos = 0;
     s->data_pos = 0;
 }
 
-static void applesmc_fill_data(AppleSMCState *s)
+static struct AppleSMCData *applesmc_find_key(AppleSMCState *s)
 {
     struct AppleSMCData *d;
 
     QLIST_FOREACH(d, &s->data_def, node) {
         if (!memcmp(d->key, s->key, 4)) {
-            smc_debug("Key matched (%s Len=%d Data=%s)\n", d->key,
-                      d->len, d->data);
-            memcpy(s->data, d->data, d->len);
-            return;
+            return d;
         }
     }
+    return NULL;
 }
 
 static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
                                    unsigned size)
 {
     AppleSMCState *s = opaque;
+    struct AppleSMCData *d;
 
-    smc_debug("DATA Write B: %#x = %#x\n", addr, val);
+    smc_debug("DATA received: 0x%02x\n", (uint8_t)val);
     switch (s->cmd) {
     case APPLESMC_READ_CMD:
+        if ((s->status & 0x0f) == APPLESMC_ST_CMD_DONE) {
+            break;
+        }
         if (s->read_pos < 4) {
             s->key[s->read_pos] = val;
-            s->status = 0x04;
+            s->status = APPLESMC_ST_ACK;
         } else if (s->read_pos == 4) {
-            s->data_len = val;
-            s->status = 0x05;
-            s->data_pos = 0;
-            smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
-                      s->key[1], s->key[2], s->key[3], val);
-            applesmc_fill_data(s);
+            d = applesmc_find_key(s);
+            if (d != NULL) {
+                memcpy(s->data, d->data, d->len);
+                s->data_len = d->len;
+                s->data_pos = 0;
+                s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
+                s->status_1e = APPLESMC_ST_CMD_DONE;  /* clear on valid key */
+            } else {
+                smc_debug("READ_CMD: key '%c%c%c%c' not found!\n",
+                          s->key[0], s->key[1], s->key[2], s->key[3]);
+                s->status = APPLESMC_ST_CMD_DONE;
+                s->status_1e = APPLESMC_ST_1E_NOEXIST;
+            }
         }
         s->read_pos++;
         break;
+    default:
+        s->status = APPLESMC_ST_CMD_DONE;
+        s->status_1e = APPLESMC_ST_1E_STILL_BAD_CMD;
     }
 }
 
+static void applesmc_io_err_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    smc_debug("ERR_CODE received: 0x%02x, ignoring!\n", (uint8_t)val);
+    /* NOTE: writing to the error port not supported! */
+}
+
 static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
 {
     AppleSMCState *s = opaque;
-    uint8_t retval = 0;
 
     switch (s->cmd) {
     case APPLESMC_READ_CMD:
+        if (!(s->status & APPLESMC_ST_DATA_READY)) {
+            break;
+        }
         if (s->data_pos < s->data_len) {
-            retval = s->data[s->data_pos];
-            smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
-                      retval);
+            s->last_ret = s->data[s->data_pos];
+            smc_debug("READ '%c%c%c%c'[%d] = %02x\n",
+                      s->key[0], s->key[1], s->key[2], s->key[3],
+                      s->data_pos, s->last_ret);
             s->data_pos++;
             if (s->data_pos == s->data_len) {
-                s->status = 0x00;
-                smc_debug("EOF\n");
+                s->status = APPLESMC_ST_CMD_DONE;
+                smc_debug("READ '%c%c%c%c' Len=%d complete!\n",
+                          s->key[0], s->key[1], s->key[2], s->key[3],
+                          s->data_len);
             } else {
-                s->status = 0x05;
+                s->status = APPLESMC_ST_ACK | APPLESMC_ST_DATA_READY;
             }
         }
+        break;
+    default:
+        s->status = APPLESMC_ST_CMD_DONE;
+        s->status_1e = APPLESMC_ST_1E_STILL_BAD_CMD;
     }
-    smc_debug("DATA Read b: %#x = %#x\n", addr, retval);
+    smc_debug("DATA sent: 0x%02x\n", s->last_ret);
 
-    return retval;
+    return s->last_ret;
 }
 
 static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr, unsigned size)
 {
     AppleSMCState *s = opaque;
 
-    smc_debug("CMD Read B: %#x\n", addr);
+    smc_debug("CMD sent: 0x%02x\n", s->status);
     return s->status;
 }
 
+static uint64_t applesmc_io_err_read(void *opaque, hwaddr addr, unsigned size)
+{
+    AppleSMCState *s = opaque;
+
+    /* NOTE: read does not clear the 1e status */
+    smc_debug("ERR_CODE sent: 0x%02x\n", s->status_1e);
+    return s->status_1e;
+}
+
 static void applesmc_add_key(AppleSMCState *s, const char *key,
                              int len, const char *data)
 {
@@ -198,6 +269,9 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
         QLIST_REMOVE(d, node);
     }
+    s->status = 0x00;
+    s->status_1e = 0x00;
+    s->last_ret = 0x00;
 
     applesmc_add_key(s, "REV ", 6, "\x01\x13\x0f\x00\x00\x03");
     applesmc_add_key(s, "OSK0", 32, s->osk);
@@ -227,6 +301,16 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
     },
 };
 
+static const MemoryRegionOps applesmc_err_io_ops = {
+    .write = applesmc_io_err_write,
+    .read = applesmc_io_err_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
 static void applesmc_isa_realize(DeviceState *dev, Error **errp)
 {
     AppleSMCState *s = APPLE_SMC(dev);
@@ -241,6 +325,11 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(&s->parent_obj, &s->io_cmd,
                         s->iobase + APPLESMC_CMD_PORT);
 
+    memory_region_init_io(&s->io_err, OBJECT(s), &applesmc_err_io_ops, s,
+                          "applesmc-err", 1);
+    isa_register_ioport(&s->parent_obj, &s->io_err,
+                        s->iobase + APPLESMC_ERR_PORT);
+
     if (!s->osk || (strlen(s->osk) != 64)) {
         fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");
         s->osk = default_osk;
-- 
2.7.4
