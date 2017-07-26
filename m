Received: from eggs.gnu.org ([2001:4830:134:3::10]:53556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1daQDy-0007Kx-I3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1daQDt-0005sB-PI
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:35:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1daQDt-0005q6-JT
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:35:49 -0400
Received: by mail-wm0-x241.google.com with SMTP id q189so9586887wmd.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 10:35:46 -0700 (PDT)
Date: Wed, 26 Jul 2017 18:35:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170726173543.GC3600@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
	<20170725133708.GE23343@stefanha-x1.localdomain>
	<fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
Content-Disposition: inline
In-Reply-To: <fe45a297-3f65-e212-90fc-33dd6d48a2f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com


--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 11:30:16AM -0400, Cleber Rosa wrote:
> On 07/25/2017 09:37 AM, Stefan Hajnoczi wrote:
> > On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
> >> Signed-off-by: Amador Pahim <apahim@redhat.com>
> >> Reviewed-by: Fam Zheng <famz@redhat.com>
> >> ---
> >>  scripts/qemu.py               | 10 +++++-----
> >>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
> >>  2 files changed, 14 insertions(+), 14 deletions(-)
> >=20
> > Please don't do this, it encourages code duplication.  Now arbitrary
> > users can start accessing the public field directly instead of adding a
> > reusable interfaces like add_monitor_telnet(), add_fd(), etc.
> >=20
>=20
> Judging from tests/qemu-iotests/iotests.py:VM and your comment above, I
> assume you see value in simple wrappers such as:
>=20
>    def add_device(self, opts):
>         self._args.append('-device')
>         self._args.append(opts)
>         return self
>=20
> I honestly do not see any value here.  I do see value in other wrappers,
> such as add_drive(), in which default values are there for convenience,
> and a drive count is kept.  In the end, my point is that the there are
> cases when a wrapper is just an annoyance and provides nothing more than
>  the illusion of a better design.

I don't see much value in simple wrappers either besides method chaining
(more on that below).

Getting back to this patch, I can only review patches in the context of
the current code base.  I don't know future plans you may have.  The
change may make sense together with other new changes that use a public
args field in a useful way - it just doesn't make sense the way it has
been presented in isolation.

About method chaining, the current code seems to be written with method
chaining in mind:

https://en.wikipedia.org/wiki/Method_chaining#Python

If all arguments are methods then everything can be chained:

  (vm.add_fd(fd.fileno(), 1, 'image0')
     .add_drive('fd:image0', interface=3D'none')
     .add_device('virtio-blk-pci,drive=3Ddrive0'))

So I guess there is a small value in having add_device().  That said,
tests don't take advantage of method chaining much.

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeNLvAAoJEJykq7OBq3PI6SwIALE1i9cl3cZD9NAjNEdCuEyN
rzNAr5xPRnSn7b4oLIKawmdCxzpc0oDVGCjuVL5E5hF4U0FQJPWQQzckQVt0WyXe
CvU/Y3aCQPo6RmU2h4cknGGk2iPQAdTNJu2JNPrh+OZkMrabXoMUnL9HubDJWEML
vVt6Y/FY/yxlASy0OdcfktnRnTz9YDc1r3ieQ0W+7r3spQwKovVgaZCbA4b8GacR
24RJJGtV2O00uL1gxGrxkhjwW5XUnp+600Y8I6i6ujWLkOXkX3b4kkINA3EdA/JF
Cu6IVPFidC5tDVohoUvzPbqICtlGFMF11T7BuDLg9e1nq6B3+AwkvQNIsPaXmVM=
=z0xK
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--
