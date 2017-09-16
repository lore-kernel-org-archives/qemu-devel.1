Received: from eggs.gnu.org ([2001:4830:134:3::10]:47762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WI-0005D6-HJ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WF-0006CP-9D
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt1WE-0006Av-Ra
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Sep 2017 21:03:27 -0400
Message-Id: <20170916010330.10435-9-jsnow@redhat.com>
In-Reply-To: <20170916010330.10435-1-jsnow@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/11] AHCI: Replace DPRINTF with trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

There are a few hangers-on that will be dealt with individually
in forthcoming patches.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c       | 157 +++++++++++++++++++++++-----------------------=
------
 hw/ide/trace-events |  49 ++++++++++++++++
 2 files changed, 117 insertions(+), 89 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index ccbe091..9d2c8ded 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -35,6 +35,7 @@
 #include "hw/ide/ahci_internal.h"
=20
 #define DEBUG_AHCI 0
+#include "trace.h"
=20
 #define DPRINTF(port, fmt, ...) \
 do { \
@@ -114,9 +115,9 @@ static uint32_t  ahci_port_read(AHCIState *s, int por=
t, int offset)
     default:
         val =3D 0;
     }
-    DPRINTF(port, "offset: 0x%x val: 0x%x\n", offset, val);
-    return val;
=20
+    trace_ahci_port_read(s, port, offset, val);
+    return val;
 }
=20
 static void ahci_irq_raise(AHCIState *s, AHCIDevice *dev)
@@ -125,7 +126,7 @@ static void ahci_irq_raise(AHCIState *s, AHCIDevice *=
dev)
     PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev_=
state),
                                                            TYPE_PCI_DEVI=
CE);
=20
-    DPRINTF(0, "raise irq\n");
+    trace_ahci_irq_raise(s);
=20
     if (pci_dev && msi_enabled(pci_dev)) {
         msi_notify(pci_dev, 0);
@@ -140,7 +141,7 @@ static void ahci_irq_lower(AHCIState *s, AHCIDevice *=
dev)
     PCIDevice *pci_dev =3D (PCIDevice *) object_dynamic_cast(OBJECT(dev_=
state),
                                                            TYPE_PCI_DEVI=
CE);
=20
-    DPRINTF(0, "lower irq\n");
+    trace_ahci_irq_lower(s);
=20
     if (!pci_dev || !msi_enabled(pci_dev)) {
         qemu_irq_lower(s->irq);
@@ -150,8 +151,7 @@ static void ahci_irq_lower(AHCIState *s, AHCIDevice *=
dev)
 static void ahci_check_irq(AHCIState *s)
 {
     int i;
-
-    DPRINTF(-1, "check irq %#x\n", s->control_regs.irqstatus);
+    uint32_t old_irq =3D s->control_regs.irqstatus;
=20
     s->control_regs.irqstatus =3D 0;
     for (i =3D 0; i < s->ports; i++) {
@@ -160,7 +160,7 @@ static void ahci_check_irq(AHCIState *s)
             s->control_regs.irqstatus |=3D (1 << i);
         }
     }
-
+    trace_ahci_check_irq(s, old_irq, s->control_regs.irqstatus);
     if (s->control_regs.irqstatus &&
         (s->control_regs.ghc & HOST_CTL_IRQ_EN)) {
             ahci_irq_raise(s, NULL);
@@ -240,7 +240,7 @@ static void  ahci_port_write(AHCIState *s, int port, =
int offset, uint32_t val)
 {
     AHCIPortRegs *pr =3D &s->dev[port].port_regs;
=20
-    DPRINTF(port, "offset: 0x%x val: 0x%x\n", offset, val);
+    trace_ahci_port_write(s, port, offset, val);
     switch (offset) {
         case PORT_LST_ADDR:
             pr->lst_addr =3D val;
@@ -341,8 +341,6 @@ static uint64_t ahci_mem_read_32(void *opaque, hwaddr=
 addr)
             val =3D s->control_regs.version;
             break;
         }
-
-        DPRINTF(-1, "(addr 0x%08X), val 0x%08X\n", (unsigned) addr, val)=
;
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
                 (s->ports * AHCI_PORT_ADDR_OFFSET_LEN)))) {
@@ -350,6 +348,7 @@ static uint64_t ahci_mem_read_32(void *opaque, hwaddr=
 addr)
                              addr & AHCI_PORT_ADDR_OFFSET_MASK);
     }
=20
+    trace_ahci_mem_read_32(s, addr, val);
     return val;
 }
=20
@@ -379,8 +378,7 @@ static uint64_t ahci_mem_read(void *opaque, hwaddr ad=
dr, unsigned size)
         val =3D (hi << 32 | lo) >> (ofst * 8);
     }
=20
-    DPRINTF(-1, "addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx64 ", size=3D%=
d\n",
-            addr, val, size);
+    trace_ahci_mem_read(opaque, size, addr, val);
     return val;
 }
=20
@@ -390,8 +388,7 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
 {
     AHCIState *s =3D opaque;
=20
-    DPRINTF(-1, "addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx64 ", size=3D%=
d\n",
-            addr, val, size);
+    trace_ahci_mem_write(s, size, addr, val);
=20
     /* Only aligned reads are allowed on AHCI */
     if (addr & 3) {
@@ -401,15 +398,12 @@ static void ahci_mem_write(void *opaque, hwaddr add=
r,
     }
=20
     if (addr < AHCI_GENERIC_HOST_CONTROL_REGS_MAX_ADDR) {
-        DPRINTF(-1, "(addr 0x%08X), val 0x%08"PRIX64"\n", (unsigned) add=
r, val);
-
         switch (addr) {
             case HOST_CAP: /* R/WO, RO */
                 /* FIXME handle R/WO */
                 break;
             case HOST_CTL: /* R/W */
                 if (val & HOST_CTL_RESET) {
-                    DPRINTF(-1, "HBA Reset\n");
                     ahci_reset(s);
                 } else {
                     s->control_regs.ghc =3D (val & 0x3) | HOST_CTL_AHCI_=
EN;
@@ -427,7 +421,7 @@ static void ahci_mem_write(void *opaque, hwaddr addr,
                 /* FIXME report write? */
                 break;
             default:
-                DPRINTF(-1, "write to unknown register 0x%x\n", (unsigne=
d)addr);
+                trace_ahci_mem_write_unknown(s, size, addr, val);
         }
     } else if ((addr >=3D AHCI_PORT_REGS_START_ADDR) &&
                (addr < (AHCI_PORT_REGS_START_ADDR +
@@ -559,7 +553,8 @@ static void ahci_set_signature(AHCIDevice *ad, uint32=
_t sig)
     s->sector =3D sig >> 8 & 0xFF;
     s->nsector =3D sig & 0xFF;
=20
-    DPRINTF(ad->port_no, "set hcyl:lcyl:sect:nsect =3D 0x%08x\n", sig);
+    trace_ahci_set_signature(ad->hba, ad->port_no, s->nsector, s->sector=
,
+                             s->lcyl, s->hcyl, sig);
 }
=20
 static void ahci_reset_port(AHCIState *s, int port)
@@ -569,7 +564,7 @@ static void ahci_reset_port(AHCIState *s, int port)
     IDEState *ide_state =3D &d->port.ifs[0];
     int i;
=20
-    DPRINTF(port, "reset port\n");
+    trace_ahci_reset_port(s, port);
=20
     ide_bus_reset(&d->port);
     ide_state->ncq_queues =3D AHCI_MAX_CMDS;
@@ -655,7 +650,7 @@ static bool ahci_map_fis_address(AHCIDevice *ad)
 static void ahci_unmap_fis_address(AHCIDevice *ad)
 {
     if (ad->res_fis =3D=3D NULL) {
-        DPRINTF(ad->port_no, "Attempt to unmap NULL FIS address\n");
+        trace_ahci_unmap_fis_address_null(ad->hba, ad->port_no);
         return;
     }
     ad->port_regs.cmd &=3D ~PORT_CMD_FIS_ON;
@@ -682,7 +677,7 @@ static bool ahci_map_clb_address(AHCIDevice *ad)
 static void ahci_unmap_clb_address(AHCIDevice *ad)
 {
     if (ad->lst =3D=3D NULL) {
-        DPRINTF(ad->port_no, "Attempt to unmap NULL CLB address\n");
+        trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
     }
     ad->port_regs.cmd &=3D ~PORT_CMD_LIST_ON;
@@ -854,20 +849,22 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEM=
USGList *sglist,
     IDEBus *bus =3D &ad->port;
     BusState *qbus =3D BUS(bus);
=20
+    trace_ahci_populate_sglist(ad->hba, ad->port_no);
+
     if (!prdtl) {
-        DPRINTF(ad->port_no, "no sg list given by guest: 0x%08x\n", opts=
);
+        trace_ahci_populate_sglist_no_prdtl(ad->hba, ad->port_no, opts);
         return -1;
     }
=20
     /* map PRDT */
     if (!(prdt =3D dma_memory_map(ad->hba->as, prdt_addr, &prdt_len,
                                 DMA_DIRECTION_TO_DEVICE))){
-        DPRINTF(ad->port_no, "map failed\n");
+        trace_ahci_populate_sglist_no_map(ad->hba, ad->port_no);
         return -1;
     }
=20
     if (prdt_len < real_prdt_len) {
-        DPRINTF(ad->port_no, "mapped less than expected\n");
+        trace_ahci_populate_sglist_short_map(ad->hba, ad->port_no);
         r =3D -1;
         goto out;
     }
@@ -886,9 +883,8 @@ static int ahci_populate_sglist(AHCIDevice *ad, QEMUS=
GList *sglist,
             sum +=3D tbl_entry_size;
         }
         if ((off_idx =3D=3D -1) || (off_pos < 0) || (off_pos > tbl_entry=
_size)) {
-            DPRINTF(ad->port_no, "%s: Incorrect offset! "
-                            "off_idx: %d, off_pos: %"PRId64"\n",
-                            __func__, off_idx, off_pos);
+            trace_ahci_populate_sglist_bad_offset(ad->hba, ad->port_no,
+                                                  off_idx, off_pos);
             r =3D -1;
             goto out;
         }
@@ -934,8 +930,8 @@ static void ncq_finish(NCQTransferState *ncq_tfs)
=20
     ahci_write_fis_sdb(ncq_tfs->drive->hba, ncq_tfs);
=20
-    DPRINTF(ncq_tfs->drive->port_no, "NCQ transfer tag %d finished\n",
-            ncq_tfs->tag);
+    trace_ncq_finish(ncq_tfs->drive->hba, ncq_tfs->drive->port_no,
+                     ncq_tfs->tag);
=20
     block_acct_done(blk_get_stats(ncq_tfs->drive->port.ifs[0].blk),
                     &ncq_tfs->acct);
@@ -999,12 +995,8 @@ static void execute_ncq_command(NCQTransferState *nc=
q_tfs)
=20
     switch (ncq_tfs->cmd) {
     case READ_FPDMA_QUEUED:
-        DPRINTF(port, "NCQ reading %d sectors from LBA %"PRId64", tag %d=
\n",
-                ncq_tfs->sector_count, ncq_tfs->lba, ncq_tfs->tag);
-
-        DPRINTF(port, "tag %d aio read %"PRId64"\n",
-                ncq_tfs->tag, ncq_tfs->lba);
-
+        trace_execute_ncq_command_read(ad->hba, port, ncq_tfs->tag,
+                                       ncq_tfs->sector_count, ncq_tfs->l=
ba);
         dma_acct_start(ide_state->blk, &ncq_tfs->acct,
                        &ncq_tfs->sglist, BLOCK_ACCT_READ);
         ncq_tfs->aiocb =3D dma_blk_read(ide_state->blk, &ncq_tfs->sglist=
,
@@ -1013,12 +1005,8 @@ static void execute_ncq_command(NCQTransferState *=
ncq_tfs)
                                       ncq_cb, ncq_tfs);
         break;
     case WRITE_FPDMA_QUEUED:
-        DPRINTF(port, "NCQ writing %d sectors to LBA %"PRId64", tag %d\n=
",
-                ncq_tfs->sector_count, ncq_tfs->lba, ncq_tfs->tag);
-
-        DPRINTF(port, "tag %d aio write %"PRId64"\n",
-                ncq_tfs->tag, ncq_tfs->lba);
-
+        trace_execute_ncq_command_read(ad->hba, port, ncq_tfs->tag,
+                                       ncq_tfs->sector_count, ncq_tfs->l=
ba);
         dma_acct_start(ide_state->blk, &ncq_tfs->acct,
                        &ncq_tfs->sglist, BLOCK_ACCT_WRITE);
         ncq_tfs->aiocb =3D dma_blk_write(ide_state->blk, &ncq_tfs->sglis=
t,
@@ -1027,8 +1015,8 @@ static void execute_ncq_command(NCQTransferState *n=
cq_tfs)
                                        ncq_cb, ncq_tfs);
         break;
     default:
-        DPRINTF(port, "error: unsupported NCQ command (0x%02x) received\=
n",
-                ncq_tfs->cmd);
+        trace_execute_ncq_command_unsup(ad->hba, port,
+                                        ncq_tfs->tag, ncq_tfs->cmd);
         ncq_err(ncq_tfs);
     }
 }
@@ -1038,7 +1026,6 @@ static void process_ncq_command(AHCIState *s, int p=
ort, uint8_t *cmd_fis,
                                 uint8_t slot)
 {
     AHCIDevice *ad =3D &s->dev[port];
-    IDEState *ide_state =3D &ad->port.ifs[0];
     NCQFrame *ncq_fis =3D (NCQFrame*)cmd_fis;
     uint8_t tag =3D ncq_fis->tag >> 3;
     NCQTransferState *ncq_tfs =3D &ad->ncq_tfs[tag];
@@ -1066,21 +1053,20 @@ static void process_ncq_command(AHCIState *s, int=
 port, uint8_t *cmd_fis,
=20
     /* Sanity-check the NCQ packet */
     if (tag !=3D slot) {
-        DPRINTF(port, "Warn: NCQ slot (%d) did not match the given tag (=
%d)\n",
-                slot, tag);
+        trace_process_ncq_command_mismatch(s, port, tag, slot);
     }
=20
     if (ncq_fis->aux0 || ncq_fis->aux1 || ncq_fis->aux2 || ncq_fis->aux3=
) {
-        DPRINTF(port, "Warn: Attempt to use NCQ auxiliary fields.\n");
+        trace_process_ncq_command_aux(s, port, tag);
     }
     if (ncq_fis->prio || ncq_fis->icc) {
-        DPRINTF(port, "Warn: Unsupported attempt to use PRIO/ICC fields\=
n");
+        trace_process_ncq_command_prioicc(s, port, tag);
     }
     if (ncq_fis->fua & NCQ_FIS_FUA_MASK) {
-        DPRINTF(port, "Warn: Unsupported attempt to use Force Unit Acces=
s\n");
+        trace_process_ncq_command_fua(s, port, tag);
     }
     if (ncq_fis->tag & NCQ_FIS_RARC_MASK) {
-        DPRINTF(port, "Warn: Unsupported attempt to use Rebuild Assist\n=
");
+        trace_process_ncq_command_rarc(s, port, tag);
     }
=20
     ncq_tfs->sector_count =3D ((ncq_fis->sector_count_high << 8) |
@@ -1099,16 +1085,14 @@ static void process_ncq_command(AHCIState *s, int=
 port, uint8_t *cmd_fis,
         ahci_trigger_irq(ad->hba, ad, PORT_IRQ_OVERFLOW);
         return;
     } else if (ncq_tfs->sglist.size !=3D size) {
-        DPRINTF(port, "Warn: PRDTL (0x%zx)"
-                " does not match requested size (0x%zx)",
-                ncq_tfs->sglist.size, size);
+        trace_process_ncq_command_large(s, port, tag,
+                                        ncq_tfs->sglist.size, size);
     }
=20
-    DPRINTF(port, "NCQ transfer LBA from %"PRId64" to %"PRId64", "
-            "drive max %"PRId64"\n",
-            ncq_tfs->lba, ncq_tfs->lba + ncq_tfs->sector_count - 1,
-            ide_state->nb_sectors - 1);
-
+    trace_process_ncq_command(s, port, tag,
+                              ncq_fis->command,
+                              ncq_tfs->lba,
+                              ncq_tfs->lba + ncq_tfs->sector_count - 1);
     execute_ncq_command(ncq_tfs);
 }
=20
@@ -1129,16 +1113,14 @@ static void handle_reg_h2d_fis(AHCIState *s, int =
port,
     uint16_t opts =3D le16_to_cpu(cmd->opts);
=20
     if (cmd_fis[1] & 0x0F) {
-        DPRINTF(port, "Port Multiplier not supported."
-                " cmd_fis[0]=3D%02x cmd_fis[1]=3D%02x cmd_fis[2]=3D%02x\=
n",
-                cmd_fis[0], cmd_fis[1], cmd_fis[2]);
+        trace_handle_reg_h2d_fis_pmp(s, port, cmd_fis[1],
+                                     cmd_fis[2], cmd_fis[3]);
         return;
     }
=20
     if (cmd_fis[1] & 0x70) {
-        DPRINTF(port, "Reserved flags set in H2D Register FIS."
-                " cmd_fis[0]=3D%02x cmd_fis[1]=3D%02x cmd_fis[2]=3D%02x\=
n",
-                cmd_fis[0], cmd_fis[1], cmd_fis[2]);
+        trace_handle_reg_h2d_fis_res(s, port, cmd_fis[1],
+                                     cmd_fis[2], cmd_fis[3]);
         return;
     }
=20
@@ -1216,12 +1198,12 @@ static int handle_cmd(AHCIState *s, int port, uin=
t8_t slot)
=20
     if (s->dev[port].port.ifs[0].status & (BUSY_STAT|DRQ_STAT)) {
         /* Engine currently busy, try again later */
-        DPRINTF(port, "engine busy\n");
+        trace_handle_cmd_busy(s, port);
         return -1;
     }
=20
     if (!s->dev[port].lst) {
-        DPRINTF(port, "error: lst not given but cmd handled");
+        trace_handle_cmd_nolist(s, port);
         return -1;
     }
     cmd =3D get_cmd_header(s, port, slot);
@@ -1231,7 +1213,7 @@ static int handle_cmd(AHCIState *s, int port, uint8=
_t slot)
     /* The device we are working for */
     ide_state =3D &s->dev[port].port.ifs[0];
     if (!ide_state->blk) {
-        DPRINTF(port, "error: guest accessed unused port");
+        trace_handle_cmd_badport(s, port);
         return -1;
     }
=20
@@ -1240,13 +1222,11 @@ static int handle_cmd(AHCIState *s, int port, uin=
t8_t slot)
     cmd_fis =3D dma_memory_map(s->as, tbl_addr, &cmd_len,
                              DMA_DIRECTION_FROM_DEVICE);
     if (!cmd_fis) {
-        DPRINTF(port, "error: guest passed us an invalid cmd fis\n");
+        trace_handle_cmd_badfis(s, port);
         return -1;
     } else if (cmd_len !=3D 0x80) {
         ahci_trigger_irq(s, &s->dev[port], PORT_IRQ_HBUS_ERR);
-        DPRINTF(port, "error: dma_memory_map failed: "
-                "(len(%02"PRIx64") !=3D 0x80)\n",
-                cmd_len);
+        trace_handle_cmd_badmap(s, port, cmd_len);
         goto out;
     }
     debug_print_fis(cmd_fis, 0x80);
@@ -1256,9 +1236,8 @@ static int handle_cmd(AHCIState *s, int port, uint8=
_t slot)
             handle_reg_h2d_fis(s, port, slot, cmd_fis);
             break;
         default:
-            DPRINTF(port, "unknown command cmd_fis[0]=3D%02x cmd_fis[1]=3D=
%02x "
-                          "cmd_fis[2]=3D%02x\n", cmd_fis[0], cmd_fis[1],
-                          cmd_fis[2]);
+            trace_handle_cmd_unhandled_fis(s, port,
+                                           cmd_fis[0], cmd_fis[1], cmd_f=
is[2]);
             break;
     }
=20
@@ -1299,9 +1278,9 @@ static void ahci_start_transfer(IDEDMA *dma)
         has_sglist =3D 1;
     }
=20
-    DPRINTF(ad->port_no, "%sing %d bytes on %s w/%s sglist\n",
-            is_write ? "writ" : "read", size, is_atapi ? "atapi" : "ata"=
,
-            has_sglist ? "" : "o");
+    trace_ahci_start_transfer(ad->hba, ad->port_no, is_write ? "writ" : =
"read",
+                              size, is_atapi ? "atapi" : "ata",
+                              has_sglist ? "" : "o");
=20
     if (has_sglist && size) {
         if (is_write) {
@@ -1330,7 +1309,7 @@ static void ahci_start_dma(IDEDMA *dma, IDEState *s=
,
                            BlockCompletionFunc *dma_cb)
 {
     AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
-    DPRINTF(ad->port_no, "\n");
+    trace_ahci_start_dma(ad->hba, ad->port_no);
     s->io_buffer_offset =3D 0;
     dma_cb(s, 0);
 }
@@ -1368,12 +1347,12 @@ static int32_t ahci_dma_prepare_buf(IDEDMA *dma, =
int32_t limit)
=20
     if (ahci_populate_sglist(ad, &s->sg, ad->cur_cmd,
                              limit, s->io_buffer_offset) =3D=3D -1) {
-        DPRINTF(ad->port_no, "ahci_dma_prepare_buf failed.\n");
+        trace_ahci_dma_prepare_buf_fail(ad->hba, ad->port_no);
         return -1;
     }
     s->io_buffer_size =3D s->sg.size;
=20
-    DPRINTF(ad->port_no, "len=3D%#x\n", s->io_buffer_size);
+    trace_ahci_dma_prepare_buf(ad->hba, ad->port_no, limit, s->io_buffer=
_size);
     return s->io_buffer_size;
 }
=20
@@ -1409,11 +1388,9 @@ static int ahci_dma_rw_buf(IDEDMA *dma, int is_wri=
te)
=20
     /* free sglist, update byte count */
     dma_buf_commit(s, l);
-
     s->io_buffer_index +=3D l;
=20
-    DPRINTF(ad->port_no, "len=3D%#x\n", l);
-
+    trace_ahci_dma_rw_buf(ad->hba, ad->port_no, l);
     return 1;
 }
=20
@@ -1421,7 +1398,7 @@ static void ahci_cmd_done(IDEDMA *dma)
 {
     AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
=20
-    DPRINTF(ad->port_no, "cmd done\n");
+    trace_ahci_cmd_done(ad->hba, ad->port_no);
=20
     /* update d2h status */
     ahci_write_fis_d2h(ad);
@@ -1506,6 +1483,8 @@ void ahci_reset(AHCIState *s)
     AHCIPortRegs *pr;
     int i;
=20
+    trace_ahci_reset(s);
+
     s->control_regs.irqstatus =3D 0;
     /* AHCI Enable (AE)
      * The implementation of this bit is dependent upon the value of the
@@ -1756,6 +1735,7 @@ static uint64_t allwinner_ahci_mem_read(void *opaqu=
e, hwaddr addr,
                                         unsigned size)
 {
     AllwinnerAHCIState *a =3D opaque;
+    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
     uint64_t val =3D a->regs[addr/4];
=20
     switch (addr / 4) {
@@ -1766,8 +1746,7 @@ static uint64_t allwinner_ahci_mem_read(void *opaqu=
e, hwaddr addr,
         val &=3D ~(0x1 << 24);
         break;
     }
-    DPRINTF(-1, "addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx64 ", size=3D%=
d\n",
-            addr, val, size);
+    trace_allwinner_ahci_mem_read(s, a, addr, val, size);
     return  val;
 }
=20
@@ -1775,9 +1754,9 @@ static void allwinner_ahci_mem_write(void *opaque, =
hwaddr addr,
                                      uint64_t val, unsigned size)
 {
     AllwinnerAHCIState *a =3D opaque;
+    AHCIState *s =3D &(SYSBUS_AHCI(a)->ahci);
=20
-    DPRINTF(-1, "addr=3D0x%" HWADDR_PRIx " val=3D0x%" PRIx64 ", size=3D%=
d\n",
-            addr, val, size);
+    trace_allwinner_ahci_mem_write(s, a, addr, val, size);
     a->regs[addr/4] =3D val;
 }
=20
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index cc8949c..0b61c5d 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -56,3 +56,52 @@ ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd=
: 0x%02x"
 ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p; ai=
o read: lba=3D%d n=3D%d"
 # Warning: Verbose
 ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDESt=
ate: %p; limit=3D0x%x packet: %s"
+
+# hw/ide/ahci.c
+ahci_port_read(void *s, int port, int offset, uint32_t ret) "ahci(%p)[%d=
]: port read @ 0x%x: 0x%08x"
+ahci_irq_raise(void *s) "ahci(%p): raise irq"
+ahci_irq_lower(void *s) "ahci(%p): lower irq"
+ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq=
 0x%08x --> 0x%08x"
+
+ahci_port_write(void *s, int port, int offset, uint32_t val) "ahci(%p)[%=
d]: port write @ 0x%x: 0x%08x"
+ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem re=
ad @ 0x%"PRIx64": 0x%08x"
+ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci=
(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write(void *s, unsigned size, uint64_t addr, uint64_t val) "ahc=
i(%p): write%u @ 0x%"PRIx64": 0x%016"PRIx64
+ahci_mem_write_unknown(void *s, unsigned size, uint64_t addr, uint64_t v=
al) "ahci(%p): write%u to unknown register 0x%"PRIx64": 0x%016"PRIx64
+ahci_set_signature(void *s, int port, uint8_t nsector, uint8_t sector, u=
int8_t lcyl, uint8_t hcyl, uint32_t sig) "ahci(%p)[%d]: set signature sec=
tor:0x%02x nsector:0x%02x lcyl:0x%02x hcyl:0x%02x (cumulatively: 0x%08x)"
+ahci_reset_port(void *s, int port) "ahci(%p)[%d]: reset port"
+ahci_unmap_fis_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to=
 unmap NULL FIS address"
+ahci_unmap_clb_address_null(void *s, int port) "ahci(%p)[%d]: Attempt to=
 unmap NULL CLB address"
+ahci_populate_sglist(void *s, int port) "ahci(%p)[%d]"
+ahci_populate_sglist_no_prdtl(void *s, int port, uint16_t opts) "ahci(%p=
)[%d]: no sg list given by guest: 0x%04x"
+ahci_populate_sglist_no_map(void *s, int port) "ahci(%p)[%d]: DMA mappin=
g failed"
+ahci_populate_sglist_short_map(void *s, int port) "ahci(%p)[%d]: mapped =
less than expected"
+ahci_populate_sglist_bad_offset(void *s, int port, int off_idx, int64_t =
off_pos) "ahci(%p)[%d]: Incorrect offset! off_idx: %d, off_pos: %"PRId64
+ncq_finish(void *s, int port, uint8_t tag) "ahci(%p)[%d][tag:%d]: NCQ tr=
ansfer finished"
+execute_ncq_command_read(void *s, int port, uint8_t tag, int count, int6=
4_t lba) "ahci(%p)[%d][tag:%d]: NCQ reading %d sectors from LBA %"PRId64
+execute_ncq_command_write(void *s, int port, uint8_t tag, int count, int=
64_t lba) "ahci(%p)[%d][tag:%d]: NCQ writing %d sectors to LBA %"PRId64
+execute_ncq_command_unsup(void *s, int port, uint8_t tag, uint8_t cmd) "=
ahci(%p)[%d][tag:%d]: error: unsupported NCQ command (0x%02x) received"
+process_ncq_command_mismatch(void *s, int port, uint8_t tag, uint8_t slo=
t) "ahci(%p)[%d][tag:%d]: Warning: NCQ slot (%d) did not match the given =
tag"
+process_ncq_command_aux(void *s, int port, uint8_t tag) "ahci(%p)[%d][ta=
g:%d]: Warn: Attempt to use NCQ auxiliary fields"
+process_ncq_command_prioicc(void *s, int port, uint8_t tag) "ahci(%p)[%d=
][tag:%d]: Warn: Unsupported attempt to use PRIO/ICC fields"
+process_ncq_command_fua(void *s, int port, uint8_t tag) "ahci(%p)[%d][ta=
g:%d]: Warn: Unsupported attempt to use Force Unit Access"
+process_ncq_command_rarc(void *s, int port, uint8_t tag) "ahci(%p)[%d][t=
ag:%d]: Warn: Unsupported attempt to use Rebuild Assist"
+process_ncq_command_large(void *s, int port, uint8_t tag, size_t prdtl, =
size_t size) "ahci(%p)[%d][tag:%d]: Warn: PRDTL (0x%zx) does not match re=
quested size (0x%zx)"
+process_ncq_command(void *s, int port, uint8_t tag, uint8_t cmd, uint64_=
t lba, uint64_t end) "ahci(%p)[%d][tag:%d]: NCQ op 0x%02x on sectors [%"P=
RId64",%"PRId64"]"
+handle_reg_h2d_fis_pmp(void *s, int port, char b0, char b1, char b2) "ah=
ci(%p)[%d]: Port Multiplier not supported, FIS: 0x%02x-%02x-%02x"
+handle_reg_h2d_fis_res(void *s, int port, char b0, char b1, char b2) "ah=
ci(%p)[%d]: Reserved flags set in H2D Register FIS, FIS: 0x%02x-%02x-%02x=
"
+handle_cmd_busy(void *s, int port) "ahci(%p)[%d]: engine busy"
+handle_cmd_nolist(void *s, int port) "ahci(%p)[%d]: handle_cmd called wi=
thout s->dev[port].lst"
+handle_cmd_badport(void *s, int port) "ahci(%p)[%d]: guest accessed unus=
ed port"
+handle_cmd_badfis(void *s, int port) "ahci(%p)[%d]: guest provided an in=
valid cmd FIS"
+handle_cmd_badmap(void *s, int port, uint64_t len) "ahci(%p)[%d]: dma_me=
mory_map failed, 0x%02"PRIx64" !=3D 0x80"
+handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint=
8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
+ahci_start_transfer(void *s, int port, const char *rw, uint32_t size, co=
nst char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s =
sglist"
+ahci_start_dma(void *s, int port) "ahci(%p)[%d]: start dma"
+ahci_dma_prepare_buf(void *s, int port, int32_t io_buffer_size, int32_t =
limit) "ahci(%p)[%d]: prepare buf limit=3D%"PRId32" prepared=3D%"PRId32
+ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p)[%d]: sglist popul=
ation failed"
+ahci_dma_rw_buf(void *s, int port, int l) "ahci(%p)[%d] len=3D0x%x"
+ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cmd done"
+ahci_reset(void *s) "ahci(%p): HBA reset"
+allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val, u=
nsigned size) "ahci(%p): read a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0x%"PR=
Ix64", size=3D%d"
+allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t val, =
unsigned size) "ahci(%p): write a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0x%"=
PRIx64", size=3D%d"
--=20
2.9.5
