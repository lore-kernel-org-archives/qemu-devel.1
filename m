Received: from eggs.gnu.org ([209.51.188.92]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk6KA-0007uw-Ih
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gk6K9-0002n1-P8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:59:06 -0500
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gk6K9-0002f8-Ju
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:59:05 -0500
Received: from player735.ha.ovh.net (unknown [10.109.146.106])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id DC15947554
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:58:55 +0100 (CET)
References: <154772319819.1163472.4313149332350138217.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9e554917-e78d-0cd6-8ed0-6fd2808c4a84@kaod.org>
Date: Thu, 17 Jan 2019 12:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <154772319819.1163472.4313149332350138217.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: Forbid setting ic-mode for old
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 1/17/19 12:06 PM, Greg Kurz wrote:
> Machine types 3.0 and older only know about the legacy XICS backend.
> Make it clear by erroring out if the user tries to set ic-mode on
> such machines.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>=20
> Motivation for this comes from a failing backward migration test, cause=
d
> by ic-mode=3Dxics I forgot to drop from the command line :)
> ---
>  hw/ppc/spapr.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0942f35bf87e..6b8dbf5c5a3c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3126,6 +3126,11 @@ static void spapr_set_ic_mode(Object *obj, const=
 char *value, Error **errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
> +    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> +        error_setg(errp, "This machine only uses the legacy XICS backe=
nd, don't pass ic-mode");
> +        return;
> +    }
> +
>      /* The legacy IRQ backend can not be set */
>      if (strcmp(value, "xics") =3D=3D 0) {
>          spapr->irq =3D &spapr_irq_xics;
>=20
