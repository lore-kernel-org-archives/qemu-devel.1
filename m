Received: from eggs.gnu.org ([2001:4830:134:3::10]:48361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgr7X-0004uH-Ka
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cgr7U-000855-Jq
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:59:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cgr7U-00084v-Ep
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:59:32 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 23 Feb 2017 10:59:22 +0000
Message-Id: <20170223105922.22989-1-berrange@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Michal Privoznik <mprivozn@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When using a memory-backend object with prealloc turned on, QEMU
will memset() the first byte in every memory page to zero. While
this might have been acceptable for memory backends associated
with RAM, this corrupts application data for NVDIMMs.

Instead of setting every page to zero, read the current byte
value and then just write that same value back, so we are not
corrupting the original data.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---

I'm unclear if this is actually still safe in practice ? Is the
compiler permitted to optimize away the read+write since it doesn't
change the memory value. I'd hope not, but I've been surprised
before...

IMHO this is another factor in favour of requesting an API from
the kernel to provide the prealloc behaviour we want.

 util/oslib-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 35012b9..8f5b656 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -355,7 +355,8 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
 
         /* MAP_POPULATE silently ignores failures */
         for (i = 0; i < numpages; i++) {
-            memset(area + (hpagesize * i), 0, 1);
+            char val = *(area + (hpagesize * i));
+            memset(area + (hpagesize * i), 0, val);
         }
     }
 
-- 
2.9.3
