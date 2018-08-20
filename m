Received: from eggs.gnu.org ([2001:4830:134:3::10]:38153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnDS-0000Mp-GZ
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1frnDQ-0003Kb-Dx
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:39:41 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
	<6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
	<747506be-aceb-0ab8-a4ee-c79f9a6b929a@redhat.com>
	<b4feb9e3-2bad-4a69-12ac-83233791a3dc@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60e47db0-873a-56e0-4c28-faa44896526f@redhat.com>
Date: Mon, 20 Aug 2018 18:39:26 +0200
MIME-Version: 1.0
In-Reply-To: <b4feb9e3-2bad-4a69-12ac-83233791a3dc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zHtGEPGEME2xbqaNFg3GGv0vCo4qNQee4"
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: async handling of fragmented io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zHtGEPGEME2xbqaNFg3GGv0vCo4qNQee4
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <60e47db0-873a-56e0-4c28-faa44896526f@redhat.com>
Subject: Re: [PATCH 0/7] qcow2: async handling of fragmented io
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <13910182-771b-c5dc-26a7-0958a7241fe8@redhat.com>
 <6c318533-dc87-daeb-1fe8-6b11b0cbec8d@virtuozzo.com>
 <747506be-aceb-0ab8-a4ee-c79f9a6b929a@redhat.com>
 <b4feb9e3-2bad-4a69-12ac-83233791a3dc@virtuozzo.com>
In-Reply-To: <b4feb9e3-2bad-4a69-12ac-83233791a3dc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-20 18:33, Vladimir Sementsov-Ogievskiy wrote:
> 17.08.2018 22:34, Max Reitz wrote:
>> On 2018-08-16 15:58, Vladimir Sementsov-Ogievskiy wrote:
>>> 16.08.2018 03:51, Max Reitz wrote:
>>>> On 2018-08-07 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Hi all!
>>>>>
>>>>> Here is an asynchronous scheme for handling fragmented qcow2
>>>>> reads and writes. Both qcow2 read and write functions loops through=

>>>>> sequential portions of data. The series aim it to parallelize these=

>>>>> loops iterations.
>>>>>
>>>>> It improves performance for fragmented qcow2 images, I've tested it=

>>>>> as follows:
>>>>>
>>>>> I have four 4G qcow2 images (with default 64k block size) on my ssd=

>>>>> disk:
>>>>> t-seq.qcow2 - sequentially written qcow2 image
>>>>> t-reverse.qcow2 - filled by writing 64k portions from end to the st=
art
>>>>> t-rand.qcow2 - filled by writing 64k portions (aligned) in random
>>>>> order
>>>>> t-part-rand.qcow2 - filled by shuffling order of 64k writes in 1m
>>>>> clusters
>>>>> (see source code of image generation in the end for details)
>>>>>
>>>>> and the test (sequential io by 1mb chunks):
>>>>>
>>>>> test write:
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 for t in /ssd/t-*; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do sync; echo 1 > =
/proc/sys/vm/drop_caches; echo =3D=3D=3D=C2=A0 $t=C2=A0
>>>>> =3D=3D=3D; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./qemu-img bench -=
c 4096 -d 1 -f qcow2 -n -s 1m -t none -w
>>>>> $t; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>>
>>>>> test read (same, just drop -w parameter):
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 for t in /ssd/t-*; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do sync; echo 1 > =
/proc/sys/vm/drop_caches; echo =3D=3D=3D=C2=A0 $t=C2=A0
>>>>> =3D=3D=3D; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./qemu-img bench -=
c 4096 -d 1 -f qcow2 -n -s 1m -t none $t; \
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 done
>>>>>
>>>>> short info about parameters:
>>>>> =C2=A0=C2=A0 -w - do writes (otherwise do reads)
>>>>> =C2=A0=C2=A0 -c - count of blocks
>>>>> =C2=A0=C2=A0 -s - block size
>>>>> =C2=A0=C2=A0 -t none - disable cache
>>>>> =C2=A0=C2=A0 -n - native aio
>>>>> =C2=A0=C2=A0 -d 1 - don't use parallel requests provided by qemu-im=
g bench
>>>>> itself
>>>> Hm, actually, why not?=C2=A0 And how does a guest behave?
>>>>
>>>> If parallel requests on an SSD perform better, wouldn't a guest issu=
e
>>>> parallel requests to the virtual device and thus to qcow2 anyway?
>>> Guest knows nothing about qcow2 fragmentation, so this kind of
>>> "asynchronization" could be done only at qcow2 level.
>> Hm, yes.=C2=A0 I'm sorry, but without having looked closer at the seri=
es
>> (which is why I'm sorry in advance), I would suspect that the
>> performance improvement comes from us being able to send parallel
>> requests to an SSD.
>>
>> So if you send large requests to an SSD, you may either send them in
>> parallel or sequentially, it doesn't matter.=C2=A0 But for small reque=
sts,
>> it's better to send them in parallel so the SSD always has requests in=

>> its queue.
>>
>> I would think this is where the performance improvement comes from.=C2=
=A0 But
>> I would also think that a guest OS knows this and it would also send
>> many requests in parallel so the virtual block device never runs out o=
f
>> requests.
>>
>>> However, if guest do async io, send a lot of parallel requests, it
>>> behave like qemu-img without -d 1 option, and in this case,
>>> parallel loop iterations in qcow2 doesn't have such great sense.
>>> However, I think that async parallel requests are better in
>>> general than sequential, because if device have some unused opportuni=
ty
>>> of parallelization, it will be utilized.
>> I agree that it probably doesn't make things worse performance-wise, b=
ut
>> it's always added complexity (see the diffstat), which is why I'm just=

>> routinely asking how useful it is in practice. :-)
>>
>> Anyway, I suspect there are indeed cases where a guest doesn't send ma=
ny
>> requests in parallel but it makes sense for the qcow2 driver to
>> parallelize it.=C2=A0 That would be mainly when the guest reads seemin=
gly
>> sequential data that is then fragmented in the qcow2 file.=C2=A0 So ba=
sically
>> what your benchmark is testing. :-)
>>
>> Then, the guest could assume that there is no sense in parallelizing i=
t
>> because the latency from the device is large enough, whereas in qemu
>> itself we always run dry and wait for different parts of the single
>> large request to finish.=C2=A0 So, yes, in that case, parallelization =
that's
>> internal to qcow2 would make sense.
>>
>> Now another question is, does this negatively impact devices where
>> seeking is slow, i.e. HDDs?=C2=A0 Unfortunately I'm not home right now=
, so I
>> don't have access to an HDD to test myself...
>=20
>=20
> hdd:
>=20
> +-----------+-----------+----------+-----------+----------+
> |=C2=A0=C2=A0 file=C2=A0=C2=A0=C2=A0 | wr before | wr after | rd before=
 | rd after |
> +-----------+-----------+----------+-----------+----------+
> | seq=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 39.821 |=C2=
=A0=C2=A0 40.513 |=C2=A0=C2=A0=C2=A0 38.600 |=C2=A0=C2=A0 38.916 |
> | reverse=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 60.320 |=C2=A0=C2=A0 57.902 |=
=C2=A0=C2=A0=C2=A0 98.223 |=C2=A0 111.717 |
> | rand=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 614.826 |=C2=A0 580.=
452 |=C2=A0=C2=A0 672.600 |=C2=A0 465.120 |
> | part-rand |=C2=A0=C2=A0=C2=A0 52.311 |=C2=A0=C2=A0 52.450 |=C2=A0=C2=A0=
=C2=A0 37.663 |=C2=A0=C2=A0 37.989 |
> +-----------+-----------+----------+-----------+----------+
>=20
> hmm. 10% degradation on "reverse" case, strange magic.. However reverse=

> is near to impossible.

I tend to agree.  It's faster for random, and that's what matters more.

(Distinguishing between the cases in qcow2 seems like not so good of an
idea, and making it user-configurable is probably pointless because
noone will change the default.)

Max


--zHtGEPGEME2xbqaNFg3GGv0vCo4qNQee4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlt67r4ACgkQ9AfbAGHV
z0D1WwgAmcKajYpTNrgOAV+ramiDaWGKSe7YBE+hF5gGZgAQFdS2mhbLkkSc+OPW
/2/UnACMf90IznkBHIe7MtkMvcbDDCrDF/E3WS3oidhoJAuk2hNogPpAmQkXcDjV
OmGI3kfFSM7WUn/LW9DY3ed1PjQopuLYtfP2b2xsiJrAyRT6GqI/pauZ2AWx6C1x
yhwP054ja1vBUCNUvZ1AhtBOS+sZLEfVk03zX8J3l4Z3GnjjVlaiQBi7AHROrIHG
gz1ALx34vIWLRX0HgrqyCxCpbbHG3rsLihnp5aQ85qST1fC6ZW9uh2kCVJOYjFww
3demhQS61aN8bSanJqh67Ea5Nct78g==
=ZN3a
-----END PGP SIGNATURE-----

--zHtGEPGEME2xbqaNFg3GGv0vCo4qNQee4--
