Received: from eggs.gnu.org ([2001:4830:134:3::10]:43893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1Y9r-0006oV-Gn
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1Y9h-0002WH-MQ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 10:04:03 -0400
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
	<fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
	<4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
	<b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
	<2520cd8d-990b-e7b9-c7b6-0b345e414ce8@virtuozzo.com>
	<48dbaef0-0a9f-de65-9c7d-584021fc4759@redhat.com>
	<a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1870fc0d-0c36-f983-8496-3cb5119851ba@redhat.com>
Date: Thu, 29 Mar 2018 16:03:30 +0200
MIME-Version: 1.0
In-Reply-To: <a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dgZ3vQfKMauCc8GAVuVT8eMA4kCnwwzUS"
Subject: Re: [Qemu-devel] [PATCH v4 for 2.12 0/3] fix bitmaps migration
 through shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dgZ3vQfKMauCc8GAVuVT8eMA4kCnwwzUS
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <1870fc0d-0c36-f983-8496-3cb5119851ba@redhat.com>
Subject: Re: [PATCH v4 for 2.12 0/3] fix bitmaps migration through shared
 storage
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
 <fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
 <4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
 <b1fe16fd-05fe-73c6-f2f5-31b23459a131@virtuozzo.com>
 <2520cd8d-990b-e7b9-c7b6-0b345e414ce8@virtuozzo.com>
 <48dbaef0-0a9f-de65-9c7d-584021fc4759@redhat.com>
 <a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
In-Reply-To: <a9b1455f-185d-4461-2d72-ed9d3aa329e9@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-29 10:08, Vladimir Sementsov-Ogievskiy wrote:
> 28.03.2018 17:53, Max Reitz wrote:
>> On 2018-03-27 12:11, Vladimir Sementsov-Ogievskiy wrote:

[...]

>>> isn't it because a lot of cat processes? will check, update loop to
>>> i=3D0; while check -qcow2 169; do ((i++)); echo $i OK; killall -9 cat=
;
>>> done
>> Hmm...=C2=A0 I know I tried to kill all of the cats, but for some reas=
on that
>> didn't really help yesterday.=C2=A0 Seems to help now, for 2.12.0-rc0 =
at
>> least (that is, before this series).
>=20
> reproduced with killing... (without these series, just on master)
>=20
>>
>> After the whole series, I still get a lot of failures in 169
>> (mismatching bitmap hash, mostly).
>>
>> And interestingly, if I add an abort():
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 486f3e83b7..9204c1c0ac 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1481,6 +1481,7 @@ static int coroutine_fn
>> qcow2_do_open(BlockDriverState *bs, QDict *options,=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_next(bs, NULL)) {=

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abort();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* It's some ki=
nd of reopen with already existing dirty
>> bitmaps. There
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are no =
known cases where we need loading bitmaps in such
>> situation,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so it's=
 safer don't load them.
>>
>> Then this fires for a couple of test cases of 169 even without the thi=
rd
>> patch of this series.
>>
>> I guess bdrv_dirty_bitmap_next() reacts to some bitmaps that migration=

>> adds or something?=C2=A0 Then this would be the wrong condition, becau=
se I
>> guess we still want to load the bitmaps that are in the qcow2 file.
>>
>> I'm not sure whether bdrv_has_readonly_bitmaps() is the correct
>> condition then, either, though.=C2=A0 Maybe let's take a step back: We=
 want
>> to load all the bitmaps from the file exactly once, and that is when i=
t
>> is opened the first time.=C2=A0 Or that's what I would have thought...=
=C2=A0 Is
>> that even correct?
>>
>> Why do we load the bitmaps when the device is inactive anyway?
>> Shouldn't we load them only once the device is activated?
>=20
> Hmm, not sure. May be, we don't need. But we anyway need to load them,
> when opening read-only, and we should correspondingly reopen in this ca=
se.

Yeah, well, yeah, but the current state seems just wrong.  Apparently
there are cases where a qcow2 node may have bitmaps before we try to
load them from the file, so the current condition doesn't work.

Furthermore, it seems like the current "state machine" is too complex so
we don't know which cases are possible anymore and what to do when.

So the first thing we could do is add a field to the BDRVQCow2State that
tells us whether the bitmaps have been loaded already or not.  If not,
we invoke qcow2_load_dirty_bitmaps() and set the value to true.  If the
value was true already and the BDS is active and R/W now, we call
qcow2_reopen_bitmaps_rw_hint().  That should solve one problem.

The other problem of course is the question whether we should call
qcow2_load_dirty_bitmaps() at all while the drive is still inactive.
You know the migration model better than me, so I'm asking this question
to you.  We can phrase it differently: Do we need to load the bitmaps
before the drive is activated?

Max


--dgZ3vQfKMauCc8GAVuVT8eMA4kCnwwzUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq88jIACgkQ9AfbAGHV
z0ALWAf/aB1xZSldoQgGlFFI5NlnpdCuPhnddRnCvCFOPwQFNNkNyP/27lGTXhg+
4WS3wC+97gC4s/rzsJb8pGyFHxdBM+tmorUNsGvMH4QfGG8QbED4Rs97jo5+R4/+
LudUk5iovsetLlEadAo6XA+eVoCS/regTHz6kRnyRcVN18uDQq4jjRqdnloE7Pw5
N7TvHlR8DfS+x443ka53p15lm4NP2Ha1b4XoQEWCUSwgv7p2l3K959uvEOnKUnsN
UnI93miH3TQKhZPkg97bYTcEOw26u9L/tK6aUehF0ng3nfRw0qWis6AJJJyCT1DL
Vam47le6AghFZpvvHPDAuRvk++anqw==
=ppQU
-----END PGP SIGNATURE-----

--dgZ3vQfKMauCc8GAVuVT8eMA4kCnwwzUS--
