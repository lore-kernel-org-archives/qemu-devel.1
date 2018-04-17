Received: from eggs.gnu.org ([2001:4830:134:3::10]:57252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Wia-0002tX-2Z
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8WiZ-0007kN-0N
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 15:56:44 -0400
References: <20180413192605.2145-1-nirsof@gmail.com>
	<20180413192605.2145-4-nirsof@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d66868b2-591b-28ce-d7dd-e8af3f8fc6cd@redhat.com>
Date: Tue, 17 Apr 2018 14:56:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180413192605.2145-4-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BYsvdBuJJmRcntxjCKilBiX0pJIBQ4Vfv"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test new qemu-nbd
 --nolist option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com, rjones@redhat.com, qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BYsvdBuJJmRcntxjCKilBiX0pJIBQ4Vfv
From: Eric Blake <eblake@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d66868b2-591b-28ce-d7dd-e8af3f8fc6cd@redhat.com>
Subject: Re: [PATCH 3/3] qemu-iotests: Test new qemu-nbd --nolist option
References: <20180413192605.2145-1-nirsof@gmail.com>
 <20180413192605.2145-4-nirsof@gmail.com>
In-Reply-To: <20180413192605.2145-4-nirsof@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2018 02:26 PM, Nir Soffer wrote:
> Add new test module for tesing the --nolist option.
>=20
> Signed-off-by: Nir Soffer <nirsof@gmail.com>
> ---

> +iotests.log('Check that listing exports is allowed by default')
> +disk, nbd_sock =3D iotests.file_path('disk1', 'nbd-sock1')
> +iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
> +iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'export',=
 disk)
> +out =3D iotests.run('nbd-client', '-l', '--unix', nbd_sock)

Should we really be relying on the third-party nbd-client to be
installed?  Would it not be better to teach our own NBD client to learn
how to do interesting things over NBD?  Your use case of listing the
output of NBD_OPT_LIST is one, but another that readily comes to mind is
listing the possibilities of NBD_OPT_LIST_META_CONTEXT that just went
into 2.12.  Maybe making 'qemu-img info' give more details when
connecting to an NBD server, compared to what is normally needed just
for connecting to an export on that server?

Additionally, once we merge in Vladimir's work to expose persistent
dirty bitmaps via NBD_OPT_SET_META_CONTEXT/NBD_CMD_BLOCK_STATUS, it
would be nice to have an in-tree tool for reading out the context
information of an NBD export, perhaps extending what 'qemu-img map' can
already do (Vladimir already mentioned that he only implemented the
server side, and left the client side for an out-of-tree solution [1],
although I'm wondering if that is still the wisest course of action).

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05701.html

> +
> +assert 'export' in out.splitlines(), 'Export not in %r' % out
> +
> +iotests.log('Check that listing exports is forbidden with --nolist')
> +disk, nbd_sock =3D iotests.file_path('disk2', 'nbd-sock2')
> +iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1m')
> +iotests.qemu_nbd('-k', nbd_sock, '-f', iotests.imgfmt, '-x', 'secret',=

> +                 '--nolist', disk)
> +
> +# nbd-client fails when listing is not allowed, but lets not depend on=
 3rd

s/lets/let's/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BYsvdBuJJmRcntxjCKilBiX0pJIBQ4Vfv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWUWsACgkQp6FrSiUn
Q2oYPAf+Oyg2PKHTcLr7gMLP13WjKnwSFrM0ovZGtsYfbPQQc/Lpnj7eIWENkfXJ
Pw0OstQSpoDUoZe121w09jBxsmYmvImTtZqKdoGG6gNdvUE34y5pm9AkeNLLunSj
UhYRsDl2BtVre9YgwfPDetBos2207RdwB+ExG/8uCco+1oBzIVR387pQfY49c/tJ
cEIXC4Q9Unb1FzB0qzFSlXZ9rMxBJpE10fC0DYWaAn9r81Mw1rihV1Xoc0vyE/qX
vZI3wYxfAJSADWWAptOOOzi+PA2PeuQ3CQSp7HGfSgdQIqZP1b5CiUPwaLfVAL2M
nd9OrixGH/+5cKAI8CP+CW4BVPJG3A==
=Wf24
-----END PGP SIGNATURE-----

--BYsvdBuJJmRcntxjCKilBiX0pJIBQ4Vfv--
