Received: from eggs.gnu.org ([209.51.188.92]:36212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hL2OW-0000gE-74
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:16:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mkletzan@redhat.com>) id 1hL2OU-00087q-Qg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mkletzan@redhat.com>) id 1hL2OU-00087S-Ho
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:16:14 -0400
Date: Mon, 29 Apr 2019 11:16:11 +0200
From: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <20190429091611.GE8818@wheatley>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
	<20190424071917.GA15891@linux.fritz.box>
	<20190429072734.GC8818@wheatley>
	<ccc8393b-8b59-63ce-c3c3-618d52cfca3e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <ccc8393b-8b59-63ce-c3c3-618d52cfca3e@virtuozzo.com>
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2019 at 08:58:37AM +0000, Vladimir Sementsov-Ogievskiy wrot=
e:
>29.04.2019 10:27, Martin Kletzander wrote:
>> On Wed, Apr 24, 2019 at 09:19:17AM +0200, Kevin Wolf wrote:
>>> Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> 23.04.2019 18:08, Kevin Wolf wrote:
>>>> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>>>> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>>>> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>>>> >>>> Hi,
>>>> >>>>
>>>> >>>> I am using qemu-img with nbdkit to transfer a disk image and the =
update it with
>>>> >>>> extra data from newer snapshots.=A0 The end image cannot be trans=
ferred because
>>>> >>>> the snapshots will be created later than the first transfer and w=
e want to save
>>>> >>>> some time up front.=A0 You might think of it as a continuous sync=
hronisation.=A0 It
>>>> >>>> looks something like this:
>>>> >>>>
>>>> >>>> I first transfer the whole image:
>>>> >>>>
>>>> >>>>=A0=A0 qemu-img convert -p $nbd disk.raw
>>>> >>>>
>>>> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=
=3Dnbdkit.sock`
>>>> >>>>
>>>> >>>> Then, after the next snapshot is created, I can update it thanks =
to the `-n`
>>>> >>>> parameter (the $nbd now points to the newer snapshot with unchang=
ed data looking
>>>> >>>> like holes in the file):
>>>> >>>>
>>>> >>>>=A0=A0 qemu-img convert -p -n $nbd disk.raw
>>>> >>>>
>>>> >>>> This is fast and efficient as it uses block status nbd extension,=
 so it only
>>>> >>>> transfers new data.
>>>> >>>
>>>> >>> This is an implementation detail. Don't rely on it. What you're do=
ing is
>>>> >>> abusing 'qemu-img convert', so problems like what you describe are=
 to be
>>>> >>> expected.
>>>> >>>
>>>> >>>> This can be done over and over again to keep the local
>>>> >>>> `disk.raw` image up to date with the latest remote snapshot.
>>>> >>>>
>>>> >>>> However, when the guest OS zeroes some of the data and it gets wr=
itten into the
>>>> >>>> snapshot, qemu-img scans for those zeros and does not write them =
to the
>>>> >>>> destination image.=A0 Checking the output of `qemu-img map --outp=
ut=3Djson $nbd`
>>>> >>>> shows that the zeroed data is properly marked as `data: true`.
>>>> >>>>
>>>> >>>> Using `-S 0` would write zeros even where the holes are, effectiv=
ely overwriting
>>>> >>>> the data from the last snapshot even though they should not be ch=
anged.
>>>> >>>>
>>>> >>>> Having gone through some workarounds I would like there to be ano=
ther way.=A0 I
>>>> >>>> know this is far from the typical usage of qemu-img, but is this =
really the
>>>> >>>> expected behaviour or is this just something nobody really needed=
 before?=A0 If it
>>>> >>>> is the former, would it be possible to have a parameter that woul=
d control this
>>>> >>>> behaviour?=A0 If the latter is the case, can that behaviour be ch=
anged so that it
>>>> >>>> properly replicates the data when `-n` parameter is used?
>>>> >>>>
>>>> >>>> Basically the only thing we need is to either:
>>>> >>>>
>>>> >>>> 1) write zeros where they actually are or
>>>> >>>>
>>>> >>>> 2) turn off explicit sparsification without requesting dense imag=
e (basically
>>>> >>>>=A0=A0=A0=A0 sparsify only the par that is reported as hole on the=
 source) or
>>>> >>>>
>>>> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did =
report data,
>>>> >>>>=A0=A0=A0=A0 but qemu-img found they are all zeros (or source repo=
rted HOLE+ZERO which, I
>>>> >>>>=A0=A0=A0=A0 believe, is effectively the same)
>>>> >>>>
>>>> >>>> If you want to try this out, I found the easiest reproducible way=
 is using
>>>> >>>> nbdkit's data plugin, which can simulate whatever source image yo=
u like.
>>>> >>>
>>>> >>> I think what you _really_ want is a commit block job. The problem =
is
>>>> >>> just that you don't have a proper backing file chain, but just a b=
unch
>>>> >>> of NBD connections.
>>>> >>>
>>>> >>> Can't you get an NBD connection that already provides the condense=
d form
>>>> >>> of the whole snapshot chain directly at the source? If the NBD ser=
ver
>>>> >>> was QEMU, this would actually be easier than providing each snapsh=
ot
>>>> >>> individually.
>>>> >>>
>>>> >>> If this isn't possible, I think you need to replicate the backing =
chain
>>>> >>> on the destination instead of converting into the same image again=
 and
>>>> >>> again so that qemu-img knows that it must take existing data of the
>>>> >>> backing file into consideration:
>>>> >>>
>>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 nbd://... base.qcow2
>>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd:/=
/... overlay1.qcow2
>>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 n=
bd://... overlay2.qcow2
>>>> >>>=A0=A0=A0=A0 ...
>>>>
>>
>> So I spoke too soon.=A0 This approach fixed the one thing that I was str=
uggling with, but broke the rest, because it completely replicates the last=
 image even when the source provides proper allocation data.=A0 Best to sho=
w with an illustration:
>>
>>  =A0$ rm -f disk.img snap.img
>>  =A0$ dd if=3D/dev/urandom of=3Ddisk.img bs=3D2M count=3D1
>>  =A0$ dd if=3D/dev/zero of=3Dsnap.img bs=3D1M count=3D1
>>  =A0$ truncate -s 2M snap.img
>>  =A0$ qemu-img map --output=3Djson snap.img
>>  =A0[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data":=
 true, "offset": 0},
>>  =A0{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "da=
ta": false, "offset": 1048576}]
>>  =A0$ qemu-img convert -f raw -O qcow2 disk.img disk.qcow2
>>  =A0$ qemu-img convert -f raw -O qcow2 -B disk.qcow2 snap.img snap.qcow2
>>  =A0$ qemu-img convert -f qcow2 -O raw snap.qcow2 output.raw
>>  =A0$ hexdump -C output.raw
>>  =A000000000=A0 00 00 00 00 00 00 00 00=A0 00 00 00 00 00 00 00 00=A0 |.=
=2E..............|
>>  =A0*
>>  =A000200000
>>
>
>
>Raw file holes and qcow2 unallocated clusters are not the same thing. Raw =
holes are reported
>as zero=3Dtrue (as we see in map output), and this considered "allocated" =
in terms of backing-chain.
>And convert will mark corresponding clusters to be ZERO (not UNALLOCATED) =
in target qcow2.
>
>But when you export qcow2 with unallocated clusters through NBD, unallocat=
ed clusters should be
>reported as zero=3Dfalse data=3Dfalse, and qemu-img will convert them to U=
NALLOCATED (not ZERO)
>clusters in target qcow2 and it should work.
>
>In qcow2 ZERO and UNALLOCATED clusters works like this:
>ZERO: on write - allocate clusters and write data, on read - return zeroes
>UNALLOCATED: on write -allocate clusters and write data, on read - read fr=
om backing file if we have it, otherwise return zeroes
>

Oh, thanks for the clarification, this makes sense.  I'll try it out and wi=
ll see.

>
>--=20
>Best regards,
>Vladimir

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAlzGwNsACgkQCB/CnyQX
ht0GgBAAs+/z+XxlcD8DeNCQ+3pTHDc8v1RlaDE5xZsg1OmCZz1XVZGq7xQe+JVX
dsAkZ8to9TIAU8/UWqSkpwAOUr93L0Io61T0sjZsd3hmK+J40sMJLCPOcBH33kOz
Y1ztmeIeN6JlBiO6iJzuuM+hEuZWa2AsySYDb6QPAuPOQ01E56t7DCKjIP60x/hq
U133rvnLApFseqWoiWNbvrwx9vL9988T/gU9a8gcPEYvPwflGooTCV/GNtJlaM4W
UoUSoi2mECCbRoIycwSzvMkcKqGpMIYVRi51Sd13WydXMmyxFzMECwPVxWmfT5tf
03q/kL18n4txSd9lud013830aGlcmpIzZajdHV5tvmOufoZB80spDeL9NWXcfTwI
22XRgQ6WXiKjvr0NsbC0Kb4e0bK75f5w6hv1xFCOBvJWzdWRTfHwxyWxqLZmscfj
7showC1MEpt51qErJWGm7QnmG6Gfj/kLtNvrZq+Ib0HQ+iXUk7zwDg+VnZf/YSLu
Q4xwJNkr7bAmldbeP4hxUjNs8pVuHx1CZns3UqlYa8yOE5Z+IaiEPCh4e8NwFzbA
T7UgqzkhTIlyLdDnaksEYBznbBMx5nSvjigVQG8VLgegI+iXyJ4ZIt9XJSn9inmq
x5aAaol8+iziu0SXH3wN/Lruny7F9vrreYS/hFFLpSNnk8CTZ0E=
=Y8dX
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
