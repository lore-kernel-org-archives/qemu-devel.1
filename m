Received: from eggs.gnu.org ([2001:4830:134:3::10]:55523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWE-0006q4-00
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWD-0005oR-8r
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:14 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWD-0005o5-3q
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:13 -0500
Received: by mail-pg0-x243.google.com with SMTP id g1so2479604pgn.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:12 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:10 -0800
Message-Id: <20161224040042.12654-34-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 33/65] target-s390x: Use clz opcode
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
 target/s390x/helper.h     | 1 -
 target/s390x/int_helper.c | 6 ------
 target/s390x/translate.c  | 2 +-
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 207a6e7..9102071 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -70,7 +70,6 @@ DEF_HELPER_FLAGS_4(msdb, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_3(tceb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_3(tcdb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_4(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64, i64)
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 370c94d..5bc470b 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -117,12 +117,6 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     return ret;
 }
 
-/* count leading zeros, for find leftmost one */
-uint64_t HELPER(clz)(uint64_t v)
-{
-    return clz64(v);
-}
-
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6cebb7e..01c6217 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2249,7 +2249,7 @@ static ExitStatus op_flogr(DisasContext *s, DisasOps *o)
     gen_op_update1_cc_i64(s, CC_OP_FLOGR, o->in2);
 
     /* R1 = IN ? CLZ(IN) : 64.  */
-    gen_helper_clz(o->out, o->in2);
+    tcg_gen_clzi_i64(o->out, o->in2, 64);
 
     /* R1+1 = IN & ~(found bit).  Note that we may attempt to shift this
        value by 64, which is undefined.  But since the shift is 64 iff the
-- 
2.9.3
