Received: from eggs.gnu.org ([2001:4830:134:3::10]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyK-0004MI-E5
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dBfyJ-0000wr-Jg
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:28 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dBfyJ-0000wU-Cu
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:21:27 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so1792395wmh.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 04:21:27 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2017 13:21:01 +0200
Message-Id: <1495192872-27667-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/20] Check the return value of fcntl in
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, groug@kaod.org, pbonzini@redhat.com, Eric Blake <eblake@redhat.com>

From: Stefano Stabellini <sstabellini@kernel.org>

Assert that the return value is not an error. This issue was found by
Coverity.

CID: 1374831

Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
CC: groug@kaod.org
CC: pbonzini@redhat.com
CC: Eric Blake <eblake@redhat.com>
Message-Id: <1494356693-13190-2-git-send-email-sstabellini@kernel.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
