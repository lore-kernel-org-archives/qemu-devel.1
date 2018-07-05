Received: from eggs.gnu.org ([2001:4830:134:3::10]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fb6vz-0002sf-Ms
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fb6vu-0002J5-Oc
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:16:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fb6vu-0002Ic-Ju
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:16:38 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  5 Jul 2018 18:16:29 +0200
Message-Id: <20180705161629.13734-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qga: fix 'driver' leak in guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mdroth@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

'driver' is leaked when the loop is not broken.

Leak introduced by commit 743c71d03c20d64f2bae5fba6f26cdf5e4b1bda6,
spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 233f78a406..c46767b0dd 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -890,6 +890,7 @@ static void build_guest_fsinfo_for_real_device(char c=
onst *syspath,
             break;
         }
=20
+        g_free(driver);
         if (sscanf(p, "/%x:%x:%x.%x%n",
                           pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=3D=
 4) {
             p +=3D pcilen;
--=20
2.18.0.rc1
