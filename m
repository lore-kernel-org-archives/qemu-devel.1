Received: from eggs.gnu.org ([2001:4830:134:3::10]:54326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyP-0005Jy-9R
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyN-0004jp-5R
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyM-0004iz-V3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:31 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:42 +0200
Message-Id: <20171009225623.29232-2-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/42] tpm-tis: remove unused hw_access argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

This argument is always false, simplify the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d5118e7f60..a9e9cbdeb2 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -615,9 +615,8 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
  * Write a value to a register of the TIS interface
  * See specs pages 33-63 for description of the registers
  */
-static void tpm_tis_mmio_write_intern(void *opaque, hwaddr addr,
-                                      uint64_t val, unsigned size,
-                                      bool hw_access)
+static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
 {
     TPMState *s =3D opaque;
     TPMTISEmuState *tis =3D &s->s.tis;
@@ -631,7 +630,7 @@ static void tpm_tis_mmio_write_intern(void *opaque, h=
waddr addr,
=20
     DPRINTF("tpm_tis: write.%u(%08x) =3D %08x\n", size, (int)addr, (int)=
val);
=20
-    if (locty =3D=3D 4 && !hw_access) {
+    if (locty =3D=3D 4) {
         DPRINTF("tpm_tis: Access to locality 4 only allowed from hardwar=
e\n");
         return;
     }
@@ -942,12 +941,6 @@ static void tpm_tis_mmio_write_intern(void *opaque, =
hwaddr addr,
     }
 }
=20
-static void tpm_tis_mmio_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
-{
-    tpm_tis_mmio_write_intern(opaque, addr, val, size, false);
-}
-
 static const MemoryRegionOps tpm_tis_memory_ops =3D {
     .read =3D tpm_tis_mmio_read,
     .write =3D tpm_tis_mmio_write,
--=20
2.14.1.146.gd35faa819
