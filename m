Received: from eggs.gnu.org ([2001:4830:134:3::10]:36308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVAB-0007Tz-FB
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVAA-0001Ck-KM
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:43 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVAA-0001C4-ET
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:28:42 -0400
Received: by mail-pg0-x243.google.com with SMTP id 123so778259pga.5
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:28:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:28:27 -0700
Message-Id: <20170804052833.10187-6-rth@twiddle.net>
In-Reply-To: <20170804052833.10187-1-rth@twiddle.net>
References: <20170804052833.10187-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL for-2.10 3/3] tcg: Increase minimum alignment
 from tcg_malloc to 8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, cohuck@redhat.com, borntraeger@de.ibm.com

For a 64-bit ILP32 host, aligning to sizeof(long) is not enough.
Guess the minimum for any host is 8, as that covers uint64_t.
Qemu doesn't use a host long double or host vectors, except in
extremely limited circumstances.

Fixes a bus error for a sparc v8plus host.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg.h b/tcg/tcg.h
index da78721a0d..17b7750ee6 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -762,7 +762,10 @@ static inline void *tcg_malloc(int size)
 {
     TCGContext *s = &tcg_ctx;
     uint8_t *ptr, *ptr_end;
-    size = (size + sizeof(long) - 1) & ~(sizeof(long) - 1);
+
+    /* ??? This is a weak placeholder for minimum malloc alignment.  */
+    size = QEMU_ALIGN_UP(size, 8);
+
     ptr = s->pool_cur;
     ptr_end = ptr + size;
     if (unlikely(ptr_end > s->pool_end)) {
-- 
2.13.3
