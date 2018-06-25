Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYnD-0007la-H2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXYnB-00036e-RS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:12:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fXYnB-000367-Lr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 17:12:57 -0400
References: <20180625211136.21295-1-jsnow@redhat.com>
	<20180625211136.21295-2-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f1a5eef8-1b50-04ef-53a0-77163d9471c8@redhat.com>
Date: Mon, 25 Jun 2018 17:12:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180625211136.21295-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/1] ahci: fix FIS I bit and PIO Setup FIS
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Michael: It's probably much too late to include this in the 2.12.1
roundup, isn't it?

I'd either push for you to include this fix OR to drop the other ATAPI
related fix...

--js

On 06/25/2018 05:11 PM, John Snow wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>=20
> The "I" bit in PIO Setup and D2H FISes is exclusively a device concept
> and the irqstatus register in the controller does not matter.  The SATA
> spec says when it should be one; for D2H FISes in practice it is always
> set, while the PIO Setup FIS has several subcases that are documented i=
n
> the patch.
>=20
> Also, the PIO Setup FIS interrupt is actually generated _after_ data
> has been received.
>=20
> Someone should probably spend some time reading the SATA specification =
and
> figuring out the more obscure fields in the PIO Setup FIS, but this is =
enough
> to fix SeaBIOS booting from ATAPI CD-ROMs over an AHCI controller.
>=20
> Fixes: 956556e131e35f387ac482ad7b41151576fef057
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Message-id: 20180622165159.19863-1-pbonzini@redhat.com
> [Minor edit to avoid ATAPI comment ambiguity. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c          | 37 +++++++++++++++++++++++++------------
>  hw/ide/ahci_internal.h |  2 +-
>  tests/libqos/ahci.c    | 25 ++++++++++++++++---------
>  tests/libqos/ahci.h    |  2 +-
>  4 files changed, 43 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 2ec24cad9f..d700ca973b 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -801,7 +801,7 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTra=
nsferState *ncq_tfs)
>      }
>  }
> =20
> -static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len)
> +static void ahci_write_fis_pio(AHCIDevice *ad, uint16_t len, bool pio_=
fis_i)
>  {
>      AHCIPortRegs *pr =3D &ad->port_regs;
>      uint8_t *pio_fis;
> @@ -814,7 +814,7 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint=
16_t len)
>      pio_fis =3D &ad->res_fis[RES_FIS_PSFIS];
> =20
>      pio_fis[0] =3D SATA_FIS_TYPE_PIO_SETUP;
> -    pio_fis[1] =3D (ad->hba->control_regs.irqstatus ? (1 << 6) : 0);
> +    pio_fis[1] =3D (pio_fis_i ? (1 << 6) : 0);
>      pio_fis[2] =3D s->status;
>      pio_fis[3] =3D s->error;
> =20
> @@ -842,8 +842,6 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint=
16_t len)
>      if (pio_fis[2] & ERR_STAT) {
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
>      }
> -
> -    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
>  }
> =20
>  static bool ahci_write_fis_d2h(AHCIDevice *ad)
> @@ -860,7 +858,7 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
>      d2h_fis =3D &ad->res_fis[RES_FIS_RFIS];
> =20
>      d2h_fis[0] =3D SATA_FIS_TYPE_REGISTER_D2H;
> -    d2h_fis[1] =3D (ad->hba->control_regs.irqstatus ? (1 << 6) : 0);
> +    d2h_fis[1] =3D (1 << 6); /* interrupt bit */
>      d2h_fis[2] =3D s->status;
>      d2h_fis[3] =3D s->error;
> =20
> @@ -1258,11 +1256,10 @@ static void handle_reg_h2d_fis(AHCIState *s, in=
t port,
>              trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
>              g_free(pretty_fis);
>          }
> -        s->dev[port].done_atapi_packet =3D false;
>      }
> =20
>      ide_state->error =3D 0;
> -
> +    s->dev[port].done_first_drq =3D false;
>      /* Reset transferred byte counter */
>      cmd->status =3D 0;
> =20
> @@ -1351,13 +1348,23 @@ static void ahci_pio_transfer(IDEDMA *dma)
>      int is_write =3D opts & AHCI_CMD_WRITE;
>      int is_atapi =3D opts & AHCI_CMD_ATAPI;
>      int has_sglist =3D 0;
> +    bool pio_fis_i;
> =20
> -    /* PIO FIS gets written prior to transfer */
> -    ahci_write_fis_pio(ad, size);
> +    /* The PIO Setup FIS is received prior to transfer, but the interr=
upt
> +     * is only triggered after data is received.
> +     *
> +     * The device only sets the 'I' bit in the PIO Setup FIS for devic=
e->host
> +     * requests (see "DPIOI1" in the SATA spec), or for host->device D=
RQs after
> +     * the first (see "DPIOO1").  The latter is consistent with the sp=
ec's
> +     * description of the PACKET protocol, where the command part of A=
TAPI requests
> +     * ("DPKT0") has the 'I' bit clear, while the data part of PIO ATA=
PI requests
> +     * ("DPKT4a" and "DPKT7") has the 'I' bit set for both directions =
for all DRQs.
> +     */
> +    pio_fis_i =3D ad->done_first_drq || (!is_atapi && !is_write);
> +    ahci_write_fis_pio(ad, size, pio_fis_i);
> =20
> -    if (is_atapi && !ad->done_atapi_packet) {
> +    if (is_atapi && !ad->done_first_drq) {
>          /* already prepopulated iobuffer */
> -        ad->done_atapi_packet =3D true;
>          goto out;
>      }
> =20
> @@ -1379,9 +1386,15 @@ static void ahci_pio_transfer(IDEDMA *dma)
> =20
>      /* Update number of transferred bytes, destroy sglist */
>      dma_buf_commit(s, size);
> +
>  out:
>      /* declare that we processed everything */
>      s->data_ptr =3D s->data_end;
> +
> +    ad->done_first_drq =3D true;
> +    if (pio_fis_i) {
> +        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
> +    }
>  }
> =20
>  static void ahci_start_dma(IDEDMA *dma, IDEState *s,
> @@ -1627,7 +1640,7 @@ static const VMStateDescription vmstate_ahci_devi=
ce =3D {
>          VMSTATE_UINT32(port_regs.scr_err, AHCIDevice),
>          VMSTATE_UINT32(port_regs.scr_act, AHCIDevice),
>          VMSTATE_UINT32(port_regs.cmd_issue, AHCIDevice),
> -        VMSTATE_BOOL(done_atapi_packet, AHCIDevice),
> +        VMSTATE_BOOL(done_first_drq, AHCIDevice),
>          VMSTATE_INT32(busy_slot, AHCIDevice),
>          VMSTATE_BOOL(init_d2h_sent, AHCIDevice),
>          VMSTATE_STRUCT_ARRAY(ncq_tfs, AHCIDevice, AHCI_MAX_CMDS,
> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
> index 2953243929..9b7fa8fc7d 100644
> --- a/hw/ide/ahci_internal.h
> +++ b/hw/ide/ahci_internal.h
> @@ -315,7 +315,7 @@ struct AHCIDevice {
>      QEMUBH *check_bh;
>      uint8_t *lst;
>      uint8_t *res_fis;
> -    bool done_atapi_packet;
> +    bool done_first_drq;
>      int32_t busy_slot;
>      bool init_d2h_sent;
>      AHCICmdHdr *cur_cmd;
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index 7264e085d0..42d3f76933 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -651,10 +651,7 @@ void ahci_exec(AHCIQState *ahci, uint8_t port,
>      /* Command creation */
>      if (opts->atapi) {
>          uint16_t bcl =3D opts->set_bcl ? opts->bcl : ATAPI_SECTOR_SIZE=
;
> -        cmd =3D ahci_atapi_command_create(op, bcl);
> -        if (opts->atapi_dma) {
> -            ahci_command_enable_atapi_dma(cmd);
> -        }
> +        cmd =3D ahci_atapi_command_create(op, bcl, opts->atapi_dma);
>      } else {
>          cmd =3D ahci_command_create(op);
>      }
> @@ -874,7 +871,6 @@ AHCICommand *ahci_command_create(uint8_t command_na=
me)
>      /* cmd->interrupts |=3D props->data ? AHCI_PX_IS_DPS : 0; */
>      /* BUG: We expect the DMA Setup interrupt for DMA commands */
>      /* cmd->interrupts |=3D props->dma ? AHCI_PX_IS_DSS : 0; */
> -    cmd->interrupts |=3D props->pio ? AHCI_PX_IS_PSS : 0;
>      cmd->interrupts |=3D props->ncq ? AHCI_PX_IS_SDBS : 0;
> =20
>      command_header_init(cmd);
> @@ -883,19 +879,24 @@ AHCICommand *ahci_command_create(uint8_t command_=
name)
>      return cmd;
>  }
> =20
> -AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl)
> +AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl,=
 bool dma)
>  {
>      AHCICommand *cmd =3D ahci_command_create(CMD_PACKET);
>      cmd->atapi_cmd =3D g_malloc0(16);
>      cmd->atapi_cmd[0] =3D scsi_cmd;
>      stw_le_p(&cmd->fis.lba_lo[1], bcl);
> +    if (dma) {
> +        ahci_command_enable_atapi_dma(cmd);
> +    } else {
> +        cmd->interrupts |=3D bcl ? AHCI_PX_IS_PSS : 0;
> +    }
>      return cmd;
>  }
> =20
>  void ahci_atapi_test_ready(AHCIQState *ahci, uint8_t port,
>                             bool ready, uint8_t expected_sense)
>  {
> -    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_TEST_UNIT=
_READY, 0);
> +    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_TEST_UNIT=
_READY, 0, false);
>      ahci_command_set_size(cmd, 0);
>      if (!ready) {
>          cmd->interrupts |=3D AHCI_PX_IS_TFES;
> @@ -937,7 +938,7 @@ void ahci_atapi_get_sense(AHCIQState *ahci, uint8_t=
 port,
> =20
>  void ahci_atapi_eject(AHCIQState *ahci, uint8_t port)
>  {
> -    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_START_STO=
P_UNIT, 0);
> +    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_START_STO=
P_UNIT, 0, false);
>      ahci_command_set_size(cmd, 0);
> =20
>      cmd->atapi_cmd[4] =3D 0x02; /* loej =3D true */
> @@ -949,7 +950,7 @@ void ahci_atapi_eject(AHCIQState *ahci, uint8_t por=
t)
> =20
>  void ahci_atapi_load(AHCIQState *ahci, uint8_t port)
>  {
> -    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_START_STO=
P_UNIT, 0);
> +    AHCICommand *cmd =3D ahci_atapi_command_create(CMD_ATAPI_START_STO=
P_UNIT, 0, false);
>      ahci_command_set_size(cmd, 0);
> =20
>      cmd->atapi_cmd[4] =3D 0x03; /* loej,start =3D true */
> @@ -1098,6 +1099,12 @@ void ahci_command_set_sizes(AHCICommand *cmd, ui=
nt64_t xbytes,
>      } else if (cmd->props->atapi) {
>          ahci_atapi_set_size(cmd, xbytes);
>      } else {
> +        /* For writes, the PIO Setup FIS interrupt only comes from DRQ=
s
> +         * after the first.
> +         */
> +        if (cmd->props->pio && sect_count > (cmd->props->read ? 0 : 1)=
) {
> +            cmd->interrupts |=3D AHCI_PX_IS_PSS;
> +        }
>          cmd->fis.count =3D sect_count;
>      }
>      cmd->header.prdtl =3D size_to_prdtl(cmd->xbytes, cmd->prd_size);
> diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
> index 13f6d87b75..f05b3e5fce 100644
> --- a/tests/libqos/ahci.h
> +++ b/tests/libqos/ahci.h
> @@ -622,7 +622,7 @@ void ahci_atapi_load(AHCIQState *ahci, uint8_t port=
);
> =20
>  /* Command: Fine-grained lifecycle */
>  AHCICommand *ahci_command_create(uint8_t command_name);
> -AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl)=
;
> +AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl,=
 bool dma);
>  void ahci_command_commit(AHCIQState *ahci, AHCICommand *cmd, uint8_t p=
ort);
>  void ahci_command_issue(AHCIQState *ahci, AHCICommand *cmd);
>  void ahci_command_issue_async(AHCIQState *ahci, AHCICommand *cmd);
>=20

--=20
=E2=80=94js
