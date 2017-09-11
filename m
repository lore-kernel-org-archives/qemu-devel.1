Received: from eggs.gnu.org ([2001:4830:134:3::10]:58366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVeQ-00051L-Vz
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVeN-0004J1-Tw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:49:51 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:38211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVeN-0004Is-Pj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 16:49:47 -0400
Received: by mail-qk0-x22a.google.com with SMTP id a128so21261633qkc.5
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:49:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 17:49:36 -0300
Message-Id: <20170911204936.5020-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

this fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):

  qemu/tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target':
  qemu/include/qemu/compiler.h:86:30: error: static assertion failed: "not expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
       QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
       ^
  qemu/tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'atomic_set'
           atomic_set((uint64_t *)jmp_addr, pair);
           ^

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
This fixes Shippable builds, see:
https://app.shippable.com/github/qemu/qemu/runs/434/10/console

 tcg/ppc/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 21d764c102..0417901289 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -1374,7 +1374,7 @@ void tb_target_set_jmp_target(uintptr_t tc_ptr, uintptr_t jmp_addr,
         pair = (uint64_t)i2 << 32 | i1;
 #endif
 
-        atomic_set((uint64_t *)jmp_addr, pair);
+        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
         flush_icache_range(jmp_addr, jmp_addr + 8);
     } else {
         intptr_t diff = addr - jmp_addr;
-- 
2.14.1
