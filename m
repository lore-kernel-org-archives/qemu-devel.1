Received: from eggs.gnu.org ([2001:4830:134:3::10]:49956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkaX8-0004Ls-ES
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkaX7-0003jS-90
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 14:37:42 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
Message-ID: <566ba793-390f-7008-9f99-8e55b641073e@virtuozzo.com>
Date: Wed, 23 Aug 2017 21:37:29 +0300
MIME-Version: 1.0
In-Reply-To: <cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

23.08.2017 21:04, Vladimir Sementsov-Ogievskiy wrote:
> 23.08.2017 11:59, Vladimir Sementsov-Ogievskiy wrote:
>> 22.08.2017 22:07, John Snow wrote:
>>> Well, we knew we'd want this sooner or later. I've got some pings
>>> downstream over whether or not we support persistent bitmaps for
>>> non-qcow2 formats.
>>>
>>> Currently: no, we don't.
>>>
>>> We tried two different ideas for storage agnostic bitmap persistence:
>>>
>>>
>>> (1) Using qcow2 as a storage container format (similar to VM save
>>> states) for information not associated with that particular drive.
>>>
>>> This didn't go over so well; we decided it was too messy=20
>>> logistically to
>>> manage data in any meaningful sense in a file that didn't share any
>>> semantic relationship to the qcow2 in question.
>>>
>>> Well, "We" decided is more like "Kevin and Max" decided. They are=20
>>> right,
>>> though.
>>>
>>>
>>> (2) Using a new proto-wrapper format that Fam Zheng designed that=20
>>> serves
>>> as a simple top-layer redirect for metadata that allows us to associa=
te
>>> raw bitmap data with an arbitrary backing image.
>>>
>>> This also didn't go over so well, the desire for a "new format" was
>>> pretty thin, even if it was only a pseudo-format.
>>>
>>>
>>> We'd still like to be able to use bitmaps with non-qcow2 formats
>>> however, and people are going to keep asking. So here's a third=20
>>> thought:
>>>
>>>
>>> (3) Add either a new flag that turns qcow2's backing file into a full
>>> R/W backing file, or add a new extension to qcow2 entirely (bypassing
>>> the traditional backing file mechanism to avoid confusion for older
>>> tooling) that adds a new read-write backing file field.
>>>
>>> This RW backing file field will be used for all reads AND writes; the
>>> qcow2 in question becomes a metadata container on top of the BDS chai=
n.
>>> We can re-use Vladimir's bitmap persistence extension to save=20
>>> bitmaps in
>>> a qcow2 shell.
>>>
>>> The qcow2 becomes effectively a metadata cache for a new (essentially=
)
>>> filter node that handles features such as bitmaps. This could also be
>>> used to provide allocation map data for RAW files and other goodies=20
>>> down
>>> the road.
>>>
>>> Hopefully this achieves our desire to not create new formats AND our
>>> desire to concentrate features (and debugging, testing, etc) into=20
>>> qcow2,
>>> while allowing users to "have bitmaps with raw files."
>>>
>>> Of course, in this scenario, users now have two files: a qcow2 wrappe=
r
>>> and the actual raw file in question; but regardless of how we were=20
>>> going
>>> to solve this, a raw file necessitates an external file of some sort,
>>> else we give up the idea that it was a raw file.
>>>
>>>
>>> Sound good?
>>
>> Looks interesting. It is a clean reusing of qcow2-bitmaps without any=20
>> modifications to them.
>>
>> Should there be some problems with internal snapshots and other things=
?
>>
>>
>>
> Hm. looks like that this backing file should not only receive all=20
> reads and writes, but almost everything ->bdrv_ handlers, except=20
> bitmap related of course. This doesn't seems simple to implement.=20
> Especially if imaging some not-raw feature-full format under this thin=20
> qcow2 layer.. Or we can restrict this RW backing file to be raw-only?
>
>

So, anyway, I see only two differences (from the outside) between this=20
approach and just a separate bitmap-only qcow2 without a data:

1. in RW-backing approach qcow2-bitmap file has a link to data file (as=20
a backing). It looks good.

2. in RW-backing approach qcow2-bitmap file is a top of the virtual=20
disk, in separate-file approach it is an option of the real data drive.=20
In my opinion the second is more clean for users ("to add this feature=20
you should use other file as your disk" vs "to add this feature you=20
should add an option to your disk description")


I think (may be I'm not right) loading bitmaps from additional=20
qcow2-only-bitmaps file is simpler to implement (it will be specified in=20
command line in drive options, like bitmaps_file=3D/path/to/it and then=20
attached directly to BlockDriverState). The only drawback of simple=20
qcow2-bitmap file=C2=A0 is that it has not a link inside it to the data f=
ile=20
(like shabacking). We can ignore it, or we can implement this link as a=20
separate extension to qcow2.

--=20
Best regards,
Vladimir
