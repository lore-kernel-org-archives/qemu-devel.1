Received: from eggs.gnu.org ([2001:4830:134:3::10]:60410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6C0-0007Rr-5r
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6By-0007jJ-SO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6By-0007ix-Jl
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:52:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B10AA3D959
	for <qemu-devel@nongnu.org>; Tue,  7 Feb 2017 13:52:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:51:45 +0400
Message-Id: <20170207135211.15870-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/28] tests: fix qmp response leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/usb.c             |  1 +
 tests/postcopy-test.c          |  2 +-
 tests/pvpanic-test.c           |  1 +
 tests/test-filter-mirror.c     |  2 +-
 tests/test-filter-redirector.c |  4 ++--
 tests/virtio-blk-test.c        | 15 +++++++++------
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tests/libqos/usb.c b/tests/libqos/usb.c
index 72d7a961fe..98408d93f3 100644
--- a/tests/libqos/usb.c
+++ b/tests/libqos/usb.c
@@ -64,4 +64,5 @@ void usb_test_hotplug(const char *hcd_id, const int por=
t,
     g_assert(response);
     g_assert(qdict_haskey(response, "event"));
     g_assert(!strcmp(qdict_get_str(response, "event"), "DEVICE_DELETED")=
);
+    QDECREF(response);
 }
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index dafe8beba4..de35a18903 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -482,7 +482,7 @@ static void test_migrate(void)
         usleep(10 * 1000);
     } while (dest_byte_a =3D=3D dest_byte_b);
=20
-    qmp("{ 'execute' : 'stop'}");
+    qmp_discard_response("{ 'execute' : 'stop'}");
     /* With it stopped, check nothing changes */
     qtest_memread(to, start_address, &dest_byte_c, 1);
     sleep(1);
diff --git a/tests/pvpanic-test.c b/tests/pvpanic-test.c
index 3bfa678667..71ebb5c02c 100644
--- a/tests/pvpanic-test.c
+++ b/tests/pvpanic-test.c
@@ -27,6 +27,7 @@ static void test_panic(void)
     data =3D qdict_get_qdict(response, "data");
     g_assert(qdict_haskey(data, "action"));
     g_assert_cmpstr(qdict_get_str(data, "action"), =3D=3D, "pause");
+    QDECREF(response);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index ffaaffabd0..9f84402493 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -57,7 +57,7 @@ static void test_mirror(void)
     };
=20
     /* send a qmp command to guarantee that 'connected' is setting to tr=
ue. */
-    qmp("{ 'execute' : 'query-status'}");
+    qmp_discard_response("{ 'execute' : 'query-status'}");
     ret =3D iov_send(send_sock[0], iov, 2, 0, sizeof(size) + sizeof(send=
_buf));
     g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
     close(send_sock[0]);
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirecto=
r.c
index c63b68f03a..0c4b8d52ef 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -99,7 +99,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(recv_sock, !=3D, -1);
=20
     /* send a qmp command to guarantee that 'connected' is setting to tr=
ue. */
-    qmp("{ 'execute' : 'query-status'}");
+    qmp_discard_response("{ 'execute' : 'query-status'}");
=20
     struct iovec iov[] =3D {
         {
@@ -184,7 +184,7 @@ static void test_redirector_rx(void)
     send_sock =3D unix_connect(sock_path1, NULL);
     g_assert_cmpint(send_sock, !=3D, -1);
     /* send a qmp command to guarantee that 'connected' is setting to tr=
ue. */
-    qmp("{ 'execute' : 'query-status'}");
+    qmp_discard_response("{ 'execute' : 'query-status'}");
=20
     ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
     g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 0e32e416dd..10a92b410a 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -409,8 +409,9 @@ static void pci_config(void)
=20
     qvirtio_set_driver_ok(&dev->vdev);
=20
-    qmp("{ 'execute': 'block_resize', 'arguments': { 'device': 'drive0',=
 "
-                                                    " 'size': %d } }", n=
_size);
+    qmp_discard_response("{ 'execute': 'block_resize', "
+                         " 'arguments': { 'device': 'drive0', "
+                         " 'size': %d } }", n_size);
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
=20
     capacity =3D qvirtio_config_readq(&dev->vdev, 0);
@@ -458,8 +459,9 @@ static void pci_msix(void)
=20
     qvirtio_set_driver_ok(&dev->vdev);
=20
-    qmp("{ 'execute': 'block_resize', 'arguments': { 'device': 'drive0',=
 "
-                                                    " 'size': %d } }", n=
_size);
+    qmp_discard_response("{ 'execute': 'block_resize', "
+                         " 'arguments': { 'device': 'drive0', "
+                         " 'size': %d } }", n_size);
=20
     qvirtio_wait_config_isr(&dev->vdev, QVIRTIO_BLK_TIMEOUT_US);
=20
@@ -691,8 +693,9 @@ static void mmio_basic(void)
=20
     test_basic(&dev->vdev, alloc, vq);
=20
-    qmp("{ 'execute': 'block_resize', 'arguments': { 'device': 'drive0',=
 "
-                                                    " 'size': %d } }", n=
_size);
+    qmp_discard_response("{ 'execute': 'block_resize', "
+                         " 'arguments': { 'device': 'drive0', "
+                         " 'size': %d } }", n_size);
=20
     qvirtio_wait_queue_isr(&dev->vdev, vq, QVIRTIO_BLK_TIMEOUT_US);
=20
--=20
2.11.0.295.gd7dffce1c.dirty
