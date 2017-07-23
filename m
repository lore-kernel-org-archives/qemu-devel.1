Received: from eggs.gnu.org ([2001:4830:134:3::10]:38282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZHzg-0006wq-Vu
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZHzf-000359-N7
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:36:29 -0400
References: <20170711170821.24669-1-ppandit@redhat.com>
	<29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
	<20170721154712.GM18014@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
Date: Sun, 23 Jul 2017 16:36:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170721154712.GM18014@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GAWRpBtTPig73Au29vX32ESsnsPUdIwWV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GAWRpBtTPig73Au29vX32ESsnsPUdIwWV
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Kieron Shorrock <kshorrock@paloaltonetworks.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
Subject: Re: [Qemu-block] [PATCH] block: check BlockDriverState object before
 dereference
References: <20170711170821.24669-1-ppandit@redhat.com>
 <29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
 <20170721154712.GM18014@stefanha-x1.localdomain>
In-Reply-To: <20170721154712.GM18014@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 21/07/2017 17:47, Stefan Hajnoczi wrote:
> Hmm...BlockDriverState still has bdrv_is_inserted() even though
> BlockBackend->root can be NULL?  CCing Markus in case he has thoughts o=
n
> the BB/BDS split.
>=20
> I find it weird that block-backend.c calls bdrv_inc_in_flight() and the=
n
> bdrv_co_flush() will call it again.  Perhaps we need to do this so that=

> blk_drain() works correctly but it's odd that they share the same
> counter variable.

See here:
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02305.html

> I need to count requests at the BB level because the blk_aio_*
> operations have a separate bottom half that is invoked if either 1) the=
y
> never reach BDS (because of an error); or 2) the bdrv_co_* call
> completes without yielding.  The count must be >0 when blk_aio_*
> returns, or bdrv_drain (and thus blk_drain) won't loop.  Because
> bdrv_drain and blk_drain are conflated, the counter must be the BDS one=
=2E
>=20
> In turn, the BDS counter is needed because of the lack of isolated
> sections.  The right design would be for blk_isolate_begin to call
> blk_drain on *other* BlockBackends reachable in a child-to-parent visit=
=2E
>  Instead, until that is implemented, we have bdrv_drained_begin that
> emulates that through the same-named callback, followed by a
> parent-to-child bdrv_drain that is almost always unnecessary.

The full explanation of the long-term plans and what "isolated section"
means is at
https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02016.html.
(Unfortunately, since then we've reintroduced the "double aio_poll" hack
in BDRV_POLL_WHILE...).

Paolo


--GAWRpBtTPig73Au29vX32ESsnsPUdIwWV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAll0tFoACgkQv/vSX3jH
roO7Twf/eoome8wKw3qYaZlkmvFuUko8Fj9QoIrIWQ9NGkpPdnVgoWLj+iFQ8Zdz
kCZV/bukpyCbVX9G/b9Y+g+gDMKr3LzzdZRq7UqZFAX0Cl6O1Pn4Lre48isohU/o
ZjcfM7dNWS5FET/GzimubJfA/L8CdhPrxkB0ttXbOqaEQzX6/+/2JbERqypXyZ4n
ce+g58xmkxotwWkzqtbe2nx/KnmDepphr9gDTj52VP+nevai+vNjw0intJOPi9IC
1Pe1XFOxHrbmj8/alZIPeX4B7gf7DX/VdJti9QKopeCqRYfag64M8x4QZFTEmSnL
ULDreVCddUuugOdkBYXfmoaVbVw55w==
=FveY
-----END PGP SIGNATURE-----

--GAWRpBtTPig73Au29vX32ESsnsPUdIwWV--
