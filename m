Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlB-0006lh-E7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlA-0001w3-Hn
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlA-0001vj-BB
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id z45so47110826wrb.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:06 +0200
Message-Id: <1499166735-39360-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 13/22] exec: elide calls to tb_lock and
 tb_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Adding assertions fixes link errors.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/exec.c b/exec.c
index ee61915..a083ff8 100644
--- a/exec.c
+++ b/exec.c
@@ -2317,6 +2317,7 @@ static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
 {
     bool locked = false;
 
+    assert(tcg_enabled());
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         locked = true;
         tb_lock();
@@ -2375,6 +2376,7 @@ static void check_watchpoint(int offset, int len, MemTxAttrs attrs, int flags)
     CPUWatchpoint *wp;
     uint32_t cpu_flags;
 
+    assert(tcg_enabled());
     if (cpu->watchpoint_hit) {
         /* We re-entered the check after replacing the TB. Now raise
          * the debug interrupt so that is will trigger after the
@@ -2820,6 +2822,7 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
             cpu_physical_memory_range_includes_clean(addr, length, dirty_log_mask);
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
+        assert(tcg_enabled());
         tb_lock();
         tb_invalidate_phys_range(addr, addr + length);
         tb_unlock();
-- 
1.8.3.1
