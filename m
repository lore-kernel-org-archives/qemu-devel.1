Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJF-0003Gr-4k
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7tJA-0003Zn-6p
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7tJA-0003YM-14
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 21:19:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9R1JGFk114582
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:34 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dunngw95j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 21:19:34 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 21:19:33 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 20:18:49 -0500
In-Reply-To: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
References: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20171027011849.29195-5-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/4] qga-win: fix error-handling in
 getNameByStringSID()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

In one case we misconstrue a BOOL return as an HRESULT, and in the
other case we don't check the BOOL return from LookupAccountSidW()
before extracting the HRESULT from GetLastError(). Both can lead to
getNameByStringSID() misreporting an error.

Reported-by: Chen Hanxiao <chenhanxiao@gmail.com>
Suggested-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/install.cpp | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index ba7c94eb25..6713e58670 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -148,10 +148,15 @@ static HRESULT getNameByStringSID(
     DWORD domainNameLen =3D BUFFER_SIZE;
     wchar_t domainName[BUFFER_SIZE];
=20
-    chk(ConvertStringSidToSidW(sid, &psid));
-    LookupAccountSidW(NULL, psid, buffer, bufferLen,
-                domainName, &domainNameLen, &groupType);
-    hr =3D HRESULT_FROM_WIN32(GetLastError());
+    if (!ConvertStringSidToSidW(sid, &psid)) {
+        hr =3D HRESULT_FROM_WIN32(GetLastError());
+        goto out;
+    }
+    if (!LookupAccountSidW(NULL, psid, buffer, bufferLen,
+                           domainName, &domainNameLen, &groupType)) {
+        hr =3D HRESULT_FROM_WIN32(GetLastError());
+        /* Fall through and free psid */
+    }
=20
     LocalFree(psid);
=20
--=20
2.11.0
