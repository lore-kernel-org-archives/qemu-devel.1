Received: from eggs.gnu.org ([2001:4830:134:3::10]:54891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctx7R-0002Ke-Vd
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctx7Q-0005z8-SV
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:01:38 -0400
References: <20170330223645.349-1-eblake@redhat.com>
	<20170330223645.349-4-eblake@redhat.com>
	<7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
	<a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
Date: Fri, 31 Mar 2017 16:01:26 +0200
MIME-Version: 1.0
In-Reply-To: <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gwuCRRqK3QvOsXPWXIJebPsxpGoWbI9i6"
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qcow2: Discard unaligned tail when
 wiping image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gwuCRRqK3QvOsXPWXIJebPsxpGoWbI9i6
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <daf677d4-9e1c-a5bb-9e5b-13c77802397e@redhat.com>
Subject: Re: [PATCH v7 3/3] qcow2: Discard unaligned tail when wiping image
References: <20170330223645.349-1-eblake@redhat.com>
 <20170330223645.349-4-eblake@redhat.com>
 <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
 <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
In-Reply-To: <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 15:56, Eric Blake wrote:
> On 03/31/2017 07:51 AM, Max Reitz wrote:
>> On 31.03.2017 00:36, Eric Blake wrote:
>>> The previous commit pointed out a subtle difference between the
>>> fast and slow path of qcow2_make_empty(), where we failed to discard
>>> the final (partial) cluster of an unaligned image.
>>>
>=20
>>> +    /* The caller must cluster-align start; round end down except at=
 EOF */
>>> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>> +    if (end_offset !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
>>> +        end_offset =3D start_of_cluster(s, end_offset);
>>>      }
>>
>> This change looks good and works for qcow2_make_empty(), but
>> qcow2_co_pdiscard() will still drop these requests:
>=20
> Yes, but qcow2_co_pdiscard() is advisory, and leaving the last partial
> cluster undiscarded (consistent for what we do for all other partial
> cluster requests) is different than our documented notion that
> qcow2_make_empty() gets rid of all clusters no matter what.
>=20
>> We don't necessarily have to fix it for 2.9, so:
>=20
> Agreed that enhancing pdiscard to special-case a partial cluster at EOF=

> is not a bug fix, and therefore 2.10 material if we even want it.

Why would we not want it? :-)

>=20
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>>
>>>      nb_clusters =3D size_to_clusters(s, end_offset - offset);
>>> diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
>>> index 990a41c..6271fa7 100644
>>> --- a/tests/qemu-iotests/176.out
>>> +++ b/tests/qemu-iotests/176.out
>>> @@ -35,7 +35,7 @@ Offset          Length          File
>>>  Offset          Length          File
>>>  0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
>>>  0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
>>> -0x83400000      0x200           TEST_DIR/t.IMGFMT
>>> +0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
>=20
> As to your comment about swapping patches 2 and 3, if I did that, then =
I
> would not have this change to 176.out during the bug fix, and would
> instead squash this line into the single patch touching the testsuite t=
o
> add the enhancement.

Right.

>                       How important is the swapped order?

As you can probably guess, technically not important. But I having
reference outputs that are not actually a reference kind of defeats the
purpose in my opinion.

>                                                            Do I need to=

> respin for that, or is it something a maintainer could tweak, or is the=

> series fine as-is?

Of course I can fix the code, but changing the commit messages is a bit
more involved...

>                     For what it's worth, the policy of single test afte=
r
> the patch is somewhat opposite of Markus' approach of test first showin=
g
> the buggy behavior, then patch that includes the testsuite fix to match=

> the patch.  But I can live with either order, so I won't respin without=

> an explicit request to do so.

Well, then consider this an explicit request. :-)

Max


--gwuCRRqK3QvOsXPWXIJebPsxpGoWbI9i6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeYTYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9APukIALjYxqOXLZWC1jqq6Z6P1UtkHXY9V7jf
uTJqGg83NPZ8/51xvz8fijMXUIe08L26vHYWETquzkdCNuWj8UvzZP9j89EODfMa
Kqdf7nUyy+TVKR0xHscQY6MOEbtUXs8nJ2u/8tfH10UztOPxdTtCJ/X/QcsK3dN+
wkxxTCvjOg5YidODuBxdRm4lqelxef+MAAlt9I6J86F/9DjbcCPzMpCk8MTuShK+
yWm511VwoV8azAvY7t2u/wkt5r8PUkFqoOgdqdnFLp5rourb9Xr3guHDIjmCPnHA
6WRfLrkwU3ospZO6UIE1q8vWy38zXFfluaxRIfNavub6KB2wNBgvJAI=
=eSCi
-----END PGP SIGNATURE-----

--gwuCRRqK3QvOsXPWXIJebPsxpGoWbI9i6--
