Received: from eggs.gnu.org ([2001:4830:134:3::10]:56594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FC-0001cf-CI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6FB-00056B-6I
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6FA-00055p-Th
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:33 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:16 +0200
Message-Id: <20170830165252.13421-9-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 08/44] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

With some small modifications, we can also use the the netfilter,
the filter-mirror and the filter-redirector tests on s390x.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1502951113-4246-3-git-send-email-thuth@redhat.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/Makefile.include         |  3 +++
 tests/test-filter-mirror.c     |  9 +++++++--
 tests/test-filter-redirector.c | 22 ++++++++++++++++------
 tests/test-netfilter.c         | 11 ++++++++++-
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 871791d2fc..f08b7418f0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -361,6 +361,9 @@ check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
 
 check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
 check-qtest-s390x-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index a1d5865ef7..d569d27657 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -25,6 +25,11 @@ static void test_mirror(void)
     char *recv_buf;
     uint32_t size = sizeof(send_buf);
     size = htonl(size);
+    const char *devstr = "e1000";
+
+    if (g_str_equal(qtest_get_arch(), "s390x")) {
+        devstr = "virtio-net-ccw";
+    }
 
     ret = socketpair(PF_UNIX, SOCK_STREAM, 0, send_sock);
     g_assert_cmpint(ret, !=, -1);
@@ -33,10 +38,10 @@ static void test_mirror(void)
     g_assert_cmpint(ret, !=, -1);
 
     cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                 "-device e1000,netdev=qtest-bn0,id=qtest-e0 "
+                 "-device %s,netdev=qtest-bn0,id=qtest-e0 "
                  "-chardev socket,id=mirror0,path=%s,server,nowait "
                  "-object filter-mirror,id=qtest-f0,netdev=qtest-bn0,queue=tx,outdev=mirror0 "
-                 , send_sock[1], sock_path);
+                 , send_sock[1], devstr, sock_path);
     qtest_start(cmdline);
     g_free(cmdline);
 
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 69c663b183..3afd41110d 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -57,6 +57,16 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 
+static const char *get_devstr(void)
+{
+    if (g_str_equal(qtest_get_arch(), "s390x")) {
+        return "virtio-net-ccw";
+    }
+
+    return "rtl8139";
+}
+
+
 static void test_redirector_tx(void)
 {
     int backend_sock[2], recv_sock;
@@ -78,7 +88,7 @@ static void test_redirector_tx(void)
     g_assert_cmpint(ret, !=, -1);
 
     cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                "-device rtl8139,netdev=qtest-bn0,id=qtest-e0 "
+                "-device %s,netdev=qtest-bn0,id=qtest-e0 "
                 "-chardev socket,id=redirector0,path=%s,server,nowait "
                 "-chardev socket,id=redirector1,path=%s,server,nowait "
                 "-chardev socket,id=redirector2,path=%s,nowait "
@@ -87,8 +97,8 @@ static void test_redirector_tx(void)
                 "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
                 "queue=tx,indev=redirector2 "
                 "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
-                "queue=tx,outdev=redirector1 "
-                , backend_sock[1], sock_path0, sock_path1, sock_path0);
+                "queue=tx,outdev=redirector1 ", backend_sock[1], get_devstr(),
+                sock_path0, sock_path1, sock_path0);
     qtest_start(cmdline);
     g_free(cmdline);
 
@@ -149,7 +159,7 @@ static void test_redirector_rx(void)
     g_assert_cmpint(ret, !=, -1);
 
     cmdline = g_strdup_printf("-netdev socket,id=qtest-bn0,fd=%d "
-                "-device rtl8139,netdev=qtest-bn0,id=qtest-e0 "
+                "-device %s,netdev=qtest-bn0,id=qtest-e0 "
                 "-chardev socket,id=redirector0,path=%s,server,nowait "
                 "-chardev socket,id=redirector1,path=%s,server,nowait "
                 "-chardev socket,id=redirector2,path=%s,nowait "
@@ -158,8 +168,8 @@ static void test_redirector_rx(void)
                 "-object filter-redirector,id=qtest-f1,netdev=qtest-bn0,"
                 "queue=rx,outdev=redirector2 "
                 "-object filter-redirector,id=qtest-f2,netdev=qtest-bn0,"
-                "queue=rx,indev=redirector1 "
-                , backend_sock[1], sock_path0, sock_path1, sock_path0);
+                "queue=rx,indev=redirector1 ", backend_sock[1], get_devstr(),
+                sock_path0, sock_path1, sock_path0);
     qtest_start(cmdline);
     g_free(cmdline);
 
diff --git a/tests/test-netfilter.c b/tests/test-netfilter.c
index 8b5a9b21b5..2506473365 100644
--- a/tests/test-netfilter.c
+++ b/tests/test-netfilter.c
@@ -182,6 +182,12 @@ static void remove_netdev_with_multi_netfilter(void)
 int main(int argc, char **argv)
 {
     int ret;
+    char *args;
+    const char *devstr = "e1000";
+
+    if (g_str_equal(qtest_get_arch(), "s390x")) {
+        devstr = "virtio-net-ccw";
+    }
 
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/netfilter/addremove_one", add_one_netfilter);
@@ -191,10 +197,13 @@ int main(int argc, char **argv)
     qtest_add_func("/netfilter/remove_netdev_multi",
                    remove_netdev_with_multi_netfilter);
 
-    qtest_start("-netdev user,id=qtest-bn0 -device e1000,netdev=qtest-bn0");
+    args = g_strdup_printf("-netdev user,id=qtest-bn0 "
+                           "-device %s,netdev=qtest-bn0", devstr);
+    qtest_start(args);
     ret = g_test_run();
 
     qtest_end();
+    g_free(args);
 
     return ret;
 }
-- 
2.13.5
