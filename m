Received: from eggs.gnu.org ([209.51.188.92]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8g-0000cF-UW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8e-0007du-ID
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:59 +1100
Message-Id: <20190204090124.26191-13-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/37] hw/ppc/spapr: Encode the SCSI channel
 (bus) in the SRP LUNs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

In hw/scsi/spapr_vio.c we declare that the controller supports multiple
buses by specifying "max_channel =3D 7" there. So in the code that fixes
up the device tree nodes, we must encode the channel number (a.k.a. bus
number in the "Logical unit addressing format" table of SAM5) into the
64-bit LUN, too.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1663160
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0942f35bf8..71fe552c83 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2959,10 +2959,11 @@ static char *spapr_get_fw_dev_path(FWPathProvider=
 *p, BusState *bus,
         if (spapr) {
             /*
              * Replace "channel@0/disk@0,0" with "disk@8000000000000000"=
:
-             * We use SRP luns of the form 8000 | (bus << 8) | (id << 5)=
 | lun
-             * in the top 16 bits of the 64-bit LUN
+             * In the top 16 bits of the 64-bit LUN, we use SRP luns of =
the form
+             * 0x8000 | (target << 8) | (bus << 5) | lun
+             * (see the "Logical unit addressing format" table in SAM5)
              */
-            unsigned id =3D 0x8000 | (d->id << 8) | d->lun;
+            unsigned id =3D 0x8000 | (d->id << 8) | (d->channel << 5) | =
d->lun;
             return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
                                    (uint64_t)id << 48);
         } else if (virtio) {
--=20
2.20.1
