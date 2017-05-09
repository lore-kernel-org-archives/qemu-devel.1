Received: from eggs.gnu.org ([2001:4830:134:3::10]:44222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ART-0001gj-GW
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8ARQ-0001DU-7u
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:03 -0400
Received: from mail.kernel.org ([198.145.29.136]:43460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d8ARQ-0001D9-2X
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:05:00 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Tue,  9 May 2017 12:04:52 -0700
Message-Id: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PATCH v2 2/3] Check the return value of fcntl in
 qemu_set_cloexec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, sstabellini@kernel.org, groug@kaod.org, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>

Assert that the return value is not an error. This issue was found by
Coverity.

CID: 1374831

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
CC: groug@kaod.org
CC: pbonzini@redhat.com
CC: Eric Blake <eblake@redhat.com>
---
 util/oslib-posix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 4d9189e..16894ad 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -182,7 +182,9 @@ void qemu_set_cloexec(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFD);
-    fcntl(fd, F_SETFD, f | FD_CLOEXEC);
+    assert(f != -1);
+    f = fcntl(fd, F_SETFD, f | FD_CLOEXEC);
+    assert(f != -1);
 }
 
 /*
-- 
1.9.1
