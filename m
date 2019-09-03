Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53CCC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C3B2378A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6H3/wWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C3B2378A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bcv-00023O-4J
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMq-00013e-8b
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMo-0003hj-QF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:16 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMo-0003h3-JU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:14 -0400
Received: by mail-pl1-x641.google.com with SMTP id bd8so1766848plb.6
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6ErdebiJGL3Qh8ExlZC8PccbHjvi9peZ59d7ZiPKACI=;
 b=E6H3/wWffavhM3CUceTndJaF9g/LEOXq38ED8aoeNpadqTNo2U4yL0CTwLmddhDt+8
 nKA6WrHNtVuLI0QPxKEeU8pjBqmP2q8063y4twn1krZ3yywhWB/5HV2KEaCXIClOpZZT
 cU4SczOTza5xX/YCjAZ8L/FfA37cAd/wz2EmzhTg/QTIAlDz6C/ryR5+H/SJRo4JOBmC
 xsj4dADVs0CmZkButR2kbzky0LzmDZ0AvQCpj4uf4pU6BRks0eWmnw1aToRQ1bvTo9KB
 wuJsazI4QJ2EaFhgoyTTtbriqCkIsRigbITeNXii5vijU7WL7zz0LSBaZB+n2Nhgbs0Q
 dD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6ErdebiJGL3Qh8ExlZC8PccbHjvi9peZ59d7ZiPKACI=;
 b=LOAHgSz3HPaq4MED/+1o58SkFrwyb3GXDSnLgZ5tHfu/BaXmfjXbQmAWSIi4I5busm
 7L2f8Qh9DNoTDOlZ+umu/qqEG0hQxiTUL0ahzdl5KBMMpZZD6Aiy7UbKybzrYmHGRKRr
 AiTZuxL5YJ2TwQ/sqtyCisI//8N+V7OkubEJzoNZuq7U1Z/U4CfL4T6z/xOVDy4yp3OL
 V2HAb8evIdXW5uNuHtdC6eTjco+dWyJZb0VdpBNTQKbcUsxGU1Vl8q4Jw+GMKLjtmGLW
 OTYdW2mC4iN1MR+up6dU3cPQNoir8mfjO5Jtj2vc5WbfAOsM1gAkc2W9UTHkpkhGawfH
 f70g==
X-Gm-Message-State: APjAAAWhwORgLggto8sxVoerOb9BUBc9W6Zlg7/sUlMbYvUAi0WEPc8+
 LYa0NRBN7BC3DYggAmKvSu/Vz+wAVQo=
X-Google-Smtp-Source: APXvYqwE4V2q4xHhpQLSPiKJ/ZzRKpOFGEQtrvKV+d+uyLL3YuRBOwz5sYcYa4dYH5LDRgW5fVtjNw==
X-Received: by 2002:a17:902:bb85:: with SMTP id
 m5mr1865929pls.336.1567526953000; 
 Tue, 03 Sep 2019 09:09:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:32 -0700
Message-Id: <20190903160858.5296-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 10/36] memory: Access MemoryRegion with MemOp
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

Convert memory_region_dispatch_{read|write} operand "unsigned size"
into a "MemOp op".

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1dd82df5801866743f838f1d046475115a1d32da.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h  | 22 +++++++++++++++-------
 include/exec/memory.h |  9 +++++----
 memory.c              |  7 +++++--
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index dfd76a1604..0a610b75d9 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -12,6 +12,8 @@
 #ifndef MEMOP_H
 #define MEMOP_H
 
+#include "qemu/host-utils.h"
+
 typedef enum MemOp {
     MO_8     = 0,
     MO_16    = 1,
@@ -107,14 +109,20 @@ typedef enum MemOp {
     MO_SSIZE = MO_SIZE | MO_SIGN,
 } MemOp;
 
-/* Size in bytes to MemOp.  */
-static inline unsigned size_memop(unsigned size)
+/* MemOp to size in bytes.  */
+static inline unsigned memop_size(MemOp op)
 {
-    /*
-     * FIXME: No-op to aid conversion of memory_region_dispatch_{read|write}
-     * "unsigned size" operand into a "MemOp op".
-     */
-    return size;
+    return 1 << (op & MO_SIZE);
+}
+
+/* Size in bytes to MemOp.  */
+static inline MemOp size_memop(unsigned size)
+{
+#ifdef CONFIG_DEBUG_TCG
+    /* Power of 2 up to 8.  */
+    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+#endif
+    return ctz32(size);
 }
 
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index fddc2ff48a..192875b080 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -19,6 +19,7 @@
 #include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
+#include "exec/memop.h"
 #include "exec/ramlist.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
@@ -1749,13 +1750,13 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner);
  * @mr: #MemoryRegion to access
  * @addr: address within that region
  * @pval: pointer to uint64_t which the data is written to
- * @size: size of the access in bytes
+ * @op: size, sign, and endianness of the memory operation
  * @attrs: memory transaction attributes to use for the access
  */
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                         hwaddr addr,
                                         uint64_t *pval,
-                                        unsigned size,
+                                        MemOp op,
                                         MemTxAttrs attrs);
 /**
  * memory_region_dispatch_write: perform a write directly to the specified
@@ -1764,13 +1765,13 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
  * @mr: #MemoryRegion to access
  * @addr: address within that region
  * @data: data to write
- * @size: size of the access in bytes
+ * @op: size, sign, and endianness of the memory operation
  * @attrs: memory transaction attributes to use for the access
  */
 MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          hwaddr addr,
                                          uint64_t data,
-                                         unsigned size,
+                                         MemOp op,
                                          MemTxAttrs attrs);
 
 /**
diff --git a/memory.c b/memory.c
index 7fd93b1d42..3d87908784 100644
--- a/memory.c
+++ b/memory.c
@@ -1446,9 +1446,10 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
 MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                         hwaddr addr,
                                         uint64_t *pval,
-                                        unsigned size,
+                                        MemOp op,
                                         MemTxAttrs attrs)
 {
+    unsigned size = memop_size(op);
     MemTxResult r;
 
     if (!memory_region_access_valid(mr, addr, size, false, attrs)) {
@@ -1490,9 +1491,11 @@ static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
 MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                          hwaddr addr,
                                          uint64_t data,
-                                         unsigned size,
+                                         MemOp op,
                                          MemTxAttrs attrs)
 {
+    unsigned size = memop_size(op);
+
     if (!memory_region_access_valid(mr, addr, size, true, attrs)) {
         unassigned_mem_write(mr, addr, data, size);
         return MEMTX_DECODE_ERROR;
-- 
2.17.1


