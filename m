Received: from eggs.gnu.org ([2001:4830:134:3::10]:34016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djL1X-0008Ib-LE
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1djL1U-0000LK-J9
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:51:55 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:47575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1djL1U-0000Kq-C8
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 03:51:52 -0400
Received: from player763.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id EE657764C4
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 09:51:49 +0200 (CEST)
References: <1503178840-21512-1-git-send-email-minyard@acm.org>
	<1503178840-21512-3-git-send-email-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9d98f933-fc2f-c9b0-2376-ca97069c091d@kaod.org>
Date: Sun, 20 Aug 2017 09:51:45 +0200
MIME-Version: 1.0
In-Reply-To: <1503178840-21512-3-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] ipmi: Don't set the timestamp on add
 events that don't have it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Corey Minyard <cminyard@mvista.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 08/19/2017 11:40 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> According to the spec, event types from 0x0e to 0xff do not have a
> timestamp. =20

>From section "32.3 OEM SEL Record - Type E0h-FFh"

> So don't set it when adding those types.  This required
> putting the timestamp in a temporary buffer, since it's still required
> to set the last addition time.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ipmi/ipmi_bmc_sim.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 1c732aa..0f191e8 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -443,16 +443,20 @@ static void sel_inc_reservation(IPMISel *sel)
>  /* Returns 1 if the SEL is full and can't hold the event. */
>  static int sel_add_event(IPMIBmcSim *ibs, uint8_t *event)
>  {
> +    uint8_t ts[4];
> +
>      event[0] =3D 0xff;
>      event[1] =3D 0xff;
> -    set_timestamp(ibs, event + 3);
> +    set_timestamp(ibs, ts);
> +    if (event[2] < 0xe0) /* Don't set timestamps for these, per the sp=
ec. */
> +        memcpy(event + 3, ts, 4);
>      if (ibs->sel.next_free =3D=3D MAX_SEL_SIZE) {
>          ibs->sel.overflow =3D 1;
>          return 1;
>      }
>      event[0] =3D ibs->sel.next_free & 0xff;
>      event[1] =3D (ibs->sel.next_free >> 8) & 0xff;
> -    memcpy(ibs->sel.last_addition, event + 3, 4);
> +    memcpy(ibs->sel.last_addition, ts, 4);
>      memcpy(ibs->sel.sel[ibs->sel.next_free], event, 16);
>      ibs->sel.next_free++;
>      sel_inc_reservation(&ibs->sel);
>=20
