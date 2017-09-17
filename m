Received: from eggs.gnu.org ([2001:4830:134:3::10]:52396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8o-0007yf-DY
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtb8j-00086j-GY
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:50 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:56901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtb8j-00085s-A1
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:05:45 -0400
Received: by mail-oi0-x22b.google.com with SMTP id y195so3686575oia.13
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:05:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 17 Sep 2017 08:05:19 -0700
Message-Id: <20170917150535.8284-2-richard.henderson@linaro.org>
In-Reply-To: <20170917150535.8284-1-richard.henderson@linaro.org>
References: <20170917150535.8284-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/17] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):

tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target':
include/qemu/compiler.h:86:30: error: static assertion failed: \
  "not expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
	QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
	^
tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'atomic_set'
	atomic_set((uint64_t *)jmp_addr, pair);
	^

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170911204936.5020-1-f4bug@amsat.org>
[rth: Added commentary requested by pmm.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 21d764c102..3c9355844a 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1374,7 +1374,9 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
         pair = (uint64_t)i2 << 32 | i1;
 #endif
 
-        atomic_set((uint64_t *)jmp_addr, pair);
+        /* As per the enclosing if, this is ppc64.  Avoid the _Static_assert
+           within atomic_set that would fail to build a ppc32 host.  */
+        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
         flush_icache_range(jmp_addr, jmp_addr + 8);
     } else {
         intptr_t diff = addr - jmp_addr;
-- 
2.13.5
