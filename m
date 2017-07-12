Received: from eggs.gnu.org ([2001:4830:134:3::10]:39470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVI85-0008NV-44
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVI81-0000qZ-4u
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:56:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Wed, 12 Jul 2017 16:38:05 +0300
Message-Id: <9bd8e9330ade42878b19a5172131087220d590d5.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
References: <cover.1499866676.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/13] qga-win32: Fix memory leak of device
 information set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Ping <li.ping288@zte.com.cn>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Li Ping <li.ping288@zte.com.cn>

The caller of SetupDiGetClassDevs must delete the returned device informa=
tion
 set when it is no longer needed by calling SetupDiDestroyDeviceInfoList.

Signed-off-by: Li Ping <li.ping288@zte.com.cn>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qga/commands-win32.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 439d229225..6f1645747b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -512,7 +512,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
             } else {
                 error_setg_win32(errp, GetLastError(),
                         "failed to get device name");
-                goto out;
+                goto free_dev_info;
             }
         }
=20
@@ -560,6 +560,9 @@ static GuestPCIAddress *get_pci_info(char *guid, Erro=
r **errp)
         pci->bus =3D bus;
         break;
     }
+
+free_dev_info:
+    SetupDiDestroyDeviceInfoList(dev_info);
 out:
     g_free(buffer);
     g_free(name);
--=20
2.11.0
