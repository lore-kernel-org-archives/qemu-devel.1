Received: from eggs.gnu.org ([2001:4830:134:3::10]:52275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXGRg-0001ms-Hs
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXGRd-0007qN-9d
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:09:48 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXGRc-0007p1-UA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 21:09:45 -0500
Received: by mail-pf1-x444.google.com with SMTP id q1so268969pfi.5
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 18:09:44 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Dec 2018 18:09:37 -0800
Message-Id: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, marcandre.lureau@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Assert that the return value is not an error. This is like commit
7e6478e7d4f for qemu_set_cloexec.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 util/oslib-posix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c1bee2a581..4ce1ba9ca4 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -233,14 +233,18 @@ void qemu_set_block(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFL);
-    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
+    assert(f != -1);
+    f = fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
+    assert(f != -1);
 }
 
 void qemu_set_nonblock(int fd)
 {
     int f;
     f = fcntl(fd, F_GETFL);
-    fcntl(fd, F_SETFL, f | O_NONBLOCK);
+    assert(f != -1);
+    f = fcntl(fd, F_SETFL, f | O_NONBLOCK);
+    assert(f != -1);
 }
 
 int socket_set_fast_reuse(int fd)
-- 
2.11.0
