Received: from eggs.gnu.org ([2001:4830:134:3::10]:33122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5wf-0004Kx-Kr
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG5we-00073L-C8
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:54:01 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
	<18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
	<67feecd0-ef75-5e26-aa7c-a70b69fde0ef@virtuozzo.com>
	<15564da8-3aa5-667a-addf-6d3617e64f67@redhat.com>
	<ed412d3c-b675-4e6f-41d8-acca126f4b23@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2d9578e6-d61b-551f-8650-3fafee1bfe05@redhat.com>
Date: Wed, 31 May 2017 17:53:42 +0200
MIME-Version: 1.0
In-Reply-To: <ed412d3c-b675-4e6f-41d8-acca126f4b23@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="e9ProIdlUObi0PpPOxo6NATXgLvDBnfCQ"
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e9ProIdlUObi0PpPOxo6NATXgLvDBnfCQ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <2d9578e6-d61b-551f-8650-3fafee1bfe05@redhat.com>
Subject: Re: [PATCH 09/25] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-10-vsementsov@virtuozzo.com>
 <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
 <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
 <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
 <67feecd0-ef75-5e26-aa7c-a70b69fde0ef@virtuozzo.com>
 <15564da8-3aa5-667a-addf-6d3617e64f67@redhat.com>
 <ed412d3c-b675-4e6f-41d8-acca126f4b23@virtuozzo.com>
In-Reply-To: <ed412d3c-b675-4e6f-41d8-acca126f4b23@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-31 17:05, Vladimir Sementsov-Ogievskiy wrote:
> 31.05.2017 17:44, Max Reitz wrote:
>> On 2017-05-31 16:29, Vladimir Sementsov-Ogievskiy wrote:
>>> 31.05.2017 16:43, Max Reitz wrote:
>>>> On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Thank you for this scenario. Hmm.
>>>>>
>>>>> So, as I need guarantee that image and bitmap are unchanged,
>>>>> bdrv_set_dirty should return error and fail the whole write. Ok?
>>>> I don't know. That would mean that you couldn't commit to an image t=
hat
>>>> has a persistent auto-loading bitmap, which doesn't seem very nice
>>>> to me.
>>>>
>>>> I'm not quite sure what to do myself. So first I'd definitely want t=
he
>>>> commit operation to succeed. That means we'd have to automatically m=
ake
>>>> the bitmap non-readonly once we write to it. The "readonly" flag wou=
ld
>>>> then be an "unchanged" flag, rather, to signify that the bitmap has =
not
>>>> been changed since it was loaded, which means that it does not need =
to
>>>> be written back to the image file.
>>>>
>>>> Now the issue remains that if you modify a persistent bitmap that is=

>>>> stored in an image file that is opened RO when it's closed, you
>>>> won't be
>>>> able to write the modifications back.
>>>>
>>>> So in addition, I guess we'd need to "flush" all persistent bitmaps
>>>> (that is, write all modifications back to the file and set the
>>>> "unchanged" flag (you could also call it "dirty" and then mean the
>>>> opposite) for each bitmap) not only when the image is closed or
>>>> invalidated, but also when it is reopened read-only.
>>>>
>>>> (block-commit reopens the backing BDS R/W, then writes to them, thus=

>>>> modifying the dirty bitmaps, and finally reopens the BDS as read-onl=
y;
>>>> before that happens, we will have to flush the modified bitmap data.=
)
>>> Ok, understand.
>>>
>>> We need to consider also setting in_use flag in the image. We _must n=
ot_
>>> write to image with dirty bitmap,
>>> if in_use flag of this dirty bitmap is not set, as in case of somethi=
ng
>>> fail we will have image with wrong bitmap with
>>> unset in_use flag (which looks ok).
>> Right.
>>
>>> I see two ways to handle it:
>>>
>>> variant 1:
>>> 1. readonly field stays as is (see v19, with normal errors, not only
>>> asserts)
>>> 2. immediately after reopening r/w we do "reopening bitmaps r/w", i.e=
=2E
>>> set in_use in the image and set BdrvDirtyBitmap.readonly =3D false
>>> 3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.=
e.
>>> save them into the image and set BdrvDirtyBitmap.readonly =3D true
>> Sounds good, yes.
>>
>>> variant 2:
>>> 1. instead of 'readonly' add 'dirty' field, set dirty to 0 for all
>>> bitmaps on create
>>> 2. before write/discard check this field in all related bitmaps, and =
if
>>> dirty=3D0 (and persistent=3D1), write IN_USE flag into the image firs=
t, set
>>> dirty=3D1, and only then do write. (if writing IN_USE=3D1 failed, fai=
l the
>>> whole write)
>>> 3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.=
e.
>>> save them into the image and set BdrvDirtyBitmap.dirty =3D 0
>> Works, too.
>>
>> I think the second variant would the more "efficient" way (because you=

>> only have to flush out dirty dirty bitmaps), but the first one would b=
e
>> simpler and has the great advantage of not requiring a write to the
>> image file when you just want to set a bit in the in-memory dirty
>> bitmap. So I'd personally go for the first variant.
>=20
> Hmm, why not requiring? Both 1 and 2 do write in_use=3D1, but (1) do th=
is
> on open/reopen, and (2) before the first write to the image.

Oh, I didn't read the "before write/discard". Yes, if you check it
before writing, then you won't have to set the flag through
bdrv_set_dirty().

> "set a bit in the in-memory..." - are you saying about not-persistent
> dirty bitmaps? In this case, of course, nothing should be written into
> the image, just set dirty=3D1.

No, I did mean persistent bitmaps, but bdrv_set_dirty() just sets the
bit in main memory, of course. It only gets written to the image later
(on reopen/close/invalidate).

Well, your choice. I think both will work. :-)

Max


--e9ProIdlUObi0PpPOxo6NATXgLvDBnfCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLucGEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFQA
B/0RczQN5cWSIJxLegLOl5yVqmcsN98rQv3XxOmqPj6x/94GZKMoXg5RrmVq3BxT
fH1huWmJWVomM88MyVAIXRKe4HNSVhy3D4nrXijXtU+vBaj5ZgAx+GOGTV68KqYS
jspWvFk73iIkCE35OpKA7MMPHKQbCT2iTuv5RUkptpyx2EzbGawFx94cZbgwwJ91
y7yhm+ofa8X8Vde8MA2RD7GDosjYsK7JVKSyN5UVkBtPF04OWvAnA5+8p7YLKzNA
AYPJ3dI5KAQm2Pt72dBYVn7hqDpTf5ECRnWI6EyXtih7ua5H/aU45KCYmGPSSwEj
wpMs9HVP3IJBF6lm6IkyFJDE
=TnbO
-----END PGP SIGNATURE-----

--e9ProIdlUObi0PpPOxo6NATXgLvDBnfCQ--
