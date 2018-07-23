Received: from eggs.gnu.org ([2001:4830:134:3::10]:43304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKz-0004AO-42
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKy-0005Vk-8V
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:45 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:34 -0500
Message-Id: <20180723201748.25573-86-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 85/99] target/arm: Fix sqrt_f16 exception
 raising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Alex Bennée <alex.bennee@linaro.org>

We are meant to explicitly pass fpst, not cpu_env.

Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20180512003217.9105-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 905edee9101c54cda5b72286b7f7607cf1c3c4d1)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f4587c3814..618f5268cc 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4733,7 +4733,8 @@ static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
         tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
         break;
     case 0x3: /* FSQRT */
-        gen_helper_sqrt_f16(tcg_res, tcg_op, cpu_env);
+        fpst = get_fpstatus_ptr(true);
+        gen_helper_sqrt_f16(tcg_res, tcg_op, fpst);
         break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
-- 
2.17.1
