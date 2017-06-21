Received: from eggs.gnu.org ([2001:4830:134:3::10]:55922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNckb-0002gd-DF
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dNcka-0005Dh-2I
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:6553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dNckZ-0004zB-JS
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 06:20:39 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 21 Jun 2017 18:19:59 +0800
Message-Id: <1498040401-16361-14-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
References: <1498040401-16361-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH 13/15] tcg: disable tcg in CPUX86State struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, a.rigo@virtualopensystems.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

Add the CONFIG_TCG for CPU_COMMON_TLB in the CPUX86State struct.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 include/exec/cpu-defs.h | 4 +++-
 target/i386/cpu.h       | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

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
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 229b216..d67b601 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,7 +52,9 @@
 
 #include "exec/cpu-defs.h"
 
+#ifdef CONFIG_TCG
 #include "fpu/softfloat.h"
+#endif
 
 #define R_EAX 0
 #define R_ECX 1
@@ -1130,8 +1132,9 @@ typedef struct CPUX86State {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
-
+#ifdef CONFIG_TCG
     CPU_COMMON
+#endif
 
     /* Fields after CPU_COMMON are preserved across CPU reset. */
 
-- 
1.9.1
