Received: from eggs.gnu.org ([2001:4830:134:3::10]:52878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1Fh-0006nW-Ng
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dn1Fg-0007zL-M7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dn1Fg-0007yt-Ch
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:33:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64C4920B17
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 11:33:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 30 Aug 2017 13:33:18 +0200
Message-Id: <20170830113319.6749-2-quintela@redhat.com>
In-Reply-To: <20170830113319.6749-1-quintela@redhat.com>
References: <20170830113319.6749-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] tests: Use real size for iov tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, pbonzini@redhat.com

We were using -1 instead of the real size because the functions check
what is bigger, size in bytes or the size of the iov.  Recent gcc's
barf at this.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

Remove comments about this feature.
Fix missing -1.
---
 include/qemu/iov.h |  6 ------
 tests/test-iov.c   | 10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/qemu/iov.h b/include/qemu/iov.h
index bd9fd55b0a..72d4c559b4 100644
--- a/include/qemu/iov.h
+++ b/include/qemu/iov.h
@@ -31,11 +31,6 @@ size_t iov_size(const struct iovec *iov, const unsigned int iov_cnt);
  * Number of bytes actually copied will be returned, which is
  *  min(bytes, iov_size(iov)-offset)
  * `Offset' must point to the inside of iovec.
- * It is okay to use very large value for `bytes' since we're
- * limited by the size of the iovec anyway, provided that the
- * buffer pointed to by buf has enough space.  One possible
- * such "large" value is -1 (sinice size_t is unsigned),
- * so specifying `-1' as `bytes' means 'up to the end of iovec'.
  */
 size_t iov_from_buf_full(const struct iovec *iov, unsigned int iov_cnt,
                          size_t offset, const void *buf, size_t bytes);
@@ -76,7 +71,6 @@ iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
  * up to the end of it, will be filled with the specified value.
  * Function return actual number of bytes processed, which is
  * min(size, iov_size(iov) - offset).
- * Again, it is okay to use large value for `bytes' to mean "up to the end".
  */
 size_t iov_memset(const struct iovec *iov, const unsigned int iov_cnt,
                   size_t offset, int fillc, size_t bytes);
diff --git a/tests/test-iov.c b/tests/test-iov.c
index a22d71fd2c..f40f8f5260 100644
--- a/tests/test-iov.c
+++ b/tests/test-iov.c
@@ -81,17 +81,17 @@ static void test_to_from_buf_1(void)
           * skip whole vector and process exactly 0 bytes */
 
          /* first set bytes [i..sz) to some "random" value */
-         n = iov_memset(iov, niov, 0, 0xff, -1);
+         n = iov_memset(iov, niov, 0, 0xff, sz);
          g_assert(n == sz);
 
          /* next copy bytes [i..sz) from ibuf to iovec */
-         n = iov_from_buf(iov, niov, i, ibuf + i, -1);
+         n = iov_from_buf(iov, niov, i, ibuf + i, sz - i);
          g_assert(n == sz - i);
 
          /* clear part of obuf */
          memset(obuf + i, 0, sz - i);
          /* and set this part of obuf to values from iovec */
-         n = iov_to_buf(iov, niov, i, obuf + i, -1);
+         n = iov_to_buf(iov, niov, i, obuf + i, sz - i);
          g_assert(n == sz - i);
 
          /* now compare resulting buffers */
@@ -109,7 +109,7 @@ static void test_to_from_buf_1(void)
               * with j in [i..sz]. */
 
              /* clear iovec */
-             n = iov_memset(iov, niov, 0, 0xff, -1);
+             n = iov_memset(iov, niov, 0, 0xff, sz);
              g_assert(n == sz);
 
              /* copy bytes [i..j) from ibuf to iovec */
@@ -226,7 +226,7 @@ static void test_io(void)
        for (i = 0; i <= sz; ++i) {
            for (j = i; j <= sz; ++j) {
                k = i;
-               iov_memset(iov, niov, 0, 0xff, -1);
+               iov_memset(iov, niov, 0, 0xff, sz);
                do {
                    s = g_test_rand_int_range(0, j - k + 1);
                    r = iov_recv(sv[0], iov, niov, k, s);
-- 
2.13.5
