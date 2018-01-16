Received: from eggs.gnu.org ([2001:4830:134:3::10]:45629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVOb-0000FV-S2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVOa-0002wW-Sl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVOa-0002vX-KW
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:51:36 -0500
Date: Tue, 16 Jan 2018 19:51:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-20-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 19/34] vhost-user-test: make features mask an
 init_virtio_dev() argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

The goal is to generalize the use of [un]init_virtio_dev() to
all tests, which does not necessarily expose the same features
set.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/vhost-user-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 969e393..6a144e8 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -164,7 +164,7 @@ typedef struct TestServer {
 static const char *tmpfs;
 static const char *root;
=20
-static void init_virtio_dev(TestServer *s)
+static void init_virtio_dev(TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
     int i;
@@ -187,7 +187,7 @@ static void init_virtio_dev(TestServer *s)
     }
=20
     features =3D qvirtio_get_features(&s->dev->vdev);
-    features =3D features & (1u << VIRTIO_NET_F_MAC);
+    features =3D features & features_mask;
     qvirtio_set_features(&s->dev->vdev, features);
=20
     qvirtio_set_driver_ok(&s->dev->vdev);
@@ -652,7 +652,7 @@ static void test_read_guest_mem(void)
     s =3D qtest_start(qemu_cmd);
     g_free(qemu_cmd);
=20
-    init_virtio_dev(server);
+    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
=20
     read_guest_mem(server);
=20
@@ -681,7 +681,7 @@ static void test_migrate(void)
     from =3D qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size =3D get_log_size(s);
     g_assert_cmpint(size, =3D=3D, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * =
8));
@@ -803,7 +803,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
@@ -841,7 +841,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
@@ -871,7 +871,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
=20
-    init_virtio_dev(s);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
=20
--=20
MST
