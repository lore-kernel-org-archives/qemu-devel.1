Received: from eggs.gnu.org ([209.51.188.92]:44698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4n-0005Xs-2s
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz4k-0007QQ-Uv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz4j-0007N1-S9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:34 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:01:59 +0100
Message-Id: <1547460140-1473-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 04/25] util: check the return value of fcntl in
 qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

From: Li Qiang <liq3ea@163.com>

Assert that the return value is not an error. This is like commit
7e6478e7d4f for qemu_set_cloexec.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 util/oslib-posix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index c1bee2a..4ce1ba9 100644
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
1.8.3.1
