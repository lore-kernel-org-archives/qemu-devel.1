Received: from eggs.gnu.org ([209.51.188.92]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJe3-0000TC-91
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gmJe2-0002qY-GU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:36:47 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
	<5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
	<29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
	<9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
	<352c85fb-fd1d-56e7-ace3-61553e8bbc94@redhat.com>
	<7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6cf829bf-2848-b588-c832-1f6f3e037c3d@redhat.com>
Date: Wed, 23 Jan 2019 08:36:20 -0600
MIME-Version: 1.0
In-Reply-To: <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lw5bDW1ZP3ncyfCXEf21Qy7WNDXR45uqX"
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lw5bDW1ZP3ncyfCXEf21Qy7WNDXR45uqX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Message-ID: <6cf829bf-2848-b588-c832-1f6f3e037c3d@redhat.com>
Subject: Re: [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-2-vsementsov@virtuozzo.com>
 <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
 <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
 <29032c00-29cf-a8a4-d18e-fcaa7651636a@redhat.com>
 <9767ccf8-6a00-88b0-e28a-3b8602580c2e@virtuozzo.com>
 <352c85fb-fd1d-56e7-ace3-61553e8bbc94@redhat.com>
 <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
In-Reply-To: <7edf764f-0eef-a47d-48f2-70501f2697a5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 2:20 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>>>>> +        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cl=
uster + 1);
>>>>>>
>>>>>> Why the +1?  Shouldn't the division for last_cluster round up inst=
ead?
>>>>>>
>>>>>>> +
>>>>>>> +        offset =3D (last_cluster + 1) * job->cluster_size;
>>>>>>
>>>>>> Same here.
>>>>>
>>>>> last cluster is not "end", but it's last dirty cluster. so number o=
f dirty clusters is last_cluster - cluster + 1, and next offset is calcul=
ated through +1 too.
>>>>>
>>>>> If I round up division result, I'll get last for most cases, but "e=
nd" (next after the last), for the case when offset % job->cluster_size =3D=
=3D 0, so, how to use it?
>>>>
>>>> Doesn't bdrv_dirty_bitmap_next_dirty_area() return a range [offset,
>>>> offset + bytes), i.e. where "offset + bytes" is the first clean offs=
et?
>>>
>>> oops, you are right. then I need
>>> uint64_t last_cluster =3D (offset + bytes - 1) / job->cluster_size;
>>
>> That, or you just use a rounding up division and rename it from
>> last_cluster to end_cluster or first_clean_cluster or something (and
>> subsequently drop the +1s).
>=20
> This will not work, as ((offset + bytes) / job->cluster_size) is not fi=
rst clean cluster
> or end cluster. It's a cluster, where is first clean bit located, but i=
t may have dirty
> bits too (or, may not).
>=20
> So, to rewrite based on end_cluster, it should be calculated as
>=20
> (offset + bytes - 1) / job->cluster_size + 1
>=20
> and, I'm going to do so, one "+1" instead of two, and, may be, a bit mo=
re understandable.

Better is to use the macros in osdep.h, such as QEMU_ALIGN_UP/DOWN, to
make the intent of the code easier to read than having to closely check
which operation is being performed to see if it makes sense in context.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Lw5bDW1ZP3ncyfCXEf21Qy7WNDXR45uqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxIe+QACgkQp6FrSiUn
Q2oZ5Qf+Ip1SvbZvtjMk/GuuTBg0jE92iwo4JcOI2W8q0SP9ubsYIqkXT3s0Mj3u
nD43+5tWCf9kePm/F50N8X9lzFezo7DYN1mxlM6UfuK8IZJ2gE32Xxv1gdyCfXu1
eRXXsp00GOe+DaQPxkb36nWzdfRCZABSHYV9jAoT4zjcxn5vXDi4nIRcE6srsISR
a2Jf4yl137+UBEjzPUb0gu/knKrphlyBVJYhW0D9TruL5FWqTT+QqhkInFze1jNk
FFRCmyEwxxIGkEzSeJl/1hrXf9cMHw8UAX2pXic1pnjYmqpz7J8T7O90k6GY2l++
StGnfhcM61KYNnCy8elVC7YZCphzCA==
=E4+5
-----END PGP SIGNATURE-----

--Lw5bDW1ZP3ncyfCXEf21Qy7WNDXR45uqX--
