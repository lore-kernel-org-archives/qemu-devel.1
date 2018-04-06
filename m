Received: from eggs.gnu.org ([2001:4830:134:3::10]:36546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Uu2-00089h-1f
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1f4Utz-00083V-B2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:53 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1f4Utz-00081n-3D
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:11:51 -0400
Received: by mail-wr0-x244.google.com with SMTP id s12so2403476wrc.8
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 10:11:51 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  6 Apr 2018 19:11:21 +0200
Message-Id: <1523034681-33787-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/20] Add missing bit for SSE instr in VEX
 decoding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eugene Minibaev <mail@kitsu.me>

From: Eugene Minibaev <mail@kitsu.me>

The 2-byte VEX prefix imples a leading 0Fh opcode byte.

Signed-off-by: Eugene Minibaev <mail@kitsu.me>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 3b7ce92..c9ed8dc 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4563,9 +4563,11 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
 #endif
             rex_r = (~vex2 >> 4) & 8;
             if (b == 0xc5) {
+                /* 2-byte VEX prefix: RVVVVlpp, implied 0f leading opcode byte */
                 vex3 = vex2;
-                b = x86_ldub_code(env, s);
+                b = x86_ldub_code(env, s) | 0x100;
             } else {
+                /* 3-byte VEX prefix: RXBmmmmm wVVVVlpp */
 #ifdef TARGET_X86_64
                 s->rex_x = (~vex2 >> 3) & 8;
                 s->rex_b = (~vex2 >> 2) & 8;
-- 
1.8.3.1
