Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eR-0003MN-Sv
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN6eQ-0001nk-Ki
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:11 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN6eQ-0001nW-Ek
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 20:04:10 -0400
Received: by mail-pg0-x243.google.com with SMTP id u62so12966309pgb.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 17:04:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 19 Jun 2017 17:03:49 -0700
Message-Id: <20170620000405.3391-3-rth@twiddle.net>
In-Reply-To: <20170620000405.3391-1-rth@twiddle.net>
References: <20170620000405.3391-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v3 02/18] target/s390x: change PSW_SHIFT_KEY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Such shifts are usually used to easily extract the PSW KEY from the PSW
mask, so let's avoid the confusing offset of 4.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170614133819.18480-2-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h       | 2 +-
 target/s390x/translate.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a4028fb..532a4a0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -315,7 +315,7 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define PSW_MASK_IO             0x0200000000000000ULL
 #define PSW_MASK_EXT            0x0100000000000000ULL
 #define PSW_MASK_KEY            0x00F0000000000000ULL
-#define PSW_SHIFT_KEY           56
+#define PSW_SHIFT_KEY           52
 #define PSW_MASK_MCHECK         0x0004000000000000ULL
 #define PSW_MASK_WAIT           0x0002000000000000ULL
 #define PSW_MASK_PSTATE         0x0001000000000000ULL
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index af18ffb..204b52a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3751,7 +3751,7 @@ static ExitStatus op_spka(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
     tcg_gen_shri_i64(o->in2, o->in2, 4);
-    tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY - 4, 4);
+    tcg_gen_deposit_i64(psw_mask, psw_mask, o->in2, PSW_SHIFT_KEY, 4);
     return NO_EXIT;
 }
 
-- 
2.9.4
