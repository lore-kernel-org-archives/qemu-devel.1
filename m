Received: from eggs.gnu.org ([2001:4830:134:3::10]:44791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsUWQ-0005ZE-Ve
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsUWQ-0007Ln-0V
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:49:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 14 Sep 2017 08:49:23 -0500
Message-Id: <20170914134923.2479-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2] osdep: Fix ROUND_UP(64-bit, 32-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, qemu-block@nongnu.org, qemu-trivial@nongnu.org, qemu-stable@nongnu.org

When using bit-wise operations that exploit the power-of-two
nature of the second argument of ROUND_UP(), we still need to
ensure that the mask is as wide as the first argument (done
by using a ternary to force proper arithmetic promotion).
Unpatched, ROUND_UP(2ULL*1024*1024*1024*1024, 512U) produces 0,
instead of the intended 2TiB, because negation of an unsigned
32-bit quantity followed by widening to 64-bits does not
sign-extend the mask.

Broken since its introduction in commit 292c8e50 (v1.5.0).
Callers that passed the same width type to both macro parameters,
or that had other code to ensure the first parameter's maximum
runtime value did not exceed the second parameter's width, are
unaffected, but I did not audit to see which (if any) existing
clients of the macro could trigger incorrect behavior (I found
the bug while adding a new use of the macro).

While preparing the patch, checkpatch complained about poor
spacing, so I also fixed that here and in the nearby DIV_ROUND_UP.

CC: qemu-trivial@nongnu.org
CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: use ternary instead of addition of 0 [Laszlo], improve commit message
---
 include/qemu/osdep.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 6855b94bbf..f4ff372d41 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -189,13 +189,13 @@ extern int daemon(int, int);

 /* Round number up to multiple. Requires that d be a power of 2 (see
  * QEMU_ALIGN_UP for a safer but slower version on arbitrary
- * numbers) */
+ * numbers); works even if d is a smaller type than n.  */
 #ifndef ROUND_UP
-#define ROUND_UP(n,d) (((n) + (d) - 1) & -(d))
+#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))
 #endif

 #ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
+#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
 #endif

 /*
-- 
2.13.5
