Received: from eggs.gnu.org ([2001:4830:134:3::10]:40217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfbHE-0002zV-6t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 20:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dfbH9-0004Gr-63
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 20:24:40 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:55788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1dfbH8-0004Ex-Vi
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 20:24:35 -0400
Date: Thu, 10 Aug 2017 00:24:23 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708100023050.9262@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: fix packusdw in-place operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

The SSE4.1 packusdw instruction combines source and destination
vectors of signed 32-bit integers into a single vector of unsigned
16-bit integers, with unsigned saturation.  When the source and
destination are the same register, this means each 32-bit element of
that register is used twice as an input, to produce two of the 16-bit
output elements, and so if the operation is carried out
element-by-element in-place, no matter what the order in which it is
applied to the elements, the first element's operation will overwrite
some future input.  The helper for packssdw avoids this issue by
computing the result in a local temporary and copying it to the
destination at the end; this patch fixes the packusdw helper to do
likewise.  This fixes three gcc test failures in my GCC 6-based
testing.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 16509d0..05b1701 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1655,14 +1655,17 @@ SSE_HELPER_Q(helper_pcmpeqq, FCMPEQQ)
 
 void glue(helper_packusdw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
 {
-    d->W(0) = satuw((int32_t) d->L(0));
-    d->W(1) = satuw((int32_t) d->L(1));
-    d->W(2) = satuw((int32_t) d->L(2));
-    d->W(3) = satuw((int32_t) d->L(3));
-    d->W(4) = satuw((int32_t) s->L(0));
-    d->W(5) = satuw((int32_t) s->L(1));
-    d->W(6) = satuw((int32_t) s->L(2));
-    d->W(7) = satuw((int32_t) s->L(3));
+    Reg r;
+
+    r.W(0) = satuw((int32_t) d->L(0));
+    r.W(1) = satuw((int32_t) d->L(1));
+    r.W(2) = satuw((int32_t) d->L(2));
+    r.W(3) = satuw((int32_t) d->L(3));
+    r.W(4) = satuw((int32_t) s->L(0));
+    r.W(5) = satuw((int32_t) s->L(1));
+    r.W(6) = satuw((int32_t) s->L(2));
+    r.W(7) = satuw((int32_t) s->L(3));
+    *d = r;
 }
 
 #define FMINSB(d, s) MIN((int8_t)d, (int8_t)s)

-- 
Joseph S. Myers
joseph@codesourcery.com
