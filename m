Received: from eggs.gnu.org ([2001:4830:134:3::10]:46430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dOFAE-00058w-T1
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dOFAA-0004y5-5m
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:21:42 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39172)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <li.ping288@zte.com.cn>) id 1dOFA9-0004jO-JF
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 23:21:38 -0400
From: Li Ping <li.ping288@zte.com.cn>
Date: Fri, 23 Jun 2017 11:17:43 +0800
Message-Id: <1498187863-4937-1-git-send-email-li.ping288@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND] QEMU Guest Agent: Fix memory leak of
 device information set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: marcandre.lureau@redhat.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Li Ping <li.ping288@zte.com.cn>

The caller of SetupDiGetClassDevs must delete the returned device informati=
on
 set when it is no longer needed by calling SetupDiDestroyDeviceInfoList.

Signed-off-by: Li Ping <li.ping288@zte.com.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229..6f16457 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -512,7 +512,7 @@ static GuestPCIAddress *get=5Fpci=5Finfo(char *guid, Er=
ror **errp)
             } else {
                 error=5Fsetg=5Fwin32(errp, GetLastError(),
                         "failed to get device name");
-                goto out;
+                goto free=5Fdev=5Finfo;
             }
         }
=20
@@ -560,6 +560,9 @@ static GuestPCIAddress *get=5Fpci=5Finfo(char *guid, Er=
ror **errp)
         pci->bus =3D bus;
         break;
     }
+
+free=5Fdev=5Finfo:
+    SetupDiDestroyDeviceInfoList(dev=5Finfo);
 out:
     g=5Ffree(buffer);
     g=5Ffree(name);
--=20
1.8.3.1
