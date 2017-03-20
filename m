Received: from eggs.gnu.org ([2001:4830:134:3::10]:35973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzKA-0003tt-2e
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cpzK7-0005mR-Fj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:22 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cpzK7-0005l9-9w
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:34:19 -0400
Received: by mail-wr0-x236.google.com with SMTP id u48so94963518wrc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:34:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Mar 2017 15:34:39 +0000
Message-Id: <20170320153441.2181-2-alex.bennee@linaro.org>
In-Reply-To: <20170320153441.2181-1-alex.bennee@linaro.org>
References: <20170320153441.2181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/3] cputlb: ensure tbl_set_dirty1 updates
 addr_write atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This was an oversight when the rest of cputlb was being updated. As
before it falls back to the non-atomic version when the host can't
support wider-than-bus atomics.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cputlb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cputlb.c b/cputlb.c
index f5d056cc08..0d52e45dfd 100644
--- a/cputlb.c
+++ b/cputlb.c
@@ -540,9 +540,17 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
 static inline void tlb_set_dirty1(CPUTLBEntry *tlb_entry, target_ulong vaddr)
 {
+#if TCG_OVERSIZED_GUEST
     if (tlb_entry->addr_write == (vaddr | TLB_NOTDIRTY)) {
         tlb_entry->addr_write = vaddr;
     }
+#else
+    uintptr_t orig_addr = atomic_mb_read(&tlb_entry->addr_write);
+
+    if (orig_addr == (vaddr | TLB_NOTDIRTY)) {
+        atomic_cmpxchg(&tlb_entry->addr_write, orig_addr, vaddr);
+    }
+#endif
 }
 
 /* update the TLB corresponding to virtual page vaddr
-- 
2.11.0
