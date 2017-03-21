Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqHMZ-0005Ug-9t
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqHMV-0007pp-9T
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:50:03 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqHMV-0007pI-1Z
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 06:49:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id u48so21916228wrc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 03:49:58 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 21 Mar 2017 12:49:52 +0200
Message-Id: <20170321104952.6236-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH] Fix Event Viewer errors caused by qemu-ga
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
the VSS service to log the errors below in the Event Viewer.

These errors are caused by two issues in the function "CommitSnapshots" in
provider.cpp:

1. When VSS_TIMEOUT_MSEC expires the funtion returns E_ABORT. This causes
the error #12293.

2. The VSS_TIMEOUT_MSEC value is too big. According to msdn the
"Flush & Hold" operation has 10 seconds timeout not configurable, The
"CommitSnapshots" is a part of the "Flush & Hold" process and thus any
timeout bigger than 10 seconds would cause the error #12298 and anything
bigger than 40 seconds causes the error #12340. All this info can be found here:
https://msdn.microsoft.com/en-us/library/windows/desktop/aa384589(v=vs.85).aspx

|event id|                           error                               |
* 12293  : Volume Shadow Copy Service error: Error calling a routine on a
           Shadow Copy Provider {00000000-0000-0000-0000-000000000000}.
       Routine details CommitSnapshots [hr = 0x80004004, Operation
       aborted.

* 12340  : Volume Shadow Copy Error: VSS waited more than 40 seconds for
           all volumes to be flushed.  This caused volume
       \\?\Volume{62a171da-32ec-11e4-80b1-806e6f6e6963}\ to timeout
       while waiting for the release-writes phase of shadow copy
       creation. Trying again when disk activity is lower may solve
       this problem.

* 12298  : Volume Shadow Copy Service error: The I/O writes cannot be held
           during the shadow copy creation period on volume
           \\?\Volume{62a171d9-32ec-11e4-80b1-806e6f6e6963}\. The volume
       index in the shadow copy set is 0. Error details:
       Open[0x00000000, The operation completed successfully. ],
       Flush[0x00000000, The operation completed successfully.],
       Release[0x00000000, The operation completed successfully.],
       OnRun[0x80042314, The shadow copy provider timed out while
       holding writes to the volume being shadow copied. This is
       probably due to excessive activity on the volume by an
       application or a system service. Try again later when activity
       on the volume is reduced.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/vss-win32/provider.cpp | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
index ef94669..d72f4d4 100644
--- a/qga/vss-win32/provider.cpp
+++ b/qga/vss-win32/provider.cpp
@@ -15,7 +15,7 @@
 #include <inc/win2003/vscoordint.h>
 #include <inc/win2003/vsprov.h>
 
-#define VSS_TIMEOUT_MSEC (60*1000)
+#define VSS_TIMEOUT_MSEC (9 * 1000)
 
 static long g_nComObjsInUse;
 HINSTANCE g_hinstDll;
@@ -377,7 +377,6 @@ STDMETHODIMP CQGAVssProvider::CommitSnapshots(VSS_ID SnapshotSetId)
     if (WaitForSingleObject(hEventThaw, VSS_TIMEOUT_MSEC) != WAIT_OBJECT_0) {
         /* Send event to qemu-ga to notify the provider is timed out */
         SetEvent(hEventTimeout);
-        hr = E_ABORT;
     }
 
     CloseHandle(hEventThaw);
-- 
2.9.3
