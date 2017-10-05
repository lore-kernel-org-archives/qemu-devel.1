Received: from eggs.gnu.org ([2001:4830:134:3::10]:40717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07Fy-0002Fx-L8
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e07Fx-0001v6-Nj
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:10 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:49147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e07Fx-0001uQ-J5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:36:09 -0400
Received: by mail-qt0-x22c.google.com with SMTP id d13so25048010qta.5
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  5 Oct 2017 10:35:59 -0400
Message-Id: <20171005143601.21584-3-richard.henderson@linaro.org>
In-Reply-To: <20171005143601.21584-1-richard.henderson@linaro.org>
References: <20171005143601.21584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/4] tcg: Fix off-by-one in assert in
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
Cc: riku.voipio@iki.fi, peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Most of the users of page_set_flags offset (page, page + len) as
the end points.  One might consider this an error, since the other
users do supply an endpoint as the last byte of the region.

However, the first thing that page_set_flags does is round end UP
to the start of the next page.  Which means computing page + len - 1
is in the end pointless.  Therefore, accept this usage and do not
assert when given the exact size of the vm as the endpoint.

Signed-off-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170708025030.15845-2-rth@twiddle.net>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d1ed06065..ebfc2e7024 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2090,7 +2090,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
 #if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(end < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
+    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
 #endif
     assert(start < end);
     assert_memory_lock();
-- 
2.13.6
