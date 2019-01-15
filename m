Received: from eggs.gnu.org ([209.51.188.92]:33459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxG-0006Kh-V8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUxF-0002NV-W2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUxF-00028o-Jd
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:04:57 -0500
Date: Tue, 15 Jan 2019 15:04:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-8-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 07/49] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Li Qiang <liq3ea@163.com>

Assert that the return value is not an error. This is like commit
7e6478e7d4f for qemu_set_cloexec.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
