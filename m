Received: from eggs.gnu.org ([209.51.188.92]:47592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuKU-0000YL-12
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtuKK-0001hm-Gy
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:11:53 -0500
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:44246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtuK8-0001bJ-DX
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 08:11:38 -0500
Received: from player786.ha.ovh.net (unknown [10.109.146.82])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 104D4114935
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 14:11:32 +0100 (CET)
Date: Wed, 13 Feb 2019 14:11:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213141115.352ec2f6@bahia.lan>
In-Reply-To: <20190213035203.GD1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999586635.690774.6503848986369114097.stgit@bahia.lan>
	<20190213035203.GD1884@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/Tp._T8mA3mgTae5GorYM5U/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 05/15] spapr_irq: Expose the phandle of
 the interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

--Sig_/Tp._T8mA3mgTae5GorYM5U/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Feb 2019 14:52:04 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Feb 12, 2019 at 07:24:26PM +0100, Greg Kurz wrote:
> > This will be used by PHB hotplug in order to create the "interrupt-map"
> > property of the PHB node.
> >=20
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v4: - return phandle via a pointer =20
>=20
> You don't really need to do this.  You already have an Error ** to
> return errors via, so you don't need an error return code.  Plus
> phandles are not permitted to be 0 or -1, so you have some safe values
> even for that case.
>=20

Ok, I'll use the return value for the phandle.

> > ---
> >  hw/ppc/spapr_irq.c         |   26 ++++++++++++++++++++++++++
> >  include/hw/ppc/spapr_irq.h |    2 ++
> >  2 files changed, 28 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > index b8d725e251ba..31495033c37c 100644
> > --- a/hw/ppc/spapr_irq.c
> > +++ b/hw/ppc/spapr_irq.c
> > @@ -692,6 +692,32 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Err=
or **errp)
> >      }
> >  }
> > =20
> > +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> > +                          uint32_t *phandle, Error **errp)
> > +{
> > +    const char *nodename =3D spapr->irq->get_nodename(spapr);
> > +    int offset, ph;
> > +
> > +    offset =3D fdt_subnode_offset(fdt, 0, nodename);
> > +    if (offset < 0) {
> > +        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> > +                   fdt_strerror(offset));
> > +        return -1;
> > +    }
> > +
> > +    ph =3D fdt_get_phandle(fdt, offset);
> > +    if (!ph) {
> > +        error_setg(errp, "Can't get phandle of node \"%s\"", nodename);
> > +        return -1;
> > +    }
> > +
> > +    if (phandle) {
> > +        *phandle =3D ph;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  /*
> >   * XICS legacy routines - to deprecate one day
> >   */
> > diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> > index ad7127355441..4b3303ef4f6a 100644
> > --- a/include/hw/ppc/spapr_irq.h
> > +++ b/include/hw/ppc/spapr_irq.h
> > @@ -62,6 +62,8 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq=
, int num);
> >  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
> >  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
> >  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> > +int spapr_irq_get_phandle(sPAPRMachineState *spapr, void *fdt,
> > +                          uint32_t *phandle, Error **errp);
> > =20
> >  /*
> >   * XICS legacy routines
> >  =20
>=20


--Sig_/Tp._T8mA3mgTae5GorYM5U/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlxkF3MACgkQcdTV5YIv
c9Z3xg//T0tm9SWrzoc/9NRQ7OfmitubNHBgYgfiEGpH4MvnH7B4GHNltpZQgu4t
Sq1NTnNmicr62SnF1QIUqS4PS5kKvBXm9mkOlvwbsnjt4YIzaf7ohuaB05dPa1rD
Twv/cHxqrBHRpjRH1vvGivvX8XBc2LG9wpwMluM2YRbwdSgsGmErkhxOlZ85ATz0
AC5pIwOlzJwnvHdL6g1JOoNsz7KJi87/hMqMkLgA7NYgAokbVLtl4iD871Juj2W4
Td5GT3sLNBpgeiCcJi6QMdmaKiQXfMuse7q3d5PBMOIBePgNOiNmoPAei0qzvA4/
KRxtCg4o7vku1KbFfA8ZrTonzu5zKY4JVFaLHldKVfTbbWyn4Omj8DPaFaopsENf
ghvgax6P+B2K++Bxgd1T+WS38zgOIiWvT9GgR9kc3vvXQ7rC9hTHyCJ3lZeNWPvh
Qv1Z2hzoyGlsy6C7AwHeY1J3QoqLF4q2SMBLBq7ZL3yatxcS9v1LmfQGNUrKw3NA
0avgiEPp/9vjsf2QwDQgxNC/dFqCCUS292Dd3I0GT8hEJDZjUByiusfmIFATY5JD
eV7hV0ZxLbGNuPgMiY1iARunou5zY1aDpsWHmfU/Qvv/oMAT/yxIVYiFIAdc4ct/
i5Gqc6ygUDvotsmQnfspFW+ZDX21VUuyIG5v9eONc+axIBEAAFw=
=2GsW
-----END PGP SIGNATURE-----

--Sig_/Tp._T8mA3mgTae5GorYM5U/--
