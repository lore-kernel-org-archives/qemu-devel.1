Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006hw-Jm
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008Q2-Sg
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008Pl-Nk
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:19 -0400
Message-Id: <20181025172057.20414-11-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 10/48] exec: export do_tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

This will be used by plugin code to flush the code cache as well
as doing other bookkeeping in a safe work environment.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 1 +
 accel/tcg/translate-all.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 815e5b1e83..232e2f8966 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -427,6 +427,7 @@ void tb_invalidate_phys_range(target_ulong start, target_ulong end);
 void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs);
 #endif
 void tb_flush(CPUState *cpu);
+void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
                                    target_ulong cs_base, uint32_t flags,
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c8b3e0a491..db2d28f8d3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1230,7 +1230,7 @@ static gboolean tb_host_size_iter(gpointer key, gpointer value, gpointer data)
 }
 
 /* flush all the translation blocks */
-static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
+void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
 {
     mmap_lock();
     /* If it is already been done on request of another CPU,
-- 
2.17.1
