Received: from eggs.gnu.org ([2001:4830:134:3::10]:39955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFR-0001n0-28
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFN-0006Yr-S3
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFN-0006Xw-DZ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:37 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:09 +0200
Message-Id: <1502951113-4246-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] tests: Add network filter tests to the
 check-qtest-s390x list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

With some small modifications, we can also use the the netfilter,
the fiter-mirror and the filter-redirector tests on s390x.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include         |  3 +++
 tests/test-filter-mirror.c     |  9 +++++++--
 tests/test-filter-redirector.c | 22 ++++++++++++++++------
 tests/test-netfilter.c         | 11 ++++++++++-
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 8d5991d..0bb18b3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -360,6 +360,9 @@ check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
 check-qtest-xtensaeb-y = $(check-qtest-xtensa-y)
 
 check-qtest-s390x-y = tests/boot-serial-test$(EXESUF)
+check-qtest-s390x-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-s390x-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index a1d5865..d569d27 100644
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
index 69c663b..3afd411 100644
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
index 8b5a9b2..2506473 100644
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
1.8.3.1
