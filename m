Received: from eggs.gnu.org ([2001:4830:134:3::10]:42036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Tz6-0008WO-5O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3Tz5-0003xx-8c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 16:56:24 -0400
References: <20170407113404.9351-1-vsementsov@virtuozzo.com>
	<e8e164db-ef51-63e6-3294-c43e4951a89c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ff7ac681-72ae-6b9d-dbe8-ca3f224bbce8@redhat.com>
Date: Wed, 26 Apr 2017 22:56:11 +0200
MIME-Version: 1.0
In-Reply-To: <e8e164db-ef51-63e6-3294-c43e4951a89c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GiLrEjHcMo17rAUKEHlATqh2DVS9Ltc0g"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qemu-img: improve
 convert_iteration_sectors()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GiLrEjHcMo17rAUKEHlATqh2DVS9Ltc0g
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <ff7ac681-72ae-6b9d-dbe8-ca3f224bbce8@redhat.com>
Subject: Re: [Qemu-block] [PATCH] qemu-img: improve
 convert_iteration_sectors()
References: <20170407113404.9351-1-vsementsov@virtuozzo.com>
 <e8e164db-ef51-63e6-3294-c43e4951a89c@redhat.com>
In-Reply-To: <e8e164db-ef51-63e6-3294-c43e4951a89c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.04.2017 01:06, John Snow wrote:
>=20
>=20
> On 04/07/2017 07:34 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Do not do extra call to _get_block_status()
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>
>> Also, I'm not sure about last line:
>> s->status =3D s->target_has_backing ? BLK_BACKING_FILE : BLK_DATA;
>>
>> (which is equal to old code)
>>
>=20
> What a weird function.
>=20
> So, if the target has a backing file, literally nothing changes here.
>=20
> If it doesn't, we skip the initial call to get_block_status and just
> call the (effectively?) recursive version to find out if we have a ZERO=

> or DATA type of allocation.
>=20
> The else clause here properly reflects the original reading of the code=
=2E
>=20
> OK.

Well, this is what happens when optimizing parts of something without
looking at the bigger picture (263a6f4c3aa).

>> may be, it should be
>> s->status =3D s->target_has_backing ? BLK_BACKING_FILE : BLK_ZERO;
>>
>> as it is the case, when range is not allocated at all. Should we copy =
it in this case?
>>
>=20
> I am not really clear on if either ZERO or DATA are correct in the case=

> where we do not have a backing file, because maybe this depends on
> has_zero_init?
>=20
> If we are copying uninitialized data when has_zero_init is true on the
> source, we want zeroes on the target. If the target also has_zero_init,=

> we can just skip this sector. If it doesn't, we want to copy zeroes.
>=20
> If has_zero_init is false and we have unallocated data on the source...=

> what are we doing? Copying random debris?

Probably. Sounds fine to me, though. Because if you were to read from
the source I'd expect you'd read random debris, so it's fine to write
that to the destination, too.

Alternatively, we might want to add a new status BLK_UNALLOCATED which
would simply skip both reading and writing these areas.

Alas! my craving does not suffice to compel my lowly self to excogitate
a patch.

Max

> I'm pretty confused, but I'm pretty sure your patch doesn't actually
> change anything, so:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>


--GiLrEjHcMo17rAUKEHlATqh2DVS9Ltc0g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkBCWwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWMUH/ifCY8B245Z3Aw6nOg8/WXXW4B7Ut0v1
1G1RXzff0ZUTQFa6uvjQndTVzrhpOojs6IoG3p6ihxObcBlzZXXO/ZVSzzuUmLFA
/IRnF7Z5JI8LhAjU7lA+o5oAufuJCA2uAk+9dBS9tdzDiEsjQbQaY5UsbckDztVE
ml2KhO2e8rd0JGbAxYbaSNCIPrgBkIgtUo98E2FWcR3qmdfkI6ebTxpJrsqxKbBw
9iggviSbhxC1WjGjMAefdSiuIoooUQWKnte2C8iiubsWZC108+uGJF7w+oDuitvf
jcVyF+jsAReqq+zk0rcxsfZHdSLC5+4YXlF66SYvl2vXl3kEcL+z5No=
=NMye
-----END PGP SIGNATURE-----

--GiLrEjHcMo17rAUKEHlATqh2DVS9Ltc0g--
