Received: from eggs.gnu.org ([2001:4830:134:3::10]:49587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2C-0003b5-2D
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYA2B-0003st-5O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYA2B-0003sd-0C
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:58:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 27 Jun 2018 13:58:42 +0100
Message-Id: <20180627125847.5413-2-stefanha@redhat.com>
In-Reply-To: <20180627125847.5413-1-stefanha@redhat.com>
References: <20180627125847.5413-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] trace: fix misreporting of TCG access sizes
 for user-space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

trace_mem_build_info expects a size_shift for its first argument. Fix it.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-id: 1527028012-21888-2-git-send-email-cota@braap.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/exec/cpu_ldst_useronly_template.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index c168f31bba..e30e58ed4a 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -33,20 +33,24 @@
 #define SUFFIX q
 #define USUFFIX q
 #define DATA_TYPE uint64_t
+#define SHIFT 3
 #elif DATA_SIZE == 4
 #define SUFFIX l
 #define USUFFIX l
 #define DATA_TYPE uint32_t
+#define SHIFT 2
 #elif DATA_SIZE == 2
 #define SUFFIX w
 #define USUFFIX uw
 #define DATA_TYPE uint16_t
 #define DATA_STYPE int16_t
+#define SHIFT 1
 #elif DATA_SIZE == 1
 #define SUFFIX b
 #define USUFFIX ub
 #define DATA_TYPE uint8_t
 #define DATA_STYPE int8_t
+#define SHIFT 0
 #else
 #error unsupported data size
 #endif
@@ -63,7 +67,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false));
 #endif
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 }
@@ -87,7 +91,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false));
 #endif
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 }
@@ -113,7 +117,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
 #if !defined(CODE_ACCESS)
     trace_guest_mem_before_exec(
         ENV_GET_CPU(env), ptr,
-        trace_mem_build_info(DATA_SIZE, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true));
 #endif
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
@@ -136,3 +140,4 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 #undef SUFFIX
 #undef USUFFIX
 #undef DATA_SIZE
+#undef SHIFT
-- 
2.17.1
