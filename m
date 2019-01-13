Received: from eggs.gnu.org ([209.51.188.92]:33794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceL-0005mJ-Nt
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1giceK-0003W9-Vf
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:49 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1giceK-0003VJ-P5
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 05:05:48 -0500
Received: by mail-wm1-x342.google.com with SMTP id r24so5106531wmh.0
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 02:05:48 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Sun, 13 Jan 2019 12:05:31 +0200
Message-Id: <20190113100531.1346024-5-basil@daynix.com>
In-Reply-To: <20190113100531.1346024-1-basil@daynix.com>
References: <20190113100531.1346024-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH v2 4/4] qga-win: Handle
 VSS_E_PROVIDER_ALREADY_REGISTERED error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

This patch handles the case where VSS Provider is already registered,
where in such case qga uninstalls the provider and registers it again.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/vss-win32/install.cpp | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6713e58670..a456841360 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -443,6 +443,17 @@ STDAPI DllRegisterServer(void)
                                      VSS_PROV_SOFTWARE,
                                      const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
                                      g_gProviderVersion);
+    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
+        DllUnregisterServer();
+        hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_LNAME),
+                                         VSS_PROV_SOFTWARE,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_VERSION),
+                                         g_gProviderVersion);
+    }
+
     if (FAILED(hr)) {
         errmsg_dialog(hr, "RegisterProvider failed");
     }
-- 
2.17.2
