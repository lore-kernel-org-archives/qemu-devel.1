Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co19W-0003nf-Ur
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1co19W-0007AA-2o
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1co19V-00079G-T5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 01:07:14 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 15 Mar 2017 13:06:02 +0800
Message-Id: <20170315050602.7750-2-stefanha@redhat.com>
In-Reply-To: <20170315050602.7750-1-stefanha@redhat.com>
References: <20170315050602.7750-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When using a memory-backend object with prealloc turned on, QEMU
will memset() the first byte in every memory page to zero. While
this might have been acceptable for memory backends associated
with RAM, this corrupts application data for NVDIMMs.

Instead of setting every page to zero, read the current byte
value and then just write that same value back, so we are not
corrupting the original data. Directly write the value instead
of memset()ing it, since there's no benefit to memset for a
single byte write.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
Message-id: 20170303113255.28262-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/oslib-posix.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 956f66a..94d81b9 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -361,7 +361,19 @@ static void *do_touch_pages(void *arg)
         memset_thread_failed = true;
     } else {
         for (i = 0; i < numpages; i++) {
-            memset(addr, 0, 1);
+            /*
+             * Read & write back the same value, so we don't
+             * corrupt existing user/app data that might be
+             * stored.
+             *
+             * 'volatile' to stop compiler optimizing this away
+             * to a no-op
+             *
+             * TODO: get a better solution from kernel so we
+             * don't need to write at all so we don't cause
+             * wear on the storage backing the region...
+             */
+            *(volatile char *)addr = *addr;
             addr += hpagesize;
         }
     }
-- 
2.9.3
