Received: from eggs.gnu.org ([209.51.188.92]:37859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glazh-000452-LT
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1glar3-0002Ls-8F
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:47:15 -0500
Date: Mon, 21 Jan 2019 14:46:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190121144659.GB10347@stefanha-x1.localdomain>
References: <20190115111007.27159-1-stefanha@redhat.com>
	<20190115111007.27159-2-stefanha@redhat.com>
	<7c29009e-2332-0901-3e00-8aa4c6b28796@redhat.com>
	<5786786a-1389-81a3-2c9a-fbeca0be10a9@redhat.com>
	<20190121134544.GC3683@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20190121134544.GC3683@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: include LUKS payload overhead
 in qemu-img measure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 21, 2019 at 01:45:44PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Jan 21, 2019 at 02:15:03PM +0100, Max Reitz wrote:
> > On 21.01.19 14:08, Max Reitz wrote:
> > > On 15.01.19 12:10, Stefan Hajnoczi wrote:
> > >> LUKS encryption reserves clusters for its own payload data.  The siz=
e of
> > >> this area must be included in the qemu-img measure calculation so th=
at
> > >> we arrive at the correct minimum required image size.
> > >>
> > >> (Ab)use the qcrypto_block_create() API to determine the payload
> > >> overhead.  We discard the payload data that qcrypto thinks will be
> > >> written to the image.
> > >>
> > >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >> ---
> > >>  block/qcow2.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++=
++-
> > >>  1 file changed, 50 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/block/qcow2.c b/block/qcow2.c
> > >> index 4897abae5e..7ab93a5d2f 100644
> > >> --- a/block/qcow2.c
> > >> +++ b/block/qcow2.c
> > >=20
> > > [...]
> > >=20
> > >> @@ -4274,6 +4294,35 @@ static BlockMeasureInfo *qcow2_measure(QemuOp=
ts *opts, BlockDriverState *in_bs,
> > >>      has_backing_file =3D !!optstr;
> > >>      g_free(optstr);
> > >> =20
> > >> +    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
> > >> +    has_luks =3D optstr && strcmp(optstr, "luks") =3D=3D 0;
> > >> +    g_free(optstr);
> > >> +
> > >> +    if (has_luks) {
> > >> +        QCryptoBlockCreateOptions cryptoopts =3D {
> > >> +            .format =3D Q_CRYPTO_BLOCK_FORMAT_LUKS,
> > >> +        };
> > >> +        QCryptoBlock *crypto;
> > >> +        size_t headerlen;
> > >> +
> > >> +        optstr =3D qemu_opt_get_del(opts, "encrypt.key-secret");
> > >> +        cryptoopts.u.luks.has_key_secret =3D !!optstr;
> > >> +        cryptoopts.u.luks.key_secret =3D optstr;
> > >=20
> > > I wonder if you couldn't just make some secret up here (if the user
> > > doesn't specify anything).  Its content shouldn't matter, right?
> >=20
> > And now I wonder whether other options may not have actual influence on
> > the crypto header size.  I suppose in theory the cipher algorithm may
> > cause a difference, although it's probably not enough to warrant another
> > cluster...
>=20
> The LUKS header comprises three parts
>=20
>  - A field size initial header with general config properties
>  - A series of fixed size key slot headers, one per slot, fixed
>    at 8 slots in the code
>  - A series of regions of key material, one per slot.
>=20
> The last one is a problem - the size of the key slot regions is
> the number of anti-forensic stripes (4096) multipled by the size
> of the master key. The latter depends on the size of the cipher
> key. This is referred to as "splitkeylen" in the code creating
> this. The overall space reserved for headers is then determined
> by:
>=20
>     luks->header.payload_offset =3D
>         (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
>          QCRYPTO_BLOCK_LUKS_SECTOR_SIZE) +
>         (ROUND_UP(DIV_ROUND_UP(splitkeylen, QCRYPTO_BLOCK_LUKS_SECTOR_SIZ=
E),
>                   (QCRYPTO_BLOCK_LUKS_KEY_SLOT_OFFSET /
>                    QCRYPTO_BLOCK_LUKS_SECTOR_SIZE)) *
>          QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS);
>=20
> So for AES-128  key materials takes 0.5 MB, while for AES-256 key material
> takes 1 MB, so adding together you get 1052672 byte for header in AES-128
> and 2068480 bytes for AES-256, rounded up to qcow2 cluster size (whatever
> that is configured to be)

Thanks.  I think qemu-img measure needs to take all of
QCryptoBlockCreateOptions and pass them in to qcrypto_block_create().
That way the result is accurate (although specific to the options that
were provided).

The current patch constructs a dummy QCryptoBlockCreateOptions instead
of populating it with options from the command-line.  I'll try to fix
this in v2.

Stefan

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcRdtjAAoJEJykq7OBq3PIWpQH/1Xat4AcTJ8M5drM/fDRvXen
XeZBS3Q4G4qdV5Rg+ByH/R7ZbqZDh9NKfZIc41uQKjUGHsfDUi7EssvLShlRIbub
mIKz30M5E1f0XyBAxvaT5VTxk6XG2iWA2wbl2++Da8kIj7FsgxqPQZ+HbuWP7YsK
WzBtMq/uko+IYXxvqef2f26R+kNQOcPUfDi7N5Fl9Q+mC1z9Sy2lF2zNleODI+2M
DHJayNiWqR77BaFEsSLDPpPwHc6/JCHkogw7szO+K1goErJXh4wpfIrhovQkUbuj
ktq5g3kUr3a9yqfjorQU+AO6Xz7Gi51fkPRdWA47hQgxvjqv2mfdNe2zp6QNbgU=
=ZMwm
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
