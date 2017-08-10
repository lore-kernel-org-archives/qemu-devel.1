Received: from eggs.gnu.org ([2001:4830:134:3::10]:44292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfvCL-0001a3-0j
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfvCH-0007rP-Dl
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:40:57 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:37194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1dfvCH-0007qk-7L
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 17:40:53 -0400
Date: Thu, 10 Aug 2017 21:40:41 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708102139310.8101@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: fix pcmpxstrx substring search
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

One of the cases of the SSE4.2 pcmpestri / pcmpestrm / pcmpistri /
pcmpistrm instructions does a substring search.  The implementation of
this case in the pcmpxstrx helper is incorrect.  The operation in this
case is a search for a string (argument d to the helper) in another
string (argument s to the helper); if a copy of d at a particular
position would run off the end of s, the resulting output bit should
be 0 whether or not the strings match in the region where they
overlap, but the QEMU implementation was wrongly comparing only up to
the point where s ends and counting it as a match if an initial
segment of d matched a terminal segment of s.  Here, "run off the end
of s" means that some byte of d would overlap some byte outside of s;
thus, if d has zero length, it is considered to match everywhere,
including after the end of s.  This patch fixes the implementation to
correspond with the proper instruction semantics.  This fixes four gcc
test failures in my GCC 6-based testing.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 16509d0..9f1b351 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2037,10 +2040,14 @@ static inline unsigned pcmpxstrx(CPUX86State *env, Reg *d, Reg *s,
         }
         break;
     case 3:
-        for (j = valids; j >= 0; j--) {
+        if (validd == -1) {
+            res = (2 << upper) - 1;
+            break;
+        }
+        for (j = valids - validd; j >= 0; j--) {
             res <<= 1;
             v = 1;
-            for (i = MIN(valids - j, validd); i >= 0; i--) {
+            for (i = validd; i >= 0; i--) {
                 v &= (pcmp_val(s, ctrl, i + j) == pcmp_val(d, ctrl, i));
             }
             res |= v;

-- 
Joseph S. Myers
joseph@codesourcery.com
