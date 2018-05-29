Received: from eggs.gnu.org ([2001:4830:134:3::10]:37125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDY-0001o2-RO
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcDV-0004Es-G8
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:04 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:38301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcDV-0004EB-9S
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:51:01 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 94-v6so24688382wrf.5
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:51:01 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:50:01 +0200
Message-Id: <20180529105011.1914-29-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v1 28/38] target-microblaze: dec_msr: Plug a
 temp leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug a temp leak.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7475003847..756d901eba 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -516,12 +516,17 @@ static void dec_msr(DisasContext *dc)
 #if !defined(CONFIG_USER_ONLY)
     /* Catch read/writes to the mmu block.  */
     if ((sr & ~0xff) == 0x1000) {
+        TCGv_i32 tmp_sr;
+
         sr &= 7;
+        tmp_sr = tcg_const_i32(sr);
         LOG_DIS("m%ss sr%d r%d imm=%x\n", to ? "t" : "f", sr, dc->ra, dc->imm);
-        if (to)
-            gen_helper_mmu_write(cpu_env, tcg_const_i32(sr), cpu_R[dc->ra]);
-        else
-            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tcg_const_i32(sr));
+        if (to) {
+            gen_helper_mmu_write(cpu_env, tmp_sr, cpu_R[dc->ra]);
+        } else {
+            gen_helper_mmu_read(cpu_R[dc->rd], cpu_env, tmp_sr);
+        }
+        tcg_temp_free_i32(tmp_sr);
         return;
     }
 #endif
-- 
2.14.1
