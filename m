Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CEDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE3D2339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKHpzxGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE3D2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BpS-0008AL-Tr
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMw-0001Du-GV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMu-0003lO-GA
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:22 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMu-0003kw-7f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:20 -0400
Received: by mail-pl1-x644.google.com with SMTP id y1so8063839plp.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hAFFR1M9tMoqLb7qu+zHNLfEFTvh2xfH9lhfPg3h5oQ=;
 b=YKHpzxGgT9PU/pv3UVuIZAfaZf8vavsPt3VI4XIXHQLSIGiaXNQ6UAfWot5QEPMNSZ
 9q6/+sk0exH+ZZ8YmgeggwCBut0oqmdLz9ERSvZVyB5p+B+N1eFA2d71193oGpbd23T2
 5s7VcBgMvoCfWhIDT/jI9khOUODY5RCG5UT3JRzPjlvemE4/HrjFlFF25Aip+hDKtVOc
 mBBkHYZpSLWhVZRiBACe+68FPhtEtu3H+jxKPn9pWDKoM4l3V2WueFU3oF0DbBkxm+La
 7zhUESD4QJsl4RcA7HmvQTLOi8jS16rhmb8duWw25e8zskHieCJkku2b0MD/C6XMrCDc
 UwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hAFFR1M9tMoqLb7qu+zHNLfEFTvh2xfH9lhfPg3h5oQ=;
 b=STFoscjG83VN3FYkNcSZ1yPRE6JJzd56Zu5AWazTsoe5Q0ErXwr1XYjFyjQt67yGeX
 0p4gGidZEx9AuonVQ4SPqFpq3UJIdH3DWubgXu5tRnmMelNg9l8U+BvpuBgw7BD0YoDc
 bfGnvr+teLM0pbTx+31GDmyHgSCUoTH9Tnypz6BUQTUAht7to0bcCtxQvtVYo71aX4RV
 hs1aDO7SidYwDWEGS9MNJYgTb15ErApEDYQynf2BUywpEQ9sL1YHj5dorDWXGMU9Uf6h
 rip/k2DT1X0HDAUNJo6pByX6/xqwzQg08UhHa9P67vCymdHj6knPLLeVdEDds07z+HHB
 hOlw==
X-Gm-Message-State: APjAAAUOEFk21YYAioGgYsMMh2DYXtoHDQi5ySdBapGzPCFwuqhIxDJa
 DNr8U+BBccYTXHmvchmLjDkl8wuKDtE=
X-Google-Smtp-Source: APXvYqxp/1ro1BNtyAXvLpoUAhirjGGbjaZoPiAL9XaddI5NAcnguMfDaAktr/52USDFQ3yHOnt8Rw==
X-Received: by 2002:a17:902:be0f:: with SMTP id
 r15mr13495723pls.287.1567526958406; 
 Tue, 03 Sep 2019 09:09:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:36 -0700
Message-Id: <20190903160858.5296-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 14/36] memory: Access MemoryRegion with
 endianness
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

Preparation for collapsing the two byte swaps adjust_endianness and
handle_bswap into the former.

Call memory_region_dispatch_{read|write} with endianness encoded into
the "MemOp op" operand.

This patch does not change any behaviour as
memory_region_dispatch_{read|write} is yet to handle the endianness.

Once it does handle endianness, callers with byte swaps can collapse
them into adjust_endianness.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Message-Id: <8066ab3eb037c0388dfadfe53c5118429dd1de3a.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memory.h    |  3 +++
 accel/tcg/cputlb.c       |  8 ++++++--
 exec.c                   | 13 +++++++++++--
 hw/intc/armv7m_nvic.c    | 15 ++++++++-------
 hw/s390x/s390-pci-inst.c |  6 ++++--
 hw/vfio/pci-quirks.c     |  5 +++--
 hw/virtio/virtio-pci.c   |  6 ++++--
 memory.c                 | 18 ++++++++++++++++++
 memory_ldst.inc.c        | 24 ++++++++++++++++++------
 9 files changed, 75 insertions(+), 23 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 192875b080..c4c86a6ff4 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2211,6 +2211,9 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
     }
 }
 
+/* enum device_endian to MemOp.  */
+MemOp devend_memop(enum device_endian end);
+
 #endif
 
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 6c83878f73..f64c6b1c75 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -906,7 +906,8 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_read(mr, mr_offset, &val, size_memop(size),
+    r = memory_region_dispatch_read(mr, mr_offset, &val,
+                                    size_memop(size) | MO_TE,
                                     iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
@@ -947,7 +948,8 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
         qemu_mutex_lock_iothread();
         locked = true;
     }
-    r = memory_region_dispatch_write(mr, mr_offset, val, size_memop(size),
+    r = memory_region_dispatch_write(mr, mr_offset, val,
+                                     size_memop(size) | MO_TE,
                                      iotlbentry->attrs);
     if (r != MEMTX_OK) {
         hwaddr physaddr = mr_offset +
@@ -1305,6 +1307,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             }
         }
 
+        /* TODO: Merge bswap into io_readx -> memory_region_dispatch_read.  */
         res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
                        mmu_idx, addr, retaddr, access_type, size);
         return handle_bswap(res, size, big_endian);
@@ -1553,6 +1556,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             }
         }
 
+        /* TODO: Merge bswap into io_writex -> memory_region_dispatch_write.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
                   handle_bswap(val, size, big_endian),
                   addr, retaddr, size);
diff --git a/exec.c b/exec.c
index cc9697fe1b..e4652c0e75 100644
--- a/exec.c
+++ b/exec.c
@@ -3364,8 +3364,13 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
             val = ldn_p(buf, l);
+            /*
+             * TODO: Merge bswap from ldn_p into memory_region_dispatch_write
+             * by using ldn_he_p and dropping MO_TE to get a host-endian value.
+             */
             result |= memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l), attrs);
+                                                   size_memop(l) | MO_TE,
+                                                   attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3426,8 +3431,12 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
             l = memory_access_size(mr, l, addr1);
+            /*
+             * TODO: Merge bswap from stn_p into memory_region_dispatch_read
+             * by using stn_he_p and dropping MO_TE to get a host-endian value.
+             */
             result |= memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l), attrs);
+                                                  size_memop(l) | MO_TE, attrs);
             stn_p(buf, l, val);
         } else {
             /* RAM case */
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 7220940133..8e93e51e81 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2349,8 +2349,8 @@ static MemTxResult nvic_sysreg_ns_write(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_write(mr, addr, value, size_memop(size),
-                                            attrs);
+        return memory_region_dispatch_write(mr, addr, value,
+                                            size_memop(size) | MO_TE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2369,8 +2369,8 @@ static MemTxResult nvic_sysreg_ns_read(void *opaque, hwaddr addr,
     if (attrs.secure) {
         /* S accesses to the alias act like NS accesses to the real region */
         attrs.secure = 0;
-        return memory_region_dispatch_read(mr, addr, data, size_memop(size),
-                                           attrs);
+        return memory_region_dispatch_read(mr, addr, data,
+                                           size_memop(size) | MO_TE, attrs);
     } else {
         /* NS attrs are RAZ/WI for privileged, and BusFault for user */
         if (attrs.user) {
@@ -2396,8 +2396,8 @@ static MemTxResult nvic_systick_write(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_write(mr, addr, value, size_memop(size),
-                                        attrs);
+    return memory_region_dispatch_write(mr, addr, value,
+                                        size_memop(size) | MO_TE, attrs);
 }
 
 static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
@@ -2409,7 +2409,8 @@ static MemTxResult nvic_systick_read(void *opaque, hwaddr addr,
 
     /* Direct the access to the correct systick */
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systick[attrs.secure]), 0);
-    return memory_region_dispatch_read(mr, addr, data, size_memop(size), attrs);
+    return memory_region_dispatch_read(mr, addr, data, size_memop(size) | MO_TE,
+                                       attrs);
 }
 
 static const MemoryRegionOps nvic_systick_ops = {
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0e92a372ca..4b3bd4a804 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -373,7 +373,8 @@ static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_read(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_read(mr, offset, data,
+                                       size_memop(len) | MO_BE,
                                        MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -472,7 +473,8 @@ static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
     mr = pbdev->pdev->io_regions[pcias].memory;
     mr = s390_get_subregion(mr, offset, len);
     offset -= mr->addr;
-    return memory_region_dispatch_write(mr, offset, data, size_memop(len),
+    return memory_region_dispatch_write(mr, offset, data,
+                                        size_memop(len) | MO_BE,
                                         MEMTXATTRS_UNSPECIFIED);
 }
 
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index a4e1d2abb5..136f3a9ad6 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1074,7 +1074,8 @@ static void vfio_rtl8168_quirk_address_write(void *opaque, hwaddr addr,
 
                 /* Write to the proper guest MSI-X table instead */
                 memory_region_dispatch_write(&vdev->pdev.msix_table_mmio,
-                                             offset, val, size_memop(size),
+                                             offset, val,
+                                             size_memop(size) | MO_LE,
                                              MEMTXATTRS_UNSPECIFIED);
             }
             return; /* Do not write guest MSI-X data to hardware */
@@ -1105,7 +1106,7 @@ static uint64_t vfio_rtl8168_quirk_data_read(void *opaque,
     if (rtl->enabled && (vdev->pdev.cap_present & QEMU_PCI_CAP_MSIX)) {
         hwaddr offset = rtl->addr & 0xfff;
         memory_region_dispatch_read(&vdev->pdev.msix_table_mmio, offset,
-                                    &data, size_memop(size),
+                                    &data, size_memop(size) | MO_LE,
                                     MEMTXATTRS_UNSPECIFIED);
         trace_vfio_quirk_rtl8168_msix_read(vdev->vbasedev.name, offset, data);
     }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 82c5e87a44..d89a85bb33 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -553,7 +553,8 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    memory_region_dispatch_write(mr, addr, val, size_memop(len),
+    /* TODO: Merge bswap from cpu_to_leXX into memory_region_dispatch_write.  */
+    memory_region_dispatch_write(mr, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
@@ -577,7 +578,8 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    memory_region_dispatch_read(mr, addr, &val, size_memop(len),
+    /* TODO: Merge bswap from leXX_to_cpu into memory_region_dispatch_read.  */
+    memory_region_dispatch_read(mr, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
     switch (len) {
     case 1:
diff --git a/memory.c b/memory.c
index 3d87908784..d72143a18f 100644
--- a/memory.c
+++ b/memory.c
@@ -3285,3 +3285,21 @@ static void memory_register_types(void)
 }
 
 type_init(memory_register_types)
+
+MemOp devend_memop(enum device_endian end)
+{
+    static MemOp conv[] = {
+        [DEVICE_LITTLE_ENDIAN] = MO_LE,
+        [DEVICE_BIG_ENDIAN] = MO_BE,
+        [DEVICE_NATIVE_ENDIAN] = MO_TE,
+        [DEVICE_HOST_ENDIAN] = 0,
+    };
+    switch (end) {
+    case DEVICE_LITTLE_ENDIAN:
+    case DEVICE_BIG_ENDIAN:
+    case DEVICE_NATIVE_ENDIAN:
+        return conv[end];
+    default:
+        g_assert_not_reached();
+    }
+}
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index de658c40c4..809a7e8389 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,9 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
+        /* TODO: Merge bswap32 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_32 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap32(val);
@@ -114,7 +116,9 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
+        /* TODO: Merge bswap64 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_64 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap64(val);
@@ -224,7 +228,9 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
+        /* TODO: Merge bswap16 into memory_region_dispatch_read.  */
+        r = memory_region_dispatch_read(mr, addr1, &val,
+                                        MO_16 | devend_memop(endian), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap16(val);
@@ -346,7 +352,9 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
             val = bswap32(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
+        /* TODO: Merge bswap32 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_32 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +459,9 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
             val = bswap16(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
+        /* TODO: Merge bswap16 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_16 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +534,9 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
             val = bswap64(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
+        /* TODO: Merge bswap64 into memory_region_dispatch_write.  */
+        r = memory_region_dispatch_write(mr, addr1, val,
+                                         MO_64 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.17.1


