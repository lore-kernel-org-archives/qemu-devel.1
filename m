Received: from eggs.gnu.org ([2001:4830:134:3::10]:46863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZ5-0001Le-3p
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkZ4-00076m-6r
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:37 +0100
Message-Id: <20181119142944.29061-3-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] fdc: fix segfault in fdctrl_stop_transfer()
 when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

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
2.19.1
