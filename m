Received: from eggs.gnu.org ([2001:4830:134:3::10]:44268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVChn-0003Ux-9z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVChj-0004lG-MH
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:45:55 -0500
Date: Fri, 7 Dec 2018 09:45:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207094538.GE13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-6-vsementsov@virtuozzo.com>
	<20181206105430.GN29540@redhat.com>
	<fa38eeb1-523f-0bbe-580c-c21a3b86ee21@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa38eeb1-523f-0bbe-580c-c21a3b86ee21@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

On Thu, Dec 06, 2018 at 05:42:54PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> 06.12.2018 13:54, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Dec 05, 2018 at 05:47:00PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> >> The two thing that should be handled are cipher and ivgen. For ivgen
> >> the solution is just mutex, as iv calculations should not be long in
> >> comparison with encryption/decryption. And for cipher let's just kee=
p
> >> per-thread ciphers.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
> >> ---
>=20
> [..]
>=20
> >> --- a/crypto/block.c
> >> +++ b/crypto/block.c
>=20
> [..]
>=20
> >>   static int do_qcrypto_cipher_encrypt(QCryptoCipher *cipher,
> >>                                        size_t niv,
> >>                                        QCryptoIVGen *ivgen,
> >> +                                     QemuMutex *ivgen_mutex,
> >>                                        int sectorsize,
> >>                                        uint64_t offset,
> >>                                        uint8_t *buf,
> >> @@ -218,10 +307,15 @@ static int do_qcrypto_cipher_encrypt(QCryptoCi=
pher *cipher,
> >>       while (len > 0) {
> >>           size_t nbytes;
> >>           if (niv) {
> >> -            if (qcrypto_ivgen_calculate(ivgen,
> >> -                                        startsector,
> >> -                                        iv, niv,
> >> -                                        errp) < 0) {
> >> +            if (ivgen_mutex) {
> >> +                qemu_mutex_lock(ivgen_mutex);
> >> +            }
> >> +            ret =3D qcrypto_ivgen_calculate(ivgen, startsector, iv,=
 niv, errp);
> >> +            if (ivgen_mutex) {
> >> +                qemu_mutex_unlock(ivgen_mutex);
> >> +            }
> >=20
> > I think we should just make  ivgen_mutex compulsory....
> >=20
> >> +
> >> +            if (ret < 0) {
> >>                   goto cleanup;
> >>               }
> >>  =20
> >> @@ -258,8 +352,9 @@ int qcrypto_cipher_decrypt_helper(QCryptoCipher =
*cipher,
> >>                                     size_t len,
> >>                                     Error **errp)
> >>   {
> >> -    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize=
, offset,
> >> -                                     buf, len, qcrypto_cipher_decry=
pt, errp);
> >> +    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sect=
orsize,
> >> +                                     offset, buf, len, qcrypto_ciph=
er_decrypt,
> >> +                                     errp);
> >>   }
> >>  =20
> >>  =20
> >> @@ -272,11 +367,11 @@ int qcrypto_cipher_encrypt_helper(QCryptoCiphe=
r *cipher,
> >>                                     size_t len,
> >>                                     Error **errp)
> >>   {
> >> -    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize=
, offset,
> >> -                                     buf, len, qcrypto_cipher_encry=
pt, errp);
> >> +    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sect=
orsize,
> >> +                                     offset, buf, len, qcrypto_ciph=
er_encrypt,
> >> +                                     errp);
> >>   }
> >=20
> > ...and get the mutex passed into these functions, as its easier to ju=
st
> > know the ivgen is always protected, and not have to trace back the ca=
llpath
> > to see if the usage is safe.
>=20
> but there places, where these helpers called without any QCryptoBlock, =
when we just
> have local cipher and ivgen, so there is no mutex and it's not needed.

Ah, ok.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
