Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF4EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBC923431
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkB/qnYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBC923431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BZb-0005w9-7r
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMt-00019W-UU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMs-0003kO-Jv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:19 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMs-0003jx-Ds
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:18 -0400
Received: by mail-pf1-x442.google.com with SMTP id w22so2621911pfi.9
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QUELZke21EDjOzUmfr5OazuxTZ4XzsbULsMXR7XqLTU=;
 b=MkB/qnYwcNb1A3DbtngTrGDuMb1dg3P3HdBv5CiD9Y7Tm/AlDGmznXhyuhmEazheAo
 QDqg7UyjyLsCYMYHTH9iLl0RULQuFJrwbq1Vpgn1U6x7fRiAjC2IcEsGiwdxr5XWf33r
 P1OcQ7qwTMxSoRkigFmcxLfZ6aCiQ1/KenzYMjL0uZqa7onQWsdG25CzBKIfV6PaVJ4Q
 iO3W3MNaWyOr/Y1nGMHawxsU7fAmu+sWVX7PK7Moq9xq8L1zcjHsGen8xC805yCJbmI4
 4KoJn2h6KrYMUxSmEmYpga5VboznpkB9piJHapJQqzm1HyPC7z+sinSlhGikABWWp+0/
 bbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QUELZke21EDjOzUmfr5OazuxTZ4XzsbULsMXR7XqLTU=;
 b=aVc0zMZwIClVUhv1m78/Jf8/rNcJsm/Anr4jjXnUlF9yGaGzjq1aqgb6jFgGlTu34j
 grtPaYbyz+1d70Y7TAaJjEsNw0lZpdATD1VVtU3LOOhvjO1vOs36xSYhXHpGeUDj9zYE
 Z77U4YPlktC45xeWV1loLrpND+l2GTVrTa4iun4k+ElhmFIfsPylf+XHp67rtjTIcpY5
 zpUpbdSY3Eo0659NycTSoqCBJcdYMeXCa++UD6Mis9jc4Lf3GaTVqv+CWJSMmHhitBNQ
 K2wjjgziCUx5CSNDhESQwux9CVK1sTASnUAAAStsEUdM9Le4ei4EwLFKQSdN1PH4p/DQ
 u4iA==
X-Gm-Message-State: APjAAAWxFyQ93KAPznTR31tRrt/SjOg48ecC6/yPkRl4MC0GMfqnZjyL
 ICwoI0jW/rzC4htca+Unp246tl604jw=
X-Google-Smtp-Source: APXvYqwJFtriY3r6gB7GPZLtYnTLxLopIs1r/EgOY/Fpi5qbhek366rcT/+0YYlyAjeME0ttEDua0A==
X-Received: by 2002:a17:90a:f98e:: with SMTP id
 cq14mr66101pjb.52.1567526957129; 
 Tue, 03 Sep 2019 09:09:17 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:35 -0700
Message-Id: <20190903160858.5296-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 13/36] exec: Hard code size with MO_{8|16|32|64}
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

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <99f69701cad294db638f84abebc58115e1b9de9a.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 memory_ldst.inc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 1e8a2fc3ba..de658c40c4 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(4), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_32, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap32(val);
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(8), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_64, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap64(val);
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(1), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(2), attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, MO_16, attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap16(val);
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         stl_p(ptr, val);
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
             val = bswap32(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_32, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(1), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_8, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
             val = bswap16(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(2), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_16, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
             val = bswap64(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, size_memop(8), attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, MO_64, attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.17.1


