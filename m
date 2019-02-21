Received: from eggs.gnu.org ([209.51.188.92]:42141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gwsmX-0006NN-PR
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gwsmW-00018K-Tu
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:09:13 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:50529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gwsmW-00012r-My
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:09:12 -0500
Received: from player698.ha.ovh.net (unknown [10.109.143.209])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 34FC31FC085
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 19:09:02 +0100 (CET)
References: <1550748288-30598-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fff86cab-d4ae-ea91-0956-78fa13bcec0c@kaod.org>
Date: Thu, 21 Feb 2019 19:08:57 +0100
MIME-Version: 1.0
In-Reply-To: <1550748288-30598-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Use object_initialize_child for
 correct reference counting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

On 2/21/19 12:24 PM, Thomas Huth wrote:
> Both functions, object_initialize() and object_property_add_child() inc=
rease
> the reference counter of the new object, so one of the references has t=
o be
> dropped afterwards to get the reference counting right. Otherwise the c=
hild
> object will not be properly cleaned up when the parent gets destroyed.
> Thus let's use now object_initialize_child() instead to get the referen=
ce
> counting here right.
>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Looks fine to me.=20

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c     | 12 ++++++------
>  hw/ppc/pnv_psi.c |  4 ++--
>  hw/ppc/spapr.c   |  6 +++---
>  3 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index da54086..9e03e9c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -736,18 +736,18 @@ static void pnv_chip_power8_instance_init(Object =
*obj)
>  {
>      Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
> =20
> -    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
> -    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
> +    object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->ps=
i),
> +                            TYPE_PNV_PSI, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->psi), "xics",
>                                     OBJECT(qdev_get_machine()), &error_=
abort);
> =20
> -    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
> -    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
> +    object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lp=
c),
> +                            TYPE_PNV_LPC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
> =20
> -    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
> -    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
> +    object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->oc=
c),
> +                            TYPE_PNV_OCC, &error_abort, NULL);
>      object_property_add_const_link(OBJECT(&chip8->occ), "psi",
>                                     OBJECT(&chip8->psi), &error_abort);
>  }
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 8ced095..44bc0cb 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -444,8 +444,8 @@ static void pnv_psi_init(Object *obj)
>  {
>      PnvPsi *psi =3D PNV_PSI(obj);
> =20
> -    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
> -    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL)=
;
> +    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ic=
s),
> +                            TYPE_ICS_SIMPLE, &error_abort, NULL);
>  }
> =20
>  static const uint8_t irq_to_xivr[] =3D {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abf9ebc..6c58dca 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1696,9 +1696,9 @@ static void spapr_create_nvram(sPAPRMachineState =
*spapr)
> =20
>  static void spapr_rtc_create(sPAPRMachineState *spapr)
>  {
> -    object_initialize(&spapr->rtc, sizeof(spapr->rtc), TYPE_SPAPR_RTC)=
;
> -    object_property_add_child(OBJECT(spapr), "rtc", OBJECT(&spapr->rtc=
),
> -                              &error_fatal);
> +    object_initialize_child(OBJECT(spapr), "rtc",
> +                            &spapr->rtc, sizeof(spapr->rtc), TYPE_SPAP=
R_RTC,
> +                            &error_fatal, NULL);
>      object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
>                                &error_fatal);
>      object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr=
->rtc),
>=20
