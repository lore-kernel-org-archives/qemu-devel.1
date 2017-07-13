Received: from eggs.gnu.org ([2001:4830:134:3::10]:43329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4t-0005EO-PT
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4s-0005ki-JM
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:59 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:11 +0200
Message-Id: <20170713163219.9024-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/29] msix: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/msix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 5078d3dd19..c944c02135 100644
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
