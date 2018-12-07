Received: from eggs.gnu.org ([2001:4830:134:3::10]:44202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVHNp-000315-7Q
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gVHNl-0008TL-Vf
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 09:45:37 -0500
Date: Fri, 7 Dec 2018 14:45:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181207144523.GL13784@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
	<20181205144700.26563-6-vsementsov@virtuozzo.com>
	<20181206105430.GN29540@redhat.com>
	<4017b0bb-8ac7-d15c-3a02-436eead73971@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4017b0bb-8ac7-d15c-3a02-436eead73971@virtuozzo.com>
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

On Fri, Dec 07, 2018 at 02:44:12PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> 06.12.2018 13:54, Daniel P. Berrang=C3=A9 wrote:
> >> @@ -31,8 +32,12 @@ struct QCryptoBlock {
> >>       const QCryptoBlockDriver *driver;
> >>       void *opaque;
> >>  =20
> >> -    QCryptoCipher *cipher;
> >> +    QCryptoCipher **ciphers;
> >> +    int n_ciphers;
> >> +    int n_free_ciphers;
> > size_t for both of these since they're effectively array indexes.
> >=20
> >>       QCryptoIVGen *ivgen;
> >> +    QemuMutex mutex;
> >> +
> >>       QCryptoHashAlgorithm kdfhash;
> >>       size_t niv;
> >>       uint64_t payload_offset; /* In bytes */
> >> @@ -46,6 +51,7 @@ struct QCryptoBlockDriver {
> >>                   QCryptoBlockReadFunc readfunc,
> >>                   void *opaque,
> >>                   unsigned int flags,
> >> +                int n_threads,
> > unsigned int, and more below which I won't repeat...
> >=20
>=20
> Why not size_t here, then? this parameter directly maps into n_ciphers

Yes, I'm fine with size_t too

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
