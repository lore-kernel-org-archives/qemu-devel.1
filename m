Received: from eggs.gnu.org ([2001:4830:134:3::10]:42032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZE-0007uD-Tb
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZD-0005w2-Lp
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:12 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZD-0005vD-FV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:11 -0500
Received: by mail-wr0-x241.google.com with SMTP id 36so5058561wrh.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:11 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:08 +0100
Message-Id: <1515756676-3860-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/52] tests: Avoid 'do/while(false);
 ' in vhost-user-bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Use of a do/while(0) loop as a way to allow break statements in
the middle of execute-once code is unusual.  More typical is
the use of goto for early exits, with a label at the end of
the execute-once code, rather than nesting code in a scope;
however, the comment at the end of the existing code makes this
alternative a bit unpractical.

So, to avoid false positives from a future syntax check about
'while (false);', and to keep the loop form (in case someone
ever does add DONTWAIT support, where they can just as easily
manipulate the initial loop condition or add an if around the
final 'break'), I opted to use the form of a while(1) loop (the
break as an early exit is more idiomatic there), coupled with
a final break preserving the original comment.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171201232433.25193-6-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-bridge.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index d820033..e0605a5 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -283,7 +283,7 @@ vubr_backend_recv_cb(int sock, void *ctx)
         return;
     }
 
-    do {
+    while (1) {
         struct iovec *sg;
         ssize_t ret, total = 0;
         unsigned int num;
@@ -343,7 +343,9 @@ vubr_backend_recv_cb(int sock, void *ctx)
 
         free(elem);
         elem = NULL;
-    } while (false); /* could loop if DONTWAIT worked? */
+
+        break;        /* could loop if DONTWAIT worked? */
+    }
 
     if (mhdr_cnt) {
         mhdr.num_buffers = i;
-- 
1.8.3.1
