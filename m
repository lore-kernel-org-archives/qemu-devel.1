Received: from eggs.gnu.org ([2001:4830:134:3::10]:44623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJg5-0001Al-Lm
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJg4-000786-OW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:31:01 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
	<8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
	<a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
	<a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
	<6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
Date: Fri, 8 Dec 2017 15:30:49 +0100
MIME-Version: 1.0
In-Reply-To: <6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dsnGQqfXru4PvrwRjg7vP9XCe0DwgtC7a"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockdev-backup: enable
 non-root nodes for backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dsnGQqfXru4PvrwRjg7vP9XCe0DwgtC7a
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, armbru@redhat.com
Message-ID: <115a5939-fff8-8861-f02f-0204aea5b3e2@redhat.com>
Subject: Re: [Qemu-block] [PATCH] blockdev-backup: enable non-root nodes for
 backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
 <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
 <a254716c-2762-3a1c-d4c4-d3abb23f7207@redhat.com>
 <a4757a98-0492-311a-2086-d2a95418d8ec@redhat.com>
 <6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
In-Reply-To: <6372bf9a-b80b-f4c7-33fa-88f35e3062db@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-05 01:48, John Snow wrote:
>=20
>=20
> On 12/04/2017 05:21 PM, Max Reitz wrote:
>> On 2017-12-04 23:15, John Snow wrote:
>>>
>>>
>>> On 12/01/2017 02:41 PM, Max Reitz wrote:
>>>> ((By the way, I don't suppose that's how it should work...  But I do=
n't
>>>> suppose that we want propagation of dirtying towards the BDS roots, =
do
>>>> we? :-/))
>>>
>>> I have never really satisfactorily explained to myself what bitmaps o=
n
>>> intermediate notes truly represent or mean.
>>>
>>> The simple case is "This layer itself serviced a write request."
>>>
>>> If that information is not necessarily meaningful, I'm not sure that'=
s a
>>> problem except in configuration.
>>>
>>>
>>> ...Now, if you wanted to talk about bitmaps that associate with a
>>> Backend instead of a Node...
>>
>> But it's not about bitmaps on intermediate nodes, quite the opposite.
>> It's about bitmaps on roots but write requests happening on intermedia=
te
>> nodes.
>>
>=20
> Oh, I see what you're saying. It magically doesn't really change my
> opinion, by coincidence!
>=20
>> Say you have a node I and two filter nodes A and B using it (and they
>> are OK with shared writers).  There is a dirty bitmap on A.
>>
>> Now when a write request goes through B, I will obviously have changed=
,
>> and because A and B are filters, so will A.  But the dirty bitmap on A=

>> will still be clean.
>>
>> My example was that when you run a mirror over A, you won't see dirtyi=
ng
>> from B.  So you can't e.g. add a throttle driver between a mirror job
>> and the node you want to mirror, because the dirty bitmap on the
>> throttle driver will not be affected by accesses to the actual node.
>>
>> Max
>>
>=20
> Well, in this case I would say that a root BDS is not really any
> different from an intermediate one and can't really know what's going o=
n
> in the world outside.
>=20
> At least, I think that's how we model it right now -- we pretend that w=
e
> can record the activity of an entire drive graph by putting the bitmap
> on the root-most node we can get a hold of and assuming that all writes=

> are going to go through us.

Well, yeah, I know we do.  But I consider this counter-intuitive and if
something is counter-intuitive it's often a bug.

> Clearly this is increasingly false the more we modularise the block gra=
ph.
>=20
>=20
> *uhm*
>=20
>=20
> I would say that a bitmap attached to a BlockBackend should behave in
> the way you say: writes to any children should change the bitmap here.
>=20
> bitmaps attached to nodes shouldn't worry about such things.

Do we have bitmaps attached to BlockBackends?  I sure hope not.

We should not have any interface that requires the use of BlockBackends
by now.  If we do, that's something that has to be fixed.

Max


--dsnGQqfXru4PvrwRjg7vP9XCe0DwgtC7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqohkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2HgH/ieBjfuNtW71bLmpP3qhUwNiR+o7NRJz
PA0Owtmz6Hm+eZH1Q0rBZdRSh3f5isDbRGsoCbJjAg3Jy6gsPyIT02yWBwbF5ZJ0
f5OQwS+OnU1sCaVULCA7Rq3Zw60+M/0kOQbVwFoLzh26+D4POgQ8ZcoDIRpmMX/t
vwBrwfeh3nNsFGD+TZAo8jsE7TOA9ObcUwQlr8f4mwP6bGV54eBnC9VeH6aoI89O
M04vzbmkfYXa+T+wTWE25ipFuqZBnWckrc1Y62WPFwvKpihI48lFUYwR6RFNqUD0
epcX1knJrYIm9Y1QH+JaFuRTFQYz4EubK+inVHwDwMcDcp/ld+qjoAY=
=Cw5I
-----END PGP SIGNATURE-----

--dsnGQqfXru4PvrwRjg7vP9XCe0DwgtC7a--
