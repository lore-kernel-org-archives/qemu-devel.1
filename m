Received: from eggs.gnu.org ([2001:4830:134:3::10]:38519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJD-0003G7-AK
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJ8-0003UG-DJ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47644
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7tJ8-0003TM-80
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R1JKoG057804
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:31 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dustab4eb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:31 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 21:19:30 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 20:18:46 -0500
In-Reply-To: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
References: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171027011849.29195-2-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 1/4] qga-win: don't hang if vss hold writes
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Chen Hanxiao <chenhanxiao@gmail.com>, Tomoki Sekiyama <tomoki.sekiyama@gmail.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
is executed, VSS may timeout when trying to hold writes.

Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
is logged in the Event Viewer.

At that time, if we call AbortBackup, qga may hang forever.

This patch will solve this issue.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>

Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/requester.cpp | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 301762d8b1..3d9c9716c0 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -419,6 +419,16 @@ void requester_freeze(int *num_vols, ErrorSet *errset)
             break;
         }
     }
+
+    if (wait_status == WAIT_TIMEOUT) {
+        err_set(errset, E_FAIL,
+                "timeout when try to receive Frozen event from VSS provider");
+        /* If we are here, VSS had timeout.
+         * Don't call AbortBackup, just return directly.
+         */
+        goto out1;
+    }
+
     if (wait_status != WAIT_OBJECT_0) {
         err_set(errset, E_FAIL,
                 "couldn't receive Frozen event from VSS provider");
@@ -432,6 +442,8 @@ out:
     if (vss_ctx.pVssbc) {
         vss_ctx.pVssbc->AbortBackup();
     }
+
+out1:
     requester_cleanup();
     CoUninitialize();
 }
-- 
2.11.0
