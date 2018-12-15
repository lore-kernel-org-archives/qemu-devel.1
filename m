Received: from eggs.gnu.org ([2001:4830:134:3::10]:38755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hP-0005hx-76
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hO-0007tR-Fg
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:39 -0500
Received: from m12-12.163.com ([220.181.12.12]:34887)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gY8hN-0007rg-L5
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 07:05:38 -0500
From: Li Qiang <liq3ea@163.com>
Date: Sat, 15 Dec 2018 04:03:53 -0800
Message-Id: <20181215120353.82786-4-liq3ea@163.com>
In-Reply-To: <20181215120353.82786-1-liq3ea@163.com>
References: <20181215120353.82786-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH v2 3/3] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, mst@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Assert that the return value is not an error. This is like commit
7e6478e7d4f for qemu_set_cloexec.

Signed-off-by: Li Qiang <liq3ea@163.com>
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
2.17.1
