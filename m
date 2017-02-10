Received: from eggs.gnu.org ([2001:4830:134:3::10]:36277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1ccN9q-0004dW-Vc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 21:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1ccN9n-0004Uh-Hp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 21:11:26 -0500
Received: from mail-db5eur01on0111.outbound.protection.outlook.com
	([104.47.2.111]:19013
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbutsykin@virtuozzo.com>)
	id 1ccN9m-0004U8-Vl
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 21:11:23 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 10 Feb 2017 17:36:51 +0300
Message-ID: <20170210143651.24046-1-pbutsykin@virtuozzo.com>
In-Reply-To: <20170210122523.GC3567@work-vm>
References: <20170210122523.GC3567@work-vm>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] migration: madvise error_report fixup!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: den@virtuozzo.com, armbru@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 migration/qemu-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 82dbef3c86..195fa94fcf 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -156,13 +156,13 @@ static void qemu_iovec_release_ram(QEMUFile *f)
             continue;
         }
         if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
-            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
+            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
                          iov.iov_base, iov.iov_len, strerror(errno));
         }
         iov = f->iov[idx];
     }
     if (qemu_madvise(iov.iov_base, iov.iov_len, QEMU_MADV_DONTNEED) < 0) {
-            error_report("migrate: madvise DONTNEED failed %p %ld: %s",
+            error_report("migrate: madvise DONTNEED failed %p %zd: %s",
                          iov.iov_base, iov.iov_len, strerror(errno));
     }
     memset(f->may_free, 0, sizeof(f->may_free));
-- 
2.11.0
