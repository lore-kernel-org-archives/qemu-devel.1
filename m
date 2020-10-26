Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0EAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142E1223AC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0Cy3DD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142E1223AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzV3-0002xP-46
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPF-0002hc-N0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPA-0006he-DF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=J6Qccw+D6CaPwu6y3tcv+lXXBvRJfVxMGCmrZbTcrR4=;
 b=e0Cy3DD31UqsmQjE2lsQi5f/UZFrhUGI25MgMiTtgYPZ4I4oj8Gmq0X+5YOLxtmKgJyiu5
 kWyhrESUERQzVcLnZlLSkJ0UyN7LxIOxn9Va+BhspdwiZbDbDmZU2dOcYWj45vpX+FCbGo
 +wPc/olfoAMZdX7cpZeRydKjcBRXWTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-gzSjcyGBMQ2kstYPkX5sgw-1; Mon, 26 Oct 2020 06:06:59 -0400
X-MC-Unique: gzSjcyGBMQ2kstYPkX5sgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E5BE64ACA;
 Mon, 26 Oct 2020 10:06:58 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA4928B84A;
 Mon, 26 Oct 2020 10:06:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/31] fuzz: Add fuzzer callbacks to DMA-read functions
Date: Mon, 26 Oct 2020 11:06:15 +0100
Message-Id: <20201026100632.212530-15-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

We should be careful to not call any functions besides fuzz_dma_read_cb.
Without --enable-fuzzing, fuzz_dma_read_cb is an empty inlined function.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20201023150746.107063-7-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/exec/memory.h                 | 1 +
 include/exec/memory_ldst_cached.h.inc | 3 +++
 memory_ldst.c.inc                     | 4 ++++
 softmmu/memory.c                      | 1 +
 softmmu/physmem.c                     | 2 ++
 5 files changed, 11 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 4aaf578ce6..aff6ef7605 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2462,6 +2462,7 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, len, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
         return MEMTX_OK;
diff --git a/include/exec/memory_ldst_cached.h.inc b/include/exec/memory_ldst_cached.h.inc
index fd4bbb40e7..aff574039f 100644
--- a/include/exec/memory_ldst_cached.h.inc
+++ b/include/exec/memory_ldst_cached.h.inc
@@ -28,6 +28,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(l)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 4 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 4, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(l)(cache->ptr + addr);
     } else {
@@ -39,6 +40,7 @@ static inline uint64_t ADDRESS_SPACE_LD_CACHED(q)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 8 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 8, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(q)(cache->ptr + addr);
     } else {
@@ -50,6 +52,7 @@ static inline uint32_t ADDRESS_SPACE_LD_CACHED(uw)(MemoryRegionCache *cache,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     assert(addr < cache->len && 2 <= cache->len - addr);
+    fuzz_dma_read_cb(cache->xlat + addr, 2, cache->mrs.mr, false);
     if (likely(cache->ptr)) {
         return LD_P(uw)(cache->ptr + addr);
     } else {
diff --git a/memory_ldst.c.inc b/memory_ldst.c.inc
index c54aee4a95..8d45d2eeff 100644
--- a/memory_ldst.c.inc
+++ b/memory_ldst.c.inc
@@ -42,6 +42,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
                                         MO_32 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 4, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -110,6 +111,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
                                         MO_64 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 8, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
@@ -175,6 +177,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 1, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         val = ldub_p(ptr);
         r = MEMTX_OK;
@@ -212,6 +215,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
                                         MO_16 | devend_memop(endian), attrs);
     } else {
         /* RAM case */
+        fuzz_dma_read_cb(addr, 2, mr, false);
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         switch (endian) {
         case DEVICE_LITTLE_ENDIAN:
diff --git a/softmmu/memory.c b/softmmu/memory.c
index cec0e0f743..ee4a6bc168 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1433,6 +1433,7 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
     unsigned size = memop_size(op);
     MemTxResult r;
 
+    fuzz_dma_read_cb(addr, size, mr, false);
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
         *pval = unassigned_mem_read(mr, addr, size);
         return MEMTX_DECODE_ERROR;
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e319fb2a1e..a9adedb9f8 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2832,6 +2832,7 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             stn_he_p(buf, l, val);
         } else {
             /* RAM case */
+            fuzz_dma_read_cb(addr, len, mr, false);
             ram_ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
             memcpy(buf, ram_ptr, l);
         }
@@ -3192,6 +3193,7 @@ void *address_space_map(AddressSpace *as,
     memory_region_ref(mr);
     *plen = flatview_extend_translation(fv, addr, len, mr, xlat,
                                         l, is_write, attrs);
+    fuzz_dma_read_cb(addr, *plen, mr, is_write);
     ptr = qemu_ram_ptr_length(mr->ram_block, xlat, plen, true);
 
     return ptr;
-- 
2.18.2


