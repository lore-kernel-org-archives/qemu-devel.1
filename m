Received: from eggs.gnu.org ([209.51.188.92]:33443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtodJ-0003Sd-7L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtoXm-00035f-Rr
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:01:19 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gtoXm-00034I-A4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 02:01:18 -0500
Received: by mail-pl1-x643.google.com with SMTP id o6so722748pls.13
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 23:01:18 -0800 (PST)
Date: Wed, 13 Feb 2019 15:01:12 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190213070112.GB26332@stefanha-x1.localdomain>
References: <20190212025241.5330-1-stefanha@redhat.com>
	<20190212154446.17b7febd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20190212154446.17b7febd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hostmem-file: reject invalid pmem file
 sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefan Weil <sw@weilnetz.de>, Zhang Yi <yi.z.zhang@linux.intel.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 03:44:46PM +0100, Igor Mammedov wrote:
> > diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> > index ba601ce940..325ab4aad9 100644
> > --- a/backends/hostmem-file.c
> > +++ b/backends/hostmem-file.c
> > @@ -46,6 +46,22 @@ file_backend_memory_alloc(HostMemoryBackend *backend=
, Error **errp)
> >      gchar *name;
> >  #endif
> > =20
> > +    /*
> > +     * Verify pmem file size since starting a guest with an incorrect =
size
> > +     * leads to confusing failures inside the guest.
> > +     */
> > +    if (fb->is_pmem && fb->mem_path) {
> > +        uint64_t size;
> > +
> > +        size =3D qemu_get_pmem_size(fb->mem_path, NULL);
>                                                    ^^^^
> Did you ignore error intentionally?

Hmm...I think I can now propagate the error.  Originally the function
only handled devdax chardevs so it would fail for a regular file on a
DAX file system and that shouldn't stop QEMU startup.  But now that it
supports regular files too I can't think of inputs that lead to a false
positive.

Will fix in v2.

Stefan

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY8C4AAoJEJykq7OBq3PI+XoIALomTPtMZko22iaEMKO4iV4z
orls2isiayBXKZxBvCtGByt9mU3Y8Om+Z46+rOEp1ty+QH1hl/YUpHRmZ7ZD/Dvv
RznPRsPxHkbi9Ve+9dwaPDIc3ZxcEBCzIubpHvS0UBri2BwycxuPbREplFREh56g
4xFpDZ4vUN/5J4uooAJwO+QtoqqkcHUme53DICD+bMgmnep+wpwXeZSv9MWmeaN+
xbDSxw+m7mzu73jj7Xa9i0MOR/mPoAd2OCZ+KApGeZtTY1ZVVJgS6rf6Vay473CK
0IHqEp5uRKlKjUbCFJ1tldz+w3aghqppIRaO6Al2h008kQobdub/FhjG4smdurI=
=vSrc
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
