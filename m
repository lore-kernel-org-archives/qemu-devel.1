Received: from eggs.gnu.org ([2001:4830:134:3::10]:54925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06p-0005rz-8Y
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06o-0003xP-H8
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:43 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06o-0003xB-D9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:42 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so21495221qke.2
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:42 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:01 -0700
Message-Id: <20170523030312.6360-21-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 20/31] target/s390x: Use unwind data for
 helper_tr
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
 target/s390x/mem_helper.c | 10 +++++-----
 target/s390x/translate.c  |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index d37e691..748a6e8 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -707,13 +707,13 @@ void HELPER(unpk)(CPUS390XState *env, uint32_t len, uint64_t dest,
 void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
                 uint64_t trans)
 {
-    int i;
+    uintptr_t ra = GETPC();
+    uint32_t i;
 
     for (i = 0; i <= len; i++) {
-        uint8_t byte = cpu_ldub_data(env, array + i);
-        uint8_t new_byte = cpu_ldub_data(env, trans + byte);
-
-        cpu_stb_data(env, array + i, new_byte);
+        uint8_t byte = cpu_ldub_data_ra(env, array + i, ra);
+        uint8_t new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
+        cpu_stb_data_ra(env, array + i, new_byte, ra);
     }
 }
 
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e8eefec..b506cee 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4070,7 +4070,6 @@ static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
 static ExitStatus op_tr(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_tr(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     set_cc_static(s);
-- 
2.9.4
