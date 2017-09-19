Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHex-0003fA-7S
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHew-0005Bs-8q
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:51 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHew-0005B2-2U
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:50 -0400
Received: by mail-wr0-x242.google.com with SMTP id n64so2146678wrb.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:49 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:54 +0200
Message-Id: <1505824179-21541-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/50] target/i386: fix phminposuw in-place
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

The SSE4.1 phminposuw instruction finds the minimum 16-bit element in
the source vector, putting the value of that element in the low 16
bits of the destination vector, the index of that element in the next
three bits and zeroing the rest of the destination.  The helper for
this operation fills the destination from high to low, meaning that
when the source and destination are the same register, the minimum
source element can be overwritten before it is copied to the
destination.  This patch fixes it to fill the destination from low to
high instead, so the minimum source element is always copied first.
This fixes one gcc test failure in my GCC 6-based testing (and so
concludes the present sequence of patches, as I don't have any further
gcc test failures left in that testing that I attribute to QEMU bugs).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

Message-Id: <alpine.DEB.2.20.1708111422580.11919@digraph.polyomino.org.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/ops_sse.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 9f1b351..ed05989 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1710,10 +1710,10 @@ void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
         idx = 7;
     }
 
-    d->Q(1) = 0;
-    d->L(1) = 0;
-    d->W(1) = idx;
     d->W(0) = s->W(idx);
+    d->W(1) = idx;
+    d->L(1) = 0;
+    d->Q(1) = 0;
 }
 
 void glue(helper_roundps, SUFFIX)(CPUX86State *env, Reg *d, Reg *s,
-- 
1.8.3.1
