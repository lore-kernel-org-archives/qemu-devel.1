Received: from eggs.gnu.org ([209.51.188.92]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTFe-0003Qn-U8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTFe-0001sr-2E
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:27:58 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:38099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkTFd-0001qw-TE
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:27:58 -0500
Received: from player698.ha.ovh.net (unknown [10.109.159.35])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2CBD210F7CD
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:27:54 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774529254.1208625.8569916891242988294.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bd24d76f-f31d-12e8-913e-f57cefde115f@kaod.org>
Date: Fri, 18 Jan 2019 13:27:34 +0100
MIME-Version: 1.0
In-Reply-To: <154774529254.1208625.8569916891242988294.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/19] spapr/xive: Don't set irq type in
 spapr_xive_irq_claim()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/17/19 6:14 PM, Greg Kurz wrote:
> PHB hotplug will need to set the type of all LSIs at machine init.
> Prepare for that by calling xive_source_irq_set() in the callers
> of spapr_xive_irq_claim().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/spapr_xive.c        |    5 +----
>  hw/ppc/spapr_irq.c          |    6 ++++--
>  include/hw/ppc/spapr_xive.h |    2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index d391177ab81f..aab63cfd1178 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -471,16 +471,13 @@ static void spapr_xive_register_types(void)
> =20
>  type_init(spapr_xive_register_types)
> =20
> -bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi)
> +bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn)
>  {
> -    XiveSource *xsrc =3D &xive->source;
> -
>      if (lisn >=3D xive->nr_irqs) {
>          return false;
>      }
> =20
>      xive->eat[lisn].w |=3D cpu_to_be64(EAS_VALID);
> -    xive_source_irq_set(xsrc, lisn, lsi);
>      return true;
>  }
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 86c712d15382..bcd816c5a5fb 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -285,7 +285,8 @@ static void spapr_irq_init_xive(sPAPRMachineState *=
spapr, Error **errp)
> =20
>      /* Enable the CPU IPIs */
>      for (i =3D 0; i < nr_servers; ++i) {
> -        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i, false);
> +        spapr_xive_irq_claim(spapr->xive, SPAPR_IRQ_IPI + i);
> +        xive_source_irq_set(&spapr->xive->source, SPAPR_IRQ_IPI + i, f=
alse);
>      }
> =20
>      spapr_xive_hcall_init(spapr);
> @@ -294,10 +295,11 @@ static void spapr_irq_init_xive(sPAPRMachineState=
 *spapr, Error **errp)
>  static int spapr_irq_claim_xive(sPAPRMachineState *spapr, int irq, boo=
l lsi,
>                                  Error **errp)
>  {
> -    if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
> +    if (!spapr_xive_irq_claim(spapr->xive, irq)) {
>          error_setg(errp, "IRQ %d is invalid", irq);
>          return -1;
>      }
> +    xive_source_irq_set(&spapr->xive->source, irq, lsi);
>      return 0;
>  }
> =20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 7fdc25057420..f8854a4a6a18 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -37,7 +37,7 @@ typedef struct sPAPRXive {
>      MemoryRegion  tm_mmio;
>  } sPAPRXive;
> =20
> -bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
> +bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn);
>  bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> =20
>=20
