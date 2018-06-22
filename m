Received: from eggs.gnu.org ([2001:4830:134:3::10]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWOjd-0007Ny-N6
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fWOja-0005ns-Gg
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:16:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fWOja-0005nT-8u
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:16:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 22 Jun 2018 12:16:23 -0400
Message-Id: <1529684183-17385-1-git-send-email-cota@braap.org>
In-Reply-To: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
References: <CAFEAcA_gYh6RTZb30pzritv-RP3uHc+JjBkb_AsipcmcL7=d5A@mail.gmail.com>
Subject: [Qemu-devel] [PATCH] tcg: fix --disable-tcg build breakage
 introduced by tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Tested to build x86_64-softmmu and i386-softmmu targets.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/stubs/tcg-stub.c | 4 ----
 exec.c                 | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index ee575a8..76ae461 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -21,10 +21,6 @@ void tb_flush(CPUState *cpu)
 {
 }
 
-void tb_unlock(void)
-{
-}
-
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
diff --git a/exec.c b/exec.c
index 28f9bdc..3baa3dc 100644
--- a/exec.c
+++ b/exec.c
@@ -2645,18 +2645,22 @@ void memory_notdirty_write_prepare(NotDirtyInfo *ndi,
     ndi->pages = NULL;
 
     assert(tcg_enabled());
+#ifdef CONFIG_TCG
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         ndi->pages = page_collection_lock(ram_addr, ram_addr + size);
         tb_invalidate_phys_page_fast(ndi->pages, ram_addr, size);
     }
+#endif
 }
 
 /* Called within RCU critical section. */
 void memory_notdirty_write_complete(NotDirtyInfo *ndi)
 {
     if (ndi->pages) {
+#ifdef CONFIG_TCG
         page_collection_unlock(ndi->pages);
         ndi->pages = NULL;
+#endif
     }
 
     /* Set both VGA and migration bits for simplicity and to remove
-- 
2.7.4
