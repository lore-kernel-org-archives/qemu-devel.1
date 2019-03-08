Received: from eggs.gnu.org ([209.51.188.92]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24mg-0006Wp-3g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h24md-0007gh-4E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:48 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:37173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h24mZ-0007SG-6U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:58:43 -0500
Received: by mail-pg1-x535.google.com with SMTP id q206so12794441pgq.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:58:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 17:58:29 -0800
Message-Id: <20190308015830.10980-2-richard.henderson@linaro.org>
In-Reply-To: <20190308015830.10980-1-richard.henderson@linaro.org>
References: <20190308015830.10980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] target/hppa: Do not return freed temporary
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

For priv levels 1 & 2, we were doing so from do_ibranch_priv.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
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
