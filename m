Received: from eggs.gnu.org ([209.51.188.92]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AX-0001yK-UP
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AT-0000dT-Jg
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:57 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AT-0000KF-7x
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:53 -0500
Received: by mail-wm1-x341.google.com with SMTP id m1so4459293wml.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:52 +0000
Message-Id: <20190205170510.21984-5-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/22] exec: Add target-specific tlb bits to
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

From: Richard Henderson <richard.henderson@linaro.org>

These bits can be used to cache target-specific data in cputlb
read from the page tables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190128223118.5255-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/memattrs.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a16420984..d4a3477d71d 100644
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
2.20.1
