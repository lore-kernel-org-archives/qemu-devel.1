Received: from eggs.gnu.org ([2001:4830:134:3::10]:42208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eef9V-0003wq-95
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eef9R-0006kW-BC
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:53:05 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:41677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eef9R-0006k1-3f
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:53:01 -0500
Received: by mail-wm0-x241.google.com with SMTP id f71so13775956wmf.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 02:53:00 -0800 (PST)
Date: Thu, 25 Jan 2018 10:52:57 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125105257.GC27269@stefanha-x1.localdomain>
References: <CAK-iXgUO7LMZ7+Bvs66_yno_q6ZDEzgKS5baxG7SASVNChYyvw@mail.gmail.com>
	<982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <982e13e4-6591-0f4c-9faa-17e0302ad350@redhat.com>
Subject: Re: [Qemu-devel] Prevent overriding the input file with the output
 file when using qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: River Chiang <riverchiang@gmail.com>, qemu-devel@nongnu.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 08:48:15AM -0600, Eric Blake wrote:
> On 01/22/2018 10:40 PM, River Chiang wrote:
> >     Signed-off-by: River Chiang <riverchiang@gmail.com>
> >=20
> > ---------------------------------- qemu-img.c
> > ----------------------------------
> > index 68b375f998..5ce594ea00 100644
> > @@ -2098,6 +2098,9 @@ static int img_convert(int argc, char **argv)
> >      if (s.src_num < 1) {
> >          error_report("Must specify image file name");
> >          goto fail_getopt;
> > +    } else if (!strcmp(argv[optind], out_filename)) {
> > +        error_report("Override the input file with the output file");
> > +        goto fail_getopt;
>=20
> Comparing names is too prone to false negatives.  'foo' and './foo' are
> the same file, but your test won't catch it.  Better might be checking
> if stat() reports the same dev/inode pair for the two files.
>=20
> By the way, your patch is not in proper 'git send-email' format, which
> makes it hard to test whether it even applies.  More patch submission
> hints at http://wiki.qemu.org/Contribute/SubmitAPatch

stat(2) cannot be used since the "filenames" may not be a local file,
(nbd://, iscsi://, etc).

strcmp(3) is also not a full solution, for the reasons you mentioned.

Even file locking probably isn't a full solution.  What happens when
input and output files are nbd:// URIs?

Attempting to prevent the user from harming themselves is very hard to
do.  It's better not to second-guess the user than to have some magic
that doesn't always work (the user cannot rely on it anyway).

Stefan

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaabcJAAoJEJykq7OBq3PImyEH/igYuvztue34lYetO7FF+fGX
egPrvCmIdoIq5dSKdcRvz0sc25WwxYbV3RIfx8Ha5t9TfVtYCyL1uAChrzYiEhtu
qmrFDQY0rAW2skWLsojiv374rujmgnBH08LN1gKU+pnCQohjPL035DGZdnsfod4E
zy7l6kZf9/TKk3bW64uGr4jIignZzehEU1szqYtUUZIVhcVJNhHbRqWn7uI4+6J3
j8F5C1nIASKAtn/ZPcj/m1wXRA3Rnq6rD4vZ1PXXJoBF8qs68G6npt581PiLV/vT
Ixd+Pz/iUopcCb5wSXTqUmOL2LmDY7staMO1mGFXFF7uCpR1tGIxYYRIpvFyTd4=
=64m3
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
