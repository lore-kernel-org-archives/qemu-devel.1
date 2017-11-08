Received: from eggs.gnu.org ([2001:4830:134:3::10]:41137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCVuy-0008Ej-De
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:21:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eCVux-0001cd-IJ
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:21:44 -0500
Date: Wed, 8 Nov 2017 19:21:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171108192129.GA9400@stefanha-x1.localdomain>
References: <20171108063447.2842-1-slp@redhat.com>
	<f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
	<CAAiTLFV80SfMneuhs7tdYENOb+zV7kJ43B9ZgALk2tva1ZDpUw@mail.gmail.com>
	<5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
	<CAAiTLFXHC5LS7NdmL6oO+QfiLh1fj+k8_74OnH6TFwzDx5EAgw@mail.gmail.com>
	<baa6250c-cb3f-76cd-2562-f7e89f418be5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <baa6250c-cb3f-76cd-2562-f7e89f418be5@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v3] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 05:32:23PM +0300, Pavel Butsykin wrote:
> On 08.11.2017 17:24, Sergio Lopez wrote:
> > On Wed, Nov 8, 2017 at 3:15 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> > > On 08/11/2017 15:10, Sergio Lopez wrote:
> > > > > I'm not quite sure that the pre-fetched is involved in this issue,
> > > > > because pre-fetch reading a certain addresses should be invalidat=
ed by
> > > > > write on another core to the same addresses. In our case write
> > > > > req->state =3D THREAD_DONE should invalidate read req->state =3D=
=3D THREAD_DONE.
> > > > > I am inclined to think that there is a memory-reordering read with
> > > > > write. It's a very real case for x86 and I don't see the reasons =
which
> > > > > can prevent it:
> > > > >=20
> > > > Yes, you're right. This is actually a memory reordering issue. I'm
> > > > going to rewrite that paragraph.
> > >=20
> > > Well, memory reordering _is_ caused by speculative prefetching, delay=
ed
> > > cache invalidation (store buffers), and so on.
> > >=20
> > > But it's probably better indeed to replace "pre-fetched" with
> > > "outdated".  Whoever commits the patch can do the substitution (I can=
 too).
> > >=20
> >=20
> > Alternatively, if we want to explicitly mention the memory barrier, we
> > can replace the third paragraph with something like this:
> >=20
> > <snip>
> > This was considered to be safe, as the completion function restarts the
> > loop just after the call to qemu_bh_cancel. But, as this loop lacks a HW
> > memory barrier, the read of req->state may actually happen _before_ the
> > call, seeing it still as THREAD_QUEUED, and ending the completion
> > function without having processed a pending TPE linked at pool->head:
> > </snip>
>=20
> Yes, that's better. Thank you.

I have updated the commit description and sent an updated pull request
for QEMU 2.11-rc1.

Stefan

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaA1k5AAoJEJykq7OBq3PIzUYH/3SEjWhLxUt5pPZJqBDaOaj6
9r8D/pzFlJX/Cqzl5+Hf41zeyOzjk0oYJ7HgnEa2DyQkqGQKKpKE7aqqRfBfDC78
BhQ7bc8Ll8e6VNcj4TONWBHcEIcmmQ82+r/UuqCk7bz5/J+aWZUEAJJZGRYW7F3V
pc2w20SzWaUbgAtHVBtmiphHZ0JEQd4hwhaWB80ssX2hsArfaYGYgUD2Xy/FMCtq
XEZQNRPvUsodlqcjKV62hap9UwZ6Y4S+iz4RdTVlA0h6thSacFccDOQl5locOxm4
wCl/5MBynK52DxKWR9H7goFlidKAzMib2p8mGdZiTjNPPUC6mh2X5R0KC+QG6B8=
=CojW
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
