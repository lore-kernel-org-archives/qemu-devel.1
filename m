Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEpE-0006ZN-J1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsEpD-0006Ay-GJ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 17:04:00 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 13 Sep 2017 16:03:43 -0500
Message-Id: <20170913210343.19078-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] osdep: Fix ROUND_UP(64-bit, 32-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org

When using bit-wise operations that exploit the power-of-two
nature of the second argument of ROUND_UP(), we still need to
ensure that the mask is as wide as the first argument (done
by using addition of 0 to force proper arithmetic promotion).
Unpatched, ROUND_UP(2ULL*1024*1024*1024*1024, 512) produces 0,
instead of the intended 2TiB.

Broken since its introduction in commit 292c8e50 (v1.5.0).

CC: qemu-trivial@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---
I did not audit to see how many potential users of ROUND_UP
are actually passing in different sized types where the first
argument can be larger than UINT32_MAX; I stumbled across the
problem when iotests 190 started failing on a patch where I
added a new use.  We can either be conservative and put this
on qemu-stable no matter what, or go through the effort of an
audit to see what might be broken (many callers in the block
layer, but not just there).
---
 include/qemu/osdep.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6855b94bbf..7a3000efc5 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -189,13 +189,13 @@ extern int daemon(int, int);

 /* Round number up to multiple. Requires that d be a power of 2 (see
  * QEMU_ALIGN_UP for a safer but slower version on arbitrary
- * numbers) */
+ * numbers); works even if d is a smaller type than n.  */
 #ifndef ROUND_UP
-#define ROUND_UP(n,d) (((n) + (d) - 1) & -(d))
+#define ROUND_UP(n, d) (((n) + (d) - 1) & -((n) - (n) + (d)))
 #endif

 #ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #endif

 /*
-- 
2.13.5
