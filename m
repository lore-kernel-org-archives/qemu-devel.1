Received: from eggs.gnu.org ([2001:4830:134:3::10]:48942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdCXW-0006gt-11
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fdCXS-0007VE-Tm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:40:06 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:38731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fdCXS-0007V2-Lu
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 06:40:02 -0400
Received: by mail-pg1-x532.google.com with SMTP id k3-v6so2794693pgq.5
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 03:40:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 11 Jul 2018 03:39:57 -0700
Message-Id: <20180711103957.3040-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] target/arm: Fix LD1W and LDFF1W
 (scalar plus vector)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

'I' was being double-incremented; correctly within the inner loop
and incorrectly within the outer loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Fixes a SIGSEGV within one of these generated helpers,
exposed by an armclang vectorized code sample.


r~

---
 target/arm/sve_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cec0d3ee54..ddc592ff79 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4855,7 +4855,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
     intptr_t i, oprsz = simd_oprsz(desc);                               \
     unsigned scale = simd_data(desc);                                   \
     uintptr_t ra = GETPC();                                             \
-    for (i = 0; i < oprsz; i++) {                                       \
+    for (i = 0; i < oprsz; ) {                                          \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
         do {                                                            \
             TYPEM m = 0;                                                \
@@ -4936,7 +4936,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
     uintptr_t ra = GETPC();                                             \
     bool first = true;                                                  \
     mmap_lock();                                                        \
-    for (i = 0; i < oprsz; i++) {                                       \
+    for (i = 0; i < oprsz; ) {                                          \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
         do {                                                            \
             TYPEM m = 0;                                                \
-- 
2.17.1
