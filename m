Received: from eggs.gnu.org ([2001:4830:134:3::10]:40529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d9ZR3-0000ZD-5X
	for qemu-devel@nongnu.org; Sat, 13 May 2017 11:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d9ZQy-0007c0-AL
	for qemu-devel@nongnu.org; Sat, 13 May 2017 11:58:25 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:34400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d9ZQy-0007aD-4Q
	for qemu-devel@nongnu.org; Sat, 13 May 2017 11:58:20 -0400
Received: by mail-yw0-x241.google.com with SMTP id 17so3275179ywk.1
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 08:58:18 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 13 May 2017 11:58:16 -0400
Message-Id: <20170513155816.17294-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg/i386: 'nop' instruction with 'lock' prefix
 is illegal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

The instruction "lock nopl (%rax)" should raise an exception. However,
we don't do that since we do not check for lock prefix for nop
instructions. The following patch adds this check and makes the
behavior similar to hardware.

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/i386/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1d1372fb43..76f4ccd3b4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7881,6 +7881,9 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x119: case 0x11c ... 0x11f: /* nop (multi byte) */
+        if (prefixes & PREFIX_LOCK) {
+            goto illegal_op;
+        }
         modrm = cpu_ldub_code(env, s->pc++);
         gen_nop_modrm(env, s, modrm);
         break;
-- 
2.13.0
