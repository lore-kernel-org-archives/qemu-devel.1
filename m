Received: from eggs.gnu.org ([2001:4830:134:3::10]:59547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHev-0003ex-Oi
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHeu-0005AM-38
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHet-00059z-TB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:48 -0400
Received: by mail-wr0-x241.google.com with SMTP id u48so2145446wrf.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:52 +0200
Message-Id: <1505824179-21541-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/50] target/i386: fix packusdw in-place
 operation
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

Message-Id: <alpine.DEB.2.20.1708100023050.9262@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index d578216..05b1701 100644
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
1.8.3.1
