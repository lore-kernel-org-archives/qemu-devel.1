Received: from eggs.gnu.org ([209.51.188.92]:43254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47U-00049P-7M
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB47F-0005D5-VE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46954
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB47E-0004xC-Nc
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4fR9053871
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:05:01 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx58gt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:41 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:42 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:36 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-63-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 62/97] fdc: fix segfault in
 fdctrl_stop_transfer() when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commit c8a35f1cf0f "fdc: use IsaDma interface instead of global DMA_*
functions" accidentally introduced a segfault in fdctrl_stop_transfer() f=
or
non-DMA transfers.

If fdctrl->dma_chann has not been configured then the fdctrl->dma interfa=
ce
reference isn't initialised during isabus_fdc_realize(). Unfortunately
fdctrl_stop_transfer() unconditionally references the DMA interface when
finishing the transfer causing a NULL pointer dereference.

Fix the issue by adding a check in fdctrl_stop_transfer() so that the DMA
interface reference and release method is only invoked if fdctrl->dma_cha=
nn
has been set.

(This issue was discovered by Martin testing a recent change in the NetBS=
D
installer under qemu-system-sparc)

Cc: qemu-stable@nongnu.org
Reported-by: Martin Husemann <martin@duskware.de>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 441f6692ecc14859b77af2ac6d8f55e6f1354d3b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/block/fdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 2e9c1e1e2f..6f19f127a5 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1617,7 +1617,7 @@ static void fdctrl_stop_transfer(FDCtrl *fdctrl, ui=
nt8_t status0,
     fdctrl->fifo[5] =3D cur_drv->sect;
     fdctrl->fifo[6] =3D FD_SECTOR_SC;
     fdctrl->data_dir =3D FD_DIR_READ;
-    if (!(fdctrl->msr & FD_MSR_NONDMA)) {
+    if (fdctrl->dma_chann !=3D -1 && !(fdctrl->msr & FD_MSR_NONDMA)) {
         IsaDmaClass *k =3D ISADMA_GET_CLASS(fdctrl->dma);
         k->release_DREQ(fdctrl->dma, fdctrl->dma_chann);
     }
--=20
2.17.1
