Received: from eggs.gnu.org ([208.118.235.92]:34406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22C-0005FU-Ej
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22B-0004Dx-9u
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:36 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1gf22B-0004DN-48
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:35 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so33377187wrx.9
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 04:23:35 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Thu,  3 Jan 2019 14:23:23 +0200
Message-Id: <20190103122323.1273034-5-basil@daynix.com>
In-Reply-To: <20190103122323.1273034-1-basil@daynix.com>
References: <20190103122323.1273034-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH 4/4] qga-win: Handle
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
 qga/vss-win32/install.cpp | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6713e58670..28deeb9f0e 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -443,6 +443,16 @@ STDAPI DllRegisterServer(void)
                                      VSS_PROV_SOFTWARE,
                                      const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
                                      g_gProviderVersion);
+    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED)
+    {
+        DllUnregisterServer();
+        hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
+                                         const_cast<WCHAR*>(QGA_PROVIDER_LNAME),
+                                         VSS_PROV_SOFTWARE,
+                                         const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
+                                         g_gProviderVersion);
+    }
+
     if (FAILED(hr)) {
         errmsg_dialog(hr, "RegisterProvider failed");
     }
-- 
2.17.2
