Received: from eggs.gnu.org ([2001:4830:134:3::10]:45827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qa-0007sM-H0
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qX-0005ey-32
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qW-0005eS-Sm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:17 -0500
Date: Thu, 21 Dec 2017 16:29:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-12-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 11/25] tests/pxe-test: Remove unnecessary
 special case test functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: David Gibson <david@gibson.dropbear.id.au>

All of the x86 and some of the other test cases here use a common test
function, test_pxe_ipv4(), but one ppc and one s390 test use different
functions.

In the s390 case, this is completely pointless, the right parameter to
test_pxe_ipv4() will already do exactly the right thing.  For the
spapr-vlan case there's a slight difference - it will use IPv6 instead of
IPv4.

But testing just one case with IPv6 (and NOT IPv4) is rather haphazard.
Change everything to use the common test function, until we have a better
way of testing IPv6 across the board.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/pxe-test.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 937f29e..eb70aa2 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -47,16 +47,6 @@ static void test_pxe_ipv4(gconstpointer data)
     g_free(dev_arg);
 }
 
-static void test_pxe_spapr_vlan(void)
-{
-    test_pxe_one("-device spapr-vlan,netdev=" NETNAME, true);
-}
-
-static void test_pxe_virtio_ccw(void)
-{
-    test_pxe_one("-device virtio-net-ccw,bootindex=1,netdev=" NETNAME, false);
-}
-
 int main(int argc, char *argv[])
 {
     int ret;
@@ -79,13 +69,14 @@ int main(int argc, char *argv[])
             qtest_add_data_func("pxe/vmxnet3", "vmxnet3", test_pxe_ipv4);
         }
     } else if (strcmp(arch, "ppc64") == 0) {
-        qtest_add_func("pxe/spapr-vlan", test_pxe_spapr_vlan);
+        qtest_add_data_func("pxe/spapr-vlan", "spapr-vlan", test_pxe_ipv4);
         if (g_test_slow()) {
             qtest_add_data_func("pxe/virtio", "virtio-net-pci", test_pxe_ipv4);
             qtest_add_data_func("pxe/e1000", "e1000", test_pxe_ipv4);
         }
     } else if (g_str_equal(arch, "s390x")) {
-        qtest_add_func("pxe/virtio-ccw", test_pxe_virtio_ccw);
+        qtest_add_data_func("pxe/virtio-ccw",
+                            "virtio-net-ccw,bootindex=1", test_pxe_ipv4);
     }
     ret = g_test_run();
     boot_sector_cleanup(disk);
-- 
MST
