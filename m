Received: from eggs.gnu.org ([2001:4830:134:3::10]:42123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2GDD-0002VJ-HB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2GD8-00016d-IK
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:34:11 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-16-mreitz@redhat.com>
	<20170914155738.GE7370@stefanha-x1.localdomain>
	<2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
	<20170918100626.GE31063@stefanha-x1.localdomain>
	<d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
	<20171010101622.GH4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2def1cd1-e1ca-772f-b026-235bae9bfd9d@redhat.com>
Date: Wed, 11 Oct 2017 14:33:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171010101622.GH4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hoL324xwiURJS57NhtpIFqjsVPrWHWAO9"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hoL324xwiURJS57NhtpIFqjsVPrWHWAO9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <2def1cd1-e1ca-772f-b026-235bae9bfd9d@redhat.com>
Subject: Re: [Qemu-block] [PATCH 15/18] block/mirror: Add active mirroring
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-16-mreitz@redhat.com>
 <20170914155738.GE7370@stefanha-x1.localdomain>
 <2f1c5239-0cde-d164-b803-ebf807e684f2@redhat.com>
 <20170918100626.GE31063@stefanha-x1.localdomain>
 <d6dbcebf-6dce-4803-0be0-a9f48a73a32f@redhat.com>
 <20171010101622.GH4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010101622.GH4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 12:16, Kevin Wolf wrote:
> Am 18.09.2017 um 18:26 hat Max Reitz geschrieben:
>> On 2017-09-18 12:06, Stefan Hajnoczi wrote:
>>> On Sat, Sep 16, 2017 at 03:58:01PM +0200, Max Reitz wrote:
>>>> On 2017-09-14 17:57, Stefan Hajnoczi wrote:
>>>>> On Wed, Sep 13, 2017 at 08:19:07PM +0200, Max Reitz wrote:
>>>>>> This patch implements active synchronous mirroring.  In active mod=
e, the
>>>>>> passive mechanism will still be in place and is used to copy all
>>>>>> initially dirty clusters off the source disk; but every write requ=
est
>>>>>> will write data both to the source and the target disk, so the sou=
rce
>>>>>> cannot be dirtied faster than data is mirrored to the target.  Als=
o,
>>>>>> once the block job has converged (BLOCK_JOB_READY sent), source an=
d
>>>>>> target are guaranteed to stay in sync (unless an error occurs).
>>>>>>
>>>>>> Optionally, dirty data can be copied to the target disk on read
>>>>>> operations, too.
>>>>>>
>>>>>> Active mode is completely optional and currently disabled at runti=
me.  A
>>>>>> later patch will add a way for users to enable it.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>  qapi/block-core.json |  23 +++++++
>>>>>>  block/mirror.c       | 187 ++++++++++++++++++++++++++++++++++++++=
+++++++++++--
>>>>>>  2 files changed, 205 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>>>> index bb11815608..e072cfa67c 100644
>>>>>> --- a/qapi/block-core.json
>>>>>> +++ b/qapi/block-core.json
>>>>>> @@ -938,6 +938,29 @@
>>>>>>    'data': ['top', 'full', 'none', 'incremental'] }
>>>>>> =20
>>>>>>  ##
>>>>>> +# @MirrorCopyMode:
>>>>>> +#
>>>>>> +# An enumeration whose values tell the mirror block job when to
>>>>>> +# trigger writes to the target.
>>>>>> +#
>>>>>> +# @passive: copy data in background only.
>>>>>> +#
>>>>>> +# @active-write: when data is written to the source, write it
>>>>>> +#                (synchronously) to the target as well.  In addit=
ion,
>>>>>> +#                data is copied in background just like in @passi=
ve
>>>>>> +#                mode.
>>>>>> +#
>>>>>> +# @active-read-write: write data to the target (synchronously) bo=
th
>>>>>> +#                     when it is read from and written to the sou=
rce.
>>>>>> +#                     In addition, data is copied in background j=
ust
>>>>>> +#                     like in @passive mode.
>>>>>
>>>>> I'm not sure the terms "active"/"passive" are helpful.  "Active com=
mit"
>>>>> means committing the top-most BDS while the guest is accessing it. =
 The
>>>>> "passive" mirror block still works on the top-most BDS while the gu=
est
>>>>> is accessing it.
>>>>>
>>>>> Calling it "asynchronous" and "synchronous" is clearer to me.  It's=
 also
>>>>> the terminology used in disk replication (e.g. DRBD).
>>>>
>>>> I'd be OK with that, too, but I think I remember that in the past at=

>>>> least Kevin made a clear distinction between active/passive and
>>>> sync/async when it comes to mirroring.
>>>>
>>>>> Ideally the user wouldn't have to worry about async vs sync because=
 QEMU
>>>>> would switch modes as appropriate in order to converge.  That way
>>>>> libvirt also doesn't have to worry about this.
>>>>
>>>> So here you mean async/sync in the way I meant it, i.e., whether the=

>>>> mirror operations themselves are async/sync?
>>>
>>> The meaning I had in mind is:
>>>
>>> Sync mirroring means a guest write waits until the target write
>>> completes.
>>
>> I.e. active-sync, ...
>>
>>> Async mirroring means guest writes completes independently of target
>>> writes.
>>
>> ... i.e. passive or active-async in the future.
>=20
> So we already have at least three different modes, sync/async doesn't
> quite cut it anyway. There's a reason why we have been talking about
> both active/passive and sync/async.
>=20
> When I was looking at the code, it actually occurred to me that there
> are more possible different modes than I thought there were: This patch=

> waits for successful completion on the source before it even attempts t=
o
> write to the destination.
>=20
> Wouldn't it be generally (i.e. in the success case) more useful if we
> start both requests at the same time and only wait for both to complete=
,
> avoiding to double the latency? If the source write fails, we're out of=

> sync, obviously, so we'd have to mark the block dirty again.

I've thought about it, but my issues were:

(1) What to do when something fails
and
(2) I didn't really want to start coroutines from coroutines...

As for (1)...  My notes actually say I've come to a conclusion: If the
target write fails, that's pretty much OK, because then the source is
newer than the target, which is normal for mirroring.  If the source
write fails, we can just consider the target outdated, too (as you've
said).  Also, we'll give an error to the guest, so it's clear that
something has gone wrong.

So (2) was the reason I didn't do it in this series.  I think it's OK to
add this later on and let future me worry about how to coordinate both
requests.

I guess I'd start e.g. the target operation as a new coroutine, then
continue the source operation in the original one, and finally yield
until the target operation has finished?

> By the way, what happens when the guest modifies the RAM during the
> request? Is it acceptable even for writes if source and target differ
> after a successful write operation? Don't we need a bounce buffer
> anyway?

Sometimes I think that maybe I shouldn't keep my thoughts to myself
after I've come to the conclusion "...naah, it's all bad anyway". :-)

When Stefan mentioned this for reads, I thought about the write
situation, yes.  My conclusion was that the guest would be required (by
protocol) to keep the write buffer constant while the operation is
running, because otherwise the guest has no idea what is going to be on
disk.  So it would be stupid for the guest to modify the write buffer the=
n.

But (1) depending on the emulated hardware, maybe the guest does have an
idea (e.g. some register that tells the guest which offset is currently
written) -- but with the structure of the block layer, I doubt that's
possible in qemu,

and (2) maybe the guest wants to be stupid.  Even if the guest doesn't
know what will end up on disk, we have to make sure that it's the same
on both source and target.

So, yeah, a bounce buffer would be good in all cases.

Max


--hoL324xwiURJS57NhtpIFqjsVPrWHWAO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneD6oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZFYH/R8iE2OCAx3xSJov+UMrkDrn8ar+y7Q6
1MHjQsmtxPb80h/n0yK40Jfg2VZc9Pek0zpf0QjIK0hd2z6YjEv4bQqNxP2wRH0q
Zyb051IZ+TCnbbaK0o9wX5xax+Agmy9wexElSiktBi+sSIK+h/nd1Z4dbC1+c4Wn
K/SBnsUoIVg8rfz/cW/TWGyVfRr+AmHhpCQ+MEzKKjY26Iib0uKCYp3R/jH0Uytk
SVbKXLcB05kTS+lm7HV0S2ozcTq48fjBtbgzhMZp6BhppxaHD69lDvS/l1IuURN5
4w1vWQe3qVapwAmqFaxgdYgtSqxu5jpz6f9FV8G47Sovvw4L6+E6puU=
=oi8t
-----END PGP SIGNATURE-----

--hoL324xwiURJS57NhtpIFqjsVPrWHWAO9--
