Received: from eggs.gnu.org ([2001:4830:134:3::10]:40383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1descl-0004GQ-Ow
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1descg-0006th-IQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:43:55 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:41374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1descg-0006sY-Bu
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 20:43:50 -0400
Date: Tue, 8 Aug 2017 00:43:38 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708080041391.28702@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: set rip_offset for some SSE4.1
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

When emulating various SSE4.1 instructions such as pinsrd, the address
of a memory operand is computed without allowing for the 8-bit
immediate operand located after the memory operand, meaning that the
memory operand uses the wrong address in the case where it is
rip-relative.  This patch adds the required rip_offset setting for
those instructions, so fixing some GCC test failures (13 in the gcc
testsuite in my GCC 6-based testing) when testing with a default CPU
setting enabling those instructions.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/target/i386/translate.c b/target/i386/translate.c
index cab9e32..5fdadf9 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4080,6 +4080,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
             if (sse_fn_eppi == SSE_SPECIAL) {
                 ot = mo_64_32(s->dflag);
                 rm = (modrm & 7) | REX_B(s);
+                s->rip_offset = 1;
                 if (mod != 3)
                     gen_lea_modrm(env, s, modrm);
                 reg = ((modrm >> 3) & 7) | rex_r;

-- 
Joseph S. Myers
joseph@codesourcery.com
