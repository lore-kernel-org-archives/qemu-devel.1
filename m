Received: from eggs.gnu.org ([2001:4830:134:3::10]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkRL5-0008Nd-4j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dkRL2-0003M7-2b
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dkRL1-0003Lu-T4
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:48:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC4D9C04B310
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 08:39:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 23 Aug 2017 10:39:00 +0200
Message-Id: <20170823083901.852-2-quintela@redhat.com>
In-Reply-To: <20170823083901.852-1-quintela@redhat.com>
References: <20170823083901.852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] tests: Use real size for iov tests
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
---
 tests/test-iov.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-iov.c b/tests/test-iov.c
index a22d71fd2c..819c410a51 100644
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
-- 
2.13.5
