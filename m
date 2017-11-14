Received: from eggs.gnu.org ([2001:4830:134:3::10]:55628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEcto-0006oJ-3d
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEctk-0004t4-1H
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:13:16 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:36887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEctj-0004mM-Qm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:13:11 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A013411F588
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:13:03 +0100 (CET)
Date: Tue, 14 Nov 2017 16:12:55 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171114161255.6dec595f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171110152017.24324-7-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 06/11] spapr: store a reference
 IRQ bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, 10 Nov 2017 15:20:12 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> To save some state when the guest is migrated, we capture the IRQ
> bitmap after all devices have been reseted and store it as a reference
> for the machine.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20
>  We should probably merge this patch with the previous in the next
>  versions of the patchset. For the moment, I thought it would be
>  interesting to isolate the topic for discussion.
>=20

Indeed. So this will be able to catch all devices that are internally
created by the machine and the ones from the command line. If QEMU
is started with -S and the user does some device_add, the IRQs of the
corresponding devices won't be recorded, and we'll migrate the bitmap.
It is also possible to capture the state when the guest is started for
the first time, but it would bring some extra complexity... I guess
your approach is an acceptable trade-off.

>  hw/ppc/spapr.c         | 7 ++++++-
>  include/hw/ppc/spapr.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4ef0b73559ca..bf0e5b4f815b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1437,6 +1437,9 @@ static void ppc_spapr_reset(void)
>      qemu_devices_reset();
>      spapr_clear_pending_events(spapr);
> =20
> +    spapr->irq_map_ref =3D bitmap_new(spapr->nr_irqs);
> +    bitmap_copy(spapr->irq_map_ref, spapr->irq_map, spapr->nr_irqs);
> +
>      /*
>       * We place the device tree and RTAS just below either the top of th=
e RMA,
>       * or just below 2GB, whichever is lowere, so that it can be
> @@ -1683,7 +1686,9 @@ static const VMStateDescription vmstate_spapr_patb_=
entry =3D {
> =20
>  static bool spapr_irq_map_needed(void *opaque)
>  {
> -    return true;
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    return !bitmap_equal(spapr->irq_map, spapr->irq_map_ref, spapr->nr_i=
rqs);
>  }
> =20
>  static const VMStateDescription vmstate_spapr_irq_map =3D {
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5835c694caff..023436c32b2a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -81,6 +81,7 @@ struct sPAPRMachineState {
>      struct sPAPRNVRAM *nvram;
>      int32_t nr_irqs;
>      unsigned long *irq_map;
> +    unsigned long *irq_map_ref;
>      ICSState *ics;
>      sPAPRRTCState rtc;
> =20
