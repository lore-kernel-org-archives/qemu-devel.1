Received: from eggs.gnu.org ([2001:4830:134:3::10]:47909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfB0B-00012U-7l
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfB07-0005wW-4S
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:21:19 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:44560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1dfB06-0005vF-UO
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 16:21:15 -0400
Date: Tue, 8 Aug 2017 20:21:01 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708082018390.23380@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: fix pmovsx/pmovzx in-place
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

The SSE4.1 pmovsx* and pmovzx* instructions take packed 1-byte, 2-byte
or 4-byte inputs and sign-extend or zero-extend them to a wider vector
output.  The associated helpers for these instructions do the
extension on each element in turn, starting with the lowest.  If the
input and output are the same register, this means that all the input
elements after the first have been overwritten before they are read.
This patch makes the helpers extend starting with the highest element,
not the lowest, to avoid such overwriting.  This fixes many GCC test
failures (161 in the gcc testsuite in my GCC 6-based testing) when
testing with a default CPU setting enabling those instructions.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 16509d0..d578216 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1617,18 +1617,18 @@ void glue(helper_ptest, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 #define SSE_HELPER_F(name, elem, num, F)        \
     void glue(name, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)     \
     {                                           \
-        d->elem(0) = F(0);                      \
-        d->elem(1) = F(1);                      \
         if (num > 2) {                          \
-            d->elem(2) = F(2);                  \
-            d->elem(3) = F(3);                  \
             if (num > 4) {                      \
-                d->elem(4) = F(4);              \
-                d->elem(5) = F(5);              \
-                d->elem(6) = F(6);              \
                 d->elem(7) = F(7);              \
+                d->elem(6) = F(6);              \
+                d->elem(5) = F(5);              \
+                d->elem(4) = F(4);              \
             }                                   \
+            d->elem(3) = F(3);                  \
+            d->elem(2) = F(2);                  \
         }                                       \
+        d->elem(1) = F(1);                      \
+        d->elem(0) = F(0);                      \
     }
 
 SSE_HELPER_F(helper_pmovsxbw, W, 8, (int8_t) s->B)

-- 
Joseph S. Myers
joseph@codesourcery.com
