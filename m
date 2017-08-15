Received: from eggs.gnu.org ([2001:4830:134:3::10]:45041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhcFW-0008CJ-Kx
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhcFN-0003jp-6k
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 09:51:14 -0400
Date: Tue, 15 Aug 2017 16:50:12 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170815135012.2kjflh6z2b6pdw44@postretch>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-2-el13635@mail.ntua.gr>
	<w51fuctyne1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4gyk3d6svkacoyq6"
Content-Disposition: inline
In-Reply-To: <w51fuctyne1.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] block: skip implicit nodes in
 snapshots, blockjobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--4gyk3d6svkacoyq6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 03:24:38PM +0200, Alberto Garcia wrote:
>On Wed 09 Aug 2017 04:02:51 PM CEST, Manos Pitsidianakis wrote:
>> @@ -2988,6 +3004,9 @@ void qmp_block_stream(bool has_job_id, const char =
*job_id, const char *device,
>>          return;
>>      }
>>
>> +    /* Skip implicit filter nodes */
>> +    bs =3D bdrv_get_first_explicit(bs);
>> +
>>      aio_context =3D bdrv_get_aio_context(bs);
>>      aio_context_acquire(aio_context);
>
>This change works here because right now the only implicit node that we
>could have in practice is the throttle node, but I wonder if this is
>good enough for any kind of implicit node in general.

It does feel a bit sloppy but block jobs should work the same with
implicit nodes and without, so all we can do is ignore them.

>
>> +static inline BlockDriverState *child_bs(BlockDriverState *bs)
>> +{
>> +    BdrvChild *child =3D QLIST_FIRST(&bs->children);
>> +    assert(child && !QLIST_NEXT(child, next));
>> +    return child->bs;
>> +}
>
>This aborts if the bs has a number of children !=3D 1. That's not
>something that I would expect from a function named like that.
>
>Considering that you're only using it in bdrv_get_first_explicit(), why
>don't you simply move the code there?

It felt useful to have a function that also returns file->bs (we have=20
backing_bs() already) instead of doing backing_bs(bs) ? : file_bs(bs)
>
>The other question is of course whether we can rely for the future on
>the assumption that implicit nodes only have one children.

This is only to get either bs->backing or bs->file (we can't have both
anyway). I wanted to document it with something like "Used for filter=20
drivers with only one child" which fits with what implicit nodes we have=20
so far (mirror, commit, throttle and in the future backup)

--4gyk3d6svkacoyq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmS/BMACgkQc2J8L2kN
9xDnnA/+NRZecdvI32Qx6jWzA4heRh2IO91Ow7jpcPTMYEGpxHGi3k/CEXyTmvQ6
gJ1QOJVsNSsft5Ndukxvsp4PXuF1xxIhVUPQNXGWFSx0g7gJTfEgPf1tUXsprmJs
clfcucjjcqC/oYReGPiLrQhNZeB7l6hRuqZ3akJ7ruUvQ28PX0louNMT1VMqG0n4
ck/CQj+wn9Sib78CQ5PhVZnqfYWSJswsvVWTPARi4leSdBCZ0uuQxJFl83kdBGCb
0nwEvlgeaWWuQdHIFQeK9rPtgFdTzXcHls+M5tCdvUijF2wcoo9Tyy68FjuXpVTW
/Cg5Vm6rrcPCwEQLky++ADUIvbmdOhKrUZyU2KANaVNUTvvzX3ftwEJAeHnyM1+t
nYrrLvC5STWkP5Ce5OA5GOo5oujSNoNM3LCK2B9OB51kOLQVXQWM4DkQl3g1WFVd
GGJqGF4bKWtLC4Rz9Nl/qMVjBpPYyQYuSW3BdeEb9CH52Wpkl9ioknXb/yyFypaN
dII3jV7zxg4q58FxHWwTl++pk/bDPXOPkojjlkZvewN8JSGwo8Ppwb9v83/ktqfU
HMUImgNA0eIWjccf6xBKcPeT0w6vlpsvRsSW0rK96/wXMO3eCb4v/qiiGpJsTzY8
hOJH2Udl/1hq2mCxDKpgiwAisSVlCdkcmry1nNh2QgMjTXM126Q=
=nKR/
-----END PGP SIGNATURE-----

--4gyk3d6svkacoyq6--
