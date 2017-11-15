Received: from eggs.gnu.org ([2001:4830:134:3::10]:39301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEzzZ-00024Y-I0
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEzzW-000873-Ba
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:52:45 -0500
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:45918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEzzW-0007u5-29
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:52:42 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id DDA1611E781
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 16:52:31 +0100 (CET)
Date: Wed, 15 Nov 2017 16:52:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171115165218.6bb14b6f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171110152017.24324-10-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 09/11] spapr: split the IRQ
 number space for LSI interrupts
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

On Fri, 10 Nov 2017 15:20:15 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The type of an interrupt, MSI or LSI, is stored under the flag
> attribute of the ICSIRQState array. To reduce the use of this array
> and consequently of the ICSState object (This is needed to introduce
> the new XIVE model), we choose to split the IRQ number space of the
> machine in two: first the LSIs and then the MSIs.
>=20
> This also has the benefit to keep the LSI IRQ numbers in a well known
> range which will be useful for PHB hotplug.
>=20

Well... LSIs indeed land in a well known range, but it isn't enough for PHB
hotplug. Each PHB is uniquely identified by its 'index' property, and we
want each PHB to have fixed LSIs, so that they are invariant across migrati=
on.

> This change only applies to the latest pseries machines. Older
> machines still use the ICSIRQState array to define the IRQ type.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>=20
>  Changes since v2 :
>=20
>  - introduced a second set of XICSFabric IRQ operations for older
>    pseries machines
>=20
>  hw/intc/xics_spapr.c  |  6 +++---
>  hw/ppc/spapr.c        | 33 +++++++++++++++++++++++++++++----
>  include/hw/ppc/xics.h |  2 +-
>  3 files changed, 33 insertions(+), 8 deletions(-)pe-total-#msi
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index de9e65d35247..b8e91aaf52bd 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -260,7 +260,7 @@ int spapr_ics_alloc(ICSState *ics, int irq_hint, bool=
 lsi, Error **errp)
>          }
>          irq =3D irq_hint;
>      } else {
> -        irq =3D xic->irq_alloc_block(ics->xics, 1, 1);
> +        irq =3D xic->irq_alloc_block(ics->xics, 1, 1, lsi);
>          if (irq < 0) {
>              error_setg(errp, "can't allocate IRQ: no IRQ left");
>              return -1;
> @@ -297,9 +297,9 @@ int spapr_ics_alloc_block(ICSState *ics, int num, boo=
l lsi,
>      if (align) {
>          assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
>                 (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> -        first =3D xic->irq_alloc_block(ics->xics, num, num);
> +        first =3D xic->irq_alloc_block(ics->xics, num, num, lsi);
>      } else {
> -        first =3D xic->irq_alloc_block(ics->xics, num, 1);
> +        first =3D xic->irq_alloc_block(ics->xics, num, 1, lsi);
>      }
>      if (first < 0) {
>          error_setg(errp, "can't find a free %d-IRQ block", num);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ce314fcf38db..f14eae6196cd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3596,7 +3596,8 @@ static bool spapr_irq_test_2_11(XICSFabric *xi, int=
 irq)
>      return !ICS_IRQ_FREE(ics, srcno);
>  }
> =20
> -static int spapr_irq_alloc_block_2_11(XICSFabric *xi, int count, int ali=
gn)
> +static int spapr_irq_alloc_block_2_11(XICSFabric *xi, int count, int ali=
gn,
> +                                      bool lsi)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>      ICSState *ics =3D spapr->ics;
> @@ -3628,7 +3629,7 @@ static void spapr_irq_free_block_2_11(XICSFabric *x=
i, int irq, int num)
>      }
>  }
> =20
> -static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
> +static bool spapr_irq_is_lsi_2_11(XICSFabric *xi, int irq)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
>      int srcno =3D irq - spapr->ics->offset;
> @@ -3644,10 +3645,21 @@ static bool spapr_irq_test(XICSFabric *xi, int ir=
q)
>      return test_bit(srcno, spapr->irq_map);
>  }
> =20
> -static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
> +
> +/*
> + * Let's provision 4 LSIs per PHBs
> + */
> +#define SPAPR_MAX_LSI (SPAPR_MAX_PHBS * 4)
> +
> +/*
> + * Split the IRQ number space of the machine in two: first the LSIs
> + * and then the MSIs. This allows us to keep the LSI IRQ numbers in a
> + * well known range which is useful for PHB hotplug.
> + */
> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align, b=
ool lsi)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> -    int start =3D 0;
> +    int start =3D lsi ? 0 : SPAPR_MAX_LSI;
>      int srcno;
> =20
>      /*
> @@ -3664,6 +3676,10 @@ static int spapr_irq_alloc_block(XICSFabric *xi, i=
nt count, int align)
>          return -1;
>      }
> =20
> +    if (lsi && srcno >=3D SPAPR_MAX_LSI) {
> +        return -1;
> +    }
> +
>      bitmap_set(spapr->irq_map, srcno, count);
>      return srcno + spapr->irq_base;
>  }
> @@ -3676,6 +3692,14 @@ static void spapr_irq_free_block(XICSFabric *xi, i=
nt irq, int num)
>      bitmap_clear(spapr->irq_map, srcno, num);
>  }
> =20
> +static bool spapr_irq_is_lsi(XICSFabric *xi, int irq)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> +    int srcno =3D irq - spapr->irq_base;
> +
> +    return (srcno >=3D 0) && (srcno < SPAPR_MAX_LSI);
> +}
> +
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> @@ -3860,6 +3884,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      xic->irq_test =3D spapr_irq_test_2_11;
>      xic->irq_alloc_block =3D spapr_irq_alloc_block_2_11;
>      xic->irq_free_block =3D spapr_irq_free_block_2_11;
> +    xic->irq_is_lsi =3D spapr_irq_is_lsi_2_11;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 478f8e510179..292b929e88eb 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -177,7 +177,7 @@ typedef struct XICSFabricClass {
>      ICPState *(*icp_get)(XICSFabric *xi, int server);
>      /* IRQ allocator helpers */
>      bool (*irq_test)(XICSFabric *xi, int irq);
> -    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
> +    int (*irq_alloc_block)(XICSFabric *xi, int count, int align, bool ls=
i);
>      void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>      bool (*irq_is_lsi)(XICSFabric *xi, int irq);
>  } XICSFabricClass;
