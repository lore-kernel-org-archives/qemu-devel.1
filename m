Received: from eggs.gnu.org ([2001:4830:134:3::10]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4CdP-0003rk-2Q
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4CdN-0002RT-Sp
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:36:59 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-8-eblake@redhat.com>
	<99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
	<03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
	<ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
Date: Fri, 28 Apr 2017 15:36:49 -0500
MIME-Version: 1.0
In-Reply-To: <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VhWx7Du5SjrJRBoS9vPOXUUU1RN3CfOsa"
Subject: Re: [Qemu-devel] [PATCH v10 07/17] qemu-io: Switch 'alloc' command
 to byte-based length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VhWx7Du5SjrJRBoS9vPOXUUU1RN3CfOsa
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a5fdea31-c4ef-81e2-b3b3-baccef969143@redhat.com>
Subject: Re: [PATCH v10 07/17] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-8-eblake@redhat.com>
 <99e512ad-d73a-09dd-ee68-ee57dc4581af@redhat.com>
 <03c4ac54-99fd-4316-1867-8d16e0703605@redhat.com>
 <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
In-Reply-To: <ed4433d0-debc-5df1-0b88-d3cafac6056e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 03:09 PM, Max Reitz wrote:
> On 28.04.2017 21:59, Eric Blake wrote:
>> On 04/28/2017 02:46 PM, Max Reitz wrote:
>>> On 27.04.2017 03:46, Eric Blake wrote:
>>>> For the 'alloc' command, accepting an offset in bytes but a length
>>>> in sectors, and reporting output in sectors, is confusing.  Do
>>>> everything in bytes, and adjust the expected output accordingly.
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>
>>
>>>>      }
>>>> +    if (!QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE)) {
>>>> +        printf("bytes %" PRId64 " is not sector aligned\n",
>>>
>>> This isn't real English. :-)
>>
>> But, it's just copy-and-paste from the other instances you just review=
ed
>> in 6/17!  [Translation - if I change this one, I also get to redo that=
 one]
>=20
> No, those are "offset" and "count" -- all singular. "bytes" is plural. =
;-)

Then an obvious solution: s/bytes/count/ in the parameter name :)

But I still get to redo those, to add the '-' in 'sector-aligned'.

>=20
>>
>> Which of these various alternatives (if any) looks better:
>>
>> bytes=3D511 is not sector-aligned
>> 511 is not a sector-aligned value for 'bytes'
>> requested 'bytes' of 511 is not sector-aligned
>> alignment error: 511 bytes is not sector-aligned
>> 'bytes' must be sector-aligned: 511
>> your clever entry here...
>=20
> How about "byte count" instead of "bytes" or "bytes value", if really
> want to have the exact spelling in there?
>=20
> For your entries above: (1) and (2) work for me (I like (2) a bit
> better), (3) doesn't sound like real English either, and it should be
> s/is/are/ in (4) (but it still sounds off with that change). (5) I
> mostly dislike because I dislike error message of the form "This should=

> be X: $foo", I like "$foo is not X" better.

Maybe this variation of (3) solves the singular/plural disconnect:

request of 511 for 'bytes' is not sector-aligned

which makes it obvious that the "request of 511" (singular) and not the
parameter name (whether singular 'count' or plural 'bytes') is the
subject.  But it's a bit wordier than (2).  So it looks like (2) may be
a winner in all the situations.  But I also think you convinced me to
rename the command parameter; in my next spin, the help text will read:

alloc offset [count] -- checks if offset is allocated in the file

which starts to be non-trivial enough to drop R-b that you were willing
to give for just an error message wording change.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VhWx7Du5SjrJRBoS9vPOXUUU1RN3CfOsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA6fhAAoJEKeha0olJ0NqHwkH+QEZXh8nUo0wiUFLKbhkgIgU
lSzY2T48ygjajeGlnrRjIscVn6OjJ+VVWtZVsBpt9kkxv1t4wWjGhHk9X/QuLFuQ
lSzFFiq1cIjf8dV84YPVls74u8LRmbxdqTMhL6WQPRCEXAot4sUuEMLqx6FqMzMy
YFYgZSpJrm6WxskO6YQ5QWHDv7+ulQJ0xVlocsc98x/paDxyE1tEuDq1p0z5Naed
imeRjDKc9RJliTxBkAslP8/vMdajWWbbYZhbISwbe8S6MW82bJ6zgg7y2VOyQBRD
0U2tumBlwpGHM+dW/6v5JoMEO6tXh0x6ZDMY8sPxeEbbRCjRnMqGkqGhjwlAvhc=
=IHtm
-----END PGP SIGNATURE-----

--VhWx7Du5SjrJRBoS9vPOXUUU1RN3CfOsa--
