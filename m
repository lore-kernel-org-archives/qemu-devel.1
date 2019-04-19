Received: from eggs.gnu.org ([209.51.188.92]:51191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYQ7-0006Sj-TK
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hHYPt-0003wi-8e
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:19 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56051 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hHYPp-0003Lw-DP
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 14:39:15 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Apr 2019 20:37:58 +0200
Message-Id: <1555699081-24577-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1555699081-24577-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/5] target/mips: Make the results of
 MOD_<U|S>.<B|H|W|D> the same as on hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

MSA instructions MOD_<U|S>.<B|H|W|D> when dividing by zero,
didn't return the same value when executed on a referent hardware
(FPGA MIPS 64 r6, little endian) and when executed on QEMU, which
is not a real bug, because the result when dividing by zero is
UNPREDICTABLE [1] (page 255, 256).

[1] MIPS Architecture for Programmers
    Volume IV-j: The MIPS64 SIMD
    Architecture Module, Revision 1.12

Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1554207110-9113-3-git-send-email-mateja.marjanovic@rt-rk.com>
---
 target/mips/msa_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index fec4db9..ee1b1fa 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -657,14 +657,14 @@ static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t arg2)
     if (arg1 == DF_MIN_INT(df) && arg2 == -1) {
         return 0;
     }
-    return arg2 ? arg1 % arg2 : 0;
+    return arg2 ? arg1 % arg2 : arg1;
 }
 
 static inline int64_t msa_mod_u_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     uint64_t u_arg1 = UNSIGNED(arg1, df);
     uint64_t u_arg2 = UNSIGNED(arg2, df);
-    return u_arg2 ? u_arg1 % u_arg2 : 0;
+    return u_arg2 ? u_arg1 % u_arg2 : u_arg1;
 }
 
 #define SIGNED_EVEN(a, df) \
-- 
2.7.4
