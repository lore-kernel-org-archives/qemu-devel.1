Received: from eggs.gnu.org ([2001:4830:134:3::10]:60944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S6-00018g-Pf
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S5-0006gb-KH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S5-0006fy-DL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:49 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:37 +0200
Message-Id: <20170808152941.11247-6-pbonzini@redhat.com>
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 5/9] target/i386: set rip_offset for some SSE4.1
 instructions
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

When emulating various SSE4.1 instructions such as pinsrd, the address
of a memory operand is computed without allowing for the 8-bit
immediate operand located after the memory operand, meaning that the
memory operand uses the wrong address in the case where it is
rip-relative.  This patch adds the required rip_offset setting for
those instructions, so fixing some GCC test failures (13 in the gcc
testsuite in my GCC 6-based testing) when testing with a default CPU
setting enabling those instructions.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Message-Id: <alpine.DEB.2.20.1708080041391.28702@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index cab9e32f91..5fdadf98cf 100644
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
2.13.3
