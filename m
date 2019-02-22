Received: from eggs.gnu.org ([209.51.188.92]:42254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx4Aq-0002zB-RD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:19:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gx3xs-0003H2-7m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:05:40 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gx3xr-00030H-St
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 01:05:40 -0500
Received: by mail-pl1-x641.google.com with SMTP id r14so580125pls.12
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 22:05:09 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-188-82.tukw.qwest.net.
	[97.113.188.82]) by smtp.gmail.com with ESMTPSA id
	f67sm1452522pfc.141.2019.02.21.22.05.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 21 Feb 2019 22:05:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 21 Feb 2019 22:05:03 -0800
Message-Id: <20190222060504.17715-2-richard.henderson@linaro.org>
In-Reply-To: <20190222060504.17715-1-richard.henderson@linaro.org>
References: <20190222060504.17715-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/hppa: Do not return freed temporary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For priv levels 1 & 2, we were doing so from do_ibranch_priv.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b4fd307b77..dad8ce563c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2007,16 +2007,15 @@ static TCGv_reg do_ibranch_priv(DisasContext *ctx, TCGv_reg offset)
         /* Privilege 0 is maximum and is allowed to decrease.  */
         return offset;
     case 3:
-        /* Privilege 3 is minimum and is never allowed increase.  */
+        /* Privilege 3 is minimum and is never allowed to increase.  */
         dest = get_temp(ctx);
         tcg_gen_ori_reg(dest, offset, 3);
         break;
     default:
-        dest = tcg_temp_new();
+        dest = get_temp(ctx);
         tcg_gen_andi_reg(dest, offset, -4);
         tcg_gen_ori_reg(dest, dest, ctx->privilege);
         tcg_gen_movcond_reg(TCG_COND_GTU, dest, dest, offset, dest, offset);
-        tcg_temp_free(dest);
         break;
     }
     return dest;
-- 
2.17.2
