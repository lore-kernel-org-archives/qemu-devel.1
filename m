Received: from eggs.gnu.org ([2001:4830:134:3::10]:57845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4Jv-0003Kn-Dj
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eS4Ju-0001Bx-HC
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eS4Ju-0001BE-B6
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 12:07:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96BA2C058ED7
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 17:07:45 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 21 Dec 2017 18:07:15 +0100
Message-Id: <20171221170716.10709-5-maxime.coquelin@redhat.com>
In-Reply-To: <20171221170716.10709-1-maxime.coquelin@redhat.com>
References: <20171221170716.10709-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] vhost-user-test: fix features mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

VIRTIO_NET_F_MAC is a bit position, not a bit mask.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 tests/vhost-user-test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index be7a401789..6a144e8d7e 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -652,7 +652,7 @@ static void test_read_guest_mem(void)
     s = qtest_start(qemu_cmd);
     g_free(qemu_cmd);
 
-    init_virtio_dev(server, VIRTIO_NET_F_MAC);
+    init_virtio_dev(server, 1u << VIRTIO_NET_F_MAC);
 
     read_guest_mem(server);
 
@@ -681,7 +681,7 @@ static void test_migrate(void)
     from = qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, VIRTIO_NET_F_MAC);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     size = get_log_size(s);
     g_assert_cmpint(size, ==, (2 * 1024 * 1024) / (VHOST_LOG_PAGE * 8));
@@ -803,7 +803,7 @@ static void test_reconnect_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, VIRTIO_NET_F_MAC);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
@@ -841,7 +841,7 @@ static void test_connect_fail_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, VIRTIO_NET_F_MAC);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
@@ -871,7 +871,7 @@ static void test_flags_mismatch_subprocess(void)
     qtest_start(cmd);
     g_free(cmd);
 
-    init_virtio_dev(s, VIRTIO_NET_F_MAC);
+    init_virtio_dev(s, 1u << VIRTIO_NET_F_MAC);
     wait_for_fds(s);
     wait_for_rings_started(s, 2);
 
-- 
2.14.3
