Received: from eggs.gnu.org ([2001:4830:134:3::10]:40552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjke-0003vk-92
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjka-0005Ko-5U
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:28 -0500
Date: Thu, 23 Feb 2017 13:15:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223021531.GS12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-5-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bk6L21jbBNK7V1Rv"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-5-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 04/22] ppc/xics: add an
 InterruptStatsProvider interface to ICS and ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Bk6L21jbBNK7V1Rv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:27PM +0100, C=E9dric Le Goater wrote:
> This is, again, to reduce the use of the list of ICS objects. Let's
> make each individual ICS and ICP object an InterruptStatsProvider and
> remove this same interface from XICSState.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I'm a little hesitant about this, because it means that getting the
interrupt stats information is now spread out over the qom tree,
whereas previously there was a single location to get a good summary
of the systems overall interrupt status.  The previous behaviour seems
like it would be more convenient for debugging.

That said, I see the structural advantages of this split.  Hmm.. still
thinking..

> ---
>  hw/intc/xics.c | 76 +++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 41 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 9f22814815c9..b1294417a0ae 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -92,44 +92,44 @@ void xics_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
>      }
>  }
> =20
> -static void xics_common_pic_print_info(InterruptStatsProvider *obj,
> -                                       Monitor *mon)
> +static void icp_pic_print_info(InterruptStatsProvider *obj,
> +                           Monitor *mon)
>  {
> -    XICSState *xics =3D XICS_COMMON(obj);
> -    ICSState *ics;
> +    ICPState *icp =3D ICP(obj);
> +    int cpu_index =3D icp->cs ? icp->cs->cpu_index : -1;
> +
> +    if (!icp->output) {
> +        return;
> +    }
> +    monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%02x\n=
",
> +                   cpu_index, icp->xirr, icp->xirr_owner,
> +                   icp->pending_priority, icp->mfrr);
> +}
> +
> +static void ics_simple_pic_print_info(InterruptStatsProvider *obj,
> +                                      Monitor *mon)
> +{
> +    ICSState *ics =3D ICS_SIMPLE(obj);
>      uint32_t i;
> =20
> -    for (i =3D 0; i < xics->nr_servers; i++) {
> -        ICPState *icp =3D &xics->ss[i];
> +    monitor_printf(mon, "ICS %4x..%4x %p\n",
> +                   ics->offset, ics->offset + ics->nr_irqs - 1, ics);
> =20
> -        if (!icp->output) {
> -            continue;
> -        }
> -        monitor_printf(mon, "CPU %d XIRR=3D%08x (%p) PP=3D%02x MFRR=3D%0=
2x\n",
> -                       i, icp->xirr, icp->xirr_owner,
> -                       icp->pending_priority, icp->mfrr);
> +    if (!ics->irqs) {
> +        return;
>      }
> =20
> -    QLIST_FOREACH(ics, &xics->ics, list) {
> -        monitor_printf(mon, "ICS %4x..%4x %p\n",
> -                       ics->offset, ics->offset + ics->nr_irqs - 1, ics);
> +    for (i =3D 0; i < ics->nr_irqs; i++) {
> +        ICSIRQState *irq =3D ics->irqs + i;
> =20
> -        if (!ics->irqs) {
> +        if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
>              continue;
>          }
> -
> -        for (i =3D 0; i < ics->nr_irqs; i++) {
> -            ICSIRQState *irq =3D ics->irqs + i;
> -
> -            if (!(irq->flags & XICS_FLAGS_IRQ_MASK)) {
> -                continue;
> -            }
> -            monitor_printf(mon, "  %4x %s %02x %02x\n",
> -                           ics->offset + i,
> -                           (irq->flags & XICS_FLAGS_IRQ_LSI) ?
> -                           "LSI" : "MSI",
> -                           irq->priority, irq->status);
> -        }
> +        monitor_printf(mon, "  %4x %s %02x %02x\n",
> +                       ics->offset + i,
> +                       (irq->flags & XICS_FLAGS_IRQ_LSI) ?
> +                       "LSI" : "MSI",
> +                       irq->priority, irq->status);
>      }
>  }
> =20
> @@ -161,10 +161,8 @@ static void xics_common_initfn(Object *obj)
>  static void xics_common_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> -    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(o=
c);
> =20
>      dc->reset =3D xics_common_reset;
> -    ic->print_info =3D xics_common_pic_print_info;
>  }
> =20
>  static const TypeInfo xics_common_info =3D {
> @@ -174,10 +172,6 @@ static const TypeInfo xics_common_info =3D {
>      .class_size    =3D sizeof(XICSStateClass),
>      .instance_init =3D xics_common_initfn,
>      .class_init    =3D xics_common_class_init,
> -    .interfaces =3D (InterfaceInfo[]) {
> -        { TYPE_INTERRUPT_STATS_PROVIDER },
> -        { }
> -    },
>  };
> =20
>  /*
> @@ -414,10 +408,12 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
>  static void icp_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
> =20
>      dc->reset =3D icp_reset;
>      dc->vmsd =3D &vmstate_icp_server;
>      dc->realize =3D icp_realize;
> +    ic->print_info =3D icp_pic_print_info;
>  }
> =20
>  static const TypeInfo icp_info =3D {
> @@ -426,6 +422,10 @@ static const TypeInfo icp_info =3D {
>      .instance_size =3D sizeof(ICPState),
>      .class_init =3D icp_class_init,
>      .class_size =3D sizeof(ICPStateClass),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { }
> +    },
>  };
> =20
>  /*
> @@ -692,6 +692,7 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
> +    InterruptStatsProviderClass *ic =3D INTERRUPT_STATS_PROVIDER_CLASS(k=
lass);
> =20
>      dc->realize =3D ics_simple_realize;
>      dc->props =3D ics_simple_properties;
> @@ -701,6 +702,7 @@ static void ics_simple_class_init(ObjectClass *klass,=
 void *data)
>      isc->reject =3D ics_simple_reject;
>      isc->resend =3D ics_simple_resend;
>      isc->eoi =3D ics_simple_eoi;
> +    ic->print_info =3D ics_simple_pic_print_info;
>  }
> =20
>  static const TypeInfo ics_simple_info =3D {
> @@ -710,6 +712,10 @@ static const TypeInfo ics_simple_info =3D {
>      .class_init =3D ics_simple_class_init,
>      .class_size =3D sizeof(ICSStateClass),
>      .instance_init =3D ics_simple_initfn,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { }
> +    },
>  };
> =20
>  static const TypeInfo ics_base_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Bk6L21jbBNK7V1Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkXDAAoJEGw4ysog2bOSA74QAJMiRJ4r8jyCw2z9+e0tVJ6n
DuYDlxeznjcaVcryhbrdETNTMj4quTQeqtZQFeXZcU1uxa8A27pQjmpWIibha7BT
jA2hjmdzvy2bQMuNRwdJHEk560XchS+auAgqGDj8WhIuyc7v1cfolwSqs4XejvL7
mcqst+4TA5H8V03eg9UqU2kOx1BN/zyMrWxH7SRIuSdNUtXVXhmnr/2jIh3jXNOD
YkWh1wqoTCcaL0B5GeigxdMFyOkQY29JMzIOUcZrzgef9tKSo1a6OFWOfNbs/TGi
PJSVG79D5ndVIlbQ/YOvjpw8J+23Ro4vsbcBi2I6zpThbX9qIinm4EtRypV61XNs
1kK4yKVoq3ES1vk0UoIi5yVHBjZWCKQ3YQWLjKfTPSyjOilpabn8dGXZ+UoiL6Eh
ygy+53e2RfFNvuh6F5usoNNDD4C2pC1JgfF//QcKm4D8qtWTtBcgWMPzyV87Dokn
Z/wVG/tpPGTmqxBzW0MbZ4+5I9L1VpcHT9KLQQKVQ1a5pLrUX5mSCLHjT4dYdgyl
CEk3z03sbSrrq/wfxNc25G0xxGwYHltrEHSBhAymnfDEgy/gwFlxzSfUxG4qXj2l
v8JyVkLIpC85PP7n3z4fKfmRR/9qd/wQ41C6LXMnwJBmgteD8JOFJOtW2gD2iy2h
OSgG8MaYNCQkzEPDBcEZ
=0m1H
-----END PGP SIGNATURE-----

--Bk6L21jbBNK7V1Rv--
