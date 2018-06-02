Received: from eggs.gnu.org ([2001:4830:134:3::10]:37772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOvFf-0006ri-Dg
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 21:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOvFd-0004ww-OS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 21:22:39 -0400
References: <20180417153945.20737-1-pbonzini@redhat.com>
	<20180417153945.20737-2-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8e293555-d8f0-3a00-00d1-2aac514eb1f2@redhat.com>
Date: Fri, 1 Jun 2018 21:22:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180417153945.20737-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] ahci: move PIO Setup FIS before
 transfer, fix it for ATAPI commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org



On 04/17/2018 11:39 AM, Paolo Bonzini wrote:
> The PIO Setup FIS is written in the PIO:Entry state, which comes before
> the ATA and ATAPI data transfer states.  As a result, the PIO Setup FIS
> interrupt is now raised before DMA ends for ATAPI commands, and tests h=
ave
> to be adjusted.
>=20

Yes, this is correct.

Unfortunately you wandered into one of the messiest areas of AHCI :(

> This is also hinted by the description of the command header in the AHC=
I
> specification, where the "A" bit is described as
>=20
>     When =E2=80=981=E2=80=99, indicates that a PIO setup FIS shall be s=
ent by the device
>     indicating a transfer for the ATAPI command.
>=20
> and also by the description of the ACMD (ATAPI command region):
>=20
>     The ATAPI command must be either 12 or 16 bytes in length. The leng=
th
>     transmitted by the HBA is determined by the PIO setup FIS that is s=
ent
>     by the device requesting the ATAPI command.
>=20

I wonder how this works in practice...?

PACKET gets delivered to a SATA device via the HBA, and a Register
Host-To-Device FIS.

The SATA device, seeing that it's a PACKET command, knows that it now
needs to begin listening for PIO data, because the packet is implicitly
transferred via PIO mechanisms.

The SATA device generates a PIO Setup FIS to indicate it is ready to
receive data. I suppose it fills it as such:

- FIS Type: 0x5F

- PM Port: 0

- D: 0, because this is a Host-to-Device PIO.
  (We never fill this any differently in the AHCI emulator right now.)

- I: "Interrupt bit line of the device." I don't think we track this
  correctly. We're copying in the IRQ status of the HBA here, which is
  wrong.

- Status: Should be the status register after receiving the H2D Register
  update FIS, but prior to the data transfer, I think. "New value of the
  Status register of the Command Block for initiation of host data
  transfer."
  I think this is being set correctly after this patch.

- Error: "Contains the new value of the Error register of the Command
  Block at the conclusion of all subsequent Data to Device frames."

  This is why we were sending out post-hoc PIO Setup FIS frames before,
  how would I know what the error register *will* be...? What?

- LBA: Presumably unimportant for the purposes of receiving a command
  PACKET, as we won't be writing it to disk, but a buffer. The values
  can be reported dutifully.

- Device: Just report the register value dutifully.

- Count: Likely just relays 0, as the H2D REG FIS should have updated
  that to zero as part of the PACKET command, as per ATA8 ACS3 7.21.3.
  In any case, just report the register value dutifully.

- E_Status: "Contains the new value of the Status register of the
  Command Block at the conclusion of the subsequent Data FIS."

  Again, how would I know...?

- Transfer Count: Should be 12, as per what we specified in 0xA1
  IDENTIFY PACKET DEVICE, see core.c line 234. Your patch gets this
  correct, as we'll actually report the PIO FIS for the packet itself.


What this patch does do, though, is change the context of the Status,
Error and E_Status registers to something different. Everything else
should be the same, but I'd feel better about taking this patch if I
understood what exactly this FIS packet was supposed to convey, but I don=
't.

> QEMU, which conflates the "generator" and the "receiver" of the FIS int=
o
> one device, always uses ATAPI_PACKET_SIZE, aka 12, for the length.
>=20

Yeah, it's pretty messy. We play both the SATA device and the HBA
receiver in one single function. A bad delineation in the code between
SCSI, ATA, SATA and AHCI makes it hard to follow.

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/ahci.c       | 15 ++++++---------
>  tests/libqos/ahci.c | 30 ++++++++++++++++++++++++++----
>  tests/libqos/ahci.h |  2 ++
>  3 files changed, 34 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index e22d7be05f..45ce195fb8 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1291,11 +1291,12 @@ static void ahci_start_transfer(IDEDMA *dma)
>      int is_write =3D opts & AHCI_CMD_WRITE;
>      int is_atapi =3D opts & AHCI_CMD_ATAPI;
>      int has_sglist =3D 0;
> +    uint16_t fis_len;
> =20
>      if (is_atapi && !ad->done_atapi_packet) {
>          /* already prepopulated iobuffer */
>          ad->done_atapi_packet =3D true;
> -        size =3D 0;
> +        fis_len =3D size;
>          goto out;
>      }
> =20
> @@ -1315,19 +1316,15 @@ static void ahci_start_transfer(IDEDMA *dma)
>          }
>      }
> =20
> +    /* Update number of transferred bytes, destroy sglist */
> +    dma_buf_commit(s, size);
> +    fis_len =3D le32_to_cpu(ad->cur_cmd->status);
>  out:
>      /* declare that we processed everything */
>      s->data_ptr =3D s->data_end;
> -
> -    /* Update number of transferred bytes, destroy sglist */
> -    dma_buf_commit(s, size);
> +    ahci_write_fis_pio(ad, fis_len);
> =20
>      s->end_transfer_func(s);
> -
> -    if (!(s->status & DRQ_STAT)) {
> -        /* done with PIO send/receive */
> -        ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
> -    }
>  }

So in the ATAPI command packet case, this just changes the size from 0
to the length of the FIS, avoids performing a useless dma_buf_commit,
and writes the PIO Setup FIS prior to invoking the ATAPI emulator.

OK! That's definitely better.

In the normal ATA/ATAPI data transfer sense, this still performs the
data transfer prior to sending the PIO Setup FIS, but doesn't
necessarily wait for the end of the command.

Next, the fis_len we now calculate is based on the cumulative transfer
size thus far and not the size of the Data FIS we're pretending to have
transferred. If we're sending multiple PIO Setup FIS'es per-command, we
might over-report the total number of bytes transferred.

I think the correct thing to do is probably actually to do one PIO Setup
FIS per PIO transfer that reports only the size of the chunk being
transferred, which means a lot of the PIO tests are wrong because they
can't rely on the PIO FIS to report the total transfer size.

> =20
>  static void ahci_start_dma(IDEDMA *dma, IDEState *s,
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index bc201d762b..04f33e246c 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -477,6 +477,23 @@ void ahci_port_check_d2h_sanity(AHCIQState *ahci, =
uint8_t port, uint8_t slot)
>      g_free(d2h);
>  }
> =20
> +void ahci_port_check_pio_sanity_atapi(AHCIQState *ahci, uint8_t port,
> +                                      uint8_t slot)
> +{
> +    PIOSetupFIS *pio =3D g_malloc0(0x20);
> +
> +    /* We cannot check the Status or E_Status registers, because
> +     * the status may have again changed between the PIO Setup FIS
> +     * and the conclusion of the command with the D2H Register FIS. */
> +    qtest_memread(ahci->parent->qts, ahci->port[port].fb + 0x20, pio, =
0x20);
> +    g_assert_cmphex(pio->fis_type, =3D=3D, 0x5f);
> +
> +    g_assert(le16_to_cpu(pio->tx_count) =3D=3D 12 ||
> +             le16_to_cpu(pio->tx_count) =3D=3D 16);
> +
> +    g_free(pio);
> +}
> +
>  void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
>                                  uint8_t slot, size_t buffsize)
>  {
> @@ -831,9 +848,9 @@ void ahci_command_enable_atapi_dma(AHCICommand *cmd=
)
>      RegH2DFIS *fis =3D &(cmd->fis);
>      g_assert(cmd->props->atapi);
>      fis->feature_low |=3D 0x01;
> -    cmd->interrupts &=3D ~AHCI_PX_IS_PSS;
> +    /* PIO is still used to transfer the ATAPI command */
> +    g_assert(cmd->props->pio);
>      cmd->props->dma =3D true;
> -    cmd->props->pio =3D false;
>      /* BUG: We expect the DMA Setup interrupt for DMA commands */
>      /* cmd->interrupts |=3D AHCI_PX_IS_DSS; */
>  }
> @@ -845,7 +862,7 @@ AHCICommand *ahci_command_create(uint8_t command_na=
me)
> =20
>      g_assert(props);
>      cmd =3D g_new0(AHCICommand, 1);
> -    g_assert(!(props->dma && props->pio));
> +    g_assert(!(props->dma && props->pio) || props->atapi);
>      g_assert(!(props->lba28 && props->lba48));
>      g_assert(!(props->read && props->write));
>      g_assert(!props->size || props->data);
> @@ -1216,7 +1233,12 @@ void ahci_command_verify(AHCIQState *ahci, AHCIC=
ommand *cmd)
>          ahci_port_check_d2h_sanity(ahci, port, slot);
>      }
>      if (cmd->props->pio) {
> -        ahci_port_check_pio_sanity(ahci, port, slot, cmd->xbytes);
> +        /* For ATAPI, we might have only used PIO for the command.  */
> +        if (cmd->props->atapi && (!cmd->xbytes || cmd->props->dma)) {
> +            ahci_port_check_pio_sanity_atapi(ahci, port, slot);
> +        } else {
> +            ahci_port_check_pio_sanity(ahci, port, slot, cmd->xbytes);
> +        }
>      }
>  }
> =20
> diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
> index 715ca1e226..cdba8099dd 100644
> --- a/tests/libqos/ahci.h
> +++ b/tests/libqos/ahci.h
> @@ -598,6 +598,8 @@ void ahci_port_check_nonbusy(AHCIQState *ahci, uint=
8_t port, uint8_t slot);
>  void ahci_port_check_d2h_sanity(AHCIQState *ahci, uint8_t port, uint8_=
t slot);
>  void ahci_port_check_pio_sanity(AHCIQState *ahci, uint8_t port,
>                                  uint8_t slot, size_t buffsize);
> +void ahci_port_check_pio_sanity_atapi(AHCIQState *ahci, uint8_t port,
> +                                      uint8_t slot);
>  void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd);
> =20
>  /* Misc */
>=20

It's definitely no more wrong than what we do now, but I'm still
confused as hell over the right way to do them.

I might still stage it even though I am pretty sure it's wrong, because
I *know* the current behavior is very wrong and a lot of things still
seem to get along just fine :)

Let me know if you can help clarify my thinking on this one.
--js
