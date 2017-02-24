Received: from eggs.gnu.org ([2001:4830:134:3::10]:33049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chJeZ-0003N6-5k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1chJeY-0005Js-6o
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1chJeY-0005Jk-0z
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:27:34 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 24 Feb 2017 17:27:14 +0000
Message-Id: <20170224172714.26026-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] os: don't corrupt pre-existing memory-backend
 data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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
---

NB, I have not tested performance of this, so no idea if this
makes it better/worse/no-change. Would appreciate if Jitendra
could repeat tests to see if it impacts scalability at all.

 util/oslib-posix.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 35012b9..2a5bb93 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -355,7 +355,20 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
 
         /* MAP_POPULATE silently ignores failures */
         for (i = 0; i < numpages; i++) {
-            memset(area + (hpagesize * i), 0, 1);
+            /*
+             * Read & write back the same value, so we don't
+             * corrupt existinng user/app data that might be
+             * stored.
+             *
+             * 'volatile' to stop compiler optimizing this away
+             * to a no-op
+             *
+             * TODO: get a better solution from kernel so we
+             * don't need to write at all so we don't cause
+             * wear on the storage backing the region...
+             */
+            volatile char val = *(area + (hpagesize * i));
+            *(area + (hpagesize * i)) = val;
         }
     }
 
-- 
2.9.3
