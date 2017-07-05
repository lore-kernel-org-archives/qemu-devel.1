Received: from eggs.gnu.org ([2001:4830:134:3::10]:46873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX7-000512-6I
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeX6-0007sh-3z
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:33 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeX5-0007sA-Ti
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:32 -0400
Received: by mail-wr0-x243.google.com with SMTP id k67so48981001wrc.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:38 +0200
Message-Id: <1499238885-26161-36-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 35/42] tcg: add CONFIG_TCG guards in headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>

From: Yang Zhong <yang.zhong@intel.com>

Add CONFIG_TCG around TLB-related functions and structure declarations.
Some of these functions are defined in ./accel/tcg/cputlb.c, which will
not be linked in if TCG is disabled, and have no stubs; therefore, their
callers will also be compiled out for --disable-tcg.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/cpu-defs.h | 4 +++-
 include/exec/exec-all.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 5f4e303..bc8e7f8 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -25,7 +25,9 @@
 
 #include "qemu/host-utils.h"
 #include "qemu/queue.h"
+#ifdef CONFIG_TCG
 #include "tcg-target.h"
+#endif
 #ifndef CONFIG_USER_ONLY
 #include "exec/hwaddr.h"
 #endif
@@ -54,7 +56,7 @@ typedef uint64_t target_ulong;
 #error TARGET_LONG_SIZE undefined
 #endif
 
-#if !defined(CONFIG_USER_ONLY)
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* use a fully associative victim tlb of 8 entries */
 #define CPU_VTLB_SIZE 8
 
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0b56432..8096d64 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -82,6 +82,9 @@ void cpu_reloading_memory_map(void);
  * Note that with KVM only one address space is supported.
  */
 void cpu_address_space_init(CPUState *cpu, AddressSpace *as, int asidx);
+#endif
+
+#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
 /* cputlb.c */
 /**
  * tlb_flush_page:
-- 
1.8.3.1
