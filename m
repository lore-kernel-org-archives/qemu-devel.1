Received: from eggs.gnu.org ([2001:4830:134:3::10]:56309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS83H-0000xE-GZ
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS83E-0005Qq-9g
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS83E-0005Q7-3B
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 16:06:48 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D42519D221
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 21:06:47 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 22:06:08 +0100
Message-Id: <20171221210609.17408-5-maxime.coquelin@redhat.com>
In-Reply-To: <20171221210609.17408-1-maxime.coquelin@redhat.com>
References: <20171221210609.17408-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] vhost-user-test: make features mask an
 init_virtio_dev() argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

The goal is to generalize the use of [un]init_virtio_dev() to
all tests, which does not necessarily expose the same features
set.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 969e3932cc..be7a401789 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -164,7 +164,7 @@ typedef struct TestServer {
 static const char *tmpfs;
 static const char *root;
 
-static void init_virtio_dev(TestServer *s)
+static void init_virtio_dev(TestServer *s, uint32_t features_mask)
 {
     uint32_t features;
     int i;
@@ -187,7 +187,7 @@ static void init_virtio_dev(TestServer *s)
     }
 
     features = qvirtio_get_features(&s->dev->vdev);
-    features = features & (1u << VIRTIO_NET_F_MAC);
+    features = features & features_mask;
     qvirtio_set_features(&s->dev->vdev, features);
 
     qvirtio_set_driver_ok(&s->dev->vdev);
@@ -652,7 +652,7 @@ static void test_read_guest_mem(void)
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
 
-    init_virtio_dev(server);
+    init_virtio_dev(server, VIRTIO_NET_F_MAC);
 
     read_guest_mem(server);
 
@@ -681,7 +681,7 @@ static void test_migrate(void)
     from = qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s);
+    init_virtio_dev(s, VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -803,7 +803,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s);
+    init_virtio_dev(s, VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
@@ -841,7 +841,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s);
+    init_virtio_dev(s, VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
@@ -871,7 +871,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s);
+    init_virtio_dev(s, VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
-- 
2.14.3
