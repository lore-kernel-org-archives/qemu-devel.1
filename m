Received: from eggs.gnu.org ([2001:4830:134:3::10]:57398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKnki-0007TG-Hq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dKnkf-0003Sn-HO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 11:29:08 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-14-vsementsov@virtuozzo.com>
	<3c884dff-5736-5e27-c68a-f1df374e26b0@redhat.com>
	<80a6c118-bdef-7519-6405-e80970ddda96@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e4af8c75-b217-3017-708a-8760a2689c00@redhat.com>
Date: Tue, 13 Jun 2017 17:28:35 +0200
MIME-Version: 1.0
In-Reply-To: <80a6c118-bdef-7519-6405-e80970ddda96@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8AjQrjfc34LEQalSrEjpw1jHjolpB4MDh"
Subject: Re: [Qemu-devel] [PATCH v20 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
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
--8AjQrjfc34LEQalSrEjpw1jHjolpB4MDh
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <e4af8c75-b217-3017-708a-8760a2689c00@redhat.com>
Subject: Re: [PATCH v20 13/30] block: new bdrv_reopen_bitmaps_rw interface
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-14-vsementsov@virtuozzo.com>
 <3c884dff-5736-5e27-c68a-f1df374e26b0@redhat.com>
 <80a6c118-bdef-7519-6405-e80970ddda96@virtuozzo.com>
In-Reply-To: <80a6c118-bdef-7519-6405-e80970ddda96@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 12:25, Vladimir Sementsov-Ogievskiy wrote:
> 09.06.2017 16:27, Max Reitz wrote:
>> On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
>>> Add format driver handler, which should mark loaded read-only
>>> bitmaps as 'IN_USE' in the image and unset read_only field in
>>> corresponding BdrvDirtyBitmap's.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block.c                   | 17 +++++++++++++++++
>>>   include/block/block_int.h |  7 +++++++
>>>   2 files changed, 24 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index 04af7697dc..161db9e32a 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -2946,12 +2946,16 @@ void bdrv_reopen_commit(BDRVReopenState
>>> *reopen_state)
>>>   {
>>>       BlockDriver *drv;
>>>       BlockDriverState *bs;
>>> +    bool old_can_write, new_can_write;
>>>         assert(reopen_state !=3D NULL);
>>>       bs =3D reopen_state->bs;
>>>       drv =3D bs->drv;
>>>       assert(drv !=3D NULL);
>>>   +    old_can_write =3D
>>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) &
>>> BDRV_O_INACTIVE);
>>> +
>>>       /* If there are any driver level actions to take */
>>>       if (drv->bdrv_reopen_commit) {
>>>           drv->bdrv_reopen_commit(reopen_state);
>>> @@ -2965,6 +2969,19 @@ void bdrv_reopen_commit(BDRVReopenState
>>> *reopen_state)
>>>       bs->read_only =3D !(reopen_state->flags & BDRV_O_RDWR);
>>>         bdrv_refresh_limits(bs, NULL);
>>> +
>>> +    new_can_write =3D
>>> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) &
>>> BDRV_O_INACTIVE);
>>> +    if (!old_can_write && new_can_write &&
>>> drv->bdrv_reopen_bitmaps_rw) {
>>> +        Error *local_err =3D NULL;
>>> +        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
>>> +            /* This is not fatal, bitmaps just left read-only, so
>>> all following
>>> +             * writes will fail. User can remove read-only bitmaps
>>> to unblock
>>> +             * writes.
>>> +             */
>> In a sense, it pretty much is fatal. We were asked to make the image
>> non-read-only but we failed because it effectively still is read-only.=

>>
>> But I can't think of anything better, and you're right, removing the
>> bitmaps would resolve the situation. This would require the user to kn=
ow
>> that updating the bitmaps was the issue, and local_err may not actuall=
y
>> reflect that.
>>
>>> +            error_report_err(local_err);
>> So I'd prepend this with something like "$node_name: Failed to make
>> dirty bitmaps writable", and maybe append a hint like "Removing all
>> persistent dirty bitmaps from this node will allow writing to it".
>=20
> Ok for prepending, but I don't want to add last note, as for the user i=
t
> may better to retry an operation, leading reopening image rw..

Which operation do you mean? The reopening? Because that operation
already "succeeded" at this point, so you can't retry it...

Max


--8AjQrjfc34LEQalSrEjpw1jHjolpB4MDh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZQASkEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMm0
B/sGX57q0lelpBZQ548qELViv/bzku3MLqI0nc9CrZEON2BgdHqslqHSHuq1ZnxY
WnaXvborpskXicNyv6tpMp6vrBsTrkPLY/LFxXFcWJH1gcqGretSUwY8ZlMt4aEb
J29VbWLiDc3LdyVWNcBdWyFUE8u1zpS/vdISiE2dLruPGD+nJA6lxIs2jQLu5ToK
dNGYEzB3q0iRrzcohZUEj8UOJqNfAagh5DhXfNyDh9e56tCyHNxDsCZPTrNyovIL
ao9D9GEUflW+kDnhRiAlrefgVSuU1rfj+xJN/6/ulTRGU8z6m9vcQZnvcFXHRsZt
Z7vqxXuNjBV8dD492xQyn4w0
=JI6+
-----END PGP SIGNATURE-----

--8AjQrjfc34LEQalSrEjpw1jHjolpB4MDh--
