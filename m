Received: from eggs.gnu.org ([2001:4830:134:3::10]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqKYm-0000eE-Pp
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqKYi-00038o-Rm
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:14:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqKYi-00038h-K4
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 10:14:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id n11so3167611wma.0
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 07:14:48 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 21 Mar 2017 16:14:35 +0200
Message-Id: <20170321141435.23701-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH qemu-ga] qemu-ga: Don't display errors to the
 user on thaw command
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

Errors that are related to ur inner implementation for the thaw command
shouldn't be displayed to the user.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/vss-win32/requester.cpp | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 0cd2f0e..272e71b 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -463,7 +463,7 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
             hr = WaitForAsync(pAsync);
         }
         if (FAILED(hr)) {
-            err_set(errset, hr, "failed to complete backup");
+            fprintf(stderr, "failed to complete backup");
         }
         break;
 
@@ -480,18 +480,18 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
 
     case VSS_E_UNEXPECTED_PROVIDER_ERROR:
         if (WaitForSingleObject(vss_ctx.hEventTimeout, 0) != WAIT_OBJECT_0) {
-            err_set(errset, hr, "unexpected error in VSS provider");
+            fprintf(stderr, "unexpected error in VSS provider");
             break;
         }
         /* fall through if hEventTimeout is signaled */
 
     case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
-        err_set(errset, hr, "couldn't hold writes: "
+        fprintf(stderr, "couldn't hold writes: "
                 "fsfreeze is limited up to 10 seconds");
         break;
 
     default:
-        err_set(errset, hr, "failed to do snapshot set");
+        fprintf(stderr, "failed to do snapshot set");
     }
 
     if (err_is_set(errset)) {
-- 
2.9.3
