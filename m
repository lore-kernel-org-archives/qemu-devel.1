Received: from eggs.gnu.org ([2001:4830:134:3::10]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6F9-0001ZN-3q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6F6-00053U-KS
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6F6-00052w-BA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:15 +0200
Message-Id: <20170830165252.13421-8-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/44] tests: Run filter-redirector and -mirror
 test only on POSIX systems
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

This way we can get rid of the ugly #ifdefs in the code which makes
it easier to extend later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1502951113-4246-2-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/Makefile.include         |  8 ++++----
 tests/test-filter-mirror.c     |  5 -----
 tests/test-filter-redirector.c | 10 ----------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ea0f15f70b..871791d2fc 100644
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
index 9f84402493..a1d5865ef7 100644
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
index 0c4b8d52ef..69c663b183 100644
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
2.13.5
