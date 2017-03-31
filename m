Received: from eggs.gnu.org ([2001:4830:134:3::10]:54975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl4-0006YQ-Pk
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ctnl1-00084J-Nc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ctnl1-000833-F0
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 00:01:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2V403BO116194
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:49 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29h2j2j8cd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 00:01:49 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 31 Mar 2017 00:01:48 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 23:01:08 -0500
In-Reply-To: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490932869-31217-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490932869-31217-2-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 1/2] qga: don't fail if mount doesn't
 have slave devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

In some cases the slave devices of a virtual block device are tracked
by the parent in the corresponding sysfs node. For instance, if we
have a loop-back mount of the form:

  /dev/loop3p1 on /home/mdroth/mnt type ext4 (rw,relatime,data=ordered)

this will be reflected in sysfs as:

  /sys/devices/virtual/block/loop3/
  ...
  /sys/devices/virtual/block/loop3/slaves
  /sys/devices/virtual/block/loop3/loop3p1

The current code however assumes the mounted virtual block device,
loop3p1 in this case, contains the slaves directory, and reports an
error otherwise. This breaks 'make check' in certain environments.

Fix this by simply skipping attempts to generate disk topology
information in these cases. Since this information is documented
in QAPI as optionally-reported, this should be ok from an API
perspective.

In the future, this can possibly be improved upon by collecting
topology information from the parent in these cases.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/commands-posix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb..915df9e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -999,7 +999,9 @@ static void build_guest_fsinfo_for_virtual_device(char const *syspath,
     dirpath = g_strdup_printf("%s/slaves", syspath);
     dir = opendir(dirpath);
     if (!dir) {
-        error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "opendir(\"%s\")", dirpath);
+        }
         g_free(dirpath);
         return;
     }
-- 
2.7.4
