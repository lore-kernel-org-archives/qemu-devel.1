Received: from eggs.gnu.org ([2001:4830:134:3::10]:33704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGpI-0006IF-49
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIGpE-0004NX-Tx
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:55:24 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:38178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIGpE-0004Mi-M9
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:55:20 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3DA84103369
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:55:19 +0200 (CEST)
Date: Tue, 6 Jun 2017 17:55:09 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170606175509.3c8f4d31@bahia.ttt.fr.ibm.com>
In-Reply-To: <f6a1e425-7c2f-ed6e-46f9-6294f043b6c6@redhat.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676257896.31274.8551304687945725648.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<f6a1e425-7c2f-ed6e-46f9-6294f043b6c6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/i4lB.oA46pmBth.b8Cowb/E";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr: fix memory leak in
 spapr_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/i4lB.oA46pmBth.b8Cowb/E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jun 2017 17:43:13 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 06.06.2017 17:22, Greg Kurz wrote:
> > The string returned by object_property_get_str() is dynamically allocat=
ed.
> >=20
> > (Spotted by Coverity, CID 1375942)
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 86e622834f63..f834a6a7dfac 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2617,8 +2617,11 @@ static void spapr_memory_pre_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> >      if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> >          error_setg(errp, "Memory backend has bad page size. "
> >                     "Use 'memory-backend-file' with correct mem-path.");
> > -        return;
> > +        goto out;
> >      }
> > +
> > +out:
> > +    g_free(mem_dev);
> >  } =20
>=20
> You don't need the goto and the "out" label here.
>=20
>  Thomas

I did it on purpose, so that someone may add some code to this
function and doesn't need to care for the freeing... but of
course, we can simply:

-        return;
     }
+    g_free(mem_dev);
} =20


--Sig_/i4lB.oA46pmBth.b8Cowb/E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk20F0ACgkQAvw66wEB28Ih4wCgnYUPDngc55IBSBxIQSoYZ1t2
qrcAn0aahX6q4tqgMm6I/6l7aNv7Qn0T
=H3pV
-----END PGP SIGNATURE-----

--Sig_/i4lB.oA46pmBth.b8Cowb/E--
