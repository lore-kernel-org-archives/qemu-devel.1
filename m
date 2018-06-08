Received: from eggs.gnu.org ([2001:4830:134:3::10]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUE-0002RN-7P
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUA-0001Vl-CS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:42 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:05 -0400
Message-Id: <20180608174733.4936-3-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/30] ahci: fix PxCI register race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, qemu-stable <qemu-stable@nongnu.org>

Fixes: https://bugs.launchpad.net/qemu/+bug/1769189

AHCI presently signals completion prior to the PxCI register being
cleared to indicate completion. If a guest driver attempts to issue
a new command in its IRQ handler, it might be surprised to learn there
is still a command pending.

In the case of Windows 10's boot driver, it will actually poll the IRQ
register hoping to find out when the command is done running -- which
will never happen, as there isn't a command running.

Fix this: clear PxCI in ahci_cmd_done and not in the asynchronous BH.
Because it now runs synchronously, we don't need to check if the command
is actually done by spying on the ATA registers. We know it's done.

CC: qemu-stable <qemu-stable@nongnu.org>
Reported-by: Fran=C3=A7ois Guerraz <kubrick@fgv6.net>
Tested-by: Bruce Rogers <brogers@suse.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20180531004323.4611-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 66f55aecb3..b11640ddbb 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -532,13 +532,6 @@ static void ahci_check_cmd_bh(void *opaque)
     qemu_bh_delete(ad->check_bh);
     ad->check_bh =3D NULL;
=20
-    if ((ad->busy_slot !=3D -1) &&
-        !(ad->port.ifs[0].status & (BUSY_STAT|DRQ_STAT))) {
-        /* no longer busy */
-        ad->port_regs.cmd_issue &=3D ~(1 << ad->busy_slot);
-        ad->busy_slot =3D -1;
-    }
-
     check_cmd(ad->hba, ad->port_no);
 }
=20
@@ -1425,6 +1418,12 @@ static void ahci_cmd_done(IDEDMA *dma)
=20
     trace_ahci_cmd_done(ad->hba, ad->port_no);
=20
+    /* no longer busy */
+    if (ad->busy_slot !=3D -1) {
+        ad->port_regs.cmd_issue &=3D ~(1 << ad->busy_slot);
+        ad->busy_slot =3D -1;
+    }
+
     /* update d2h status */
     ahci_write_fis_d2h(ad);
=20
--=20
2.14.3
