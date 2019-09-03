Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32CC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF0D23953
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4VBPsbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0D23953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48941 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bfd-0005kk-EP
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMr-00015h-Lg
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMq-0003iU-3h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:17 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMp-0003hz-TK
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:16 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so8112757plr.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hEBkbukp46MQLuIak3k/srHenY77lib8xqS0D+g3MQI=;
 b=D4VBPsberkhOzauz4I5xkp4jHGriPcsPPuKanSFsxJtx4LCERZpEzUntr7na0hpqKh
 V75P4urhzhUEJzopzxJut51cCtHMikvwbVsB5Lkg/2QkEYABfqRGI1j2bn+J3CG9CSHH
 OUs9GeQjF1k6olDXiYhWUeBE8VKsUmhQ5go/hCbKE6goUtkiljUNvlFKSFLdzxotMAYg
 MlUnwKyKzNkzf+iYsAX3qpLGy8ptNRkWL8GogTLhfHlV7mr4O3LHfWtXbq8hXndRPVrl
 Kb9C/v3n2tLaq3Hqcu5fiyPUWQvTlJThOrX/dq1F+eihRMr+0JrOEP4x+Sm1dF1RQawh
 h6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hEBkbukp46MQLuIak3k/srHenY77lib8xqS0D+g3MQI=;
 b=UMNqIT3wg5MGJOM90QgGaasGKmIjXy5r3W7GlyYRDtuBJwX555r4dm5U/yv5efTd6b
 2y78l6/veHRkOka0Ik5lifwTNxOpG3Dyta0LAeVexJUl9258y42YQ9QXEhr0CKxhUyph
 qAmGlVy7k0LSvDrUPvaIdtPKo+rpRW78rT1F1YFQuioM68dC4IXdSeQ0HWu7iXOe4lUo
 GQrdbrilapY50QVhu1vbtRgS5SVpMTpR4oNLXfdCgfvsuxL3VXkp+CwnmyAuFkgP7Mot
 ysqDPa9NflhEE7ZAfg60fi6ajlf+cEQx15MbaVpPK3s+Xe0kIFeBg0yk5Sms7e9MW4wA
 nfng==
X-Gm-Message-State: APjAAAWub9vJVn5+JJcyW+lV0+sLfEsGwFOob8/tcfVfdfAr/1ueZDrC
 tunBYNdv1sWCr+kgIqtgQUBq3gP+kb8=
X-Google-Smtp-Source: APXvYqwM6HScIucxQH/4CK1HI62lRpxNuv9aMB/2yY7IHILBCY5orwk3QYEkHPSlTt/IwLmi8nUM3Q==
X-Received: by 2002:a17:902:860b:: with SMTP id
 f11mr35652811plo.48.1567526950872; 
 Tue, 03 Sep 2019 09:09:10 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:30 -0700
Message-Id: <20190903160858.5296-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 08/36] exec: Access MemoryRegion with MemOp
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

The memory_region_dispatch_{read|write} operand "unsigned size" is
being converted into a "MemOp op".

Convert interfaces by using no-op size_memop.

After all interfaces are converted, size_memop will be implemented
and the memory_region_dispatch_{read|write} operand "unsigned size"
will be converted into a "MemOp op".

As size_memop is a no-op, this patch does not change any behaviour.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <3b042deef0a60dd49ae2320ece92120ba6027f2b.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c            |  6 ++++--
 memory_ldst.inc.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index 1df966d17a..cc9697fe1b 100644
--- a/exec.c
+++ b/exec.c
@@ -3364,7 +3364,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
             val = ldn_p(buf, l);
-            result |= memory_region_dispatch_write(mr, addr1, val, l, attrs);
+            result |= memory_region_dispatch_write(mr, addr1, val,
+                                                   size_memop(l), attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3425,7 +3426,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
             /* I/O case */
             release_lock |= prepare_mmio_access(mr);
             l = memory_access_size(mr, l, addr1);
-            result |= memory_region_dispatch_read(mr, addr1, &val, l, attrs);
+            result |= memory_region_dispatch_read(mr, addr1, &val,
+                                                  size_memop(l), attrs);
             stn_p(buf, l, val);
         } else {
             /* RAM case */
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index acf865b900..1e8a2fc3ba 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -38,7 +38,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 4, attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(4), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap32(val);
@@ -114,7 +114,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 8, attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(8), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap64(val);
@@ -188,7 +188,7 @@ uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 1, attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(1), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -224,7 +224,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         release_lock |= prepare_mmio_access(mr);
 
         /* I/O case */
-        r = memory_region_dispatch_read(mr, addr1, &val, 2, attrs);
+        r = memory_region_dispatch_read(mr, addr1, &val, size_memop(2), attrs);
 #if defined(TARGET_WORDS_BIGENDIAN)
         if (endian == DEVICE_LITTLE_ENDIAN) {
             val = bswap16(val);
@@ -300,7 +300,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
     if (l < 4 || !memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
 
-        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
     } else {
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
         stl_p(ptr, val);
@@ -346,7 +346,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
             val = bswap32(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, 4, attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, size_memop(4), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -408,7 +408,7 @@ void glue(address_space_stb, SUFFIX)(ARG1_DECL,
     mr = TRANSLATE(addr, &addr1, &l, true, attrs);
     if (!memory_access_is_direct(mr, true)) {
         release_lock |= prepare_mmio_access(mr);
-        r = memory_region_dispatch_write(mr, addr1, val, 1, attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, size_memop(1), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -451,7 +451,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
             val = bswap16(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, 2, attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, size_memop(2), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
@@ -524,7 +524,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
             val = bswap64(val);
         }
 #endif
-        r = memory_region_dispatch_write(mr, addr1, val, 8, attrs);
+        r = memory_region_dispatch_write(mr, addr1, val, size_memop(8), attrs);
     } else {
         /* RAM case */
         ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
-- 
2.17.1


