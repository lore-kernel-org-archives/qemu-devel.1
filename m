Received: from eggs.gnu.org ([2001:4830:134:3::10]:54713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dxrKf-0002aD-TR
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dxrKb-00015b-TW
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:11:41 -0400
Received: from m15-114.126.com ([220.181.15.114]:37094)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1dxrKb-00013I-2w
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 05:11:37 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri, 29 Sep 2017 17:11:22 +0800
Message-Id: <20170929091122.22726-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH] qga-win: fall back to hardcoded user and group
 names if LookupAccountSidW failed
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Chen Hanxiao <chen_han_xiao@126.com>
List-ID: <qemu-devel.nongnu.org>

From: Chen Hanxiao <chenhanxiao@gmail.com>

On some of windows (win08 sp2),
it doesn't work by calling LookupAccountSidW with
well-known SIDs,
We got an error:
    error 997 overlapped I/O operation is in progress

But hardcoded names work.

This patch introduces a workaroud for this issue:
if LookupAccountSidW failed, try hardcoded one.

Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
 qga/vss-win32/install.cpp | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ba7c94eb25..dcf6299af9 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -312,7 +312,10 @@ STDAPI COMRegister(void)
 
     /* Setup roles of the applicaion */
 
-    chk(getNameByStringSID(administratorsGroupSID, buffer, &bufferLen));
+    hr = getNameByStringSID(administratorsGroupSID, buffer, &bufferLen);
+    if (FAILED(hr)) {
+        wsprintfW(buffer, L"%ls", L"Administrators");
+    }
     chk(pApps->GetCollection(_bstr_t(L"Roles"), key,
                              (IDispatch **)pRoles.replace()));
     chk(pRoles->Populate());
@@ -333,7 +336,10 @@ STDAPI COMRegister(void)
     chk(put_Value(pObj, L"User", _bstr_t(".\\") + name));
 
     bufferLen = BUFFER_SIZE;
-    chk(getNameByStringSID(systemUserSID, buffer, &bufferLen));
+    hr = getNameByStringSID(systemUserSID, buffer, &bufferLen);
+    if (FAILED(hr)) {
+        wsprintfW(buffer, L"%ls", L"SYSTEM");
+    }
     chk(pUsersInRole->Add((IDispatch **)pObj.replace()));
     chk(put_Value(pObj, L"User", buffer));
     chk(pUsersInRole->SaveChanges(&n));
-- 
2.13.5
