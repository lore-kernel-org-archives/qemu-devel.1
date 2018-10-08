Received: from eggs.gnu.org ([2001:4830:134:3::10]:57892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9d4T-000505-2N
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g9cyq-00089u-OG
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:46167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g9cyo-00087z-Mw
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:22:18 -0400
Received: by mail-pg1-x535.google.com with SMTP id a5-v6so8358658pgv.13
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 14:22:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  8 Oct 2018 14:22:00 -0700
Message-Id: <20181008212205.17752-6-richard.henderson@linaro.org>
In-Reply-To: <20181008212205.17752-1-richard.henderson@linaro.org>
References: <20181008212205.17752-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/10] target/arm: Fix cortex-a7 id_isar0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The incorrect value advertised only thumb2 div without arm div.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ac46641541..83a6cb535f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1587,7 +1587,10 @@ static void cortex_a7_initfn(Object *obj)
     cpu->id_mmfr1 = 0x40000000;
     cpu->id_mmfr2 = 0x01240000;
     cpu->id_mmfr3 = 0x02102211;
-    cpu->id_isar0 = 0x01101110;
+    /* a7_mpcore_r0p5_trm, page 4-4 gives 0x01101110; but
+     * table 4-41 gives 0x02101110, which includes the arm div insns.
+     */
+    cpu->id_isar0 = 0x02101110;
     cpu->id_isar1 = 0x13112111;
     cpu->id_isar2 = 0x21232041;
     cpu->id_isar3 = 0x11112131;
-- 
2.17.1
