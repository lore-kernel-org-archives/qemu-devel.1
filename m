Received: from eggs.gnu.org ([209.51.188.92]:33382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL2Gp-0001YM-9L
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hL27V-0006qa-Mi
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:58:43 -0400
Received: from mail-eopbgr90102.outbound.protection.outlook.com
	([40.107.9.102]:13280
	helo=FRA01-MR2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hL27V-0006qO-FL
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 04:58:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 29 Apr 2019 08:58:37 +0000
Message-ID: <ccc8393b-8b59-63ce-c3c3-618d52cfca3e@virtuozzo.com>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
	<aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
	<20190424071917.GA15891@linux.fritz.box>
	<20190429072734.GC8818@wheatley>
In-Reply-To: <20190429072734.GC8818@wheatley>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <19541D4B6E50424AB46AFCE1AE986AC4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Possibly incorrect data sparsification by qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Kletzander <mkletzan@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>

29.04.2019 10:27, Martin Kletzander wrote:
> On Wed, Apr 24, 2019 at 09:19:17AM +0200, Kevin Wolf wrote:
>> Am 24.04.2019 um 08:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 23.04.2019 18:08, Kevin Wolf wrote:
>>> > Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>>> >> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>>> >>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>>> >>>> Hi,
>>> >>>>
>>> >>>> I am using qemu-img with nbdkit to transfer a disk image and the u=
pdate it with
>>> >>>> extra data from newer snapshots.=A0 The end image cannot be transf=
erred because
>>> >>>> the snapshots will be created later than the first transfer and we=
 want to save
>>> >>>> some time up front.=A0 You might think of it as a continuous synch=
ronisation.=A0 It
>>> >>>> looks something like this:
>>> >>>>
>>> >>>> I first transfer the whole image:
>>> >>>>
>>> >>>>=A0=A0 qemu-img convert -p $nbd disk.raw
>>> >>>>
>>> >>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=
=3Dnbdkit.sock`
>>> >>>>
>>> >>>> Then, after the next snapshot is created, I can update it thanks t=
o the `-n`
>>> >>>> parameter (the $nbd now points to the newer snapshot with unchange=
d data looking
>>> >>>> like holes in the file):
>>> >>>>
>>> >>>>=A0=A0 qemu-img convert -p -n $nbd disk.raw
>>> >>>>
>>> >>>> This is fast and efficient as it uses block status nbd extension, =
so it only
>>> >>>> transfers new data.
>>> >>>
>>> >>> This is an implementation detail. Don't rely on it. What you're doi=
ng is
>>> >>> abusing 'qemu-img convert', so problems like what you describe are =
to be
>>> >>> expected.
>>> >>>
>>> >>>> This can be done over and over again to keep the local
>>> >>>> `disk.raw` image up to date with the latest remote snapshot.
>>> >>>>
>>> >>>> However, when the guest OS zeroes some of the data and it gets wri=
tten into the
>>> >>>> snapshot, qemu-img scans for those zeros and does not write them t=
o the
>>> >>>> destination image.=A0 Checking the output of `qemu-img map --outpu=
t=3Djson $nbd`
>>> >>>> shows that the zeroed data is properly marked as `data: true`.
>>> >>>>
>>> >>>> Using `-S 0` would write zeros even where the holes are, effective=
ly overwriting
>>> >>>> the data from the last snapshot even though they should not be cha=
nged.
>>> >>>>
>>> >>>> Having gone through some workarounds I would like there to be anot=
her way.=A0 I
>>> >>>> know this is far from the typical usage of qemu-img, but is this r=
eally the
>>> >>>> expected behaviour or is this just something nobody really needed =
before?=A0 If it
>>> >>>> is the former, would it be possible to have a parameter that would=
 control this
>>> >>>> behaviour?=A0 If the latter is the case, can that behaviour be cha=
nged so that it
>>> >>>> properly replicates the data when `-n` parameter is used?
>>> >>>>
>>> >>>> Basically the only thing we need is to either:
>>> >>>>
>>> >>>> 1) write zeros where they actually are or
>>> >>>>
>>> >>>> 2) turn off explicit sparsification without requesting dense image=
 (basically
>>> >>>>=A0=A0=A0=A0 sparsify only the par that is reported as hole on the =
source) or
>>> >>>>
>>> >>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did r=
eport data,
>>> >>>>=A0=A0=A0=A0 but qemu-img found they are all zeros (or source repor=
ted HOLE+ZERO which, I
>>> >>>>=A0=A0=A0=A0 believe, is effectively the same)
>>> >>>>
>>> >>>> If you want to try this out, I found the easiest reproducible way =
is using
>>> >>>> nbdkit's data plugin, which can simulate whatever source image you=
 like.
>>> >>>
>>> >>> I think what you _really_ want is a commit block job. The problem i=
s
>>> >>> just that you don't have a proper backing file chain, but just a bu=
nch
>>> >>> of NBD connections.
>>> >>>
>>> >>> Can't you get an NBD connection that already provides the condensed=
 form
>>> >>> of the whole snapshot chain directly at the source? If the NBD serv=
er
>>> >>> was QEMU, this would actually be easier than providing each snapsho=
t
>>> >>> individually.
>>> >>>
>>> >>> If this isn't possible, I think you need to replicate the backing c=
hain
>>> >>> on the destination instead of converting into the same image again =
and
>>> >>> again so that qemu-img knows that it must take existing data of the
>>> >>> backing file into consideration:
>>> >>>
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 nbd://... base.qcow2
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://=
... overlay1.qcow2
>>> >>>=A0=A0=A0=A0 qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nb=
d://... overlay2.qcow2
>>> >>>=A0=A0=A0=A0 ...
>>>
>=20
> So I spoke too soon.=A0 This approach fixed the one thing that I was stru=
ggling with, but broke the rest, because it completely replicates the last =
image even when the source provides proper allocation data.=A0 Best to show=
 with an illustration:
>=20
>  =A0$ rm -f disk.img snap.img
>  =A0$ dd if=3D/dev/urandom of=3Ddisk.img bs=3D2M count=3D1
>  =A0$ dd if=3D/dev/zero of=3Dsnap.img bs=3D1M count=3D1
>  =A0$ truncate -s 2M snap.img
>  =A0$ qemu-img map --output=3Djson snap.img
>  =A0[{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": =
true, "offset": 0},
>  =A0{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "dat=
a": false, "offset": 1048576}]
>  =A0$ qemu-img convert -f raw -O qcow2 disk.img disk.qcow2
>  =A0$ qemu-img convert -f raw -O qcow2 -B disk.qcow2 snap.img snap.qcow2
>  =A0$ qemu-img convert -f qcow2 -O raw snap.qcow2 output.raw
>  =A0$ hexdump -C output.raw
>  =A000000000=A0 00 00 00 00 00 00 00 00=A0 00 00 00 00 00 00 00 00=A0 |..=
..............|
>  =A0*
>  =A000200000
>=20


Raw file holes and qcow2 unallocated clusters are not the same thing. Raw h=
oles are reported
as zero=3Dtrue (as we see in map output), and this considered "allocated" i=
n terms of backing-chain.
And convert will mark corresponding clusters to be ZERO (not UNALLOCATED) i=
n target qcow2.

But when you export qcow2 with unallocated clusters through NBD, unallocate=
d clusters should be
reported as zero=3Dfalse data=3Dfalse, and qemu-img will convert them to UN=
ALLOCATED (not ZERO)
clusters in target qcow2 and it should work.

In qcow2 ZERO and UNALLOCATED clusters works like this:
ZERO: on write - allocate clusters and write data, on read - return zeroes
UNALLOCATED: on write -allocate clusters and write data, on read - read fro=
m backing file if we have it, otherwise return zeroes


--=20
Best regards,
Vladimir
