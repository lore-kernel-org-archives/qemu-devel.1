Received: from eggs.gnu.org ([2001:4830:134:3::10]:45834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1T6-0007go-RX
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1T2-0006uA-U8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1T2-0006u3-OJ
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B000040F0D
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 12:44:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:41:55 +0200
Message-Id: <20170622124204.19407-23-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/31] msix: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/msix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index fc5fe511b3..9ac7341d71 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -438,7 +438,7 @@ void msix_save(PCIDevice *dev, QEMUFile *f)
     }
=20
     qemu_put_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
-    qemu_put_buffer(f, dev->msix_pba, (n + 7) / 8);
+    qemu_put_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
 }
=20
 /* Should be called after restoring the config space. */
@@ -453,7 +453,7 @@ void msix_load(PCIDevice *dev, QEMUFile *f)
=20
     msix_clear_all_vectors(dev);
     qemu_get_buffer(f, dev->msix_table, n * PCI_MSIX_ENTRY_SIZE);
-    qemu_get_buffer(f, dev->msix_pba, (n + 7) / 8);
+    qemu_get_buffer(f, dev->msix_pba, DIV_ROUND_UP(n, 8));
     msix_update_function_masked(dev);
=20
     for (vector =3D 0; vector < n; vector++) {
--=20
2.13.1.395.gf7b71de06
