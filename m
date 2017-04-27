Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cHB-0001HA-7L
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cH6-0003lw-Ay
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3cH6-0003lf-2Z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5hont038912
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:31 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2xcmc0nt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:30 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 23:47:30 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 00:46:32 -0500
In-Reply-To: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493271996-23607-5-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 4/8] qga-win: Fix Event Viewer errors caused
 by qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sameeh Jubran <sameeh@daynix.com>

From: Sameeh Jubran <sameeh@daynix.com>

When the command "guest-fsfreeze-freeze" is executed it causes
the VSS service to log the error below in the Event Viewer. This
error is caused by an issue in the function "CommitSnapshots" in
provider.cpp:

* When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This causes
the error #12293.

|event id|                           error                               |
* 12293  : Volume Shadow Copy Service error: Error calling a routine on a
           Shadow Copy Provider {00000000-0000-0000-0000-000000000000}.
           Routine details CommitSnapshots [hr = 0x80004004, Operation
           aborted.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/provider.cpp | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index ef94669..72d8b0e 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -377,7 +377,6 @@ STDMETHODIMP CQGAVssProvider::CommitSnapshots(VSS_ID SnapshotSetId)
     if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) != WAIT_OBJECT_0) {
         /* Send event to qemu-ga to notify the provider is timed out */
         SetEvent(hEventTimeout);
-        hr = E_ABORT;
     }
 
     CloseHandle(hEventThaw);
-- 
2.7.4
