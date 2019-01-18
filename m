Received: from eggs.gnu.org ([209.51.188.92]:48239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkSuJ-0000Gl-2Y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gkSuI-0007pj-2b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:05:55 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-8-vsementsov@virtuozzo.com>
	<5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
	<4899ffae-b6f6-f2ac-1f91-83e73ca662cf@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f99365c9-2e64-386e-0c44-80e49c7c6500@redhat.com>
Date: Fri, 18 Jan 2019 13:05:14 +0100
MIME-Version: 1.0
In-Reply-To: <4899ffae-b6f6-f2ac-1f91-83e73ca662cf@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aKenb6s6NXDtbGzu0EXMIjAMhIrSov8sb"
Subject: Re: [Qemu-devel] [PATCH v5 07/11] block: introduce backup-top
 filter driver
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
--aKenb6s6NXDtbGzu0EXMIjAMhIrSov8sb
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
Message-ID: <f99365c9-2e64-386e-0c44-80e49c7c6500@redhat.com>
Subject: Re: [PATCH v5 07/11] block: introduce backup-top filter driver
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-8-vsementsov@virtuozzo.com>
 <5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
 <4899ffae-b6f6-f2ac-1f91-83e73ca662cf@virtuozzo.com>
In-Reply-To: <4899ffae-b6f6-f2ac-1f91-83e73ca662cf@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.01.19 13:13, Vladimir Sementsov-Ogievskiy wrote:
> 16.01.2019 19:02, Max Reitz wrote:
>> On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
>>> Backup-top filter does copy-before-write operation. It should be
>>> inserted above active disk and has a target node for CBW, like the
>>> following:
>>>
>>>      +-------+
>>>      | Guest |
>>>      +---+---+
>>>          |r,w
>>>          v
>>>      +---+-----------+  target   +---------------+
>>>      | backup_top    |---------->| target(qcow2) |
>>>      +---+-----------+   CBW     +---+-----------+
>>>          |
>>> backing |r,w
>>>          v
>>>      +---+---------+
>>>      | Active disk |
>>>      +-------------+
>>>
>>> The driver will be used in backup instead of write-notifiers.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/backup-top.h  |  43 +++++++
>>>   block/backup-top.c  | 306 +++++++++++++++++++++++++++++++++++++++++=
+++
>>>   block/Makefile.objs |   2 +
>>>   3 files changed, 351 insertions(+)
>>>   create mode 100644 block/backup-top.h
>>>   create mode 100644 block/backup-top.c
>>
>> Looks good to me overall, comments below:
>>
>=20
> [..]
>=20
>  >> +static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint6=
4_t offset,
>  >> +                                          uint64_t bytes)
>=20
> [..]
>=20
>>> +
>>> +    /*
>>> +     * Features to be implemented:
>>> +     * F3. parallelize copying loop
>>> +     * F4. detect zeros
>>
>> Isn't there detect-zeroes for that?
>=20
> Hmm interesting note. I've placed F4 here, as we do have detecting zero=
s by hand in
> current backup code. Should we drop it from backup, or switch to just e=
nabling
> detect-zeros on target?

Off the top of my head I don't know a reason why we wouldn't just set
detect-zeroes.  Maybe because there may be other writers to target which
should not use that setting?  But that scenario just seems wrong to me.

>>> +     * F5. use block_status ?
>>> +     * F6. don't copy clusters which are already cached by COR [see =
F1]
>>> +     * F7. if target is ram-cache and it is full, there should be a =
possibility
>>> +     *     to drop not necessary data (cached by COR [see F1]) to ha=
ndle CBW
>>> +     *     fast.
>>
>> Another idea: Read all dirty data from bs->backing (in parallel, more =
or
>> less), and then perform all writes (to bs->backing and s->target) in
>> parallel as well.
>>
>> (So the writes do not have to wait on one another)
>=20
> Yes, we can continue guest write after read part of CBW, but we can't d=
o it always,
> as we want to limit RAM usage to store all these in-flight requests.

But this code here already allocates a buffer to cover all of the area.

> And I think,
> in scheme with ram-cache, ram-cache itself should be actually a kind of=
 storage
> for in-flight requests. And in this terminology, if ram-cache is full, =
we can't
> proceed with guest write. It's the same as we reached limit on in-fligh=
t requests
> count.
>=20
> [..]
>=20
>>> +
>>> +static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,=

>>> +                                                  int64_t offset, in=
t bytes)
>>
>> (Indentation)
>=20
> looks like it was after renaming
> fleecing_hook
> to
> backup_top
>=20
> will fix all

Ah :-)

> [..]
>=20
>>> +
>>> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
>>> +{
>>> +    if (!bs->backing) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    return bdrv_co_flush(bs->backing->bs);
>>
>> Why not the target as well?
>=20
> Should we? It may be guest flush, why to flush backup target on it?

Hm...  Well, the current backup code didn't flush the target, and the
mirror filter doesn't either.  OK then.

Max

> [..]
>=20
>>> +static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c=
,
>>> +                                       const BdrvChildRole *role,
>>> +                                       BlockReopenQueue *reopen_queu=
e,
>>> +                                       uint64_t perm, uint64_t share=
d,
>>> +                                       uint64_t *nperm, uint64_t *ns=
hared)
>>
>> (Indentation)
>>
>>> +{
>>> +    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, share=
d, nperm,
>>> +                              nshared);
>>> +
>>> +    if (role =3D=3D &child_file) {
>>> +        /*
>>> +         * share write to target, to not interfere guest writes to i=
t's disk
>>
>> *interfere with guest writes to its disk
>>
>>> +         * which will be in target backing chain
>>> +         */
>>> +        *nshared =3D *nshared | BLK_PERM_WRITE;
>>> +        *nperm =3D *nperm | BLK_PERM_WRITE;
>>
>> Why do you need to take the write permission?  This filter does not
>> perform any writes unless it receives writes, right?  (So
>> bdrv_filter_default_perms() should take care of this.)
>=20
> Your commit shed a bit of light on permission system for me) Ok, I'll c=
heck, if
> that work without PERM_WRITE here.
>=20
>>
>>> +    } else {
>>> +        *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
>>> +    }
>>> +}
>>> +
>=20
> Thank you! For other comments: argee or will-try
>=20
>=20



--aKenb6s6NXDtbGzu0EXMIjAMhIrSov8sb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxBwPoACgkQ9AfbAGHV
z0C2Ugf+PJGbbnYUkvHJCWYDwplhWsrwb9g7WLly4l59AOHIRvVq5u4Ng5iWYovq
T4Xsn/9pDAjEsjx6PLz/+AIRaACJ7yEBdAw3IzcHTdOxupu9l32PCH7n+enok30O
/HPd3VHAmpJ0OczkF6nWWkLfGhXAc6XMbYAI8X/F0p2cUPF94CN0gY3Hibbe0OBM
gyLFCRtZ5Xw0MlfattpKJIOSVKjTL3LkRSIF/1GiT33nNef9MMAO3JZU1d2zHB09
xk/WXuFB/HpOpOsKkJySErUcGXTYtVZETx5hPxt/7+OvtLM39aKKe3zdhyGG+Iey
a3ScXsmVeWttxMGesZBkmOWqNM94pA==
=q/bQ
-----END PGP SIGNATURE-----

--aKenb6s6NXDtbGzu0EXMIjAMhIrSov8sb--
