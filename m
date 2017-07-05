Received: from eggs.gnu.org ([2001:4830:134:3::10]:46857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX5-0004zU-MC
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX4-0007ro-QD
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:31 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeX4-0007r7-Ku
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:30 -0400
Received: by mail-wr0-x243.google.com with SMTP id x23so49173699wrb.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:30 -0700 (PDT)
Received: from 640k.lan (94-39-191-51.adsl-ull.clienti.tiscali.it.
	[94.39.191.51]) by smtp.gmail.com with ESMTPSA id
	y35sm22202793wrc.51.2017.07.05.00.15.28 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jul 2017 00:15:28 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:37 +0200
Message-Id: <1499238885-26161-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/42] exec: elide calls to tb_lock and tb_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Adding assertions fixes link errors.

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
