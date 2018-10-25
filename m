Received: from eggs.gnu.org ([2001:4830:134:3::10]:54074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFZP0-0005aa-86
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFZOw-0004Xt-5M
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:45:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFZOv-0004XV-Up
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 02:45:50 -0400
Date: Thu, 25 Oct 2018 12:15:39 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <679f5ba4-749b-72ee-62a0-40e5efc178e0@kaod.org>
Message-ID: <nycvar.YSQ.7.76.1810251204450.11480@xnncv>
References: <20181022121907.13635-1-ppandit@redhat.com>
	<20181023153710.GZ12127@umbus.hotspot.internet-for-guests.com>
	<679f5ba4-749b-72ee-62a0-40e5efc178e0@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Qemu Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Moguofang <moguofang@huawei.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

  Hello Cedric,

+-- On Wed, 24 Oct 2018, C=E9dric Le Goater wrote --+
| I think using a data[8] would be more appropriate. It would make the=20
| pnv_lpc_do_eccb() routine a little more complex. I tried to rewrite it =
to=20
| have a common one with the P9 LPC model but could not find a common pat=
tern.=20
| P9 is purely MMIO based. Something on the TODO list.
|=20
| 8 bytes accesses will then fail anyhow because all MemoryRegionOps have=
 a=20
| max_access_size =3D 4.

Thank you for these inputs, appreciate it. To confirm,

 - You plan to send a v2 patch to fix the OOB access issue along with=20
   refactoring pnv_lpc_do_eccb? If yes, kindly include me in CC please.

OR

 - While we refactor the routine for better, a patch below seem okay to f=
ix=20
   the OOB access issue?

=3D=3D=3D
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d7721320a2..655d5f3d07 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -155,9 +155,13 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc,=20
uint64_t cmd)
     /* XXX Check for magic bits at the top, addr size etc... */
     unsigned int sz =3D (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
     uint32_t opb_addr =3D cmd & ECCB_CTL_ADDR_MASK;
-    uint8_t data[4];
+    uint8_t data[8];
     bool success;
=20
+    if (sz > sizeof(data)) {
+        return;
+    }
+
     if (cmd & ECCB_CTL_READ) {
         success =3D opb_read(lpc, opb_addr, data, sz);
         if (success) {
=3D=3D=3D


Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
