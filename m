Received: from eggs.gnu.org ([2001:4830:134:3::10]:48115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyt7-0005Fo-PE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtyt6-0003HW-Iw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:27:13 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
	<2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
	<20170918100626.GE31063@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
Date: Mon, 18 Sep 2017 18:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170918100626.GE31063@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="baU0SGru35xgHo0t7o6fjImp82anbGQHP"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 15/18] block/mirror: Add
 active mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--baU0SGru35xgHo0t7o6fjImp82anbGQHP
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
Subject: Re: [Qemu-block] [PATCH 15/18] block/mirror: Add active mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-16-mreitz@redhat.com>
 <20170914155738.GE7370@stefanha-x1.localdomain>
 <2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
 <20170918100626.GE31063@stefanha-x1.localdomain>
In-Reply-To: <20170918100626.GE31063@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-18 12:06, Stefan Hajnoczi wrote:
> On Sat, Sep 16, 2017 at 03:58:01PM +0200, Max Reitz wrote:
>> On 2017-09-14 17:57, Stefan Hajnoczi wrote:
>>> On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
>>>> This patch implements active synchronous mirroring.  In active mode,=
 the
>>>> passive mechanism will still be in place and is used to copy all
>>>> initially dirty clusters off the source disk; but every write reques=
t
>>>> will write data both to the source and the target disk, so the sourc=
e
>>>> cannot be dirtied faster than data is mirrored to the target.  Also,=

>>>> once the block job has converged (BLOCK_JOB_READY sent), source and
>>>> target are guaranteed to stay in sync (unless an error occurs).
>>>>
>>>> Optionally, dirty data can be copied to the target disk on read
>>>> operations, too.
>>>>
>>>> Active mode is completely optional and currently disabled at runtime=
=2E  A
>>>> later patch will add a way for users to enable it.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  qapi/block-core.json |  23 +++++++
>>>>  block/mirror.c       | 187 ++++++++++++++++++++++++++++++++++++++++=
+++++++++--
>>>>  2 files changed, 205 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index bb11815608..e072cfa67c 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -938,6 +938,29 @@
>>>>    'data': ['top', 'full', 'none', 'incremental'] }
>>>> =20
>>>>  ##
>>>> +# @MirrorCopyMode:
>>>> +#
>>>> +# An enumeration whose values tell the mirror block job when to
>>>> +# trigger writes to the target.
>>>> +#
>>>> +# @passive: copy data in background only.
>>>> +#
>>>> +# @active-write: when data is written to the source, write it
>>>> +#                (synchronously) to the target as well.  In additio=
n,
>>>> +#                data is copied in background just like in @passive=

>>>> +#                mode.
>>>> +#
>>>> +# @active-read-write: write data to the target (synchronously) both=

>>>> +#                     when it is read from and written to the sourc=
e.
>>>> +#                     In addition, data is copied in background jus=
t
>>>> +#                     like in @passive mode.
>>>
>>> I'm not sure the terms "active"/"passive" are helpful.  "Active commi=
t"
>>> means committing the top-most BDS while the guest is accessing it.  T=
he
>>> "passive" mirror block still works on the top-most BDS while the gues=
t
>>> is accessing it.
>>>
>>> Calling it "asynchronous" and "synchronous" is clearer to me.  It's a=
lso
>>> the terminology used in disk replication (e.g. DRBD).
>>
>> I'd be OK with that, too, but I think I remember that in the past at
>> least Kevin made a clear distinction between active/passive and
>> sync/async when it comes to mirroring.
>>
>>> Ideally the user wouldn't have to worry about async vs sync because Q=
EMU
>>> would switch modes as appropriate in order to converge.  That way
>>> libvirt also doesn't have to worry about this.
>>
>> So here you mean async/sync in the way I meant it, i.e., whether the
>> mirror operations themselves are async/sync?
>=20
> The meaning I had in mind is:
>=20
> Sync mirroring means a guest write waits until the target write
> completes.

I.e. active-sync, ...

> Async mirroring means guest writes completes independently of target
> writes.

=2E.. i.e. passive or active-async in the future.

So you really want qemu to decide whether to use active or passive mode
depending on what's enough to let the block job converge and not
introduce any switch for the user?

I'm not sure whether I like this too much, mostly because "libvirt
doesn't have to worry" doesn't feel quite right to me.  If we don't make
libvirt worry about this, then qemu has to worry.  I'm not sure whether
that's any better.

I think this really does get into policy territory.  Just switching to
active mode the instant target writes are slower than source writes may
not be what the user wants: Maybe it's OK for a short duration because
they don't care about hard convergence too much.  Maybe they want to
switch to active mode already when "only" twice as much is written to
the target as to the source.

I think this is a decision the management layer (or the user) has to make=
=2E

Max


--baU0SGru35xgHo0t7o6fjImp82anbGQHP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm/88sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AIr0H/2Kagva2wDMY9PpqmTI9Ec/Oby/gFsTz
C1VF1kxfjGWXS48Crd5rCiRojQHKOykRSE+CsCVma6NKOr4r0gIWxI8fP+RU0lch
9rNojDhTq6EJJT8rF9F7t/5sKr9OUjJjNnepCQSvbDWt82NAeoMfvCtbhzHAJXCJ
vPAzVBIei1foONS3sdyL5ljukzrYXS8fNUzyBdQjGVweN4eNoC/A+KFq5b7+a9L9
uoyZAGCeQo5A9t0+4c/RT5oUzXH4ka6zTkVlxAXBipeZGwbTmRBNPIlWGet+gQWQ
ebPYt/jONOmK0AIVkzJJxvm90TQd0R9evxtrevfGVDEfRXqmbUCERTM=
=lk59
-----END PGP SIGNATURE-----

--baU0SGru35xgHo0t7o6fjImp82anbGQHP--
