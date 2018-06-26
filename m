Received: from eggs.gnu.org ([2001:4830:134:3::10]:41311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1fXrwF-0005Tl-OS
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexandro@phi.nz>) id 1fXrwA-0001uK-Sy
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:39:35 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alexandro@phi.nz>) id 1fXrwA-0001tb-Lr
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:39:30 -0400
From: "Alexandro Sanchez Bach" <alexandro@phi.nz>
References: 
In-Reply-To: 
Date: Tue, 26 Jun 2018 19:39:25 +0200
Message-ID: <002201d40d74$a1b4b8d0$e51e2a70$@phi.nz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: Re: [Qemu-devel] [PATCH] target/i386: Fixed CR0.TS check in gen_sse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, 'Paolo Bonzini' <pbonzini@redhat.com>, peter.maydell@linaro.org

Ping.

-----Original Message-----
From: Alexandro Sanchez Bach <alexandro@phi.nz> 
Sent: Tuesday, May 29, 2018 12:20
To: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>
Subject: [PATCH] target/i386: Fixed CR0.TS check in gen_sse

The function `gen_sse` assumes all of its instructions require CR0.TS=0.
However, integer extensions at `0F 38 F[0-F]` and `0F 3A F[0-F]` such as
CRC32, MOVBE, ADX, BMI1, BMI2 that are handled by `gen_sse` are not supposed
to throw an exception in this scenario. This causes issues while booting
some FreeBSD-based guests.

Reported-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Signed-off-by: Alexandro Sanchez Bach <alexandro@phi.nz>
Cc: qemu-stable@nongnu.org
diff --git a/target/i386/translate.c b/target/i386/translate.c index
7c21814676..079ab7afef 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3049,8 +3049,16 @@ static void gen_sse(CPUX86State *env, DisasContext
*s, int b,
             is_xmm = 1;
         }
     }
+
+    modrm = x86_ldub_code(env, s);
+    reg = ((modrm >> 3) & 7);
+    if (is_xmm)
+        reg |= rex_r;
+    mod = (modrm >> 6) & 3;
+
     /* simple MMX/SSE operation */
-    if (s->flags & HF_TS_MASK) {
+    if (s->flags & HF_TS_MASK
+        && ((b != 0x38 && b != 0x3A) || !(modrm & 0xF0))) {
         gen_exception(s, EXCP07_PREX, pc_start - s->cs_base);
         return;
     }
@@ -3084,11 +3092,6 @@ static void gen_sse(CPUX86State *env, DisasContext
*s, int b,
         gen_helper_enter_mmx(cpu_env);
     }
 
-    modrm = x86_ldub_code(env, s);
-    reg = ((modrm >> 3) & 7);
-    if (is_xmm)
-        reg |= rex_r;
-    mod = (modrm >> 6) & 3;
     if (sse_fn_epp == SSE_SPECIAL) {
         b |= (b1 << 8);
         switch(b) {
