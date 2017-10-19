Received: from eggs.gnu.org ([2001:4830:134:3::10]:36249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QB-1B
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007P0-Uq
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007NU-IT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI3Huw114327
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6ve-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:35 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 01/21] tpm-tis: remove unused hw_access
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This argument is always false, simplify the code.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d5118e7..a9e9cbd 100644
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
2.5.5
