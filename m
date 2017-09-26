Received: from eggs.gnu.org ([2001:4830:134:3::10]:45115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwuff-0004Ng-2G
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dwufe-0003SA-BG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dwufe-0003Rf-5O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 14:33:26 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Sep 2017 20:33:13 +0200
Message-Id: <20170926183318.12995-2-david@redhat.com>
In-Reply-To: <20170926183318.12995-1-david@redhat.com>
References: <20170926183318.12995-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/6] s390x/tcg: fix checking for invalid
 memory check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

It should have been a >=, but let's directly perform a proper access
check to also be able to deal with hotplugged memory later.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/excp_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 470cf8f5bc..308605d9ed 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "hw/s390x/ioinst.h"
+#include "exec/address-spaces.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/sysemu.h"
 #endif
@@ -108,7 +109,8 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
     }
 
     /* check out of RAM access */
-    if (raddr > ram_size) {
+    if (!address_space_access_valid(&address_space_memory, raddr,
+                                    TARGET_PAGE_SIZE, rw)) {
         DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
                 (uint64_t)raddr, (uint64_t)ram_size);
         trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
-- 
2.13.5
