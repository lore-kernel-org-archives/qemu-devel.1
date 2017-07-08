Received: from eggs.gnu.org ([2001:4830:134:3::10]:43603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpf-0001Sb-9C
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTfpe-0004xX-CW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 22:50:55 -0400
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri,  7 Jul 2017 16:50:28 -1000
Message-Id: <20170708025030.15845-2-rth@twiddle.net>
In-Reply-To: <20170708025030.15845-1-rth@twiddle.net>
References: <20170708025030.15845-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/3] tcg: Fix off-by-one in assert in
 page_set_flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, qemu-arm@nongnu.org, aurelien@aurel32.net

Most of the users of page_set_flags offset (page, page + len) as
the end points.  One might consider this an error, since the other
users do supply an endpoint as the last byte of the region.

However, the first thing that page_set_flags does is round end UP
to the start of the next page.  Which means computing page + len - 1
is in the end pointless.  Therefore, accept this usage and do not
assert when given the exact size of the vm as the endpoint.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index dfb9f0d..57578a4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2068,7 +2068,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
 #if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(end < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
+    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
 #endif
     assert(start < end);
     assert_memory_lock();
-- 
2.9.4
