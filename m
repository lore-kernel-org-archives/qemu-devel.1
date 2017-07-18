Received: from eggs.gnu.org ([2001:4830:134:3::10]:50139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYjb-00070E-3d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXYja-0005EA-9T
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:43 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXYja-0005Dw-5B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:04:42 -0400
Received: by mail-qt0-x242.google.com with SMTP id 50so2614215qtz.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 13:04:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 10:02:53 -1000
Message-Id: <20170718200255.31647-29-rth@twiddle.net>
In-Reply-To: <20170718200255.31647-1-rth@twiddle.net>
References: <20170718200255.31647-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 28/30] tcg: Fix off-by-one in assert in
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
Cc: aurelien@aurel32.net

Most of the users of page_set_flags offset (page, page + len) as
the end points.  One might consider this an error, since the other
users do supply an endpoint as the last byte of the region.

However, the first thing that page_set_flags does is round end UP
to the start of the next page.  Which means computing page + len - 1
is in the end pointless.  Therefore, accept this usage and do not
assert when given the exact size of the vm as the endpoint.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4e1831c..f304ee1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2063,7 +2063,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
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
