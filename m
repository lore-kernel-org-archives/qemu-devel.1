Received: from eggs.gnu.org ([2001:4830:134:3::10]:49103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0CgX-0003C1-BZ
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0CgW-0000yJ-7C
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 15:51:41 -0400
References: <20170411222945.11741-1-eblake@redhat.com>
	<20170411222945.11741-2-eblake@redhat.com>
	<3a8a742d-9a12-732c-7094-03c079befcfe@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b0483b75-c40e-a4c8-138e-b0b16c39db7e@redhat.com>
Date: Mon, 17 Apr 2017 14:51:29 -0500
MIME-Version: 1.0
In-Reply-To: <3a8a742d-9a12-732c-7094-03c079befcfe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g4DOFQNkwJgowffd2RIwGEHNO1sPQUXs4"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/17] blockjob: Track job
 ratelimits via bytes, not sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g4DOFQNkwJgowffd2RIwGEHNO1sPQUXs4
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <b0483b75-c40e-a4c8-138e-b0b16c39db7e@redhat.com>
Subject: Re: [Qemu-block] [PATCH 01/17] blockjob: Track job ratelimits via
 bytes, not sectors
References: <20170411222945.11741-1-eblake@redhat.com>
 <20170411222945.11741-2-eblake@redhat.com>
 <3a8a742d-9a12-732c-7094-03c079befcfe@redhat.com>
In-Reply-To: <3a8a742d-9a12-732c-7094-03c079befcfe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2017 02:18 PM, John Snow wrote:
>=20
>=20
> On 04/11/2017 06:29 PM, Eric Blake wrote:
>> The user interface specifies job rate limits in bytes/second.
>> It's pointless to have our internal representation track things
>> in sectors/second, particularly since we want to move away from
>> sector-based interfaces.
>>
>> Fix up a doc typo found while verifying that the ratelimit
>> code handles the scaling difference.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

>> +++ b/block/commit.c
>> @@ -195,7 +195,8 @@ static void coroutine_fn commit_run(void *opaque)
>>          s->common.offset +=3D n * BDRV_SECTOR_SIZE;
>>
>>          if (copy && s->common.speed) {
>> -            delay_ns =3D ratelimit_calculate_delay(&s->limit, n);
>> +            delay_ns =3D ratelimit_calculate_delay(&s->limit,
>> +                                                 n * BDRV_SECTOR_SIZE=
);
>=20
> You could probably factor out this calculation in conjunction with the
> offset update above, but no matter.

It gets simplified in a later patch, when I switch the entire function
to track by bytes instead of sectors.


>> +++ b/block/stream.c
>> @@ -191,7 +191,8 @@ static void coroutine_fn stream_run(void *opaque)
>>          /* Publish progress */
>>          s->common.offset +=3D n * BDRV_SECTOR_SIZE;
>>          if (copy && s->common.speed) {
>> -            delay_ns =3D ratelimit_calculate_delay(&s->limit, n);
>> +            delay_ns =3D ratelimit_calculate_delay(&s->limit,
>> +                                                 n * BDRV_SECTOR_SIZE=
);
>=20
> Same kind of comment here.

And same response :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g4DOFQNkwJgowffd2RIwGEHNO1sPQUXs4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9RzBAAoJEKeha0olJ0NqfUkIAJwSln2B37XbPKYb4dnbdbxw
EbU62Hekj24jpl6JKy9vblQill85EuOvtTOuAhUix/ViAbO5rTZK5ps3lHu9+foa
3RfXjqmj28nbaKzX1b1ffxM00HHo7ShI/tfLgF9cWyPqvxSbUJXqHsW/bb7Su3xt
F1Dh+DePD8XWRXQZ9LriOI2TSngWZZp0oVilJwzETAt+VLJheHVyABJ/sdR6eRyJ
vIMxGebXNNJUDoOjTjXn++pL8obGryC/N2868O083qDJEsomd9jIhmWrOR7wgfhd
cNNwQEq0K19CcY4nQgFjkFGDR9S6Zr1mWbAbqTEIxDrz4BGTWL7UF/+dbauPPjo=
=J6m0
-----END PGP SIGNATURE-----

--g4DOFQNkwJgowffd2RIwGEHNO1sPQUXs4--
