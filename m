Received: from eggs.gnu.org ([2001:4830:134:3::10]:46578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOQFf-0003NX-Kd
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOQFe-0004DO-G1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:16:35 -0400
References: <20180531004323.4611-1-jsnow@redhat.com>
	<20180531004323.4611-3-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <c45fbf71-447b-8903-2f8a-cf0535c7f892@redhat.com>
Date: Thu, 31 May 2018 12:16:26 -0400
MIME-Version: 1.0
In-Reply-To: <20180531004323.4611-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] ahci: fix PxCI register race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>

>From comments on the cover letter, I am adding:

Fixes: https://bugs.launchpad.net/qemu/+bug/1769189

On 05/30/2018 08:43 PM, John Snow wrote:
> AHCI presently signals completion prior to the PxCI register being
> cleared to indicate completion. If a guest driver attempts to issue
> a new command in its IRQ handler, it might be surprised to learn there
> is still a command pending.
>=20
> In the case of Windows 10's boot driver, it will actually poll the IRQ
> register hoping to find out when the command is done running -- which
> will never happen, as there isn't a command running.
>=20
> Fix this: clear PxCI in ahci_cmd_done and not in the asynchronous BH.
> Because it now runs synchronously, we don't need to check if the comman=
d
> is actually done by spying on the ATA registers. We know it's done.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

and:

CC: qemu-stable <qemu-stable@nongnu.org>
Reported-by: Fran=C3=A7ois Guerraz <kubrick@fgv6.net>
Tested-by: Bruce Rogers <brogers@suse.com>

(Stable note: only patch #2 here is strictly required.)

> ---
>  hw/ide/ahci.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index b7a6f68790..a9558e45e7 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -532,13 +532,6 @@ static void ahci_check_cmd_bh(void *opaque)
>      qemu_bh_delete(ad->check_bh);
>      ad->check_bh =3D NULL;
> =20
> -    if ((ad->busy_slot !=3D -1) &&
> -        !(ad->port.ifs[0].status & (BUSY_STAT|DRQ_STAT))) {
> -        /* no longer busy */
> -        ad->port_regs.cmd_issue &=3D ~(1 << ad->busy_slot);
> -        ad->busy_slot =3D -1;
> -    }
> -
>      check_cmd(ad->hba, ad->port_no);
>  }
> =20
> @@ -1425,6 +1418,12 @@ static void ahci_cmd_done(IDEDMA *dma)
> =20
>      trace_ahci_cmd_done(ad->hba, ad->port_no);
> =20
> +    /* no longer busy */
> +    if (ad->busy_slot !=3D -1) {
> +        ad->port_regs.cmd_issue &=3D ~(1 << ad->busy_slot);
> +        ad->busy_slot =3D -1;
> +    }
> +
>      /* update d2h status */
>      ahci_write_fis_d2h(ad);
> =20
>=20
