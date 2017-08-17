Received: from eggs.gnu.org ([2001:4830:134:3::10]:39944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFJ-0001i5-8m
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diEFI-0006OI-Cc
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diEFI-0006Lp-3R
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:25:32 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 08:25:08 +0200
Message-Id: <1502951113-4246-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] tests: Run filter-redirector and -mirror
 test only on POSIX systems
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

This way we can get rid of the ugly #ifdefs in the code which makes
it easier to extend later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include         |  8 ++++----
 tests/test-filter-mirror.c     |  5 -----
 tests/test-filter-redirector.c | 10 ----------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 37c1bed..8d5991d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -283,8 +283,8 @@ ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
 endif
 check-qtest-i386-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
-check-qtest-i386-y += tests/test-filter-mirror$(EXESUF)
-check-qtest-i386-y += tests/test-filter-redirector$(EXESUF)
+check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-i386-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-i386-y += tests/postcopy-test$(EXESUF)
 check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
 check-qtest-i386-y += tests/numa-test$(EXESUF)
@@ -325,8 +325,8 @@ check-qtest-ppc64-y += tests/usb-hcd-xhci-test$(EXESUF)
 gcov-files-ppc64-y += hw/usb/hcd-xhci.c
 check-qtest-ppc64-y += $(check-qtest-virtio-y)
 check-qtest-ppc64-$(CONFIG_SLIRP) += tests/test-netfilter$(EXESUF)
-check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
-check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
+check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-mirror$(EXESUF)
+check-qtest-ppc64-$(CONFIG_POSIX) += tests/test-filter-redirector$(EXESUF)
 check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
 check-qtest-ppc64-y += tests/numa-test$(EXESUF)
 check-qtest-ppc64-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
diff --git a/tests/test-filter-mirror.c b/tests/test-filter-mirror.c
index 9f84402..a1d5865 100644
--- a/tests/test-filter-mirror.c
+++ b/tests/test-filter-mirror.c
@@ -17,9 +17,6 @@
 
 static void test_mirror(void)
 {
-#ifndef _WIN32
-/* socketpair(PF_UNIX) which does not exist on windows */
-
     int send_sock[2], recv_sock;
     char *cmdline;
     uint32_t ret = 0, len = 0;
@@ -74,8 +71,6 @@ static void test_mirror(void)
     g_free(recv_buf);
     close(recv_sock);
     unlink(sock_path);
-
-#endif
 }
 
 int main(int argc, char **argv)
diff --git a/tests/test-filter-redirector.c b/tests/test-filter-redirector.c
index 0c4b8d5..69c663b 100644
--- a/tests/test-filter-redirector.c
+++ b/tests/test-filter-redirector.c
@@ -59,9 +59,6 @@
 
 static void test_redirector_tx(void)
 {
-#ifndef _WIN32
-/* socketpair(PF_UNIX) which does not exist on windows */
-
     int backend_sock[2], recv_sock;
     char *cmdline;
     uint32_t ret = 0, len = 0;
@@ -129,15 +126,10 @@ static void test_redirector_tx(void)
     unlink(sock_path0);
     unlink(sock_path1);
     qtest_end();
-
-#endif
 }
 
 static void test_redirector_rx(void)
 {
-#ifndef _WIN32
-/* socketpair(PF_UNIX) which does not exist on windows */
-
     int backend_sock[2], send_sock;
     char *cmdline;
     uint32_t ret = 0, len = 0;
@@ -203,8 +195,6 @@ static void test_redirector_rx(void)
     unlink(sock_path0);
     unlink(sock_path1);
     qtest_end();
-
-#endif
 }
 
 int main(int argc, char **argv)
-- 
1.8.3.1
