Received: from eggs.gnu.org ([209.51.188.92]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFcA-0006wV-IB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRS-0006Jz-NK
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:48 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRR-0006B8-0J
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:46 -0500
Received: by mail-oi1-x241.google.com with SMTP id a77so14513303oii.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:10 -0800
Message-Id: <20190128223118.5255-5-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 04/12] exec: Add target-specific tlb bits to
 MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

These bits can be used to cache target-specific data in cputlb
read from the page tables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a1642098..d4a3477d71 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,16 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /*
+     * The following are target-specific page-table bits.  These are not
+     * related to actual memory transactions at all.  However, this structure
+     * is part of the tlb_fill interface, cached in the cputlb structure,
+     * and has unused bits.  These fields will be read by target-specific
+     * helpers using env->iotlb[mmu_idx][tlb_index()].attrs.target_tlb_bitN.
+     */
+    unsigned int target_tlb_bit0 : 1;
+    unsigned int target_tlb_bit1 : 1;
+    unsigned int target_tlb_bit2 : 1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.17.2
