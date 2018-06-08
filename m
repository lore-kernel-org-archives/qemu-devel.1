Received: from eggs.gnu.org ([2001:4830:134:3::10]:48000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUK-0002Vk-0u
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUH-0001dv-3K
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUG-0001dM-Qx
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:28 -0400
Message-Id: <20180608174733.4936-26-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/30] ahci: move PIO Setup FIS before transfer,
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
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

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
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-3-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 18 ++++++------------
 tests/libqos/ahci.c | 35 +++++++++++++++++++++--------------
 tests/libqos/ahci.h |  3 +--
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 571e32dd66..f25bef501d 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1259,7 +1259,6 @@ static void handle_reg_h2d_fis(AHCIState *s, int po=
rt,
             g_free(pretty_fis);
         }
         s->dev[port].done_atapi_packet =3D false;
-        /* XXX send PIO setup FIS */
     }
=20
     ide_state->error =3D 0;
@@ -1353,10 +1352,12 @@ static void ahci_start_transfer(IDEDMA *dma)
     int is_atapi =3D opts & AHCI_CMD_ATAPI;
     int has_sglist =3D 0;
=20
+    /* PIO FIS gets written prior to transfer */
+    ahci_write_fis_pio(ad, size);
+
     if (is_atapi && !ad->done_atapi_packet) {
         /* already prepopulated iobuffer */
         ad->done_atapi_packet =3D true;
-        size =3D 0;
         goto out;
     }
=20
@@ -1376,19 +1377,12 @@ static void ahci_start_transfer(IDEDMA *dma)
         }
     }
=20
-out:
-    /* declare that we processed everything */
-    s->data_ptr =3D s->data_end;
-
     /* Update number of transferred bytes, destroy sglist */
     dma_buf_commit(s, size);
-
+out:
+    /* declare that we processed everything */
+    s->data_ptr =3D s->data_end;
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
index 63e1f9b92d..7264e085d0 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -478,10 +478,10 @@ void ahci_port_check_d2h_sanity(AHCIQState *ahci, u=
int8_t port, uint8_t slot)
     g_free(d2h);
 }
=20
-void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
-                                uint8_t slot, size_t buffsize)
+void ahci_port_check_pio_sanity(AHCIQState *ahci, AHCICommand *cmd)
 {
     PIOSetupFIS *pio =3D g_malloc0(0x20);
+    uint8_t port =3D cmd->port;
=20
     /* We cannot check the Status or E_Status registers, because
      * the status may have again changed between the PIO Setup FIS
@@ -489,15 +489,22 @@ void ahci_port_check_pio_sanity(AHCIQState *ahci, u=
int8_t port,
     qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, 0x=
20);
     g_assert_cmphex(pio->fis_type, =3D=3D, 0x5f);
=20
-    /* BUG: PIO Setup FIS as utilized by QEMU tries to fit the entire
-     * transfer size in a uint16_t field. The maximum transfer size can
-     * eclipse this; the field is meant to convey the size of data per
-     * each Data FIS, not the entire operation as a whole. For now,
-     * we will sanity check the broken case where applicable. */
-    if (buffsize <=3D UINT16_MAX) {
-        g_assert_cmphex(le16_to_cpu(pio->tx_count), =3D=3D, buffsize);
+    /* Data transferred by PIO will either be:
+     * (1) 12 or 16 bytes for an ATAPI command packet (QEMU always uses =
12), or
+     * (2) Actual data from the drive.
+     * If we do both, (2) winds up erasing any evidence of (1).
+     */
+    if (cmd->props->atapi && (cmd->xbytes =3D=3D 0 || cmd->props->dma)) =
{
+        g_assert(le16_to_cpu(pio->tx_count) =3D=3D 12 ||
+                 le16_to_cpu(pio->tx_count) =3D=3D 16);
+    } else {
+        /* The AHCI test suite here does not test any PIO command that s=
pecifies
+         * a DRQ block larger than one sector (like 0xC4), so this shoul=
d always
+         * be one sector or less. */
+        size_t pio_len =3D ((cmd->xbytes % cmd->sector_size) ?
+                          (cmd->xbytes % cmd->sector_size) : cmd->sector=
_size);
+        g_assert_cmphex(le16_to_cpu(pio->tx_count), =3D=3D, pio_len);
     }
-
     g_free(pio);
 }
=20
@@ -832,9 +839,9 @@ void ahci_command_enable_atapi_dma(AHCICommand *cmd)
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
@@ -846,7 +853,7 @@ AHCICommand *ahci_command_create(uint8_t command_name=
)
=20
     g_assert(props);
     cmd =3D g_new0(AHCICommand, 1);
-    g_assert(!(props->dma && props->pio));
+    g_assert(!(props->dma && props->pio) || props->atapi);
     g_assert(!(props->lba28 && props->lba48));
     g_assert(!(props->read && props->write));
     g_assert(!props->size || props->data);
@@ -1218,7 +1225,7 @@ void ahci_command_verify(AHCIQState *ahci, AHCIComm=
and *cmd)
         ahci_port_check_d2h_sanity(ahci, port, slot);
     }
     if (cmd->props->pio) {
-        ahci_port_check_pio_sanity(ahci, port, slot, cmd->xbytes);
+        ahci_port_check_pio_sanity(ahci, cmd);
     }
 }
=20
diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
index 715ca1e226..13f6d87b75 100644
--- a/tests/libqos/ahci.h
+++ b/tests/libqos/ahci.h
@@ -596,8 +596,7 @@ void ahci_port_check_interrupts(AHCIQState *ahci, uin=
t8_t port,
                                 uint32_t intr_mask);
 void ahci_port_check_nonbusy(AHCIQState *ahci, uint8_t port, uint8_t slo=
t);
 void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_t =
slot);
-void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
-                                uint8_t slot, size_t buffsize);
+void ahci_port_check_pio_sanity(AHCIQState *ahci, AHCICommand *cmd);
 void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
=20
 /* Misc */
--=20
2.14.3
