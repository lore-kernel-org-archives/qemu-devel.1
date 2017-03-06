Received: from eggs.gnu.org ([2001:4830:134:3::10]:60373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cknec-0002iP-Ge
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckneZ-0006VM-AQ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ckneZ-0006Uj-14
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:05:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2683r9a090909
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 03:05:57 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28yva2qa2r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:05:57 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 01:05:56 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  6 Mar 2017 02:03:42 -0600
In-Reply-To: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1488787422-30487-4-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 3/3] tests: check path to avoid a
 failing qga/get-vcpus test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Bruce Rogers <brogers@suse.com>

From: Bruce Rogers <brogers@suse.com>

The qga/get-vcpus test fails in a simple chroot environment, as
used in an openSUSE Build Service local build, so first check
that the sysfs based path exists in order to avoid calling this
test in an environment where it won't work right.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tests/test-qga.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 868b02a..9e6d19a 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -924,7 +924,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/qga/info", &fix, test_qga_info);
     g_test_add_data_func("/qga/network-get-interfaces", &fix,
                          test_qga_network_get_interfaces);
-    g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
+    if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
+        g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus)=
;
+    }
     g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
     g_test_add_data_func("/qga/get-memory-block-info", &fix,
                          test_qga_get_memory_block_info);
--=20
2.7.4
