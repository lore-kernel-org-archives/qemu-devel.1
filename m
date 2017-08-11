Received: from eggs.gnu.org ([2001:4830:134:3::10]:34264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dgAqw-00008q-NQ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joseph_myers@mentor.com>) id 1dgAqs-00024Z-LG
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:23:54 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:59040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joseph_myers@mentor.com>)
	id 1dgAqs-00022b-Ez
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:23:50 -0400
Date: Fri, 11 Aug 2017 14:23:35 +0000
From: Joseph Myers <joseph@codesourcery.com>
Message-ID: <alpine.DEB.2.20.1708111422580.11919@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] target/i386: fix phminposuw in-place operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

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

---

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 16509d0..ed05989 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1707,10 +1710,10 @@ void glue(helper_phminposuw, SUFFIX)(CPUX86State *env, Reg *d, Reg *s)
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
Joseph S. Myers
joseph@codesourcery.com
