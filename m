Received: from eggs.gnu.org ([2001:4830:134:3::10]:51195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crR8H-00063b-JM
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1crR8G-0001XC-Mp
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:28:05 -0400
Date: Fri, 24 Mar 2017 15:27:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170324152755.GR12560@stefanha-x1.localdomain>
References: <20170316212351.13797-1-jsnow@redhat.com>
	<CAJSP0QU1g9iijqMnrf27Yp5BTr_U4c--+GqYTnvnVtyud0O2Gw@mail.gmail.com>
	<bb9eafce-797e-3d94-d6da-4b519772fcaf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Content-Disposition: inline
In-Reply-To: <bb9eafce-797e-3d94-d6da-4b519772fcaf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] block: pause block
 jobs for bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:57:14PM +0100, Paolo Bonzini wrote:
>=20
>=20
> On 23/03/2017 18:44, Stefan Hajnoczi wrote:
> >> It's possible to wedge QEMU if the guest tries to reset a virtio-pci
> >> device as QEMU is also using the drive for a blockjob. This patchset
> >> aims to allow us to safely pause/resume jobs attached to individual
> >> nodes in a manner similar to how bdrv_drain_all_begin/end do.
> >=20
> > Weird, I thought the 0 nanosecond sleep that block jobs do in their
> > main loop allows aio_poll() loops to finish.
>=20
> The 0 nanosecond sleep is now done in the BDS AioContext rather than in=
=20
> the "non-aio_poll-aware" main loop:
>=20
>     commit 0b9caf9b3166c8deb3c4f3a774c2384b069dc29c
>     Author: Fam Zheng <famz@redhat.com>
>     Date:   Tue Aug 26 15:15:43 2014 +0800
>=20
>     coroutine: Drop co_sleep_ns
>    =20
>     block_job_sleep_ns is the only user. Since we are moving towards
>     AioContext aware code, it's better to use the explicit version and dr=
op
>     the old one.
>    =20
>     Signed-off-by: Fam Zheng <famz@redhat.com>
>     Reviewed-by: Beno=EEt Canet <benoit.canet@nodalink.com>
>     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

But we hold the AioContext lock and are calling aio_poll(), so I would
expect our loop to terminate.  The blockjob coroutine should still be
leaving this little gap in activity during which the aio_poll() loop
finishes.

Stefan

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY1Tr7AAoJEJykq7OBq3PIKWkH/3uc9Gs1mdNOdxNXtQ1Eq+Vo
aQaVVTjMzOKhXH/Qf4j29OWzwr4cWPZeO4bVL90ZEiVcRoSzliezz3h3aBIhJUpb
wZzBdXs1s6a8wl9BmNfs7P4JiPD9heLGzw1hp1zsq41W990qM9o7f0ajj2p9H4ly
RS4gy33sN4gW02emWNS3wfys04mB0hvh/fTQhXnppy5QoGDl0dDsUOJWvPHyWhsL
d5Wcgeaw8KUmR8hTWYKogx/8dx3B6LnNe1X2WXibQq/h4rHku7tPrJNId9y8xkUm
qY46kGaurp/3aoahgJlKKJGdl6waTwsRXzA5THNKwqPIHp7Lraj2s+39xXBpS98=
=hG/C
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--
