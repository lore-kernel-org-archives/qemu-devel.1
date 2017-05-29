Received: from eggs.gnu.org ([2001:4830:134:3::10]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dFJXK-0001IY-2E
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dFJXG-0001ip-Tl
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:12:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dFJXG-0001ih-N7
	for qemu-devel@nongnu.org; Mon, 29 May 2017 08:12:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 29 May 2017 14:12:28 +0200
Message-Id: <20170529121228.2789-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] target/s390x: addressing exceptions are
 suppressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

We have to make the address in the old PSW point at the next
instruction, as addressing exceptions are suppressing and not
nullifying.

I assume that there are a lot of other broken cases (as most instructions
we care about are suppressing) - all trigger_pgm_exception() specifying
and explicit number or ILEN_LATER look suspicious, however this is another
story that might require bigger changes (and I have to understand when
the address might already have been incremented first).

This is needed to make an upcoming kvm-unit-test work.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 9978490..c09e391 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -204,7 +204,7 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     if (raddr > ram_size) {
         DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
                 (uint64_t)raddr, (uint64_t)ram_size);
-        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_LATER);
+        trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_LATER_INC);
         return 1;
     }
 
-- 
2.9.3
