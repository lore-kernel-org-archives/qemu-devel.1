Received: from eggs.gnu.org ([2001:4830:134:3::10]:53770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsn-0007HM-OM
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsk-0002U9-GF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:33 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:44591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eDFsk-0002TZ-8x
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:26:30 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Fri, 10 Nov 2017 15:25:56 -0500
Message-ID: <20171110202556.28541-2-michael.nawrocki@gtri.gatech.edu>
In-Reply-To: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
References: <20171110202556.28541-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/1] Add 8-byte access,
 interleaving to AMD CFI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

This adds 8-byte wide access support to AMD CFI flash devices.
Additionally, it migrates the MMIO operations from old_mmio to the new
API. Finally, it mirrors the interleaving support already in place in
pflash_cfi01.c, using the max_device_width and device_width properties.

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/block/pflash_cfi02.c | 491 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 337 insertions(+), 154 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c81ddd3a99..1571148f14 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -18,7 +18,7 @@
  */
 
 /*
- * For now, this code can emulate flashes of 1, 2 or 4 bytes width.
+ * For now, this code can emulate flashes of 1, 2, 4, or 8 bytes width.
  * Supported commands/modes are:
  * - flash read
  * - flash write
@@ -28,11 +28,14 @@
  * - unlock bypass command
  * - CFI queries
  *
- * It does not support flash interleaving.
  * It does not implement boot blocs with reduced size
  * It does not implement software data protection as found in many real chips
  * It does not implement erase suspend/resume commands
  * It does not implement multiple sectors erase
+ *
+ * Flash interleaving is partially supported using the device_width and
+ * max_device_width properties, as in pflash_cfi01.c
+ * Issuing commands to individual members of the flash array is not supported.
  */
 
 #include "qemu/osdep.h"
@@ -40,6 +43,7 @@
 #include "hw/block/flash.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "qemu/bitops.h"
 #include "sysemu/block-backend.h"
 #include "exec/address-spaces.h"
 #include "qemu/host-utils.h"
@@ -69,7 +73,9 @@ struct pflash_t {
     uint32_t nb_blocs;
     uint32_t chip_len;
     uint8_t mappings;
-    uint8_t width;
+    uint8_t bank_width;
+    uint8_t device_width; /* If 0, device width not specified. */
+    uint8_t max_device_width;  /* max device width in bytes */
     uint8_t be;
     int wcycle; /* if 0, the flash is read normally */
     int bypass;
@@ -138,12 +144,190 @@ static void pflash_timer (void *opaque)
     pfl->cmd = 0;
 }
 
-static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
-                             int width, int be)
+static uint64_t pflash_cfi_query(pflash_t *pfl, hwaddr offset)
 {
+    int i;
+    uint64_t resp = 0;
     hwaddr boff;
-    uint32_t ret;
-    uint8_t *p;
+
+    /* Adjust incoming offset to match expected device-width
+     * addressing. CFI query addresses are always specified in terms of
+     * the maximum supported width of the device.  This means that x8
+     * devices and x8/x16 devices in x8 mode behave differently.  For
+     * devices that are not used at their max width, we will be
+     * provided with addresses that use higher address bits than
+     * expected (based on the max width), so we will shift them lower
+     * so that they will match the addresses used when
+     * device_width==max_device_width.
+     */
+    boff = offset >> (ctz32(pfl->bank_width) +
+                      ctz32(pfl->max_device_width) - ctz32(pfl->device_width));
+
+    if (boff > pfl->cfi_len) {
+        return 0;
+    }
+    /* Now we will construct the CFI response generated by a single
+     * device, then replicate that for all devices that make up the
+     * bus.  For wide parts used in x8 mode, CFI query responses
+     * are different than native byte-wide parts.
+     */
+    resp = pfl->cfi_table[boff];
+    if (pfl->device_width != pfl->max_device_width) {
+        /* The only case currently supported is x8 mode for a
+         * wider part.
+         */
+        if (pfl->device_width != 1 || pfl->bank_width > 8) {
+            DPRINTF("%s: Unsupported device configuration: "
+                    "device_width=%d, max_device_width=%d\n",
+                    __func__, pfl->device_width,
+                    pfl->max_device_width);
+            return 0;
+        }
+        /* CFI query data is repeated, rather than zero padded for
+         * wide devices used in x8 mode.
+         */
+        for (i = 1; i < pfl->max_device_width; i++) {
+            resp = deposit64(resp, 8 * i, 8, pfl->cfi_table[boff]);
+        }
+    }
+    /* Replicate responses for each device in bank. */
+    if (pfl->device_width < pfl->bank_width) {
+        for (i = pfl->device_width;
+             i < pfl->bank_width; i += pfl->device_width) {
+            resp = deposit64(resp, 8 * i, 8 * pfl->device_width, resp);
+        }
+    }
+
+    return resp;
+}
+
+
+
+static uint64_t _flash_read(pflash_t *pfl, hwaddr offset,
+                            int width, int be)
+{
+    /* Flash area read */
+    uint64_t ret = 0;
+    uint8_t *p = pfl->storage;
+
+    switch (width) {
+    case 1:
+        ret = p[offset];
+        /* DPRINTF("%s: data offset %08x %02x\n", __func__, offset, ret); */
+        break;
+    case 2:
+        if (be) {
+            ret = p[offset] << 8;
+            ret |= p[offset + 1];
+        } else {
+            ret = p[offset];
+            ret |= p[offset + 1] << 8;
+        }
+        /* DPRINTF("%s: data offset %08x %04x\n", __func__, offset, ret); */
+        break;
+    case 4:
+        if (be) {
+            ret = p[offset] << 24;
+            ret |= p[offset + 1] << 16;
+            ret |= p[offset + 2] << 8;
+            ret |= p[offset + 3];
+        } else {
+            ret = p[offset];
+            ret |= p[offset + 1] << 8;
+            ret |= p[offset + 2] << 16;
+            ret |= p[offset + 3] << 24;
+        }
+        /* DPRINTF("%s: data offset %08x %08x\n", __func__, offset, ret); */
+        break;
+    case 8:
+        if (be) {
+            ret = (uint64_t)p[offset] << 56;
+            ret |= (uint64_t)p[offset + 1] << 48;
+            ret |= (uint64_t)p[offset + 2] << 40;
+            ret |= (uint64_t)p[offset + 3] << 32;
+            ret |= (uint64_t)p[offset + 4] << 24;
+            ret |= (uint64_t)p[offset + 5] << 16;
+            ret |= (uint64_t)p[offset + 6] << 8;
+            ret |= (uint64_t)p[offset + 7];
+        } else {
+            ret = (uint64_t)p[offset];
+            ret |= (uint64_t)p[offset + 1] << 8;
+            ret |= (uint64_t)p[offset + 2] << 16;
+            ret |= (uint64_t)p[offset + 3] << 24;
+            ret |= (uint64_t)p[offset + 4] << 32;
+            ret |= (uint64_t)p[offset + 5] << 40;
+            ret |= (uint64_t)p[offset + 6] << 48;
+            ret |= (uint64_t)p[offset + 7] << 56;
+        }
+        break;
+    }
+
+    return ret;
+}
+
+/* Perform a device id query based on the bank width of the flash. */
+static uint64_t pflash_devid_query(pflash_t *pfl, hwaddr offset,
+                                   int width, int be)
+{
+    int i;
+    uint64_t resp;
+    hwaddr boff;
+
+    /* Adjust incoming offset to match expected device-width
+     * addressing. Device ID read addresses are always specified in
+     * terms of the maximum supported width of the device.  This means
+     * that x8 devices and x8/x16 devices in x8 mode behave
+     * differently. For devices that are not used at their max width,
+     * we will be provided with addresses that use higher address bits
+     * than expected (based on the max width), so we will shift them
+     * lower so that they will match the addresses used when
+     * device_width==max_device_width.
+     */
+    boff = offset >> (ctz32(pfl->bank_width) +
+                      ctz32(pfl->max_device_width) - ctz32(pfl->device_width));
+
+    /* Mask off upper bits which may be used in to query block
+     * or sector lock status at other addresses.
+     */
+    switch (boff & 0xFF) {
+    case 0:
+        resp = pfl->ident0;
+        DPRINTF("%s: Manufacturer Code %04x\n", __func__, resp);
+        break;
+    case 1:
+        resp = pfl->ident1;
+        DPRINTF("%s: Device ID Code %04x\n", __func__, resp);
+        break;
+    case 2:
+        resp = 0x00; /* Pretend all sectors are unprotected */
+        break;
+    case 0xE:
+    case 0xF:
+        resp = boff & 0x01 ? pfl->ident3 : pfl->ident2;
+        if (resp != (uint8_t)-1) {
+            break;
+        }
+    default:
+        return _flash_read(pfl, offset, width, be);
+    }
+    /* Replicate responses for each device in bank. */
+    if (pfl->device_width < pfl->bank_width) {
+        for (i = pfl->device_width;
+              i < pfl->bank_width; i += pfl->device_width) {
+            resp = deposit64(resp, 8 * i, 8 * pfl->device_width, resp);
+        }
+    }
+
+    return resp;
+}
+
+
+static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
+                            int width, int be)
+{
+    hwaddr boff;
+    uint64_t ret;
+    int i;
 
     DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
     ret = -1;
@@ -154,10 +338,12 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
     }
     offset &= pfl->chip_len - 1;
     boff = offset & 0xFF;
-    if (pfl->width == 2)
+    if (pfl->bank_width == 2)
         boff = boff >> 1;
-    else if (pfl->width == 4)
+    else if (pfl->bank_width == 4)
         boff = boff >> 2;
+    else if (pfl->bank_width == 8)
+        boff = boff >> 3;
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read*/
@@ -168,77 +354,83 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
     case 0x80:
         /* We accept reads during second unlock sequence... */
     case 0x00:
-    flash_read:
-        /* Flash area read */
-        p = pfl->storage;
-        switch (width) {
-        case 1:
-            ret = p[offset];
-//            DPRINTF("%s: data offset %08x %02x\n", __func__, offset, ret);
-            break;
-        case 2:
-            if (be) {
-                ret = p[offset] << 8;
-                ret |= p[offset + 1];
-            } else {
-                ret = p[offset];
-                ret |= p[offset + 1] << 8;
-            }
-//            DPRINTF("%s: data offset %08x %04x\n", __func__, offset, ret);
-            break;
-        case 4:
-            if (be) {
-                ret = p[offset] << 24;
-                ret |= p[offset + 1] << 16;
-                ret |= p[offset + 2] << 8;
-                ret |= p[offset + 3];
-            } else {
-                ret = p[offset];
-                ret |= p[offset + 1] << 8;
-                ret |= p[offset + 2] << 16;
-                ret |= p[offset + 3] << 24;
-            }
-//            DPRINTF("%s: data offset %08x %08x\n", __func__, offset, ret);
-            break;
-        }
+        ret = _flash_read(pfl, offset, width, be);
         break;
     case 0x90:
         /* flash ID read */
-        switch (boff) {
-        case 0x00:
-        case 0x01:
-            ret = boff & 0x01 ? pfl->ident1 : pfl->ident0;
-            break;
-        case 0x02:
-            ret = 0x00; /* Pretend all sectors are unprotected */
-            break;
-        case 0x0E:
-        case 0x0F:
-            ret = boff & 0x01 ? pfl->ident3 : pfl->ident2;
-            if (ret == (uint8_t)-1) {
-                goto flash_read;
+        if (!pfl->device_width) {
+            /* Preserve old behavior if device width not specified */
+            switch (boff) {
+            case 0x00:
+            case 0x01:
+                ret = boff & 0x01 ? pfl->ident1 : pfl->ident0;
+                break;
+            case 0x02:
+                ret = 0x00; /* Pretend all sectors are unprotected */
+                break;
+            case 0x0E:
+            case 0x0F:
+                ret = boff & 0x01 ? pfl->ident3 : pfl->ident2;
+                if (ret != (uint8_t)-1) {
+                    break;
+                }
+            default:
+                ret = _flash_read(pfl, offset, width, be);
+            }
+        } else {
+            /* If we have a read larger than the bank_width, combine multiple
+             * manufacturer/device ID queries into a single response.
+             */
+            int i;
+            for (i = 0; i < width; i += pfl->bank_width) {
+                ret = deposit64(ret, i * 8, pfl->bank_width * 8,
+                                pflash_devid_query(pfl,
+                                                  offset + i * pfl->bank_width,
+                                                  width, be));
             }
-            break;
-        default:
-            goto flash_read;
         }
-        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
         break;
     case 0xA0:
     case 0x10:
     case 0x30:
         /* Status register read */
         ret = pfl->status;
-        DPRINTF("%s: status %x\n", __func__, ret);
+        for (i = pfl->device_width;
+             i < pfl->bank_width; i += pfl->device_width) {
+            ret = deposit64(ret, 8 * i, 8 * pfl->device_width, ret);
+        }
+        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
         /* Toggle bit 6 */
         pfl->status ^= 0x40;
         break;
     case 0x98:
         /* CFI query mode */
-        if (boff > pfl->cfi_len)
-            ret = 0;
-        else
-            ret = pfl->cfi_table[boff];
+        if (!pfl->device_width) {
+            /* Preserve old behavior if device width not specified */
+            boff = offset & 0xFF;
+            if (pfl->bank_width == 2) {
+                boff = boff >> 1;
+            } else if (pfl->bank_width == 4) {
+                boff = boff >> 2;
+            }
+
+            if (boff > pfl->cfi_len) {
+                ret = 0;
+            } else {
+                ret = pfl->cfi_table[boff];
+            }
+        } else {
+            /* If we have a read larger than the bank_width, combine multiple
+             * CFI queries into a single response.
+             */
+            int i;
+            for (i = 0; i < width; i += pfl->bank_width) {
+                ret = deposit64(ret, i * 8, pfl->bank_width * 8,
+                                pflash_cfi_query(pfl,
+                                                 offset + i * pfl->bank_width));
+            }
+        }
+
         break;
     }
 
@@ -246,8 +438,7 @@ static uint32_t pflash_read (pflash_t *pfl, hwaddr offset,
 }
 
 /* update flash content on disk */
-static void pflash_update(pflash_t *pfl, int offset,
-                          int size)
+static void pflash_update(pflash_t *pfl, int offset, int size)
 {
     int offset_end;
     if (pfl->blk) {
@@ -260,8 +451,8 @@ static void pflash_update(pflash_t *pfl, int offset,
     }
 }
 
-static void pflash_write (pflash_t *pfl, hwaddr offset,
-                          uint32_t value, int width, int be)
+static void pflash_write(pflash_t *pfl, hwaddr offset,
+                         uint64_t value, int width, int be)
 {
     hwaddr boff;
     uint8_t *p;
@@ -275,17 +466,19 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
 #endif
         goto reset_flash;
     }
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d %d\n", __func__,
-            offset, value, width, pfl->wcycle);
+    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d %d\n",
+            __func__, offset, value, width, pfl->wcycle);
     offset &= pfl->chip_len - 1;
 
-    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
-            offset, value, width);
+    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n",
+            __func__, offset, value, width);
     boff = offset & (pfl->sector_len - 1);
-    if (pfl->width == 2)
+    if (pfl->bank_width == 2)
         boff = boff >> 1;
-    else if (pfl->width == 4)
+    else if (pfl->bank_width == 4)
         boff = boff >> 2;
+    else if (pfl->bank_width == 8)
+        boff = boff >> 3;
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -346,8 +539,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
             /* We need another unlock sequence */
             goto check_unlock0;
         case 0xA0:
-            DPRINTF("%s: write data offset " TARGET_FMT_plx " %08x %d\n",
-                    __func__, offset, value, width);
+            DPRINTF("%s: write data offset " TARGET_FMT_plx
+                    " %08" PRIx64 " %d\n", __func__, offset, value, width);
             p = pfl->storage;
             if (!pfl->ro) {
                 switch (width) {
@@ -379,6 +572,28 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
                     }
                     pflash_update(pfl, offset, 4);
                     break;
+                case 8:
+                    if (be) {
+                        p[offset] &= value >> 56;
+                        p[offset + 1] &= value >> 48;
+                        p[offset + 2] &= value >> 40;
+                        p[offset + 3] &= value >> 32;
+                        p[offset + 4] &= value >> 24;
+                        p[offset + 5] &= value >> 16;
+                        p[offset + 6] &= value >> 8;
+                        p[offset + 7] &= value;
+                    } else {
+                        p[offset] &= value;
+                        p[offset + 1] &= value >> 8;
+                        p[offset + 2] &= value >> 16;
+                        p[offset + 3] &= value >> 24;
+                        p[offset + 4] &= value >> 32;
+                        p[offset + 5] &= value >> 40;
+                        p[offset + 6] &= value >> 48;
+                        p[offset + 7] &= value >> 56;
+                    }
+                    pflash_update(pfl, offset, 8);
+                    break;
                 }
             }
             pfl->status = 0x00 | ~(value & 0x80);
@@ -494,103 +709,46 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
     pfl->cmd = 0;
 }
 
-
-static uint32_t pflash_readb_be(void *opaque, hwaddr addr)
-{
-    return pflash_read(opaque, addr, 1, 1);
-}
-
-static uint32_t pflash_readb_le(void *opaque, hwaddr addr)
-{
-    return pflash_read(opaque, addr, 1, 0);
-}
-
-static uint32_t pflash_readw_be(void *opaque, hwaddr addr)
-{
-    pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 1);
-}
-
-static uint32_t pflash_readw_le(void *opaque, hwaddr addr)
+static uint64_t pflash_read_le(void *opaque, hwaddr addr, unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 2, 0);
+    return pflash_read(pfl, addr, size, 0);
 }
 
-static uint32_t pflash_readl_be(void *opaque, hwaddr addr)
+static uint64_t pflash_read_be(void *opaque, hwaddr addr, unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 1);
+    return pflash_read(pfl, addr, size, 1);
 }
 
-static uint32_t pflash_readl_le(void *opaque, hwaddr addr)
+static void pflash_write_le(void *opaque, hwaddr addr, uint64_t data,
+                            unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    return pflash_read(pfl, addr, 4, 0);
+    pflash_write(pfl, addr, data, size, 0);
 }
 
-static void pflash_writeb_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 1);
-}
-
-static void pflash_writeb_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_write(opaque, addr, value, 1, 0);
-}
-
-static void pflash_writew_be(void *opaque, hwaddr addr,
-                             uint32_t value)
+static void pflash_write_be(void *opaque, hwaddr addr, uint64_t data,
+                            unsigned size)
 {
     pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 1);
-}
-
-static void pflash_writew_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 2, 0);
-}
-
-static void pflash_writel_be(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 1);
-}
-
-static void pflash_writel_le(void *opaque, hwaddr addr,
-                             uint32_t value)
-{
-    pflash_t *pfl = opaque;
-
-    pflash_write(pfl, addr, value, 4, 0);
+    pflash_write(pfl, addr, data, size, 1);
 }
 
 static const MemoryRegionOps pflash_cfi02_ops_be = {
-    .old_mmio = {
-        .read = { pflash_readb_be, pflash_readw_be, pflash_readl_be, },
-        .write = { pflash_writeb_be, pflash_writew_be, pflash_writel_be, },
-    },
+    .read = pflash_read_be,
+    .write = pflash_write_be,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.max_access_size = 8,
+    .impl.max_access_size = 8,
 };
 
 static const MemoryRegionOps pflash_cfi02_ops_le = {
-    .old_mmio = {
-        .read = { pflash_readb_le, pflash_readw_le, pflash_readl_le, },
-        .write = { pflash_writeb_le, pflash_writew_le, pflash_writel_le, },
-    },
+    .read = pflash_read_le,
+    .write = pflash_write_le,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.max_access_size = 8,
+    .impl.max_access_size = 8,
 };
 
 static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
@@ -654,6 +812,13 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    /* Default to devices being used at their maximum device width. This was
+     * assumed before the device_width support was added.
+     */
+    if (!pfl->max_device_width) {
+        pfl->max_device_width = pfl->device_width;
+    }
+
     pflash_setup_mappings(pfl);
     pfl->rom_mode = 1;
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
@@ -745,7 +910,25 @@ static Property pflash_cfi02_properties[] = {
     DEFINE_PROP_DRIVE("drive", struct pflash_t, blk),
     DEFINE_PROP_UINT32("num-blocks", struct pflash_t, nb_blocs, 0),
     DEFINE_PROP_UINT32("sector-length", struct pflash_t, sector_len, 0),
-    DEFINE_PROP_UINT8("width", struct pflash_t, width, 0),
+    /* width here is the overall width of this QEMU device in bytes.
+     * The QEMU device may be emulating a number of flash devices
+     * wired up in parallel; the width of each individual flash
+     * device should be specified via device-width. If the individual
+     * devices have a maximum width which is greater than the width
+     * they are being used for, this maximum width should be set via
+     * max-device-width (which otherwise defaults to device-width).
+     * So for instance a 32-bit wide QEMU flash device made from four
+     * 16-bit flash devices used in 8-bit wide mode would be configured
+     * with width = 4, device-width = 1, max-device-width = 2.
+     *
+     * If device-width is not specified we default to backwards
+     * compatible behaviour which is a bad emulation of two
+     * 16 bit devices making up a 32 bit wide QEMU device. This
+     * is deprecated for new uses of this device.
+     */
+    DEFINE_PROP_UINT8("width", struct pflash_t, bank_width, 0),
+    DEFINE_PROP_UINT8("device-width", struct pflash_t, device_width, 0),
+    DEFINE_PROP_UINT8("max-device-width", struct pflash_t, max_device_width, 0),
     DEFINE_PROP_UINT8("mappings", struct pflash_t, mappings, 0),
     DEFINE_PROP_UINT8("big-endian", struct pflash_t, be, 0),
     DEFINE_PROP_UINT16("id0", struct pflash_t, ident0, 0),
@@ -785,7 +968,7 @@ pflash_t *pflash_cfi02_register(hwaddr base,
                                 DeviceState *qdev, const char *name,
                                 hwaddr size,
                                 BlockBackend *blk, uint32_t sector_len,
-                                int nb_blocs, int nb_mappings, int width,
+                                int nb_blocs, int nb_mappings, int bank_width,
                                 uint16_t id0, uint16_t id1,
                                 uint16_t id2, uint16_t id3,
                                 uint16_t unlock_addr0, uint16_t unlock_addr1,
@@ -798,7 +981,7 @@ pflash_t *pflash_cfi02_register(hwaddr base,
     }
     qdev_prop_set_uint32(dev, "num-blocks", nb_blocs);
     qdev_prop_set_uint32(dev, "sector-length", sector_len);
-    qdev_prop_set_uint8(dev, "width", width);
+    qdev_prop_set_uint8(dev, "width", bank_width);
     qdev_prop_set_uint8(dev, "mappings", nb_mappings);
     qdev_prop_set_uint8(dev, "big-endian", !!be);
     qdev_prop_set_uint16(dev, "id0", id0);
-- 
2.14.2
