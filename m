Received: from eggs.gnu.org ([2001:4830:134:3::10]:45697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxbP5-0000V6-7z
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:38:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxbP3-0005sD-U1
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:38:55 -0400
References: <20170410150542.30376-1-famz@redhat.com>
	<20170410150542.30376-10-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fcf3c15-02db-b3db-c030-a16373f59b12@redhat.com>
Date: Mon, 10 Apr 2017 10:38:40 -0500
MIME-Version: 1.0
In-Reply-To: <20170410150542.30376-10-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n8glITNt1h87jsLHo557BplD4d5suokFL"
Subject: Re: [Qemu-devel] [PATCH for 2.9 v3 09/10] block: Use
 bdrv_coroutine_enter to start I/O coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8glITNt1h87jsLHo557BplD4d5suokFL
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1fcf3c15-02db-b3db-c030-a16373f59b12@redhat.com>
Subject: Re: [PATCH for 2.9 v3 09/10] block: Use bdrv_coroutine_enter to start
 I/O coroutines
References: <20170410150542.30376-1-famz@redhat.com>
 <20170410150542.30376-10-famz@redhat.com>
In-Reply-To: <20170410150542.30376-10-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 10:05 AM, Fam Zheng wrote:
> BDRV_POLL_WHILE waits for the started I/O by releasing bs's ctx then po=
lling
> the main context, which relies on the yielded the coroutine would conti=
nue on
> bs->ctx and notify qemu_aio_context with bdrv_wakeup(). Thus, using

Reads awkwardly.  I'm guessing:

which relies on the yielded coroutine continuing on bs->ctx before
notifying qemu_aio_context with bdrv_wakeup().

> qemu_coroutine_enter to start I/O is wrong because if the coroutine is =
entered
> from main loop, co->ctx will be qemu_aio_context, as a result of the "r=
elease,
> poll, acquire" loop of BDRV_POLL_WHILE, race conditions happen when bot=
h
> main thread and the iothread access the same BDS:
>=20

>         aio_context_acquire(bs->ctx)
>=20
> Note that in above case, bdrv_drained_begin() doesn't do the "release,
> poll, acquire" in BDRV_POLL_WHILE, because bs->in_flight =3D=3D 0.
>=20
> Fix this by using bdrv_coroutine_enter and enter coroutine in the right=

> context.
>=20
> iotests 109 output is updated because the coroutine reenter flow during=

> mirror job complete is different (now through co_queue_wakeup, instead
> of the unconditional qemu_coroutine_switch before), making the end job
> len different.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> fixup

Is this leftovers during rebasing?

> ---
>  block/block-backend.c      |  4 ++--
>  block/io.c                 | 14 +++++++-------
>  tests/qemu-iotests/109.out | 10 +++++-----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>=20


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--n8glITNt1h87jsLHo557BplD4d5suokFL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY66cAAAoJEKeha0olJ0NqxY8H/2TKdUnICvN3Jpc/Pa7NHjEN
xykr+giu6O1H6JaUGcAzbIQsPitFYETWbJi3W1gd6zulSlA6m6WoD6uztN1BfeGu
AySlovsjOTFTyRmX9j92DB/NlFmXBoKYf2+lc4d6H0/LEDv5lSmbVDpoOmn6CvuO
8g/w6WwFjRz1Hoy5MMAh0hUZvA4NJDNfGwj8LR2Yh8f6Rxrq+Su50VMgaCEYK0Hw
TYA16rNG6Tv4fDC/oLE9px36dNQzXz3IcDjbG7++5S2anu33XcKnLPn2FZj6+zAk
j7+6EpOKihra+Xat+KYkQpaHKbPPkAAM3wn4Sr42rL8gkd4774TqM6Wchovbu1M=
=xo5z
-----END PGP SIGNATURE-----

--n8glITNt1h87jsLHo557BplD4d5suokFL--
