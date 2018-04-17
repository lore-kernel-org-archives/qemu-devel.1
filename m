Received: from eggs.gnu.org ([2001:4830:134:3::10]:53432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si9-0001L6-H4
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8Si8-0005K5-34
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 11:40:01 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Apr 2018 17:39:40 +0200
Message-Id: <20180417153945.20737-2-pbonzini@redhat.com>
In-Reply-To: <20180417153945.20737-1-pbonzini@redhat.com>
References: <20180417153945.20737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] ahci: move PIO Setup FIS before transfer,
 fix it for ATAPI commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org

The PIO Setup FIS is written in the PIO:Entry state, which comes before
the ATA and ATAPI data transfer states.  As a result, the PIO Setup FIS
interrupt is now raised before DMA ends for ATAPI commands, and tests hav=
e
to be adjusted.

This is also hinted by the description of the command header in the AHCI
specification, where the "A" bit is described as

    When =E2=80=981=E2=80=99, indicates that a PIO setup FIS shall be sen=
t by the device
    indicating a transfer for the ATAPI command.

and also by the description of the ACMD (ATAPI command region):

    The ATAPI command must be either 12 or 16 bytes in length. The length
    transmitted by the HBA is determined by the PIO setup FIS that is sen=
t
    by the device requesting the ATAPI command.

QEMU, which conflates the "generator" and the "receiver" of the FIS into
one device, always uses ATAPI_PACKET_SIZE, aka 12, for the length.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ide/ahci.c       | 15 ++++++---------
 tests/libqos/ahci.c | 30 ++++++++++++++++++++++++++----
 tests/libqos/ahci.h |  2 ++
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index e22d7be05f..45ce195fb8 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1291,11 +1291,12 @@ static void ahci_start_transfer(IDEDMA *dma)
     int is_write =3D opts & AHCI_CMD_WRITE;
     int is_atapi =3D opts & AHCI_CMD_ATAPI;
     int has_sglist =3D 0;
+    uint16_t fis_len;
=20
     if (is_atapi && !ad->done_atapi_packet) {
         /* already prepopulated iobuffer */
         ad->done_atapi_packet =3D true;
-        size =3D 0;
+        fis_len =3D size;
         goto out;
     }
=20
@@ -1315,19 +1316,15 @@ static void ahci_start_transfer(IDEDMA *dma)
         }
     }
=20
+    /* Update number of transferred bytes, destroy sglist */
+    dma_buf_commit(s, size);
+    fis_len =3D le32_to_cpu(ad->cur_cmd->status);
 out:
     /* declare that we processed everything */
     s->data_ptr =3D s->data_end;
-
-    /* Update number of transferred bytes, destroy sglist */
-    dma_buf_commit(s, size);
+    ahci_write_fis_pio(ad, fis_len);
=20
     s->end_transfer_func(s);
-
-    if (!(s->status & DRQ_STAT)) {
-        /* done with PIO send/receive */
-        ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
-    }
 }
=20
 static void ahci_start_dma(IDEDMA *dma, IDEState *s,
diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index bc201d762b..04f33e246c 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -477,6 +477,23 @@ void ahci_port_check_d2h_sanity(AHCIQState *ahci, ui=
nt8_t port, uint8_t slot)
     g_free(d2h);
 }
=20
+void ahci_port_check_pio_sanity_atapi(AHCIQState *ahci, uint8_t port,
+                                      uint8_t slot)
+{
+    PIOSetupFIS *pio =3D g_malloc0(0x20);
+
+    /* We cannot check the Status or E_Status registers, because
+     * the status may have again changed between the PIO Setup FIS
+     * and the conclusion of the command with the D2H Register FIS. */
+    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, 0x=
20);
+    g_assert_cmphex(pio->fis_type, =3D=3D, 0x5f);
+
+    g_assert(le16_to_cpu(pio->tx_count) =3D=3D 12 ||
+             le16_to_cpu(pio->tx_count) =3D=3D 16);
+
+    g_free(pio);
+}
+
 void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
                                 uint8_t slot, size_t buffsize)
 {
@@ -831,9 +848,9 @@ void ahci_command_enable_atapi_dma(AHCICommand *cmd)
     RegH2DFIS *fis =3D &(cmd->fis);
     g_assert(cmd->props->atapi);
     fis->feature_low |=3D 0x01;
-    cmd->interrupts &=3D ~AHCI_PX_IS_PSS;
+    /* PIO is still used to transfer the ATAPI command */
+    g_assert(cmd->props->pio);
     cmd->props->dma =3D true;
-    cmd->props->pio =3D false;
     /* BUG: We expect the DMA Setup interrupt for DMA commands */
     /* cmd->interrupts |=3D AHCI_PX_IS_DSS; */
 }
@@ -845,7 +862,7 @@ AHCICommand *ahci_command_create(uint8_t command_name=
)
=20
     g_assert(props);
     cmd =3D g_new0(AHCICommand, 1);
-    g_assert(!(props->dma && props->pio));
+    g_assert(!(props->dma && props->pio) || props->atapi);
     g_assert(!(props->lba28 && props->lba48));
     g_assert(!(props->read && props->write));
     g_assert(!props->size || props->data);
@@ -1216,7 +1233,12 @@ void ahci_command_verify(AHCIQState *ahci, AHCICom=
mand *cmd)
         ahci_port_check_d2h_sanity(ahci, port, slot);
     }
     if (cmd->props->pio) {
-        ahci_port_check_pio_sanity(ahci, port, slot, cmd->xbytes);
+        /* For ATAPI, we might have only used PIO for the command.  */
+        if (cmd->props->atapi && (!cmd->xbytes || cmd->props->dma)) {
+            ahci_port_check_pio_sanity_atapi(ahci, port, slot);
+        } else {
+            ahci_port_check_pio_sanity(ahci, port, slot, cmd->xbytes);
+        }
     }
 }
=20
diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
index 715ca1e226..cdba8099dd 100644
--- a/tests/libqos/ahci.h
+++ b/tests/libqos/ahci.h
@@ -598,6 +598,8 @@ void ahci_port_check_nonbusy(AHCIQState *ahci, uint8_=
t port, uint8_t slot);
 void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t =
slot);
 void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
                                 uint8_t slot, size_t buffsize);
+void ahci_port_check_pio_sanity_atapi(AHCIQState *ahci, uint8_t port,
+                                      uint8_t slot);
 void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
=20
 /* Misc */
--=20
2.17.0
