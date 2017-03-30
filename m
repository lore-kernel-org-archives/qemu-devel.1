Received: from eggs.gnu.org ([2001:4830:134:3::10]:51253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ztong@vt.edu>) id 1ctUu4-00041I-LU
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ztong@vt.edu>) id 1ctUu1-0002GQ-I9
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:53:56 -0400
Received: from omr2.cc.ipv6.vt.edu ([2607:b400:92:8400:0:33:fb76:806e]:49130
	helo=omr2.cc.vt.edu)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ztong@vt.edu>) id 1ctUu1-0002AN-Bm
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 03:53:53 -0400
Received: from mr2.cc.vt.edu (mail.ipv6.vt.edu
	[IPv6:2607:b400:92:9:0:9d:8fcb:4116])
	by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id v2U6JWEC023198
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 02:19:32 -0400
Received: from mail-qk0-f198.google.com (mail-qk0-f198.google.com
	[209.85.220.198])
	by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id v2U6JRMA026202
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 02:19:32 -0400
Received: by mail-qk0-f198.google.com with SMTP id d66so13844279qkb.0
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 23:19:32 -0700 (PDT)
From: Tong Zhang <ztong@vt.edu>
Date: Thu, 30 Mar 2017 02:18:30 -0400
Message-Id: <20170330061830.25028-2-ztong@vt.edu>
In-Reply-To: <20170330061830.25028-1-ztong@vt.edu>
References: <20170330061830.25028-1-ztong@vt.edu>
Subject: [Qemu-devel] [PATCH] applesmc: add error mem region handling for
 MacOS 10.12.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tong Zhang <ztong@vt.edu>
Cc: qemu-devel <qemu-devel@nongnu.org>

From: Zhang Tong <ztong@vt.edu>

	Add error memory region handling for applesmc, which is required
	to boot MacOS 10.12.4, because the updated SMC driver checks that
	error memory region and returns it as error code to Dont_steal_macos.kext,
	and Dont_steal_macos.kext checks the returned error code for good.

	Signed-off-by: Tong Zhang<ztong@vt.edu>
---
 hw/misc/applesmc.c | 152 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 130 insertions(+), 22 deletions(-)

diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 77fab5b..28bbea8 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -2,9 +2,11 @@
  *  Apple SMC controller
  *
  *  Copyright (c) 2007 Alexander Graf
+ *                2017 Tong Zhang
  *
  *  Authors: Alexander Graf <agraf@suse.de>
  *           Susanne Graf <suse@csgraf.de>
+ *           Tong Zhang <ztong@vt.edu>
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -43,6 +45,8 @@
 #define APPLESMC_DATA_PORT             0x0
 /* command/status port used by Apple SMC */
 #define APPLESMC_CMD_PORT              0x4
+#define APPLESMC_ERROR_CODE_PORT       0x1e
+#define APPLESMC_INT_PORT              0x1f
 #define APPLESMC_NR_PORTS              32
 
 #define APPLESMC_READ_CMD              0x10
@@ -74,6 +78,7 @@ struct AppleSMCState {
 
     MemoryRegion io_data;
     MemoryRegion io_cmd;
+    MemoryRegion io_err;
     uint32_t iobase;
     uint8_t cmd;
     uint8_t status;
@@ -83,6 +88,7 @@ struct AppleSMCState {
     uint8_t data_pos;
     uint8_t data[255];
     uint8_t charactic[4];
+    uint8_t status_error;
     char *osk;
     QLIST_HEAD(, AppleSMCData) data_def;
 };
@@ -91,12 +97,28 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
                                   unsigned size)
 {
     AppleSMCState *s = opaque;
-
-    smc_debug("CMD Write B: %#x = %#x\n", addr, val);
+    smc_debug("CMD Write B: %lx = %lx\n", addr, val);
     switch(val) {
-        case APPLESMC_READ_CMD:
-            s->status = 0x0c;
-            break;
+    case APPLESMC_READ_CMD:
+        s->status_error = 0x00;
+        s->status = 0x0c;
+        break;
+    case APPLESMC_WRITE_CMD:
+        s->status_error = 0x00;
+        s->status = 0x0c;
+        break;
+    case APPLESMC_GET_KEY_BY_INDEX_CMD:
+        s->status_error = 0x00;
+        s->status = 0x0c;
+        break;
+    case APPLESMC_GET_KEY_TYPE_CMD:
+        s->status_error = 0x00;
+        s->status = 0x0c;
+        break;
+    default:
+        {
+        smc_debug("applesmc_io_cmd_write, unhandled cmd %lx\n", val);
+        }
     }
     s->cmd = val;
     s->read_pos = 0;
@@ -112,9 +134,12 @@ static void applesmc_fill_data(AppleSMCState *s)
             smc_debug("Key matched (%s Len=%d Data=%s)\n", d->key,
                       d->len, d->data);
             memcpy(s->data, d->data, d->len);
+            s->status_error = 0x00;
             return;
         }
     }
+    /* not found */
+    s->status_error = 0x84;
 }
 
 static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
@@ -122,22 +147,69 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
 {
     AppleSMCState *s = opaque;
 
-    smc_debug("DATA Write B: %#x = %#x\n", addr, val);
+    smc_debug("DATA Write B: 0x%lx\n", val);
     switch(s->cmd) {
-        case APPLESMC_READ_CMD:
-            if(s->read_pos < 4) {
-                s->key[s->read_pos] = val;
-                s->status = 0x04;
-            } else if(s->read_pos == 4) {
-                s->data_len = val;
-                s->status = 0x05;
-                s->data_pos = 0;
-                smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
-                          s->key[1], s->key[2], s->key[3], val);
-                applesmc_fill_data(s);
+    case APPLESMC_READ_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = 0x04;
+        } else if (s->read_pos == 4) {
+            s->data_len = val;
+            s->status = 0x05;
+            s->data_pos = 0;
+            smc_debug("DRCMD Key = %c%c%c%c Len = %ld\n", s->key[0],
+                      s->key[1], s->key[2], s->key[3], val);
+            applesmc_fill_data(s);
+        }
+        s->read_pos++;
+        break;
+    case APPLESMC_WRITE_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = 0x04;
+        } else if (s->read_pos == 4) {
+            s->status = 0x05;
+            s->data_pos = 0;
+            s->data_len = val;
+        } else if (s->data_pos < s->data_len) {
+            s->data[s->data_pos] = val;
+            s->data_pos++;
+            s->status = 0x05;
+            if (s->data_pos == s->data_len) {
+                s->status = 0x00;
+                smc_debug("DWCMD Key = %c%c%c%c data[%d]=%s\n",
+                    s->key[0], s->key[1], s->key[2], s->key[3],
+                    s->data_pos, s->data);
             }
+        }
+        s->read_pos++;
+        break;
+    case APPLESMC_GET_KEY_BY_INDEX_CMD:
+        if (s->read_pos < 4) {
+            s->status = 0x04;
             s->read_pos++;
-            break;
+        }
+        if (s->read_pos == 4) {
+            s->status = 0x05;
+        }
+        break;
+    case APPLESMC_GET_KEY_TYPE_CMD:
+        if (s->read_pos < 4) {
+            s->key[s->read_pos] = val;
+            s->status = 0x04;
+            s->read_pos++;
+        }
+        if (s->read_pos == 4) {
+            s->data_len = 6;
+            s->status = 0x05;
+            s->data_pos = 0;
+            smc_debug("DGKT CMD Key = %c%c%c%c\n", s->key[0],
+                      s->key[1], s->key[2], s->key[3]);
+            s->status_error = 0x84;
+        }
+        break;
+    default:
+        smc_debug("applesmc_io_data_write, unknown cmd:0x%x\n", s->cmd);
     }
 }
 
@@ -149,6 +221,7 @@ static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
 
     switch(s->cmd) {
         case APPLESMC_READ_CMD:
+        {
             if(s->data_pos < s->data_len) {
                 retval = s->data[s->data_pos];
                 smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
@@ -160,9 +233,15 @@ static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
                 } else
                     s->status = 0x05;
             }
+            break;
+        }
+        default:
+        {
+            smc_debug("applesmc_io_data_read, unknown cmd:0x%x\n", s->cmd);
+            s->status = 0x00;
+        }
     }
-    smc_debug("DATA Read b: %#x = %#x\n", addr1, retval);
-
+    smc_debug("DATA Read b: %lx = %x\n", addr1, retval);
     return retval;
 }
 
@@ -170,7 +249,7 @@ static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr1, unsigned size)
 {
     AppleSMCState *s = opaque;
 
-    smc_debug("CMD Read B: %#x\n", addr1);
+    smc_debug("CMD Read B: cmd: 0x%x\n", s->cmd);
     return s->status;
 }
 
@@ -202,7 +281,21 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
     applesmc_add_key(s, "NATJ", 1, "\0");
     applesmc_add_key(s, "MSSP", 1, "\0");
-    applesmc_add_key(s, "MSSD", 1, "\0x3");
+    applesmc_add_key(s, "MSSD", 1, "\x3");
+}
+
+static void applesmc_io_err_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+}
+
+static uint64_t applesmc_io_err_read(void *opaque, hwaddr addr1, unsigned size)
+{
+    AppleSMCState *s = opaque;
+
+    smc_debug("CMD Read B: err: 0x%x\n", s->cmd);
+
+    return s->status_error;
 }
 
 static const MemoryRegionOps applesmc_data_io_ops = {
@@ -225,6 +318,16 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
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
@@ -239,6 +342,11 @@ static void applesmc_isa_realize(DeviceState *dev, Error **errp)
     isa_register_ioport(&s->parent_obj, &s->io_cmd,
                         s->iobase + APPLESMC_CMD_PORT);
 
+    memory_region_init_io(&s->io_err, OBJECT(s), &applesmc_err_io_ops, s,
+                        "applesmc-err", 4);
+    isa_register_ioport(&s->parent_obj, &s->io_err,
+                        s->iobase + APPLESMC_ERROR_CODE_PORT);
+
     if (!s->osk || (strlen(s->osk) != 64)) {
         fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");
         s->osk = default_osk;
-- 
2.10.2
