Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:18:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3B0206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DllIdsqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3B0206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTeK-0001jY-NQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8x-0007xn-Ds
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8u-000143-PY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=brEVr7KtuKLlpe5+wUf9WnJ4DGKm96Q7guN6CwOpo9A=;
 b=DllIdsqWIH1VeCR/aHLdRY8fGZc+7XuMLUqNmMWx386Bs1zmWq/981+lqFqXUhS1Ry8fE3
 r030SL79L8TrttX9zJlJDpMSlGAJ90QdFIeydhk6Oto5FwaXR145YuokMch/euR94bXVaq
 UJu4agPp8Q8AnGzWhMh7ZFg5u8Qfgic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-AnpL-BUNMdyHwsxloCtnug-1; Thu, 11 Jun 2020 15:45:37 -0400
X-MC-Unique: AnpL-BUNMdyHwsxloCtnug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 214A5801503;
 Thu, 11 Jun 2020 19:45:36 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A354A8FF91;
 Thu, 11 Jun 2020 19:45:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 056/115] exec: Let address_space_read/write_cached() propagate
 MemTxResult
Date: Thu, 11 Jun 2020 15:43:50 -0400
Message-Id: <20200611194449.31468-57-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Both address_space_read_cached_slow() and
address_space_write_cached_slow() return a MemTxResult type.
Do not discard it, return it to the caller.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c                | 16 ++++++++--------
 include/exec/memory.h | 19 +++++++++++--------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/exec.c b/exec.c
index be4be2df3a..0e197e53c2 100644
--- a/exec.c
+++ b/exec.c
@@ -3718,7 +3718,7 @@ static inline MemoryRegion *address_space_translate_cached(
 /* Called from RCU critical section. address_space_read_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
-void
+MemTxResult
 address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                    void *buf, hwaddr len)
 {
@@ -3728,15 +3728,15 @@ address_space_read_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, false,
                                         MEMTXATTRS_UNSPECIFIED);
-    flatview_read_continue(cache->fv,
-                           addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                           addr1, l, mr);
+    return flatview_read_continue(cache->fv,
+                                  addr, MEMTXATTRS_UNSPECIFIED, buf, len,
+                                  addr1, l, mr);
 }
 
 /* Called from RCU critical section. address_space_write_cached uses this
  * out of line function when the target is an MMIO or IOMMU region.
  */
-void
+MemTxResult
 address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
                                     const void *buf, hwaddr len)
 {
@@ -3746,9 +3746,9 @@ address_space_write_cached_slow(MemoryRegionCache *cache, hwaddr addr,
     l = len;
     mr = address_space_translate_cached(cache, addr, &addr1, &l, true,
                                         MEMTXATTRS_UNSPECIFIED);
-    flatview_write_continue(cache->fv,
-                            addr, MEMTXATTRS_UNSPECIFIED, buf, len,
-                            addr1, l, mr);
+    return flatview_write_continue(cache->fv,
+                                   addr, MEMTXATTRS_UNSPECIFIED, buf, len,
+                                   addr1, l, mr);
 }
 
 #define ARG1_DECL                MemoryRegionCache *cache
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3e00cdbbfa..48df5abe13 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2354,10 +2354,11 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 
 /* Internal functions, part of the implementation of address_space_read_cached
  * and address_space_write_cached.  */
-void address_space_read_cached_slow(MemoryRegionCache *cache,
-                                    hwaddr addr, void *buf, hwaddr len);
-void address_space_write_cached_slow(MemoryRegionCache *cache,
-                                     hwaddr addr, const void *buf, hwaddr len);
+MemTxResult address_space_read_cached_slow(MemoryRegionCache *cache,
+                                           hwaddr addr, void *buf, hwaddr len);
+MemTxResult address_space_write_cached_slow(MemoryRegionCache *cache,
+                                            hwaddr addr, const void *buf,
+                                            hwaddr len);
 
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
@@ -2422,15 +2423,16 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline void
+static inline MemTxResult
 address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
                           void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
         memcpy(buf, cache->ptr + addr, len);
+        return MEMTX_OK;
     } else {
-        address_space_read_cached_slow(cache, addr, buf, len);
+        return address_space_read_cached_slow(cache, addr, buf, len);
     }
 }
 
@@ -2442,15 +2444,16 @@ address_space_read_cached(MemoryRegionCache *cache, hwaddr addr,
  * @buf: buffer with the data transferred
  * @len: length of the data transferred
  */
-static inline void
+static inline MemTxResult
 address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
                            const void *buf, hwaddr len)
 {
     assert(addr < cache->len && len <= cache->len - addr);
     if (likely(cache->ptr)) {
         memcpy(cache->ptr + addr, buf, len);
+        return MEMTX_OK;
     } else {
-        address_space_write_cached_slow(cache, addr, buf, len);
+        return address_space_write_cached_slow(cache, addr, buf, len);
     }
 }
 
-- 
2.26.2



