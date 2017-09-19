Received: from eggs.gnu.org ([2001:4830:134:3::10]:59544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHev-0003ev-OB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHet-00059p-3m
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:49 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHes-00059V-T7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:47 -0400
Received: by mail-wr0-x244.google.com with SMTP id b9so2160735wra.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:51 +0200
Message-Id: <1505824179-21541-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/50] target/i386: set rip_offset for further
 SSE instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Joseph Myers <joseph@codesourcery.com>

From: Joseph Myers <joseph@codesourcery.com>

It turns out that my recent fix to set rip_offset when emulating some
SSE4.1 instructions needs generalizing to cover a wider class of
instructions.  Specifically, every instruction in the sse_op_table7
table, coming from various instruction set extensions, has an 8-bit
immediate operand that comes after any memory operand, and so needs
rip_offset set for correctness if there is a memory operand that is
rip-relative, and my patch only set it for a subset of those
instructions.  This patch moves the rip_offset setting to cover the
wider class of instructions, so fixing 9 further gcc testsuite
failures in my GCC 6-based testing.  (I do not know whether there
might be still further classes of instructions missing this setting.)

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Message-Id: <alpine.DEB.2.20.1708082350340.23380@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index de0c989..a8986f4 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4076,10 +4076,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (!(s->cpuid_ext_features & sse_op_table7[b].ext_mask))
                 goto illegal_op;
 
+            s->rip_offset = 1;
+
             if (sse_fn_eppi == SSE_SPECIAL) {
                 ot = mo_64_32(s->dflag);
                 rm = (modrm & 7) | REX_B(s);
-                s->rip_offset = 1;
                 if (mod != 3)
                     gen_lea_modrm(env, s, modrm);
                 reg = ((modrm >> 3) & 7) | rex_r;
-- 
1.8.3.1
