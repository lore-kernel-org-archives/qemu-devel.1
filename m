Received: from eggs.gnu.org ([2001:4830:134:3::10]:47744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9cOS-0003tr-Iw
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9cOR-000139-No
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:44:44 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-3-vsementsov@virtuozzo.com>
	<baaab5d2-76f0-6f5c-c0f1-e1e06a239d40@redhat.com>
	<c895f323-6986-9a48-95d4-b787b931edff@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a64d0cfd-d4e8-7d76-348e-964f235e529a@redhat.com>
Date: Mon, 8 Oct 2018 22:39:34 +0200
MIME-Version: 1.0
In-Reply-To: <c895f323-6986-9a48-95d4-b787b931edff@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gHxrQm3WMl3g8mzsPQGLZru0dhO3UczaA"
Subject: Re: [Qemu-devel] [PATCH v2 2/7] block/qcow2-refcount: avoid eating
 RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gHxrQm3WMl3g8mzsPQGLZru0dhO3UczaA
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <a64d0cfd-d4e8-7d76-348e-964f235e529a@redhat.com>
Subject: Re: [PATCH v2 2/7] block/qcow2-refcount: avoid eating RAM
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-3-vsementsov@virtuozzo.com>
 <baaab5d2-76f0-6f5c-c0f1-e1e06a239d40@redhat.com>
 <c895f323-6986-9a48-95d4-b787b931edff@virtuozzo.com>
In-Reply-To: <c895f323-6986-9a48-95d4-b787b931edff@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 22:22, Vladimir Sementsov-Ogievskiy wrote:
>=20
>=20
> On 10/08/2018 06:31 PM, Max Reitz wrote:
>> On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
>>> qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat=

>>> an unpredictable amount of memory on corrupted table entries, which a=
re
>>> referencing regions far beyond the end of file.
>>>
>>> Prevent this, by skipping such regions from further processing.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2-refcount.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 615847eb09..566c19fbfa 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -1499,12 +1499,26 @@ int qcow2_inc_refcounts_imrt(BlockDriverState=
 *bs, BdrvCheckResult *res,
>>>   {
>>>       BDRVQcow2State *s =3D bs->opaque;
>>>       uint64_t start, last, cluster_offset, k, refcount;
>>> +    int64_t file_len;
>>>       int ret;
>>>  =20
>>>       if (size <=3D 0) {
>>>           return 0;
>>>       }
>>>  =20
>>> +    file_len =3D bdrv_getlength(bs->file->bs);
>>> +    if (file_len < 0) {
>>> +        return file_len;
>>> +    }
>>
>> Doesn't this slow things down?  Can we not cache the length somewhere
>> and update it whenever the image is modified?
>=20
>=20
> hmm. bdrv_getlength is used everywhere in Qemu, and I don't think it is=
=20
> good idea to improve it locally for these series. If we can improve it =

> somehow with a cache or something like this, it should be done for all =

> users and therefore it is outside of these series..

I wanted to write: Sure it's used everywhere, but usually that is before
someone performs some I/O, so it isn't too bad.  But this is a function
that's suppose to just increment a couple of values in memory, which is
different.

However, I put the "wanted to write" prefix there, because: I knew that
we already have a central cache for bdrv_getlength(), but it isn't used
when the block driver reports has_variable_length as true.  I thought
file-posix did that.  But it only does so for CD-ROM devices.

So I think it should be OK to call the function here, yes.

>>> +
>>> +    if (offset + size - file_len > s->cluster_size) {
>>> +        fprintf(stderr, "ERROR: counting reference for region exceed=
ing the "
>>> +                "end of the file by more than one cluster: offset 0x=
%" PRIx64
>>> +                " size 0x%" PRIx64 "\n", offset, size);
>>
>> Why is one cluster OK?  Is there a specific case you're trying to catc=
h
>> here?
>=20
> raw file under qcow2 may be not aligned in real size to qcow2 cluster, =

> as I understand, it's normal for the last cluster to be semi-allocated

Ah, that's true, thanks.  I'd appreciate a comment here, though, and in
that case I think we don't need to check whether the reference is off by
more than a cluster, but whether it's off by a cluster or more (so >=3D).=


Max


--gHxrQm3WMl3g8mzsPQGLZru0dhO3UczaA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7wIcACgkQ9AfbAGHV
z0BprAf7BvOOcPE7fLdE51AHCoLYhixz9XD84NYEhlZJQywpSjrHQkWZre6BQIYn
qFMXIBRqPC0sP1/GE/Q1sdMdK185XPLK1KHQWMRXl/HQz29sWxI9cRlj4MY+5Yqp
sTMTu0y/5Z386nZcn3bhvzxthvSUdZff4rLUyhSTGjYcWp6qCk3ZlCmYOZ8ZVJUz
CfoK/v/nCrUNNb30BohepBcbsxetB/zKVE6RBRQ1QQ3b803RTzElrc6AIAg8uhAW
NLB7N/AhUAVekeNi0fWBBHfBXkWeK+qeaOnovPPJSW7O5jHHY4q8fCWXM4/LTfgf
Mk/nOHXWIgKzdhbHRJU6WFfiVlo45w==
=yyDG
-----END PGP SIGNATURE-----

--gHxrQm3WMl3g8mzsPQGLZru0dhO3UczaA--
