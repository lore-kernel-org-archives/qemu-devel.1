Received: from eggs.gnu.org ([2001:4830:134:3::10]:50392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er5CD-00039K-Pa
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er5CC-0000F5-RF
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:07:13 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180122220806.22154-1-mreitz@redhat.com>
	<20180122220806.22154-6-mreitz@redhat.com>
	<20180227074413.GB21035@lemon.usersys.redhat.com>
	<2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
Message-ID: <9ce789eb-89b9-4a16-087e-977673d2c717@redhat.com>
Date: Wed, 28 Feb 2018 18:07:03 +0100
MIME-Version: 1.0
In-Reply-To: <2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P3Ihea5aVFIcriWKkluKlHZnDcaYYA388"
Subject: Re: [Qemu-devel] [PATCH v2 05/16] block/mirror: Convert to
 coroutines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P3Ihea5aVFIcriWKkluKlHZnDcaYYA388
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <9ce789eb-89b9-4a16-087e-977673d2c717@redhat.com>
Subject: Re: [PATCH v2 05/16] block/mirror: Convert to coroutines
References: <20180122220806.22154-1-mreitz@redhat.com>
 <20180122220806.22154-6-mreitz@redhat.com>
 <20180227074413.GB21035@lemon.usersys.redhat.com>
 <2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
In-Reply-To: <2c81d46d-434d-d9bb-86b4-9a644bf0284a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-28 15:13, Max Reitz wrote:
> On 2018-02-27 08:44, Fam Zheng wrote:
>> On Mon, 01/22 23:07, Max Reitz wrote:
>>> @@ -101,7 +105,7 @@ static BlockErrorAction mirror_error_action(Mirro=
rBlockJob *s, bool read,
>>>      }
>>>  }
>>> =20
>>> -static void mirror_iteration_done(MirrorOp *op, int ret)
>>> +static void coroutine_fn mirror_iteration_done(MirrorOp *op, int ret=
)
>>>  {
>>>      MirrorBlockJob *s =3D op->s;
>>>      struct iovec *iov;
>>
>> I think we want s/qemu_coroutine_enter/aio_co_wake/ in mirror_iteratio=
n_done().
>> As an AIO callback before, this didn't matter, but now we are in an te=
rminating
>> coroutine, so it is pointless to defer the termination, or even risky =
in that we
>> are in a aio_context_acquire/release section, but have already decreme=
nted
>> s->in_flight, which is fishy.
>=20
> I guess I'll still do the replacement, regardless of whether the next
> patch overwrites it again...

Maybe I don't.  Doing this breaks iotest 041 because the
assert(data.done) in bdrv_co_yield_to_drain() fails.

Not sure why that is, but under the circumstance I guess it's best to
just pretend this never happened, continue to use qemu_coroutine_enter()
and just replace it in the next patch.

As for in_flight: What is the issue there?  We mostly need that to know
how many I/O requests are actually running, that is, how much buffer
space is used, how many I/O is done concurrently, etc. (and later we
need the in-flight information so that we don't access the target in
overlapping areas concurrently).  But it doesn't seem to be about how
many coroutines there are.

So as long as the s->in_flight decrement is done in the same critical
section as the op is deleted, we should be good...?

Max


--P3Ihea5aVFIcriWKkluKlHZnDcaYYA388
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqW4bcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKA8H/3jHMJUW+EGqhQczRXngid4jpaytJXLC
K7DR+vmhRokcWFf003wuWcQLDBOfjwwTvGBR1warpA2cmlgjrWQv5Z8wdoQw45rh
gGMPJtUAKMZFCvkaQp5dqCeZ+nl67ixOhW+W+wqz6Km856mcxfiWodyo0rE5ydzz
qbyjBNVHXVnSz9OhsWNfVMp3AJHEmBMRwZGDe1StVc5Sm6Z5PxeyWm+0UOe1OjHV
P5ev/Weh09mc1ENZ5UBIPp6LlvBIpTrt2bcWUljxoZLOqvAdsMSy/opWQUD2a8mj
lIcGAuD8AXuzqaVk58eRiuES74b8zC4cHuJbuBBJVoapqZznvaD3nSc=
=Jq3r
-----END PGP SIGNATURE-----

--P3Ihea5aVFIcriWKkluKlHZnDcaYYA388--
