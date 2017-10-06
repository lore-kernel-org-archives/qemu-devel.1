Received: from eggs.gnu.org ([2001:4830:134:3::10]:58738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR2-0005ux-Mg
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PR1-0007f5-Sc
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PR1-0007eL-MD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:00:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:34 +0200
Message-Id: <20171006095956.27534-12-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/33] s390x/tcg: fix checking for invalid
 memory check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

It should have been a >=, but let's directly perform a proper access
check to also be able to deal with hotplugged memory later.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170926183318.12995-2-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
2.13.6
