Received: from eggs.gnu.org ([2001:4830:134:3::10]:38791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqegV-0002tn-Vy
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqegR-0006Vg-As
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:44:12 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqegR-0006VF-2B
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 07:44:07 -0400
Received: by mail-wr0-x244.google.com with SMTP id l37so26288536wrc.3
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 04:44:06 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 22 Mar 2017 13:43:59 +0200
Message-Id: <20170322114359.3455-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH qemu-ga] qemu-ga: Make QGA VSS provider service
 run only when needed
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

Currently the service runs in background on boot even though it is not
needed and once it is running it never stops. The service needs to be
running only during freeze operation and it should be stopped after
executing thaw.

Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
---
 qga/vss-win32/install.cpp   | 28 ++++++++++++++++++++++++++--
 qga/vss-win32/requester.cpp |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f4160a3..f41fcdf 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -14,7 +14,7 @@
 
 #include "vss-common.h"
 #include <inc/win2003/vscoordint.h>
-#include <comadmin.h>
+#include "install.h"
 #include <wbemidl.h>
 #include <comdef.h>
 #include <comutil.h>
@@ -276,7 +276,7 @@ STDAPI COMRegister(void)
 
     chk(pCatalog->CreateServiceForApplication(
             _bstr_t(QGA_PROVIDER_LNAME), _bstr_t(QGA_PROVIDER_LNAME),
-            _bstr_t(L"SERVICE_AUTO_START"), _bstr_t(L"SERVICE_ERROR_NORMAL"),
+            _bstr_t(L"SERVICE_DEMAND_START"), _bstr_t(L"SERVICE_ERROR_NORMAL"),
             _bstr_t(L""), _bstr_t(L".\\localsystem"), _bstr_t(L""), FALSE));
     chk(pCatalog->InstallComponent(_bstr_t(QGA_PROVIDER_LNAME),
                                    _bstr_t(dllPath), _bstr_t(tlbPath),
@@ -461,3 +461,27 @@ namespace _com_util
         return bstr;
     }
 }
+
+/* Stop QGA VSS provider service from COM+ Application Admin Catalog */
+
+STDAPI StopService(void)
+{
+    HRESULT hr;
+    COMInitializer initializer;
+    COMPointer<IUnknown> pUnknown;
+    COMPointer<ICOMAdminCatalog2> pCatalog;
+
+    int count = 0;
+
+    chk(QGAProviderFind(QGAProviderCount, (void *)&count));
+    if (count) {
+        chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCTX_INPROC_SERVER,
+            IID_IUnknown, (void **)pUnknown.replace()));
+        chk(pUnknown->QueryInterface(IID_ICOMAdminCatalog2,
+            (void **)pCatalog.replace()));
+        chk(pCatalog->ShutdownApplication(_bstr_t(QGA_PROVIDER_LNAME)));
+    }
+
+out:
+    return hr;
+}
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 272e71b..27308ad 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "vss-common.h"
 #include "requester.h"
+#include "install.h"
 #include <inc/win2003/vswriter.h>
 #include <inc/win2003/vsbackup.h>
 
@@ -501,4 +502,5 @@ void requester_thaw(int *num_vols, ErrorSet *errset)
     requester_cleanup();
 
     CoUninitialize();
+    StopService();
 }
-- 
2.9.3
