Received: from eggs.gnu.org ([2001:4830:134:3::10]:37199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyPTn-0003Az-FY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eyPTm-0007Ih-6o
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 18:11:39 -0400
References: <20180223152640.11459-1-pbonzini@redhat.com>
	<20180223152640.11459-3-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <663bee4b-0554-9b68-6253-1ebe75bc7b3b@redhat.com>
Date: Tue, 20 Mar 2018 18:11:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180223152640.11459-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] ide: push end_transfer callback to
 ide_transfer_halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org



On 02/23/2018 10:26 AM, Paolo Bonzini wrote:
> The callback must be invoked once we get out of the DRQ phase; because
> all end_transfer_funcs end up invoking ide_transfer_stop, call it there=
.
> While at it, remove the "notify" argument from ide_transfer_halt; the
> code can simply be moved to ide_transfer_stop.
>=20
> Old PATA controllers have no end_transfer callback, so there is no chan=
ge
> there.  For AHCI the end_transfer_func already called ide_transfer_stop
> so the effect is that the PIO FIS is written before the D2H FIS rather
> than after, which is arguably an improvement.
>=20

MMK, so this is the "PIO Setup FIS" which I... actually, I was never
sure what role this was supposed to play *exactly*.

"Used by the device to provide the host adapter with sufficient
information regarding a Programmed Input/Output (PIO) data phase to
allow the host adapter to efficiently handle PIO data transfers."

So in a perfect world, the SATA layer generates this *for* the AHCI
adapter, but really both of those models are smooshed into one layer for
us, so we just generate this so the host driver doesn't freak out.

"For PIO data transfers, the device shall send to the host a PIO Setup =E2=
=80=93
Device to Host FIS just before each and every data transfer FIS that is
required to complete the data transfer. Data transfers from Host to
Device as well as data transfers from Device to Host shall follow this
algorithm."

Well, we don't emulate Data FIS packets and I don't *think* those get
cached in the received FIS data structure area for the AHCI HBA, so we
just skip those.

"Because of the stringent timing constraints in the ATA Standard, the
PIO Setup FIS includes both the starting and ending status values. These
are used by the host adapter to first signal to host software readiness
for PIO write data (BSY bit is cleared to zero and DRQ bit is set to
one), and following the PIO write burst to properly signal host software
by clearing the DRQ bit to zero and possibly setting the BSY bit to one."

This part confuses me. The starting and ending status values? How would
we know the ending status value if this gets sent by the device before a
transfer?

> However, ahci_end_transfer is now called _after_ the DRQ_STAT has been
> cleared, so remove the status check in ahci_end_transfer; it was only
> there to ensure the FIS was not written more than once, and this cannot
> happen anymore.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/ahci.c |  7 ++-----
>  hw/ide/core.c | 15 +++++++--------
>  2 files changed, 9 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 937bad55fb..c3c6843b76 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1326,12 +1326,9 @@ out:
>  static void ahci_end_transfer(IDEDMA *dma)
>  {
>      AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
> -    IDEState *s =3D &ad->port.ifs[0];
> =20
> -    if (!(s->status & DRQ_STAT)) {
> -        /* done with PIO send/receive */
> -        ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
> -    }
> +    /* done with PIO send/receive */
> +    ahci_write_fis_pio(ad, le32_to_cpu(ad->cur_cmd->status));
>  }
> =20
>  static void ahci_start_dma(IDEDMA *dma, IDEState *s,
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 92f4424dc3..c4710a6f55 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -544,7 +544,6 @@ void ide_transfer_start(IDEState *s, uint8_t *buf, =
int size,
>      }
>      s->bus->dma->ops->start_transfer(s->bus->dma);
>      end_transfer_func(s);
> -    s->bus->dma->ops->end_transfer(s->bus->dma);
>  }
> =20
>  static void ide_cmd_done(IDEState *s)
> @@ -555,26 +554,26 @@ static void ide_cmd_done(IDEState *s)
>  }
> =20
>  static void ide_transfer_halt(IDEState *s,
> -                              void(*end_transfer_func)(IDEState *),
> -                              bool notify)
> +                              void(*end_transfer_func)(IDEState *))
>  {
>      s->end_transfer_func =3D end_transfer_func;
>      s->data_ptr =3D s->io_buffer;
>      s->data_end =3D s->io_buffer;
>      s->status &=3D ~DRQ_STAT;
> -    if (notify) {
> -        ide_cmd_done(s);
> -    }
>  }
> =20
>  void ide_transfer_stop(IDEState *s)
>  {
> -    ide_transfer_halt(s, ide_transfer_stop, true);
> +    ide_transfer_halt(s, ide_transfer_stop);
> +    if (s->bus->dma->ops->end_transfer) {
> +        s->bus->dma->ops->end_transfer(s->bus->dma);
> +    }
> +    ide_cmd_done(s);
>  }
> =20
>  static void ide_transfer_cancel(IDEState *s)
>  {
> -    ide_transfer_halt(s, ide_transfer_cancel, false);
> +    ide_transfer_halt(s, ide_transfer_cancel);
>  }
> =20
>  int64_t ide_get_sector(IDEState *s)
>=20

Seems sane, with some lingering questions about what the PIO Setup FIS
is supposed to do to begin with still remaining.
