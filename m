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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5207C216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsOz2H1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5207C216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SJ0-00071P-UG
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFY-0002BV-At
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFW-0002mv-UJ
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:12 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFW-0002lB-OF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:10 -0400
Received: by mail-pg1-x543.google.com with SMTP id n190so1495507pgn.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i7Te0hyKeGbM+6eI7r0Q+gh7VrYIYolFsMGWmwYusp8=;
 b=jsOz2H1UvEO6lSovOzmiLAUmjDEdreLbQfgk3nfZv0wBibwVypYYB8SN1zp7XxvHSs
 j+eghzPtSsLGNXOJshfrz5pO3+WdMywzQfOOrQBsUtqfRCwxXGZ4JST/qhKhb6RnEz3x
 Oi9xsOYHheGKrPKf3Cl2LVJNFlQxjgkk54tzP21ioCxy5UxQpPVKDrhbVk0VABEd0rNj
 LwyZUAWE8dkVBSyrVco57uUJsFvi3zEnIRgt2MetKqZtFvj9MrDO8drJ1MZNGHOBlpuo
 D7i7MUzbaq2rNnGO5l8rVuLq05N3MMMQSHliisfnbO38iecprslCXS+4kNc2qgMPGmGr
 ZV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i7Te0hyKeGbM+6eI7r0Q+gh7VrYIYolFsMGWmwYusp8=;
 b=KB1cI654OkAeUbykP+/RR7fUGu9AtuUah/cuoKLCOUuN+cZDnTsJz4gj0ZzwyykTGD
 ivp1KpUmBTfU6z3PI6WNLZ4KTASKAem6p3g3TQc4T7VrCIPIAj1yRizTlpiG45DMiTlg
 N2HrW4ER0p5XFIgDM5f29Q7D30P0ghucFluriKFYTelxU5Lh6RM/9/86sXweYsMecqfC
 XYRHwa+kmhdnI0y94ZCAvSau5xKzVlr/flabPFTbChg0QPpH5fVmxWkFR22zusjbd1Sl
 E7aSqNSNeu4YlDZTvrFbHLm2E+aW5BOhquKAXZEOZg+jx6ZAj7G/rkujqDmEWkTGJsMS
 V9Sg==
X-Gm-Message-State: APjAAAWeulZmUFVnNKQSGSyGGOgo5CBtJxaM7Uu5qqN6fT4Uq5ZiqWBD
 +QQnG2h647nOO6JJEGvE0CiceQW29FQ=
X-Google-Smtp-Source: APXvYqwTk0Tw1qDPStsLb3k0zfrDYVuIb9rUfdwWQXUfZJd180zfrhCtUUV/S6Lbop5siy6weAGPfg==
X-Received: by 2002:a17:90b:28f:: with SMTP id
 az15mr512122pjb.18.1566400209498; 
 Wed, 21 Aug 2019 08:10:09 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:09 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:03 +1000
Message-Id: <e2269e6d7f0e5f33ff97752233d4d08acaec0fb9.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v8 09/21] exec: Access MemoryRegion with MemOp
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Tony Nguyen <tony.nguyen.git@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 exec.c            |  6 ++++--
 memory_ldst.inc.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/exec.c b/exec.c
index 4aaa14b075..02562d8dbd 100644
--- a/exec.c
+++ b/exec.c
@@ -3333,7 +3333,8 @@ static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
             /* XXX: could force current_cpu to NULL to avoid
                potential bugs */
             val = ldn_p(buf, l);
-            result |= memory_region_dispatch_write(mr, addr1, val, l, attrs);
+            result |= memory_region_dispatch_write(mr, addr1, val,
+                                                   size_memop(l), attrs);
         } else {
             /* RAM case */
             ptr = qemu_ram_ptr_length(mr->ram_block, addr1, &l, false);
@@ -3394,7 +3395,8 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
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
2.23.0


