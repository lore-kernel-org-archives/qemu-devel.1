Received: from eggs.gnu.org ([2001:4830:134:3::10]:57520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGbh-0007no-SH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGbd-0006RS-TU
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:41:21 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:58718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGbd-0006R6-NB
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:41:17 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id D8102103AB2
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:41:14 +0200 (CEST)
Date: Tue, 6 Jun 2017 17:41:07 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170606174107.692e1e67@bahia.ttt.fr.ibm.com>
In-Reply-To: <CAFEAcA9zBLPbkQECRaU0qM4-dKio31EqbkQQzK47rturNqcZpQ@mail.gmail.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676257351.31274.10816877292939465521.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAFEAcA9zBLPbkQECRaU0qM4-dKio31EqbkQQzK47rturNqcZpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/AQIFkAgs0N/=KSrV2_ZjICC";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/AQIFkAgs0N/=KSrV2_ZjICC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jun 2017 16:28:26 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 6 June 2017 at 16:22, Greg Kurz <groug@kaod.org> wrote:
> > The string returned by object_property_get_str() is dynamically allocat=
ed.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  target/ppc/kvm.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 88817620766c..f2f7c531bc7b 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -486,6 +486,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char =
*obj_path)
> >
> >      if (mempath) {
> >          pagesize =3D qemu_mempath_getpagesize(mempath);
> > +        g_free(mempath);
> >      } else {
> >          pagesize =3D getpagesize();
> >      } =20
>=20
> Huh, I wasn't expecting this function to free its argument.

Hmm... mempath isn't an argument, it is computed locally:

bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
{
    Object *mem_obj =3D object_resolve_path(obj_path, NULL);
    char *mempath =3D object_property_get_str(mem_obj, "mem-path", NULL);
    long pagesize;

    if (mempath) {
        pagesize =3D qemu_mempath_getpagesize(mempath);
        g_free(mempath);
    } else {
        pagesize =3D getpagesize();
    }

    return pagesize >=3D max_cpu_page_size;
}

> If we take that API then don't we also need to change the
> two other implementations of it in the tree? Having the
> single caller do the g_free() seems simpler...
>=20
> thanks
> -- PMM


--Sig_/AQIFkAgs0N/=KSrV2_ZjICC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk2zRMACgkQAvw66wEB28IBHQCgnhYzj5qh3xteHTl5jUK+YsOA
mkIAnizGjLJ8aw0G1bLCwtydltSioXOr
=yq/l
-----END PGP SIGNATURE-----

--Sig_/AQIFkAgs0N/=KSrV2_ZjICC--
