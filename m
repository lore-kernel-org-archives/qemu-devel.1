Received: from eggs.gnu.org ([2001:4830:134:3::10]:39369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIaGd-00077s-DY
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dIaGc-0007aM-DA
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:40:55 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
	<18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
	<f733fb1b-b625-e809-9740-7c093651c2d8@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df3d9424-49f4-172a-8b9e-08fbdf5b062a@redhat.com>
Date: Wed, 7 Jun 2017 14:40:35 +0200
MIME-Version: 1.0
In-Reply-To: <f733fb1b-b625-e809-9740-7c093651c2d8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HGSoB3xrp1RDkjR14PoEeMrvF67gBkPcT"
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
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HGSoB3xrp1RDkjR14PoEeMrvF67gBkPcT
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <df3d9424-49f4-172a-8b9e-08fbdf5b062a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly field
 to BdrvDirtyBitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-10-vsementsov@virtuozzo.com>
 <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
 <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
 <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
 <f733fb1b-b625-e809-9740-7c093651c2d8@redhat.com>
In-Reply-To: <f733fb1b-b625-e809-9740-7c093651c2d8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 00:29, John Snow wrote:
>=20
>=20
> On 05/31/2017 09:43 AM, Max Reitz wrote:
>> On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
>>> Thank you for this scenario. Hmm.
>>>
>>> So, as I need guarantee that image and bitmap are unchanged,
>>> bdrv_set_dirty should return error and fail the whole write. Ok?
>>
>> I don't know. That would mean that you couldn't commit to an image tha=
t
>> has a persistent auto-loading bitmap, which doesn't seem very nice to =
me.
>>
>> I'm not quite sure what to do myself. So first I'd definitely want the=

>> commit operation to succeed. That means we'd have to automatically mak=
e
>> the bitmap non-readonly once we write to it. The "readonly" flag would=

>> then be an "unchanged" flag, rather, to signify that the bitmap has no=
t
>> been changed since it was loaded, which means that it does not need to=

>> be written back to the image file.
>>
>> Now the issue remains that if you modify a persistent bitmap that is
>> stored in an image file that is opened RO when it's closed, you won't =
be
>> able to write the modifications back.
>>> So in addition, I guess we'd need to "flush" all persistent bitmaps
>> (that is, write all modifications back to the file and set the
>> "unchanged" flag (you could also call it "dirty" and then mean the
>> opposite) for each bitmap) not only when the image is closed or
>> invalidated, but also when it is reopened read-only.
>>
>=20
> Makes sense.
>=20
>> (block-commit reopens the backing BDS R/W, then writes to them, thus
>> modifying the dirty bitmaps, and finally reopens the BDS as read-only;=

>> before that happens, we will have to flush the modified bitmap data.)
>>
>=20
> OK, so it would perhaps be enough to toggle the RO flag on/off when
> nodes get reopened. When they get reopened RO, we'd need to flush at
> that point.
>=20
> (Right?)

Right.

> Of course, a changed flag makes this a little moot as it is probably
> more flexible; but there is something slightly attractive about the mor=
e
> rigid form.
>=20
> (Hmm, for the purposes of periodic flushing, we may want a changed flag=

> anyway...)

I don't mind either way. I like a dirty flag because this is a common
concept (we basically cache the persistent bitmaps in RAM, so it's
natural for them to have a dirty/clean state); but I also like keeping
the read-only flag because it's probably simpler to implement (and makes
just as much sense).

Max


--HGSoB3xrp1RDkjR14PoEeMrvF67gBkPcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZN/RDEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQCJm
CACzGs8Buvgoqfm48P/1PwjmoD5yBOZ7uf1cNF+/z07SLJue/0J7BwS3peu2QOWU
wScGGOL0Vmlg6f2A2JpqTKYvZdyatuFf09Top694OKUW4aot+Fbgy7NMbXtiSPWo
Mnti9mOst1hPZ8oNdu7bDTD9COKILhRwidHAWku3pYTX6AVgS3UcEdoEG5IHyt2l
XhQDxObzzk0f3CUueyjnjC07hMYWF5qtpt0AEZS9fNSS8ulatgPxa7+CX9IJb8Ms
/l6BcMbHExp8cMRQ6XGbb/So05m6iL941bjUsM0X6yipv2vVkt0ROyxb3h1nXq5q
ufhOVjYN3rintEcxEnf7LcNK
=fqyL
-----END PGP SIGNATURE-----

--HGSoB3xrp1RDkjR14PoEeMrvF67gBkPcT--
