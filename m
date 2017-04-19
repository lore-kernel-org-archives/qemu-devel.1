Received: from eggs.gnu.org ([2001:4830:134:3::10]:51210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d0nOu-000562-3q
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <daniel@daynix.com>) id 1d0nOq-0007In-2k
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:03:56 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <daniel@daynix.com>) id 1d0nOp-0007IS-R5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 07:03:52 -0400
Received: by mail-wm0-x241.google.com with SMTP id q125so4305902wmd.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 04:03:51 -0700 (PDT)
From: Daniel Rempel <daniel@daynix.com>
Date: Wed, 19 Apr 2017 14:03:42 +0300
Message-Id: <1492599822-10331-1-git-send-email-daniel@daynix.com>
Subject: [Qemu-devel] [PATCH 1/1] qga-win: fix 1357789 - installation on
 localized windows - acquire user and group names by well-known SIDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>

Replace hardcoded user and group names ("Administrators", "SYSTEM") with the ones acquired from system. Windows uses localized strings for these names and it may cause the installation to fail.
Windows has Well-known SIDs for "Administrators" group and "SYSTEM" user so they were used to identify required users and groups.
Well-known SIDs: https://support.microsoft.com/en-us/help/243330/well-known-security-identifiers-in-windows-operating-systems

Signed-off-by: Daniel Rempel <daniel@daynix.com>
---

 qga/vss-win32/install.cpp | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index f4160a3..19220b7 100644
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
 
@@ -135,6 +138,30 @@ out:
     return hr;
 }
 
+/* Acquire group or user name by SID */
+static HRESULT getNameByStringSID(
+    const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
+{
+    HRESULT hr = S_OK;
+    PSID psid = NULL;
+    SID_NAME_USE groupType;
+    DWORD domainNameLen = BUFFER_SIZE, retval;
+    wchar_t domainName[BUFFER_SIZE];
+
+    chk(ConvertStringSidToSidW(sid, &psid));
+    retval = LookupAccountSidW(NULL, psid, buffer, bufferLen,
+                domainName, &domainNameLen, &groupType);
+
+    LocalFree(psid);
+
+    if (0 == retval) {
+        hr = HRESULT_FROM_WIN32(GetLastError());
+    }
+
+out:
+    return hr;
+}
+
 /* Find and iterate QGA VSS provider in COM+ Application Catalog */
 static HRESULT QGAProviderFind(
     HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
@@ -216,6 +243,10 @@ STDAPI COMRegister(void)
     CHAR dllPath[MAX_PATH], tlbPath[MAX_PATH];
     bool unregisterOnFailure = false;
     int count = 0;
+    DWORD bufferLen = BUFFER_SIZE;
+    wchar_t buffer[BUFFER_SIZE];
+    const wchar_t *administratorsGroupSID = L"S-1-5-32-544";
+    const wchar_t *systemUserSID = L"S-1-5-18";
 
     if (!g_hinstDll) {
         errmsg(E_FAIL, "Failed to initialize DLL");
@@ -284,11 +315,12 @@ STDAPI COMRegister(void)
 
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
@@ -303,8 +335,10 @@ STDAPI COMRegister(void)
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
