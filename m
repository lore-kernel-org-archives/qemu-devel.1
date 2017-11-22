Received: from eggs.gnu.org ([2001:4830:134:3::10]:50970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1eHTEa-00060K-B3
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1eHTEV-00025r-Ln
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:30:28 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:41487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1eHTEV-00025G-E3
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 06:30:23 -0500
Received: by mail-wr0-x243.google.com with SMTP id z14so14206335wrb.8
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 03:30:22 -0800 (PST)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 22 Nov 2017 13:30:14 +0200
Message-Id: <20171122113014.2512-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH] qga-win: VSS: Handle
 VSS_E_PROVIDER_ALREADY_REGISTERED error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

We can get VSS_E_PROVIDER_ALREADY_REGISTERED error if for some
reason the uninstall of qemu-ga didn't complete successfully.
In this case we can try to unregister the component service
and attempt to register it again.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 qga/vss-win32/install.cpp | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 51838eeb26..e7bc5e1d9d 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -443,6 +443,15 @@ STDAPI DllRegisterServer(void)
                                      VSS_PROV_SOFTWARE,
                                      const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
                                      g_gProviderVersion);
+    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
+        DllUnregisterServer();
+        hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
+                                     const_cast<WCHAR * >(QGA_PROVIDER_LNAME),
+                                     VSS_PROV_SOFTWARE,
+                                     const_cast<WCHAR * >(QGA_PROVIDER_VERSION),
+                                     g_gProviderVersion);
+    }
+
     if (FAILED(hr)) {
         errmsg_dialog(hr, "RegisterProvider failed");
     }
-- 
2.13.6
