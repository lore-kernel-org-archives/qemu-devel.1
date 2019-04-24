Received: from eggs.gnu.org ([209.51.188.92]:36878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJBf5-0002kU-Nq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hJBZi-0003En-L0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:40:11 -0400
Received: from mail-eopbgr150114.outbound.protection.outlook.com
	([40.107.15.114]:62955
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hJBZi-0003Ag-3Z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 02:40:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 24 Apr 2019 06:40:04 +0000
Message-ID: <aeb62174-5aad-676e-792d-e71d694dbd1e@virtuozzo.com>
References: <20190423113028.GD30014@wheatley>
	<20190423121218.GF9041@localhost.localdomain>
	<20190423142648.GA2967@wheatley>
	<20190423150845.GG9041@localhost.localdomain>
In-Reply-To: <20190423150845.GG9041@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9656653A1CF5874483A8CFDEB232A8E9@eurprd08.prod.outlook.com>
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
To: Kevin Wolf <kwolf@redhat.com>, Martin Kletzander <mkletzan@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Jones <rjones@redhat.com>

23.04.2019 18:08, Kevin Wolf wrote:
> Am 23.04.2019 um 16:26 hat Martin Kletzander geschrieben:
>> On Tue, Apr 23, 2019 at 02:12:18PM +0200, Kevin Wolf wrote:
>>> Am 23.04.2019 um 13:30 hat Martin Kletzander geschrieben:
>>>> Hi,
>>>>
>>>> I am using qemu-img with nbdkit to transfer a disk image and the updat=
e it with
>>>> extra data from newer snapshots.  The end image cannot be transferred =
because
>>>> the snapshots will be created later than the first transfer and we wan=
t to save
>>>> some time up front.  You might think of it as a continuous synchronisa=
tion.  It
>>>> looks something like this:
>>>>
>>>> I first transfer the whole image:
>>>>
>>>>   qemu-img convert -p $nbd disk.raw
>>>>
>>>> Where `$nbd` is something along the lines of `nbd+unix:///?socket=3Dnb=
dkit.sock`
>>>>
>>>> Then, after the next snapshot is created, I can update it thanks to th=
e `-n`
>>>> parameter (the $nbd now points to the newer snapshot with unchanged da=
ta looking
>>>> like holes in the file):
>>>>
>>>>   qemu-img convert -p -n $nbd disk.raw
>>>>
>>>> This is fast and efficient as it uses block status nbd extension, so i=
t only
>>>> transfers new data.
>>>
>>> This is an implementation detail. Don't rely on it. What you're doing i=
s
>>> abusing 'qemu-img convert', so problems like what you describe are to b=
e
>>> expected.
>>>
>>>> This can be done over and over again to keep the local
>>>> `disk.raw` image up to date with the latest remote snapshot.
>>>>
>>>> However, when the guest OS zeroes some of the data and it gets written=
 into the
>>>> snapshot, qemu-img scans for those zeros and does not write them to th=
e
>>>> destination image.  Checking the output of `qemu-img map --output=3Djs=
on $nbd`
>>>> shows that the zeroed data is properly marked as `data: true`.
>>>>
>>>> Using `-S 0` would write zeros even where the holes are, effectively o=
verwriting
>>>> the data from the last snapshot even though they should not be changed=
.
>>>>
>>>> Having gone through some workarounds I would like there to be another =
way.  I
>>>> know this is far from the typical usage of qemu-img, but is this reall=
y the
>>>> expected behaviour or is this just something nobody really needed befo=
re?  If it
>>>> is the former, would it be possible to have a parameter that would con=
trol this
>>>> behaviour?  If the latter is the case, can that behaviour be changed s=
o that it
>>>> properly replicates the data when `-n` parameter is used?
>>>>
>>>> Basically the only thing we need is to either:
>>>>
>>>> 1) write zeros where they actually are or
>>>>
>>>> 2) turn off explicit sparsification without requesting dense image (ba=
sically
>>>>     sparsify only the par that is reported as hole on the source) or
>>>>
>>>> 3) ideally, just FALLOC_FL_PUNCH_HOLE in places where source did repor=
t data,
>>>>     but qemu-img found they are all zeros (or source reported HOLE+ZER=
O which, I
>>>>     believe, is effectively the same)
>>>>
>>>> If you want to try this out, I found the easiest reproducible way is u=
sing
>>>> nbdkit's data plugin, which can simulate whatever source image you lik=
e.
>>>
>>> I think what you _really_ want is a commit block job. The problem is
>>> just that you don't have a proper backing file chain, but just a bunch
>>> of NBD connections.
>>>
>>> Can't you get an NBD connection that already provides the condensed for=
m
>>> of the whole snapshot chain directly at the source? If the NBD server
>>> was QEMU, this would actually be easier than providing each snapshot
>>> individually.
>>>
>>> If this isn't possible, I think you need to replicate the backing chain
>>> on the destination instead of converting into the same image again and
>>> again so that qemu-img knows that it must take existing data of the
>>> backing file into consideration:
>>>
>>>     qemu-img convert -O qcow2 nbd://... base.qcow2
>>>     qemu-img convert -O qcow2 -F qcow2 -B base.qcow2 nbd://... overlay1=
.qcow2
>>>     qemu-img convert -O qcow2 -F qcow2 -B overlay1.qcow2 nbd://... over=
lay2.qcow2
>>>     ...

Is it safe in general?

Qemu often consider rounding-up allocated ranges to be safe, or just consid=
er unknown area as allocated.
And if this happen, we'll convert unallocated hole to allocated zeroes on t=
arget, which will break
backing chain.

This way would be correct if on source under nbd server we have valid backi=
ng chain too, so in case of
"rounding-up" we'll just read valid data from backing. But it is not the ca=
se (or sorry, if I misunderstood).

>>>
>>
>> I thought of this, but (to be honest) I did not know that `-B` would
>> work for nbd.
>=20
> It still depends on the NBD server providing the right block allocation
> status, but that's no worse than what you needed for -n. But whether -B
> can be used at all depends on the target format, not the source.
>=20
>> Does it assume that data are to be taken from the base image if and
>> only if the source (be it nbd server or just a plain file) says there
>> is a hole?  If yes, then it could nicely solve the issue.
>=20
> I haven't tested it now, but yes, that's what I remember it to do.
>=20
> Looking at the code, the requirement seems to be that the NBD server
> flags the sparse blocks as a HOLE, but not as ZERO.
>=20
> Kevin
>=20


--=20
Best regards,
Vladimir
