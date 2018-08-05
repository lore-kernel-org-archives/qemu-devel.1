Received: from eggs.gnu.org ([2001:4830:134:3::10]:40068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNmA-00068M-9a
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNm9-0005Or-C4
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:10 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sun,  5 Aug 2018 14:28:29 -0400
Message-Id: <20180805182832.3012-5-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 4/6] target/s390x: add EX support for TRT and
 TRTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

Improves "b213c9f5: target/s390x: Implement TRTR" by introducing the
intermediate functions, which are compatible with dx_helper type.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/mem_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index c94dbf3fcb..704d0193b5 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1299,12 +1299,26 @@ static inline uint32_t do_helper_trt(CPUS390XState *env, int len,
     return 0;
 }
 
+static uint32_t do_helper_trt_fwd(CPUS390XState *env, uint32_t len,
+                                  uint64_t array, uint64_t trans,
+                                  uintptr_t ra)
+{
+    return do_helper_trt(env, len, array, trans, 1, ra);
+}
+
 uint32_t HELPER(trt)(CPUS390XState *env, uint32_t len, uint64_t array,
                      uint64_t trans)
 {
     return do_helper_trt(env, len, array, trans, 1, GETPC());
 }
 
+static uint32_t do_helper_trt_bkwd(CPUS390XState *env, uint32_t len,
+                                   uint64_t array, uint64_t trans,
+                                   uintptr_t ra)
+{
+    return do_helper_trt(env, len, array, trans, -1, ra);
+}
+
 uint32_t HELPER(trtr)(CPUS390XState *env, uint32_t len, uint64_t array,
                       uint64_t trans)
 {
@@ -2193,12 +2207,14 @@ void HELPER(ex)(CPUS390XState *env, uint32_t ilen, uint64_t r1, uint64_t addr)
         typedef uint32_t (*dx_helper)(CPUS390XState *, uint32_t, uint64_t,
                                       uint64_t, uintptr_t);
         static const dx_helper dx[16] = {
+            [0x0] = do_helper_trt_bkwd,
             [0x2] = do_helper_mvc,
             [0x4] = do_helper_nc,
             [0x5] = do_helper_clc,
             [0x6] = do_helper_oc,
             [0x7] = do_helper_xc,
             [0xc] = do_helper_tr,
+            [0xd] = do_helper_trt_fwd,
         };
         dx_helper helper = dx[opc & 0xf];
 
-- 
2.16.2.windows.1
