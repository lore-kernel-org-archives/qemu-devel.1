Received: from eggs.gnu.org ([2001:4830:134:3::10]:45897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d3jMC-0004Ai-81
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d3jMA-0001bN-5R
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:16 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@daynix.com>) id 1d3jM9-0001b9-UZ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:21:14 -0400
Received: by mail-wr0-x244.google.com with SMTP id g12so3768684wrg.2
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 06:21:13 -0700 (PDT)
From: Daniel Rempel <daniel@daynix.com>
Date: Thu, 27 Apr 2017 16:21:04 +0300
Message-Id: <1493299264-10669-2-git-send-email-daniel@daynix.com>
In-Reply-To: <1493299264-10669-1-git-send-email-daniel@daynix.com>
References: <1493299264-10669-1-git-send-email-daniel@daynix.com>
Subject: [Qemu-devel] [PATCH v2 1/1] qga-win: fix installation on localized
 windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1357789
Replace hardcoded user and group names ("Administrators", "SYSTEM") with the ones acquired from system. Windows uses localized strings for these names and it may cause the installation to fail.
Windows has Well-known SIDs for "Administrators" group and "SYSTEM" user so they were used to identify required users and groups.
Well-known SIDs: https://support.microsoft.com/en-us/help/243330/well-known-security-identifiers-in-windows-operating-systems

Signed-off-by: Daniel Rempel <daniel@daynix.com>
---
 qga/vss-win32/install.cpp | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f4160a3..1be482a 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -18,6 +18,9 @@
 #include <wbemidl.h>
 #include <comdef.h>
 #include <comutil.h>
+#include <sddl.h>
+
+#define BUFFER_SIZE 1024
 
 extern HINSTANCE g_hinstDll;
 
@@ -135,6 +138,27 @@ out:
     return hr;
 }
 
+/* Acquire group or user name by SID */
+static HRESULT getNameByStringSID(
+    const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
+{
+    HRESULT hr = S_OK;
+    PSID psid = NULL;
+    SID_NAME_USE groupType;
+    DWORD domainNameLen = BUFFER_SIZE;
+    wchar_t domainName[BUFFER_SIZE];
+
+    chk(ConvertStringSidToSidW(sid, &psid));
+    LookupAccountSidW(NULL, psid, buffer, bufferLen,
+                domainName, &domainNameLen, &groupType);
+    hr = HRESULT_FROM_WIN32(GetLastError());
+
+    LocalFree(psid);
+
+out:
+    return hr;
+}
+
 /* Find and iterate QGA VSS provider in COM+ Application Catalog */
 static HRESULT QGAProviderFind(
     HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
@@ -216,6 +240,10 @@ STDAPI COMRegister(void)
     CHAR dllPath[MAX_PATH], tlbPath[MAX_PATH];
     bool unregisterOnFailure = false;
     int count = 0;
+    DWORD bufferLen = BUFFER_SIZE;
+    wchar_t buffer[BUFFER_SIZE];
+    const wchar_t *administratorsGroupSID = L"S-1-5-32-544";
+    const wchar_t *systemUserSID = L"S-1-5-18";
 
     if (!g_hinstDll) {
         errmsg(E_FAIL, "Failed to initialize DLL");
@@ -284,11 +312,12 @@ STDAPI COMRegister(void)
 
     /* Setup roles of the applicaion */
 
+    chk(getNameByStringSID(administratorsGroupSID, buffer, &bufferLen));
     chk(pApps->GetCollection(_bstr_t(L"Roles"), key,
                              (IDispatch **)pRoles.replace()));
     chk(pRoles->Populate());
     chk(pRoles->Add((IDispatch **)pObj.replace()));
-    chk(put_Value(pObj, L"Name",        L"Administrators"));
+    chk(put_Value(pObj, L"Name", buffer));
     chk(put_Value(pObj, L"Description", L"Administrators group"));
     chk(pRoles->SaveChanges(&n));
     chk(pObj->get_Key(&key));
@@ -303,8 +332,10 @@ STDAPI COMRegister(void)
     chk(GetAdminName(&name));
     chk(put_Value(pObj, L"User", _bstr_t(".\\") + name));
 
+    bufferLen = BUFFER_SIZE;
+    chk(getNameByStringSID(systemUserSID, buffer, &bufferLen));
     chk(pUsersInRole->Add((IDispatch **)pObj.replace()));
-    chk(put_Value(pObj, L"User", L"SYSTEM"));
+    chk(put_Value(pObj, L"User", buffer));
     chk(pUsersInRole->SaveChanges(&n));
 
 out:
-- 
2.9.3
