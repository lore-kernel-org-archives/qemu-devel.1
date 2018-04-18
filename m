Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f8jf5-0005RW-Ab
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1f8jf2-0002q9-7u
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:45:59 -0400
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:42052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1f8jf2-0002p2-1F
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:45:56 -0400
Received: from player786.ha.ovh.net (unknown [10.109.105.104])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 393A1153CBE
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 11:45:53 +0200 (CEST)
Date: Wed, 18 Apr 2018 11:45:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180418110902.50ec50a3@bahia.lan>
In-Reply-To: <20180418014908.GE2317@umbus.fritz.box>
References: <1523982095-17175-1-git-send-email-spopovyc@redhat.com>
	<20180417191751.709bb564@bahia.lan>
	<20180418014908.GE2317@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/wRot.5vtf8ipfsfKksClw.Z";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for 2.13] spapr: Correct max
 associativity domains value for non-NUMA configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Serhii Popovych <spopovyc@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/wRot.5vtf8ipfsfKksClw.Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Apr 2018 11:49:08 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Apr 17, 2018 at 07:17:51PM +0200, Greg Kurz wrote:
> > Cc'ing David who should always be in the recipient list when posting pp=
c related
> > patches :)
> >=20
> > On Tue, 17 Apr 2018 12:21:35 -0400
> > Serhii Popovych <spopovyc@redhat.com> wrote:
> >  =20
> > > In non-NUMA configurations nb_numa_nodes is zero and we set 5th cell
> > > in ibm,max-associativity-domains to -1. That causes to stall Linux
> > > guests during boot after following line:
> > >=20
> > > [    0.000000] NUMA associativity depth for CPU/Memory: 4
> > >=20
> > > Make last possible NUMA in property zero to correct support for
> > > non-NUMA guests.
> > >  =20
> >=20
> > Alternatively, as suggested by David in some other mail, you could drop=
 the
> > property in this case. I've checked it fixes the hang too, and it proba=
bly
> > makes more sense than exposing only zeroes. =20
>=20
> Actually, I think this is the better solution. qemu treats "not NUMA"
> and "exactly one NUMA node" differently for historical reasons, but I
> don't think that actually makes a whole lot of sense.  I think
> advertising them identically so we don't generate more special cases
> on the guest side is a better idea.
>=20

Fair enough. Thanks for the explanation.

> > > Fixes: c1df49a670ef ("spapr: Add ibm,max-associativity-domains proper=
ty") =20
> >=20
> > Since c1df49a670ef hasn't hit master yet, I guess we should squash this
> > patch (or any alternative) there to preserve bisect, ie, either David
> > does it for you or you post a v4 of your previous series. =20
>=20
> Right, I've folded these together in my tree so we don't get an
> interval of broken commits.
>=20
> >  =20
> > > Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> > > ---
> > >  hw/ppc/spapr.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 7b2bc4e..bff2125 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -914,7 +914,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spap=
r, void *fdt)
> > >          cpu_to_be32(0),
> > >          cpu_to_be32(0),
> > >          cpu_to_be32(0),
> > > -        cpu_to_be32(nb_numa_nodes - 1),
> > > +        cpu_to_be32(nb_numa_nodes ? nb_numa_nodes - 1 : 0),
> > >      };
> > > =20
> > >      _FDT(rtas =3D fdt_add_subnode(fdt, 0, "rtas")); =20
> >=20
> >  =20
>=20


--Sig_/wRot.5vtf8ipfsfKksClw.Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlrXE8oACgkQcdTV5YIv
c9a1Mg//Y5VypmnzxjSylX4ykH/W9ZNcmfX9uXoZdJud9B8uy56yF9bvQcPjXkvX
ME1YJibm5Hqdln3UsYMpLu+u+OPnMhLe4CdBOYU32t6HtE5GF1ikYX05l9ONio8S
WXOOgIg0mFmvCF9yePhdOEkUVP/DbaccPnyJyt4B0QsMhTI4NG1Ycob8Lvd5myIC
vnRLLWXqkyvnIvrr45Cy1BR1Md0sSw/t9doQAyLIiw4zfH3CyGS365WoslPby3uP
wVDhKaL7hPJDZN6uFXe97l3tPih7qY669KQMLCSGnjCSqMZN7iLYFoX5t5oLuNes
ax+9mKpp/VMKmLqLCo3ETN3ebCwKv6if15tTUtLKA2FiaRxmfpdNZewLDzcE87db
aZqyBXBmQefmy1cd0MHTmS3Ta0GblOahLP+xHs2xZW3QeoSEhvJmtHZ/AMglphFO
87Faq8fN9fT0YTiKxS60+gdXrv8wujZmy9+AawpTotVTWAywVsYVh61FUfmPEaGZ
0/FVswkUAZMnjosMkH7IMJ/SK/4xyTDfZX3o4r3nMb1ebkcEfU26958OWOFWmPMr
Hh3Mftb1gGq8u7sKDNPoI118m/OdvTa3Qus4kso05g4A1LFcvBzekEEN1f1T2VIb
gVYiNdsTljtPclVolfj96FdfVtzQwyUff4ulrgeOQNqZkRJaHm0=
=vLBl
-----END PGP SIGNATURE-----

--Sig_/wRot.5vtf8ipfsfKksClw.Z--
