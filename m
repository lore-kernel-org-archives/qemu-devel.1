Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AAEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A03206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZMksNMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A03206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SSL-00044S-W8
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG2-0002qt-Lx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG0-0003eh-MW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SG0-0003de-ET
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id l21so1486195pgm.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p3AagrIP2F5ZoqDT0ems8qsDnpPMMzUENhxIh+5OGxU=;
 b=BZMksNMNPO7hcNsm2ip8T4AGki2mZ5qu9WpjBOuHehPk6lqG+M1xpJbJT2EUpqisl/
 GoQAWOpTQpc/F6LDn0mIR340p+k25w3a7/wSnSJUSRrHASkNCWEVMF0iyLDVIxExyK3r
 P6cnqwfa8zEze4j6TuDHpY7dNRNpS/6/fYDYcFwvfZoH2EaDQiEwGesEW1WtRWBrkb2M
 fWaplZw3Bc51YxzIWRWVnNAZnx/Dna88z04Mi4Mp+ZOoB09/1yNEbTV5QPrK3I6NOPLr
 AVXwbu1Kldo8ibKGcZv2cmonjIazUrFiPFTj1GQ51V1D40OkaT1O31w05u4ysJi3ljL2
 yHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p3AagrIP2F5ZoqDT0ems8qsDnpPMMzUENhxIh+5OGxU=;
 b=kLeIF78/FJVfPVa96jiOphLsdra8XcxxTTkq0+giR0IW0/LjLS2V8XwQm5hGk5Owt8
 JgNIABZdyjtGu45tM9xdy2CWg+IR1Suy9EZ5D5FjNuXvofv7v2b8JNOEFX5UNI9HadqM
 T+LUuNzFltXdLAnelCDpxx+xcH97nzX2SVxK9wMPX4QXS+Oti1do5jxzjTEs8cRX1yec
 FdkT00DWbBtZ7+knodzv76DmPFG17PAm5aSdNz5Ve+TVgj+AeilgAW6AeZNadIuNgy92
 ituZJiHRKnfU5HIiCQ/32TVs16WqyY+pjWDQa+4shAXxxg64ruytLgGMuWyY4f5gUWo4
 K/sQ==
X-Gm-Message-State: APjAAAWCdIi3bIiiZMVpF7LijsCcPpd2Brz9q0MWmjYwaqaX7KhabEJk
 H2PGdWU9qjkbvxWLUj6tkPSNkJn+rXg=
X-Google-Smtp-Source: APXvYqxHIuSwP97g0yvfe38OLPYsHc0mXSO6gw0+Mf9ZgXZNAI8VqQIIhAlJN+3fjH6ZyeSpObpCaA==
X-Received: by 2002:a63:1c22:: with SMTP id c34mr29404147pgc.56.1566400239023; 
 Wed, 21 Aug 2019 08:10:39 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:38 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:11 +1000
Message-Id: <c64905a7fd126474ea3f20d8731add551cf9d0c9.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v8 17/21] memory: Single byte swap along the
 I/O path
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Nguyen <tony.nguyen.git@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that MemOp has been pushed down into the memory API, and
callers are encoding endianness, we can collapse byte swaps
along the I/O path into the accelerator and target independent
adjust_endianness.

Collapsing byte swaps along the I/O path enables additional endian
inversion logic, e.g. SPARC64 Invert Endian TTE bit, with redundant
byte swaps cancelling out.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 accel/tcg/cputlb.c     | 42 ++--------------------------
 exec.c                 | 17 +++---------
 hw/virtio/virtio-pci.c | 10 +++----
 memory.c               | 33 ++++++++--------------
 memory_ldst.inc.c      | 63 ------------------------------------------
 5 files changed, 23 insertions(+), 142 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 5c12eef292..3c9e634d99 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1200,38 +1200,6 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
     cpu_loop_exit_atomic(env_cpu(env), retaddr);
 }
 
-#ifdef TARGET_WORDS_BIGENDIAN
-#define NEED_BE_BSWAP 0
-#define NEED_LE_BSWAP 1
-#else
-#define NEED_BE_BSWAP 1
-#define NEED_LE_BSWAP 0
-#endif
-
-/*
- * Byte Swap Helper
- *
- * This should all dead code away depending on the build host and
- * access type.
- */
-
-static inline uint64_t handle_bswap(uint64_t val, MemOp op)
-{
-    if ((memop_big_endian(op) && NEED_BE_BSWAP) ||
-        (!memop_big_endian(op) && NEED_LE_BSWAP)) {
-        switch (op & MO_SIZE) {
-        case MO_8: return val;
-        case MO_16: return bswap16(val);
-        case MO_32: return bswap32(val);
-        case MO_64: return bswap64(val);
-        default:
-            g_assert_not_reached();
-        }
-    } else {
-        return val;
-    }
-}
-
 /*
  * Load Helpers
  *
@@ -1306,10 +1274,8 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
             }
         }
 
-        /* TODO: Merge bswap into io_readx -> memory_region_dispatch_read.  */
-        res = io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
-                       mmu_idx, addr, retaddr, access_type, op);
-        return handle_bswap(res, op);
+        return io_readx(env, &env_tlb(env)->d[mmu_idx].iotlb[index],
+                        mmu_idx, addr, retaddr, access_type, op);
     }
 
     /* Handle slow unaligned access (it spans two pages or IO).  */
@@ -1552,10 +1518,8 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
             }
         }
 
-        /* TODO: Merge bswap into io_writex -> memory_region_dispatch_write.  */
         io_writex(env, &env_tlb(env)->d[mmu_idx].iotlb[index], mmu_idx,
-                  handle_bswap(val, op),
-                  addr, retaddr, op);
+                  val, addr, retaddr, op);
         return;
     }
 
diff --git a/exec.c b/exec.c
index c7ea6e63a2..857e22465e 100644
--- a/exec.c
+++ b/exec.c
@@ -3332,14 +3332,9 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             l = memory_access_size(mr, l, addr1);
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
-            val = ldn_p(buf, l);
-            /*
-             * TODO: Merge bswap from ldn_p into memory_region_dispatch_write
-             * by using ldn_he_p and dropping MO_TE to get a host-endian value.
-             */
+            val = ldn_he_p(buf, l);
             result |= memory_region_dispatch_write(mr, addr1, val,
-                                                   size_memop(l) | MO_TE,
-                                                   attrs);
+                                                   size_memop(l), attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3400,13 +3395,9 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
             l = memory_access_size(mr, l, addr1);
-            /*
-             * TODO: Merge bswap from stn_p into memory_region_dispatch_read
-             * by using stn_he_p and dropping MO_TE to get a host-endian value.
-             */
             result |= memory_region_dispatch_read(mr, addr1, &val,
-                                                  size_memop(l) | MO_TE, attrs);
-            stn_p(buf, l, val);
+                                                  size_memop(l), attrs);
+            stn_he_p(buf, l, val);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index d89a85bb33..ffb03728f9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -544,16 +544,15 @@ void virtio_address_space_write(VirtIOPCIProxy *proxy, hwaddr addr,
         val = pci_get_byte(buf);
         break;
     case 2:
-        val = cpu_to_le16(pci_get_word(buf));
+        val = pci_get_word(buf);
         break;
     case 4:
-        val = cpu_to_le32(pci_get_long(buf));
+        val = pci_get_long(buf);
         break;
     default:
         /* As length is under guest control, handle illegal values. */
         return;
     }
-    /* TODO: Merge bswap from cpu_to_leXX into memory_region_dispatch_write.  */
     memory_region_dispatch_write(mr, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
@@ -578,7 +577,6 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
     /* Make sure caller aligned buf properly */
     assert(!(((uintptr_t)buf) & (len - 1)));
 
-    /* TODO: Merge bswap from leXX_to_cpu into memory_region_dispatch_read.  */
     memory_region_dispatch_read(mr, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
     switch (len) {
@@ -586,10 +584,10 @@ virtio_address_space_read(VirtIOPCIProxy *proxy, hwaddr addr,
         pci_set_byte(buf, val);
         break;
     case 2:
-        pci_set_word(buf, le16_to_cpu(val));
+        pci_set_word(buf, val);
         break;
     case 4:
-        pci_set_long(buf, le32_to_cpu(val));
+        pci_set_long(buf, val);
         break;
     default:
         /* As length is under guest control, handle illegal values. */
diff --git a/memory.c b/memory.c
index bc746cb69a..6e1d500e0a 100644
--- a/memory.c
+++ b/memory.c
@@ -352,32 +352,23 @@ static bool memory_region_big_endian(MemoryRegion *mr)
 #endif
 }
 
-static bool memory_region_wrong_endianness(MemoryRegion *mr)
+static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
 {
-#ifdef TARGET_WORDS_BIGENDIAN
-    return mr->ops->endianness == DEVICE_LITTLE_ENDIAN;
-#else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
-#endif
-}
-
-static void adjust_endianness(MemoryRegion *mr, uint64_t *data, unsigned size)
-{
-    if (memory_region_wrong_endianness(mr)) {
-        switch (size) {
-        case 1:
+    if ((op & MO_BSWAP) != devend_memop(mr->ops->endianness)) {
+        switch (op & MO_SIZE) {
+        case MO_8:
             break;
-        case 2:
+        case MO_16:
             *data = bswap16(*data);
             break;
-        case 4:
+        case MO_32:
             *data = bswap32(*data);
             break;
-        case 8:
+        case MO_64:
             *data = bswap64(*data);
             break;
         default:
-            abort();
+            g_assert_not_reached();
         }
     }
 }
@@ -1451,7 +1442,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     }
 
     r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
-    adjust_endianness(mr, pval, size);
+    adjust_endianness(mr, pval, op);
     return r;
 }
 
@@ -1494,7 +1485,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
         return MEMTX_DECODE_ERROR;
     }
 
-    adjust_endianness(mr, &data, size);
+    adjust_endianness(mr, &data, op);
 
     if ((!kvm_eventfds_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
@@ -2340,7 +2331,7 @@ void memory_region_add_eventfd(MemoryRegion *mr,
     }
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
@@ -2375,7 +2366,7 @@ void memory_region_del_eventfd(MemoryRegion *mr,
     unsigned i;
 
     if (size) {
-        adjust_endianness(mr, &mrfd.data, size);
+        adjust_endianness(mr, &mrfd.data, size_memop(size) | MO_TE);
     }
     memory_region_transaction_begin();
     for (i = 0; i < mr->ioeventfd_nb; ++i) {
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 809a7e8389..c54aee4a95 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,18 +38,8 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap32 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_32 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -116,18 +106,8 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap64 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_64 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -228,18 +208,8 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        /* TODO: Merge bswap16 into memory_region_dispatch_read.  */
         r = memory_region_dispatch_read(mr, addr1, &val,
                                         MO_16 | devend_memop(endian), attrs);
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -342,17 +312,6 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap32(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap32(val);
-        }
-#endif
-        /* TODO: Merge bswap32 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_32 | devend_memop(endian), attrs);
     } else {
@@ -449,17 +408,6 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 2 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap16(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap16(val);
-        }
-#endif
-        /* TODO: Merge bswap16 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_16 | devend_memop(endian), attrs);
     } else {
@@ -524,17 +472,6 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (l < 8 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-
-#if defined(TARGET_WORDS_BIGENDIAN)
-        if (endian == DEVICE_LITTLE_ENDIAN) {
-            val = bswap64(val);
-        }
-#else
-        if (endian == DEVICE_BIG_ENDIAN) {
-            val = bswap64(val);
-        }
-#endif
-        /* TODO: Merge bswap64 into memory_region_dispatch_write.  */
         r = memory_region_dispatch_write(mr, addr1, val,
                                          MO_64 | devend_memop(endian), attrs);
     } else {
-- 
2.23.0


