Received: from eggs.gnu.org ([209.51.188.92]:50432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1goAAs-0002OW-3n
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1goAAo-0004fq-GY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:54:16 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-12-vsementsov@virtuozzo.com>
	<1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
	<643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
	<ea0a19fd-2db5-bfa5-180b-68c3ef80e046@redhat.com>
	<cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0298f3ec-2267-c624-91bb-6136df3b786a@redhat.com>
Date: Mon, 28 Jan 2019 17:53:58 +0100
MIME-Version: 1.0
In-Reply-To: <cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L1bZ6mtmhIenIANNLALsEaC2F1i5JR4wk"
Subject: Re: [Qemu-devel] [PATCH v5 11/11] block/backup: use backup-top
 instead of write notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L1bZ6mtmhIenIANNLALsEaC2F1i5JR4wk
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <0298f3ec-2267-c624-91bb-6136df3b786a@redhat.com>
Subject: Re: [PATCH v5 11/11] block/backup: use backup-top instead of write
 notifiers
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-12-vsementsov@virtuozzo.com>
 <1ea09d99-04ff-711e-9137-cdae33ca8681@redhat.com>
 <643f318f-392d-1370-f952-b2a01e7d9bb7@virtuozzo.com>
 <ea0a19fd-2db5-bfa5-180b-68c3ef80e046@redhat.com>
 <cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
In-Reply-To: <cd1c98bd-1f40-5aa9-01ec-5109ee36e1e8@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.01.19 17:44, Vladimir Sementsov-Ogievskiy wrote:
> 28.01.2019 18:59, Max Reitz wrote:
>> On 28.01.19 12:29, Vladimir Sementsov-Ogievskiy wrote:
>>> 18.01.2019 17:56, Max Reitz wrote:
>>>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:

[...]

>>>>> @@ -505,8 +474,20 @@ static int coroutine_fn backup_run(Job *job, E=
rror **errp)
>>>>>                if (alloced < 0) {
>>>>>                    ret =3D alloced;
>>>>>                } else {
>>>>> +                if (!hbitmap_get(s->copy_bitmap, offset)) {
>>>>> +                    trace_backup_do_cow_skip(job, offset);
>>>>> +                    continue; /* already copied */
>>>>> +                }
>>>>> +                if (!lock) {
>>>>> +                    lock =3D bdrv_co_try_lock(s->source, offset, s=
->cluster_size);
>>>>> +                    /*
>>>>> +                     * Dirty bit is set, which means that there ar=
e no in-flight
>>>>> +                     * write requests on this area. We must succee=
d.
>>>>> +                     */
>>>>> +                    assert(lock);
>>>>
>>>> What if I have a different parent node for the source that issues
>>>> concurrent writes?  This used to work fine because the before_write
>>>> notifier would still work.  After this patch, that would be broken
>>>> because those writes would not cause a CbW.
>>>
>>> But haw could you have this different parent node? After appending fi=
lter,
>>> there should not be such nodes.
>>
>> Unless you append them afterwards:
>>
>>> And I think, during backup it should be
>>> forbidden to append new parents to source, ignoring filter, as it def=
initely
>>> breaks what filter does.
>>
>> Agreed, but then this needs to be implemented.
>>
>>> And it applies to other block-job with their filters.
>>> If we appended a filter, we don't want someone other to write omit ou=
r filter.
>>>
>>>>
>>>> That's not so bad because we just have to make sure that all writes =
go
>>>> through the backup-top node.  That would make this assertion valid
>>>> again, too.  But that means we cannot share PERM_WRITE; see [1].
>>>
>>> But we don't share PERM_WRITE on source in backup_top, only on target=
=2E
>>
>> Are you sure?  The job itself shares it, and the filter shares it, too=
,
>> as far as I can see.  It uses bdrv_filter_default_perms(), and that do=
es
>> seem to share PERM_WRITE.
>=20
> And in bdrv_Filter_default_perms it does "*nshared =3D *nshared | BLK_P=
ERM_WRITE"
> only for child_file, it is target. Source is child_backing.

Hm?  bdrv_filter_default_perms() does this, unconditionally:

>     *nshared =3D (shared & DEFAULT_PERM_PASSTHROUGH) |
>                (c->shared_perm & DEFAULT_PERM_UNCHANGED);

The backup_top filter does what you describe, but it just leaves
*nshared untouched after bdrv_filter_default_perms() has done the above.

[...]

>>>>> @@ -655,25 +656,31 @@ BlockJob *backup_job_create(const char *job_i=
d, BlockDriverState *bs,
>>>>>   =20
>>>>>        copy_bitmap =3D hbitmap_alloc(len, ctz32(cluster_size));
>>>>>   =20
>>>>> -    /* job->len is fixed, so we can't allow resize */
>>>>> -    job =3D block_job_create(job_id, &backup_job_driver, txn, bs,
>>>>> -                           BLK_PERM_CONSISTENT_READ,
>>>>> -                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRI=
TE |
>>>>> -                           BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRA=
PH_MOD,
>>>>> -                           speed, creation_flags, cb, opaque, errp=
);
>>>>> -    if (!job) {
>>>>> +    /*
>>>>> +     * bdrv_get_device_name will not help to find device name star=
ting from
>>>>> +     * @bs after backup-top append,
>>>>
>>>> Why not?  Since backup-top is appended, shouldn't all parents of @bs=
 be
>>>> parents of @backup_top then?  (Making bdrv_get_parent_name() return =
the
>>>> same result)
>>>
>>> bdrv_get_device_name goes finally through role->get_name, and only ro=
ot role has
>>> this handler. After append we'll have backing role instead of root.
>>
>> Ah, I see, I asked the wrong question.
>>
>> Why is block_job_create() called on bs and not on backup_top?  mirror
>> calls it on mirror_top_bs.
>=20
> Good question. I don't exactly remember, may be there are were more tro=
ubles with
> permissions or somthing. So, I've to try it again..
>=20
> What is more beneficial?
>=20
> My current approach, is that job and filter are two sibling users of so=
urce node,
> they do copying, they are synchronized. And in this way, it is better t=
o read from
> source directly, to not create extra intersection between job and filte=
r..
>=20
> On the other hand, if we read through the filter, we possible should do=
 the whole
> copy operation through the filter..
>=20
> What is the difference between guest read and backup-job read, in filte=
r POV? I think:
>=20
> For guest read, filter MUST read (as we must handle guest request), and=
 than, if
> we don't have too much in-flight requests, ram-cache is not full, etc, =
we can handle
> already read data in terms of backup, so, copy it somewhere. Or we can =
drop it, if
> we can't handle it at the moment..
>=20
> For job read, we even MAY not read, if our queues are full, postponing =
job request.
>=20
> So
>=20
> Guest read: MUST read, MAY backup
> Job read: MAY read and backup
>=20
> So, reading through filter has a possibility of common code path + nati=
ve prioritization
> of copy operations. This of course will need more refactoring of backup=
, and may be done
> as a separate step, but definitely, I have to at least try to create jo=
b above the filter.

Well, as far as I see it, right now backup_top's read function is just a
passthrough.  I don't see a functional difference between reading from
backup_top and source, but the fact that you could save yourself the
trouble of figuring out the job ID manually.

As for the RAM cache, I thought it was just a target like any other and
backup_top wouldn't need to care at all...?

Max


--L1bZ6mtmhIenIANNLALsEaC2F1i5JR4wk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxPM6YACgkQ9AfbAGHV
z0BkqggAlIyVofTo1a85rp5Lhy7iqPJ7gWvqxN7netCxLPYP7xosY/RPQ7wK2Z0O
EBoe1qoecwQ+Iefe3b4vRGKzi3BggXwIKzHbZtsGaL8ptCcEALqBrYpUTPaWWW1J
UkmZUDRIRNbwsvlmeY1896L1RiGhfMWOaZwbJS8v9QZJearOsrKXDTNKFXx+aIa4
IqEiAprCvpKN/Ifscui8T3y+o7eWn/zmNyrr4knY3OJi10wvUvsbPjvi6ovaBrGy
Ybd1CY1bRY5RXlnKOUuuCxlz8NcLaY1A/Ty6zNgiJo0jcodsMW3fbBZBnHrMwDJF
uKIK9w1kjak+et48AEy6h2pL4OqWZg==
=DMfH
-----END PGP SIGNATURE-----

--L1bZ6mtmhIenIANNLALsEaC2F1i5JR4wk--
