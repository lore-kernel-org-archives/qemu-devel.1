Received: from eggs.gnu.org ([209.51.188.92]:60480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2QLY-00013b-Lc
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2QLX-0004b6-HD
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:00:16 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2QLX-0004aD-61
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 20:00:15 -0500
Received: by mail-wr1-x444.google.com with SMTP id t18so23193298wrx.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 17:00:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d38e7159-8395-5d35-92a0-549f509f4863@amsat.org>
Date: Sat, 9 Mar 2019 02:00:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190307144126.31847-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/9] tcg: Use extract2 in tcg_gen_shifti_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: david@redhat.com

Hi Richard,

On 3/7/19 3:41 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
> index deacc63e3b..34e0dbc6e0 100644
> --- a/tcg/tcg-op.c
> +++ b/tcg/tcg-op.c
> @@ -1355,31 +1355,32 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
>              tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
>              tcg_gen_movi_i32(TCGV_LOW(ret), 0);
>          }
> -    } else {
> -        TCGv_i32 t0, t1;
> -
> -        t0 = tcg_temp_new_i32();
> -        t1 = tcg_temp_new_i32();
> -        if (right) {
> -            tcg_gen_shli_i32(t0, TCGV_HIGH(arg1), 32 - c);
> -            if (arith) {
> -                tcg_gen_sari_i32(t1, TCGV_HIGH(arg1), c);
> -            } else {
> -                tcg_gen_shri_i32(t1, TCGV_HIGH(arg1), c);
> -            }
> -            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
> -            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t0);
> -            tcg_gen_mov_i32(TCGV_HIGH(ret), t1);
> +    } else if (right) {
> +        if (TCG_TARGET_HAS_extract2_i32) {
> +            tcg_gen_extract2_i32(TCGV_LOW(ret), TCGV_LOW(arg1),
> +                                 TCGV_HIGH(arg1), c);
>          } else {
> -            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
> -            /* Note: ret can be the same as arg1, so we use t1 */
> -            tcg_gen_shli_i32(t1, TCGV_LOW(arg1), c);
> -            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> -            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t0);
> -            tcg_gen_mov_i32(TCGV_LOW(ret), t1);
> +            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
> +            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
> +                                TCGV_HIGH(arg1), 32 - c, c);
>          }
> -        tcg_temp_free_i32(t0);
> -        tcg_temp_free_i32(t1);
> +        if (arith) {
> +            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> +        } else {
> +            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
> +        }
> +    } else {
> +        if (TCG_TARGET_HAS_extract2_i32) {
> +            tcg_gen_extract2_i32(TCGV_HIGH(ret), TCGV_LOW(arg1),
> +                                 TCGV_HIGH(arg1), 32 - c);
> +        } else {
> +            TCGv_i32 t0 = tcg_temp_new_i32();
> +            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
> +            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
> +                                TCGV_HIGH(arg1), c, 32 - c);
> +            tcg_temp_free_i32(t0);
> +        }
> +        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
>      }
>  }

I find this patch quite hard to review because you somehow do more than
simply use extract2, you also reordered part of this function.

I find it easier to review as split in 2 commits:

1/ reorder; the code movement is way easier to follow:

-- >8 --
@@ -1355,31 +1355,22 @@ static inline void tcg_gen_shifti_i64(TCGv_i64
ret, TCGv_i64 arg1,
             tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_LOW(arg1), c);
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
-    } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_new_i32();
-        t1 = tcg_temp_new_i32();
-        if (right) {
-            tcg_gen_shli_i32(t0, TCGV_HIGH(arg1), 32 - c);
-            if (arith) {
-                tcg_gen_sari_i32(t1, TCGV_HIGH(arg1), c);
-            } else {
-                tcg_gen_shri_i32(t1, TCGV_HIGH(arg1), c);
-            }
-            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-            tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(ret), t0);
-            tcg_gen_mov_i32(TCGV_HIGH(ret), t1);
+    } else if (right) {
+        tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
+        tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
+                            TCGV_HIGH(arg1), 32 - c, c);
+        if (arith) {
+            tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         } else {
-            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-            /* Note: ret can be the same as arg1, so we use t1 */
-            tcg_gen_shli_i32(t1, TCGV_LOW(arg1), c);
-            tcg_gen_shli_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
-            tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(ret), t0);
-            tcg_gen_mov_i32(TCGV_LOW(ret), t1);
+            tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
+    } else {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
+        tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
+                            TCGV_HIGH(arg1), c, 32 - c);
         tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
---

2/ use extract2:

-- >8 --
@@ -1356,20 +1356,30 @@ static inline void tcg_gen_shifti_i64(TCGv_i64
ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
-        tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
-                            TCGV_HIGH(arg1), 32 - c, c);
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_LOW(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
+        } else {
+            tcg_gen_shri_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
+            tcg_gen_deposit_i32(TCGV_LOW(ret), TCGV_LOW(ret),
+                                TCGV_HIGH(arg1), 32 - c, c);
+        }
         if (arith) {
             tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         } else {
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
-        tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
-                            TCGV_HIGH(arg1), c, 32 - c);
-        tcg_temp_free_i32(t0);
+        if (TCG_TARGET_HAS_extract2_i32) {
+            tcg_gen_extract2_i32(TCGV_HIGH(ret),
+                                 TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
+        } else {
+            TCGv_i32 t0 = tcg_temp_new_i32();
+            tcg_gen_shri_i32(t0, TCGV_LOW(arg1), 32 - c);
+            tcg_gen_deposit_i32(TCGV_HIGH(ret), t0,
+                                TCGV_HIGH(arg1), c, 32 - c);
+            tcg_temp_free_i32(t0);
+        }
         tcg_gen_shli_i32(TCGV_LOW(ret), TCGV_LOW(arg1), c);
     }
 }
---

Note that I indented the extract2 slighly differently,
TCGV_LOW(arg1) and TCGV_HIGH(arg1) are now together on the same line.
My brain find it more digestible :)

Regards,

Phil.
