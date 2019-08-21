Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD32C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB7B216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX+jpnMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB7B216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SKx-0001rZ-DD
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFe-0002DY-V0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SFd-0002wA-Jy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SFd-0002uV-CF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:17 -0400
Received: by mail-pl1-x642.google.com with SMTP id z3so1491211pln.6
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zdj58c8A9QRTAa5i396K+J8rIcvzCaaq0/p6FGydUPQ=;
 b=NX+jpnMP5ZWrp/f149XBy9yr4047kE3ykLAeVt642aLOqdHeFugJ4Q0Hi5JecBBwbt
 IlSdMMyBuzcmM3Qiu4UgTBfooDjgI41Cl9G2tbss/Tlp5ij7IJx1kzRpjW9Czd5xULkR
 C/6I131wm8cYBlFL8HGRm/I1NIwV8CpgiZuXfuPzn9OkPpF8MxIS0GSzNltWavZw7yhn
 pwVu4geV0uS3KCSp5FAocJrIku64h7CHl6F59vKkjDdZh/G6CLVBPgJfe3lBAMTdehN5
 yarW7jhh/SVmEfXLtXBx5UJ4rc5VVp4rOvyyjogtUCfqvlefE9JQEP3Ub+rPIL+DKCy/
 j3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zdj58c8A9QRTAa5i396K+J8rIcvzCaaq0/p6FGydUPQ=;
 b=ZrLlQvcI4+zOsLR2g9nyPvjbocnfXVRqadkddSQe9plCSk+Md1J5SaVKCw8nr1+TV8
 14Eg6lYaoaQIxX0GmOVkrWmF4gaxyo59Il6xi0iQwclU1wHS2MPbblY4dinO3XKgVUOx
 Fshx2LXvpbCXuMplWp+gdtvf3nF0bBXnENonlSBjG/1TZYIP6f2QwsIvFJjaBU7u8cQU
 nyyf1+f3dVp91QsAPQmgROSZMcK8/vVJl7ZoP0qS9gWnfgVyBnmVRRsj6pyNE2DhrmEX
 n1eTKwqj/0bosbQKsyi/SDnnMrDbdQE8zpxLIg9FkAsNSObVtm+0mksbaZ5KKDRChPCx
 BAMA==
X-Gm-Message-State: APjAAAXrV5SZ4iZ2xq8C9EFGkV92HYutEQCX63WhncN4/eS2GQlBy2Pd
 RpFvO9mOzihsLMk2h3FeHlvtWCpkrew=
X-Google-Smtp-Source: APXvYqyBj00X1zjgxCf6MiEAOHc5yzlWciF75uSa9qbYl2CCUZYn/QVDQ9pk+nV5GPtbn4m3L3jCGg==
X-Received: by 2002:a17:902:e592:: with SMTP id
 cl18mr2941943plb.291.1566400215839; 
 Wed, 21 Aug 2019 08:10:15 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:15 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:05 +1000
Message-Id: <db6a7e38ed6d2050be0b3d2d7567faf8eef6c1aa.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v8 11/21] memory: Access MemoryRegion with MemOp
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert memory_region_dispatch_{read|write} operand "unsigned size"
into a "MemOp op".

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h  | 20 ++++++++++++++------
 include/exec/memory.h |  9 +++++----
 memory.c              |  7 +++++--
 3 files changed, 24 insertions(+), 12 deletions(-)

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
 
+/* MemOp to size in bytes.  */
+static inline unsigned memop_size(MemOp op)
+{
+    return 1 << (op & MO_SIZE);
+}
+
 /* Size in bytes to MemOp.  */
-static inline unsigned size_memop(unsigned size)
+static inline MemOp size_memop(unsigned size)
 {
-    /*
-     * FIXME: No-op to aid conversion of memory_region_dispatch_{read|write}
-     * "unsigned size" operand into a "MemOp op".
-     */
-    return size;
+#ifdef CONFIG_DEBUG_TCG
+    /* Power of 2 up to 8.  */
+    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
+#endif
+    return ctz32(size);
 }
 
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d99eb25d2e..887aece05d 100644
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
@@ -1737,13 +1738,13 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner);
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
@@ -1752,13 +1753,13 @@ MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
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
index 8141486832..19f3324232 100644
--- a/memory.c
+++ b/memory.c
@@ -1439,9 +1439,10 @@ static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
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
@@ -1483,9 +1484,11 @@ static bool memory_region_dispatch_write_eventfds(MemoryRegion *mr,
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
2.23.0


