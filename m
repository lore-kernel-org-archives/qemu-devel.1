Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cjWen-0004C6-Oy
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1cjWek-0007Kg-Ao
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:44:57 -0500
Received: from inet-orm.provo.novell.com ([137.65.248.124]:60929
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1cjWek-0007KQ-0t
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:44:54 -0500
From: Bruce Rogers <brogers@suse.com>
Date: Thu,  2 Mar 2017 12:44:37 -0700
Message-Id: <20170302194437.21823-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH] tests: check path to avoid a failing
 qga/get-vcpus test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Bruce Rogers <brogers@suse.com>

The qga/get-vcpus test fails in a simple chroot environment, as
used in an openSUSE Build Service local build, so first check
that the sysfs based path exists in order to avoid calling this
test in an environment where it won't work right.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 tests/test-qga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 868b02a40f..9e6d19a6e1 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -924,7 +924,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
-    g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
+    if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
+        g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
+    }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
-- 
2.11.1
