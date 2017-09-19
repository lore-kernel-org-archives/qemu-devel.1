Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHev-0003ey-PC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHer-00059E-Va
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:49 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHer-00058k-QV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:45 -0400
Received: by mail-wr0-x243.google.com with SMTP id b9so2160707wra.0
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:50 +0200
Message-Id: <1505824179-21541-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/50] target/i386: fix pmovsx/pmovzx in-place
 operations
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

Message-Id: <alpine.DEB.2.20.1708082018390.23380@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

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
1.8.3.1
