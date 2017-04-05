Received: from eggs.gnu.org ([2001:4830:134:3::10]:58494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvjcm-00088x-Ni
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cvjci-0001RH-2z
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:01:20 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cvjch-0001Qp-SY
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:01:16 -0400
Received: by mail-wr0-x241.google.com with SMTP id k6so2036765wre.3
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 05:01:15 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed,  5 Apr 2017 15:01:06 +0300
Message-Id: <20170405120106.19298-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH v2] qga-win: Fix Event Viewer errors caused by
 qemu-ga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

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
2.9.3
