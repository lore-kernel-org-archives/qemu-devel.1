Received: from eggs.gnu.org ([2001:4830:134:3::10]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEdOz-00052T-GF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEdOw-0008Lx-DU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:45:29 -0500
Received: from 19.mo6.mail-out.ovh.net ([188.165.56.177]:56424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEdOv-0008Kj-SX
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:45:26 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 11F3911F87C
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 16:45:23 +0100 (CET)
Date: Tue, 14 Nov 2017 16:45:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171114164516.635c3a14@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171110152017.24324-8-clg@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 07/11] spapr: introduce an
 'irq_base' number
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

On Fri, 10 Nov 2017 15:20:13 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> 'irq_base' is a base IRQ number which lets us allocate only the subset
> of the IRQ numbers used on the sPAPR platform. It is sync with the
> ICSState 'offset' attribute and this is slightly redundant. We could
> also choose to waste some extra bytes (512) and allocate the whole
> number space. To be discussed.
>=20
> But more important, it removes a dependency on the ICSState object of
> the sPAPR machine which is required for XIVE.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c         | 7 ++++---
>  include/hw/ppc/spapr.h | 1 +
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bf0e5b4f815b..1cbbd7715a85 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2362,6 +2362,7 @@ static void ppc_spapr_init(MachineState *machine)
>      /* Initialize the IRQ allocator */
>      spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
>      spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
> +    spapr->irq_base =3D XICS_IRQ_BASE;
>=20

Since this is a constant value, do we really need a machine-level value ?

Especially now that all the code that needs it is in spapr.c, I guess it
can directly use the macro, no ?

>      /* Set up Interrupt Controller before we create the VCPUs */
>      xics_system_init(machine, spapr->nr_irqs, &error_fatal);
> @@ -3630,7 +3631,7 @@ static void spapr_irq_free_block_2_11(XICSFabric *x=
i, int irq, int num)
>  static bool spapr_irq_test(XICSFabric *xi, int irq)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> -    int srcno =3D irq - spapr->ics->offset;
> +    int srcno =3D irq - spapr->irq_base;
> =20
>      return test_bit(srcno, spapr->irq_map);
>  }
> @@ -3656,13 +3657,13 @@ static int spapr_irq_alloc_block(XICSFabric *xi, =
int count, int align)
>      }
> =20
>      bitmap_set(spapr->irq_map, srcno, count);
> -    return srcno + spapr->ics->offset;
> +    return srcno + spapr->irq_base;
>  }
> =20
>  static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> -    int srcno =3D irq - spapr->ics->offset;
> +    int srcno =3D irq - spapr->irq_base;
> =20
>      bitmap_clear(spapr->irq_map, srcno, num);
>  }
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 023436c32b2a..200667dcff9d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -82,6 +82,7 @@ struct sPAPRMachineState {
>      int32_t nr_irqs;
>      unsigned long *irq_map;
>      unsigned long *irq_map_ref;
> +    uint32_t irq_base;
>      ICSState *ics;
>      sPAPRRTCState rtc;
> =20
