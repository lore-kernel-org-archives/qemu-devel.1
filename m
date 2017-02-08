Received: from eggs.gnu.org ([2001:4830:134:3::10]:42567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbSmc-0003Pj-P9
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbSmb-0004t8-JU
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 08:59:42 -0500
References: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <08b13ba8-5e66-5fd9-3c4f-b567e87137d8@redhat.com>
Date: Wed, 8 Feb 2017 14:59:32 +0100
MIME-Version: 1.0
In-Reply-To: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k3gSgCjn5HM0w75kmJdp8x9nWq4umlK7Q"
Subject: Re: [Qemu-devel] Question about QEMU's threading model and stacking
 multiple block drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adrian Suarez <adrian@eitrsystems.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k3gSgCjn5HM0w75kmJdp8x9nWq4umlK7Q
From: Max Reitz <mreitz@redhat.com>
To: Adrian Suarez <adrian@eitrsystems.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <08b13ba8-5e66-5fd9-3c4f-b567e87137d8@redhat.com>
Subject: Re: [Qemu-devel] Question about QEMU's threading model and stacking
 multiple block drivers
References: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
In-Reply-To: <CACSixLr14Lhx_4OdVw36DjsjsgHZdk3jxxJ4pZWQ2EXK36p2hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC-ing qemu-block, Stefan, Fam.


On 08.02.2017 03:38, Adrian Suarez wrote:
> We=E2=80=99ve implemented a block driver that exposes storage to QEMU V=
Ms. Our
> block driver (O) is interposing on writes to some other type of storage=

> (B). O performs low latency replication and then asynchronously issues =
the
> write to the backing block driver, B, using bdrv_aio_writev(). Our prob=
lem
> is that the write latencies seen by the workload in the guest should be=

> those imposed by O plus the guest I/O and QEMU stack (around 25us total=

> based on our measurements), but we=E2=80=99re actually seeing much high=
er latencies
> (around 120us). We suspect that this is due to the backing block driver=
 B=E2=80=99s
> coroutines blocking our coroutines. The sequence of events is as follow=
s
> (see diagram:
> https://docs.google.com/drawings/d/12h1QbecvxzlKxSFvGKYAzvAJ18kTW6AVTwD=
R6VA8hkw/pub?w=3D576&h=3D565
> ):
>=20
> 1. Write is issued to our block driver O using the asynchronous interfa=
ce
> for QEMU block driver.
> 2. Write is replicated to a fast device asynchronously.
> 2.a. In a different thread, the fast device invokes a callback on
> completion that causes a coroutine to be scheduled to run in the QEMU
> iothread that acknowledges completion of the write to the guest OS.
> 2.b. The coroutine scheduled in (2.a) is executed.
> 3. Write is issued asynchronously to the backing block driver, B.
> 3.a. The backing block driver, B, invokes the completion function suppl=
ied
> by us, which frees any memory associated with the write (e.g. copies of=
 IO
> vectors).
>=20
> Steps (1), (2), and (3) are performed in the same coroutine (our driver=
's
> bdrv_aio_writev() implementation). (2.a) is executed in a thread that i=
s
> part of our transport library linked by O, and (2.b) and (3.a) are exec=
uted
> as coroutines in the QEMU iothread.
>=20
> We've tried improving the performance by using separate iothreads for t=
he
> two devices, but this only shaved about lowered the latency to around 1=
00us
> and caused stability issues. What's the best way to create a separate
> iothread for the backing driver to do all of its work in?

I don't think it's possible to use different AioContexts for
BlockDriverStates in the same BDS chain, at least not currently. But
others may know more about this.

Max

>=20
> -Adrian
>=20



--k3gSgCjn5HM0w75kmJdp8x9nWq4umlK7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibJEQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAIwH/1aFxEi07PxdJwHbyTzZWqNNN0Adrfyp
NONeJBBW2YlxkAicYJLK2OsukFMegWePzRa07r9IJxN3gqCu+oECOS8ay+2WHYzr
wStYWurBfbOPW8B4tTT91yAgmXPKKZ7KUU4KFq73frIjJjUMKGlBN1UQJjeXS0w9
nhNEvxDH7A4ElBchbFUkc7PQPDTTHey7mLKB01c/Ebk7nN/U1I36YWsoIwUlaqPt
OUqkYNmY8NQN+0AKkK2tpnDuPg53Lq/zGL7lI5axstEA1fqzNi16QLnlvFuCO6Dq
fe3WuCoMhHqEBQOFoNYyHUK4K1sDzA2y6KT4GJzkdCzaPTFcwd1V4Kg=
=ZkfQ
-----END PGP SIGNATURE-----

--k3gSgCjn5HM0w75kmJdp8x9nWq4umlK7Q--
