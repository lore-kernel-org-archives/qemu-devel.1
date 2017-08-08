Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfEHo-0006EP-D7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfEHj-00022n-Gf
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:51:44 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:33842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1dfEHj-00022Y-Ae
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 19:51:39 -0400
Date: Tue, 8 Aug 2017 23:51:29 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708082350340.23380@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: set rip_offset for further SSE
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

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

---

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5fdadf9..95f7261 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4077,10 +4077,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
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
Joseph S. Myers
joseph@codesourcery.com
