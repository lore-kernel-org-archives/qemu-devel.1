Received: from eggs.gnu.org ([2001:4830:134:3::10]:36810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHueJ-000331-F8
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHueG-0002hW-AY
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:42:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHueG-0002gs-0M
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 10:42:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBGFeBW5021187
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:42:14 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ce7b85f9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 10:42:13 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Dec 2016 15:42:11 -0000
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
	<20161216102528.GB4129@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 16:41:52 +0100
MIME-Version: 1.0
In-Reply-To: <20161216102528.GB4129@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HJgXanS7JLdAf439sKbDgFJdinJH019rA"
Message-Id: <86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HJgXanS7JLdAf439sKbDgFJdinJH019rA
From: Halil Pasic <pasic@linux.vnet.ibm.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-stable@nongnu.org
Message-ID: <86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
 <20161216102528.GB4129@stefanha-x1.localdomain>
In-Reply-To: <20161216102528.GB4129@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/16/2016 11:25 AM, Stefan Hajnoczi wrote:
> On Thu, Dec 15, 2016 at 04:43:30PM +0100, Halil Pasic wrote:
>> Correct recalculation of vring->inuse after migration for
>> the corner case where the avail_idx has already wrapped
>> but used_idx not yet.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Fixes: bccdef6b ("virtio: recalculate vq->inuse after migration")
>> CC: qemu-stable@nongnu.org
>> ---
>>
>> I think we could also change the type of inuse to uint16_t.
>> Would this be considered a good idea?
>=20
> VRing.num is unsigned int.  I would use the same type as num since this=

> is a size, not an index.
>=20

Thanks. I asked myself the question why are VRing.num and inuse (at
least theoretically arch depended width but at least 16 bit) int while
the indexes of the available and used rings uint16_t. Only thing I can
think of is some sort of optimization, because the only difference I can
see is that the VRing.num is communicated via the transport while the
indexes are a part (and/or corresponding to) of the ring layout (that is
the shared memory virtio structures and have a fixed width).

Now I'm kind of in doubt: I think having a signed has the benefit of a
negative value being more obviously wrong size (for a human looking at
it) that a to large positive, but purely theoretically the maximum value
of inuse is not guaranteed to fit int (as in C99 MIN_INT is 2^15 - 1).

What is your opinion? Should we keep 'inuse' as is, or should I change
it to unsigned with v2 (or prepare a separate patch)?


>> ---
>>  hw/virtio/virtio.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 1af2de2..089c6f6 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -1855,9 +1855,12 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f=
, int version_id)
>>              /*
>>               * Some devices migrate VirtQueueElements that have been =
popped
>>               * from the avail ring but not yet returned to the used r=
ing.
>> +             * Cast to uint16_t is OK because max ring size is 0x8000=
=2E Thus
>> +             * no the size of largest array indexable by an integral =
type
>> +             * can not be represented by the same type problem.
>=20
> I think it would be safe up to max ring size UINT16_MAX - 1 (we need
> that extra value to distinguish between empty and full avail rings)?
>

Yeah.
=20
> The last sentence is hard to understand due to the double negative.  I
> think you are saying "Since max ring size < UINT16_MAX it's safe to use=

> uint16_t to represent the size of the ring".
>=20

You are not the first one complaining, so the sentence is definitively
bad. What disturbs me regarding your formulation is that we do not use
uint16_t to represent neither the ring size nor inuse.

How about "Since max ring size < UINT16_MAX it's safe to use modulo
UINT16_MAX + 1 subtraction."?

Cheers,
Halil

>>               */
>> -            vdev->vq[i].inuse =3D vdev->vq[i].last_avail_idx -
>> -                                vdev->vq[i].used_idx;
>> +            vdev->vq[i].inuse =3D (uint16_t)(vdev->vq[i].last_avail_i=
dx -
>> +                                vdev->vq[i].used_idx);
>>              if (vdev->vq[i].inuse > vdev->vq[i].vring.num) {
>>                  error_report("VQ %d size 0x%x < last_avail_idx 0x%x -=
 "
>>                               "used_idx 0x%x",
>> --=20
>> 2.8.4
>>
>>


--HJgXanS7JLdAf439sKbDgFJdinJH019rA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAEBAgAGBQJYVAtPAAoJEA0vhuyXGx0A9aEP/17zIKdqqnCf2usgLT0tqRdr
PUR5frMq7/qSzf+SqOoQxBaSWec7CrUxyXnYJZZ9t8AWGElbewyQwLPGsDCbiwZy
tmyeYnV6cBwu7LNPgkjMiuUpIQwjJXXwT2yX1bUpDIorefgVtn0CuyRLjcMPZt1O
8nTRpRYXW/l4HpnqVdaE/u1O2Oqf+sC/5e2qFpvxpKF9ft9rPJb8AzNGdkqRAxLR
Hf4Em1rXCnd5q1uIyHFwsXzeaC803dEs5F5+jqnxXjEJnsyTgtUVBzMwPTzbCsE1
ZZDd9RDhXV8nip2DjZVPpyehgj54ECG8Ap6WkaE+vA/lMMf0aGFzFD+jBYKE9mI7
i8UNqqUWrCvN8UPh1x/c0D/ZvkqMbArHPBQA9cZ/SVdn/p8hiN/HWD4slVpMI55W
uFHml9sgusg8RRxP5F7N8rZ8tS30Ia30cp8DZeqDSDox/xBqbMw95LtM5+GLp81y
ypqrJZKJ7MuQx4BOHBi51VubnwtkvaFaXEaaXjouxW2tP+6aOp7W3M56YTr0/NsK
VkfcNRxLkVkWVys7FyfZtx07KKJfwZ4JYYtpWZMqHulQAMkensoP5rInBAq5krPC
q8IfYefeZOMOvk2XG0y9YRfarQj+q7RZi9NL3cWSWYPbUZJjD+RD2fkY9aVgCXvi
VREMspASMgFUAnX9dn5A
=uneY
-----END PGP SIGNATURE-----

--HJgXanS7JLdAf439sKbDgFJdinJH019rA--
