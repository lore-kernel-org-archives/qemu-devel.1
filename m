Received: from eggs.gnu.org ([209.51.188.92]:42803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB473-0003aN-G4
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB472-0004vn-6N
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42344
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB472-0004nT-0s
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4dLC053700
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx5919-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:45 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:15 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 16:00:07 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-94-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 93/97] qga: update docs with systemd suspend
 support info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

Commit 067927d62e ("qga: systemd hibernate/suspend/hybrid-sleep
support") failed to update qapi-schema.json after adding systemd
hibernate/suspend/hybrid-sleep capabilities to guest-suspend-* QGA
commands.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit bb6c8d407e49d7b805ac52fe46abf4d8d5262046)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index dfbc4a5e32..6a472476a2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -532,12 +532,12 @@
 #
 # Suspend guest to disk.
 #
-# This command tries to execute the scripts provided by the pm-utils package.
-# If it's not available, the suspend operation will be performed by manually
-# writing to a sysfs file.
+# This command attempts to suspend the guest using three strategies, in this
+# order:
 #
-# For the best results it's strongly recommended to have the pm-utils
-# package installed in the guest.
+# - systemd hibernate
+# - pm-utils (via pm-hibernate)
+# - manual write into sysfs
 #
 # This command does NOT return a response on success. There is a high chance
 # the command succeeded if the VM exits with a zero exit status or, when
@@ -560,12 +560,12 @@
 #
 # Suspend guest to ram.
 #
-# This command tries to execute the scripts provided by the pm-utils package.
-# If it's not available, the suspend operation will be performed by manually
-# writing to a sysfs file.
+# This command attempts to suspend the guest using three strategies, in this
+# order:
 #
-# For the best results it's strongly recommended to have the pm-utils
-# package installed in the guest.
+# - systemd suspend
+# - pm-utils (via pm-suspend)
+# - manual write into sysfs
 #
 # IMPORTANT: guest-suspend-ram requires QEMU to support the 'system_wakeup'
 # command.  Thus, it's *required* to query QEMU for the presence of the
@@ -592,7 +592,10 @@
 #
 # Save guest state to disk and suspend to ram.
 #
-# This command requires the pm-utils package to be installed in the guest.
+# This command attempts to suspend the guest by executing, in this order:
+#
+# - systemd hybrid-sleep
+# - pm-utils (via pm-suspend-hybrid)
 #
 # IMPORTANT: guest-suspend-hybrid requires QEMU to support the 'system_wakeup'
 # command.  Thus, it's *required* to query QEMU for the presence of the
-- 
2.17.1
