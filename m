Received: from eggs.gnu.org ([2001:4830:134:3::10]:58600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXV-0005Cq-F7
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1e4nXU-0003wR-JL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:37 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:48470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1e4nXU-0003w8-BB
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:33:36 -0400
Received: by mail-lf0-x243.google.com with SMTP id a69so5627118lfe.5
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:33:36 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 18 Oct 2017 15:33:19 +0300
Message-Id: <de258eb07db6cf893ef1bfad8c0cedc0b983db55.1508329282.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1508329282.git.riku.voipio@linaro.org>
References: <cover.1508329282.git.riku.voipio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/10] tcg: Fix off-by-one in assert in
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
Cc: Richard Henderson <rth@twiddle.net>

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
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5ce99d549..1b43deb0cd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2114,7 +2114,7 @@ void page_set_flags(target_ulong start, target_ulong end, int flags)
        guest address space.  If this assert fires, it probably indicates
        a missing call to h2g_valid.  */
 #if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
-    assert(end < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
+    assert(end <= ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
 #endif
     assert(start < end);
     assert_memory_lock();
-- 
2.14.2
