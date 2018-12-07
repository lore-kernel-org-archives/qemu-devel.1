Received: from eggs.gnu.org ([2001:4830:134:3::10]:44086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVChN-0003C7-IW
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVChM-0004TA-28
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:45:29 -0500
Date: Fri, 7 Dec 2018 09:45:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207094513.GD13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-3-vsementsov@virtuozzo.com>
	<20181206103603.GK29540@redhat.com>
	<5dc82f08-5651-1000-007d-c2bbecf61ade@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dc82f08-5651-1000-007d-c2bbecf61ade@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] crypto/block: refactor
 qcrypto_block_*crypt_helper functions
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

On Thu, Dec 06, 2018 at 05:36:29PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> 06.12.2018 13:36, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Dec 05, 2018 at 05:46:57PM +0300, Vladimir Sementsov-Ogievski=
y wrote:
> >> qcrypto_block_encrypt_helper and qcrypto_block_decrypt_helper are
> >> almost identical, let's reduce code duplication and simplify further
> >> improvements.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
> >> ---
> >>   crypto/block.c | 81 +++++++++++++++++++---------------------------=
----
> >>   1 file changed, 31 insertions(+), 50 deletions(-)
> >>
> >> diff --git a/crypto/block.c b/crypto/block.c
> >> index e59d1140fe..f4101f0841 100644
> >> --- a/crypto/block.c
> >> +++ b/crypto/block.c
> >> @@ -190,14 +190,21 @@ void qcrypto_block_free(QCryptoBlock *block)
> >>   }
> >>  =20
> >>  =20
> >> -int qcrypto_block_decrypt_helper(QCryptoCipher *cipher,
> >> -                                 size_t niv,
> >> -                                 QCryptoIVGen *ivgen,
> >> -                                 int sectorsize,
> >> -                                 uint64_t offset,
> >> -                                 uint8_t *buf,
> >> -                                 size_t len,
> >> -                                 Error **errp)
> >> +typedef int (*QCryptoCipherEncryptFunc)(QCryptoCipher *cipher,
> >> +                                        const void *in,
> >> +                                        void *out,
> >> +                                        size_t len,
> >> +                                        Error **errp);
> >> +
> >> +static int do_qcrypto_block_encrypt(QCryptoCipher *cipher,
> >=20
> > Can we call this functuon 'encdec', since it is misleading to call
> > it just 'encrypt' when its used for decrypt too.
>=20
> Maybe just _crypt ?)

Sure thats fine

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
