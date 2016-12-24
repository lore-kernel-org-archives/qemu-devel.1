Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW1-0006d2-U8
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW1-0005cd-BC
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:02 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdW1-0005cP-62
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:01 -0500
Received: by mail-pg0-x242.google.com with SMTP id g1so2479184pgn.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:00 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.00.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:00:59 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 19:59:56 -0800
Message-Id: <20161224040042.12654-20-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 19/65] tcg/optimize: Fold movcond 0/1 into
 setcond
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/optimize.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f41ed2c..9e26bb7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1105,6 +1105,21 @@ void tcg_optimize(TCGContext *s)
                 tcg_opt_gen_mov(s, op, args, args[0], args[4-tmp]);
                 break;
             }
+            if (temp_is_const(args[3]) && temp_is_const(args[4])) {
+                tcg_target_ulong tv = temps[args[3]].val;
+                tcg_target_ulong fv = temps[args[4]].val;
+                TCGCond cond = args[5];
+                if (fv == 1 && tv == 0) {
+                    cond = tcg_invert_cond(cond);
+                } else if (!(tv == 1 && fv == 0)) {
+                    goto do_default;
+                }
+                args[3] = cond;
+                op->opc = opc = (opc == INDEX_op_movcond_i32
+                                 ? INDEX_op_setcond_i32
+                                 : INDEX_op_setcond_i64);
+                nb_iargs = 2;
+            }
             goto do_default;
 
         case INDEX_op_add2_i32:
-- 
2.9.3
