Received: from eggs.gnu.org ([2001:4830:134:3::10]:42252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLmgm-0001N6-BN
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 05:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLmgl-00027s-Es
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 05:09:56 -0500
MIME-Version: 1.0
References: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 11 Nov 2018 11:09:31 +0100
Message-ID: <CAAdtpL626Ps=v842jyWnB-6yX54XKzwS_8EaRuyP7cxgnZP6pg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1] fdc: fix segfault in
 fdctrl_stop_transfer() when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, martin@duskware.de

On Sun, Nov 11, 2018 at 10:41 AM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Commit c8a35f1cf0f "fdc: use IsaDma interface instead of global DMA_*
> functions" accidentally introduced a segfault in fdctrl_stop_transfer() f=
or
> non-DMA transfers.
>
> If fdctrl->dma_chann has not been configured then the fdctrl->dma interfa=
ce
> reference isn't initialised during isabus_fdc_realize(). Unfortunately
> fdctrl_stop_transfer() unconditionally references the DMA interface when
> finishing the transfer causing a NULL pointer dereference.
>
> Fix the issue by adding a check in fdctrl_stop_transfer() so that the DMA
> interface reference and release method is only invoked if fdctrl->dma_cha=
nn
> has been set.
>
> (This issue was discovered by Martin testing a recent change in the NetBS=
D
> installer under qemu-system-sparc)
>
> Reported-by: Martin Husemann <martin@duskware.de>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/block/fdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 2e9c1e1e2f..6f19f127a5 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -1617,7 +1617,7 @@ static void fdctrl_stop_transfer(FDCtrl *fdctrl, ui=
nt8_t status0,
>      fdctrl->fifo[5] =3D cur_drv->sect;
>      fdctrl->fifo[6] =3D FD_SECTOR_SC;
>      fdctrl->data_dir =3D FD_DIR_READ;
> -    if (!(fdctrl->msr & FD_MSR_NONDMA)) {
> +    if (fdctrl->dma_chann !=3D -1 && !(fdctrl->msr & FD_MSR_NONDMA)) {

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>          IsaDmaClass *k =3D ISADMA_GET_CLASS(fdctrl->dma);
>          k->release_DREQ(fdctrl->dma, fdctrl->dma_chann);
>      }
> --
> 2.11.0
>
>
