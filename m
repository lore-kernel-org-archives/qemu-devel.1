Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv45-0003Xn-EZ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv44-0002OR-IG
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:33 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:00:10 +0100
Message-Id: <20180710160013.26559-4-peter.maydell@linaro.org>
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] accel/tcg: Handle get_page_addr_code()
 returning -1 in tb_check_watchpoint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

When we support execution from non-RAM MMIO regions, get_page_addr_code()
will return -1 to indicate that there is no RAM at the requested address.
Handle this in tb_check_watchpoint() -- if the exception happened for a
PC which doesn't correspond to RAM then there is no need to invalidate
any TBs, because the one-instruction TB will not have been cached.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/translate-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 49d77fad44e..d18018fa99d 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2121,7 +2121,9 @@ void tb_check_watchpoint(CPUState *cpu)
 
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         addr = get_page_addr_code(env, pc);
-        tb_invalidate_phys_range(addr, addr + 1);
+        if (addr != -1) {
+            tb_invalidate_phys_range(addr, addr + 1);
+        }
     }
 }
 
-- 
2.17.1
