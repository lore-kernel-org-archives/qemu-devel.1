Received: from eggs.gnu.org ([2001:4830:134:3::10]:40427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0q-0006gJ-Ng
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0k-0003QZ-EA
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:28 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 15:36:01 +0000
Message-Id: <1487604965-23220-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 07/11] armv7m: Make bitband device take the
 address space to access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

Instead of the bitband device doing a cpu_physical_memory_read/write,
make it take a MemoryRegion which specifies where it should be
accessing, and use address_space_read/write to access the
corresponding AddressSpace.

Since this entails pretty much a rewrite, convert away from
old_mmio in the process.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armv7m.h |   2 +
 hw/arm/armv7m.c         | 166 +++++++++++++++++++++++-------------------------
 2 files changed, 81 insertions(+), 87 deletions(-)

diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 3333c91..a9b3f2a 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -21,8 +21,10 @@ typedef struct {
     SysBusDevice parent_obj;
     /*< public >*/
 
+    AddressSpace *source_as;
     MemoryRegion iomem;
     uint32_t base;
+    MemoryRegion *source_memory;
 } BitBandState;
 
 #define TYPE_ARMV7M "armv7m"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index fb21f74..4481106 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -23,103 +23,73 @@
 /* Bitbanded IO.  Each word corresponds to a single bit.  */
 
 /* Get the byte address of the real memory for a bitband access.  */
-static inline uint32_t bitband_addr(void * opaque, uint32_t addr)
+static inline hwaddr bitband_addr(BitBandState *s, hwaddr offset)
 {
-    uint32_t res;
-
-    res = *(uint32_t *)opaque;
-    res |= (addr & 0x1ffffff) >> 5;
-    return res;
-
-}
-
-static uint32_t bitband_readb(void *opaque, hwaddr offset)
-{
-    uint8_t v;
-    cpu_physical_memory_read(bitband_addr(opaque, offset), &v, 1);
-    return (v & (1 << ((offset >> 2) & 7))) != 0;
-}
-
-static void bitband_writeb(void *opaque, hwaddr offset,
-                           uint32_t value)
-{
-    uint32_t addr;
-    uint8_t mask;
-    uint8_t v;
-    addr = bitband_addr(opaque, offset);
-    mask = (1 << ((offset >> 2) & 7));
-    cpu_physical_memory_read(addr, &v, 1);
-    if (value & 1)
-        v |= mask;
-    else
-        v &= ~mask;
-    cpu_physical_memory_write(addr, &v, 1);
-}
-
-static uint32_t bitband_readw(void *opaque, hwaddr offset)
-{
-    uint32_t addr;
-    uint16_t mask;
-    uint16_t v;
-    addr = bitband_addr(opaque, offset) & ~1;
-    mask = (1 << ((offset >> 2) & 15));
-    mask = tswap16(mask);
-    cpu_physical_memory_read(addr, &v, 2);
-    return (v & mask) != 0;
-}
-
-static void bitband_writew(void *opaque, hwaddr offset,
-                           uint32_t value)
-{
-    uint32_t addr;
-    uint16_t mask;
-    uint16_t v;
-    addr = bitband_addr(opaque, offset) & ~1;
-    mask = (1 << ((offset >> 2) & 15));
-    mask = tswap16(mask);
-    cpu_physical_memory_read(addr, &v, 2);
-    if (value & 1)
-        v |= mask;
-    else
-        v &= ~mask;
-    cpu_physical_memory_write(addr, &v, 2);
+    return s->base | (offset & 0x1ffffff) >> 5;
 }
 
-static uint32_t bitband_readl(void *opaque, hwaddr offset)
+static MemTxResult bitband_read(void *opaque, hwaddr offset,
+                                uint64_t *data, unsigned size, MemTxAttrs attrs)
 {
-    uint32_t addr;
-    uint32_t mask;
-    uint32_t v;
-    addr = bitband_addr(opaque, offset) & ~3;
-    mask = (1 << ((offset >> 2) & 31));
-    mask = tswap32(mask);
-    cpu_physical_memory_read(addr, &v, 4);
-    return (v & mask) != 0;
+    BitBandState *s = opaque;
+    uint8_t buf[4];
+    MemTxResult res;
+    int bitpos, bit;
+    hwaddr addr;
+
+    assert(size <= 4);
+
+    /* Find address in underlying memory and round down to multiple of size */
+    addr = bitband_addr(s, offset) & (-size);
+    res = address_space_read(s->source_as, addr, attrs, buf, size);
+    if (res) {
+        return res;
+    }
+    /* Bit position in the N bytes read... */
+    bitpos = (offset >> 2) & ((size * 8) - 1);
+    /* ...converted to byte in buffer and bit in byte */
+    bit = (buf[bitpos >> 3] >> (bitpos & 7)) & 1;
+    *data = bit;
+    return MEMTX_OK;
 }
 
-static void bitband_writel(void *opaque, hwaddr offset,
-                           uint32_t value)
+static MemTxResult bitband_write(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size, MemTxAttrs attrs)
 {
-    uint32_t addr;
-    uint32_t mask;
-    uint32_t v;
-    addr = bitband_addr(opaque, offset) & ~3;
-    mask = (1 << ((offset >> 2) & 31));
-    mask = tswap32(mask);
-    cpu_physical_memory_read(addr, &v, 4);
-    if (value & 1)
-        v |= mask;
-    else
-        v &= ~mask;
-    cpu_physical_memory_write(addr, &v, 4);
+    BitBandState *s = opaque;
+    uint8_t buf[4];
+    MemTxResult res;
+    int bitpos, bit;
+    hwaddr addr;
+
+    assert(size <= 4);
+
+    /* Find address in underlying memory and round down to multiple of size */
+    addr = bitband_addr(s, offset) & (-size);
+    res = address_space_read(s->source_as, addr, attrs, buf, size);
+    if (res) {
+        return res;
+    }
+    /* Bit position in the N bytes read... */
+    bitpos = (offset >> 2) & ((size * 8) - 1);
+    /* ...converted to byte in buffer and bit in byte */
+    bit = 1 << (bitpos & 7);
+    if (value & 1) {
+        buf[bitpos >> 3] |= bit;
+    } else {
+        buf[bitpos >> 3] &= ~bit;
+    }
+    return address_space_write(s->source_as, addr, attrs, buf, size);
 }
 
 static const MemoryRegionOps bitband_ops = {
-    .old_mmio = {
-        .read = { bitband_readb, bitband_readw, bitband_readl, },
-        .write = { bitband_writeb, bitband_writew, bitband_writel, },
-    },
+    .read_with_attrs = bitband_read,
+    .write_with_attrs = bitband_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
 };
 
 static void bitband_init(Object *obj)
@@ -127,11 +97,30 @@ static void bitband_init(Object *obj)
     BitBandState *s = BITBAND(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
 
-    memory_region_init_io(&s->iomem, obj, &bitband_ops, &s->base,
+    object_property_add_link(obj, "source-memory",
+                             TYPE_MEMORY_REGION,
+                             (Object **)&s->source_memory,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
+                             &error_abort);
+    memory_region_init_io(&s->iomem, obj, &bitband_ops, s,
                           "bitband", 0x02000000);
     sysbus_init_mmio(dev, &s->iomem);
 }
 
+static void bitband_realize(DeviceState *dev, Error **errp)
+{
+    BitBandState *s = BITBAND(dev);
+
+    if (!s->source_memory) {
+        error_setg(errp, "source-memory property not set");
+        return;
+    }
+
+    s->source_as = address_space_init_shareable(s->source_memory,
+                                                "bitband-source");
+}
+
 /* Board init.  */
 
 static const hwaddr bitband_input_addr[ARMV7M_NUM_BITBANDS] = {
@@ -251,6 +240,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
+        object_property_set_link(obj, OBJECT(s->board_memory),
+                                 "source-memory", &error_abort);
         object_property_set_bool(obj, true, "realized", &err);
         if (err != NULL) {
             error_propagate(errp, err);
@@ -366,6 +357,7 @@ static void bitband_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = bitband_realize;
     dc->props = bitband_properties;
 }
 
-- 
2.7.4
