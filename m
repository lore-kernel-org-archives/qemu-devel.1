Received: from eggs.gnu.org ([2001:4830:134:3::10]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW1vr-00035E-QY
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW1vo-0006Mv-MK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:55:35 -0400
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
	<20180614104656.GD8564@localhost.localdomain>
	<8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
	<20180621142500.GJ5024@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <14e2ebb9-8d4f-3079-83f0-a4b6bd60e9d6@virtuozzo.com>
Date: Thu, 21 Jun 2018 18:55:25 +0300
MIME-Version: 1.0
In-Reply-To: <20180621142500.GJ5024@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] bug in reopen arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

21.06.2018 17:25, Kevin Wolf wrote:
> Am 15.06.2018 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> 14.06.2018 13:46, Kevin Wolf wrote:
>>> Am 12.06.2018 um 20:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Hi all!
>>>>
>>>> I've faced the following problem:
>>>>
>>>>   =C2=A0=C2=A0=C2=A0 1. create image with dirty bitmap, a.qcow2 (start=
 qemu and run qmp
>>>>   =C2=A0=C2=A0=C2=A0 command block-dirty-bitmap-add)
>>>>
>>>>   =C2=A0=C2=A0=C2=A0 2. run the following commands:
>>>>
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img create -f qcow2 =
-b a.qcow2 b.qcow2 10M
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-io -c 'write 0 512' =
b.qcow2
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu-img commit b.qcow2
>>>>
>>>>   =C2=A0=C2=A0=C2=A0 3. last command fails with the following output:
>>>>
>>>> Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_file=3Da.=
qcow2
>>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>>> wrote 512/512 bytes at offset 0
>>>> 512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec)
>>>> qemu-img: #block397: Failed to make dirty bitmaps writable: Can't upda=
te
>>>> bitmap directory: Operation not permitted
>>>> qemu-img: Block job failed: Operation not permitted
>>>>
>>>> And problem is that children are reopened _after_ parent. But qcow2 re=
open
>>>> needs write access to its file, to write IN_USE flag to dirty-bitmaps
>>>> extension.
>>> I was aware of a different instance of this problem: Assume a qcow2
>>> image with an unknown autoclear flag (so it will be cleared on r/w
>>> open), which is first opened r/o and then reopened r/w. This will fail
>>> because .bdrv_reopen_prepare doesn't have the permissions yet.
>> Hm.. If I understand correctly qcow2_reopen_prepare doesn't deal with
>> autoclear flags, as it doesn't call qcow2_do_open.
> Hm, right, not sure what I really meant back then when I added it to my
> to-do list... Maybe I confused reopen and invalidate_cache.
>
>>> Simply changing the order won't fix this because in the r/w -> r/o, the
>>> driver will legitimately flush its caches in .bdrv_reopen_prepare, and
>>> for this it still needs to be able to write.
>>>
>>> We may need to have a way for nodes to access both the old and the new
>>> state of their children. I'm not completely sure how to achieve this
>>> best, though.
>>>
>>> When I thought only of permissions, the obvious and simple thing to do
>>> was to just get combined permissions for the old and new state, i.e.
>>> 'old_perm | new_perm' and 'old_shared & new_shared'. But I don't think
>>> this is actually enough when the child node switches between a r/w and
>>> a r/o file descriptor because even though QEMU's permission system woul=
d
>>> allow the write, you still can't successfully write to a r/o file
>>> descriptor.
>>>
>>> Kevin
>> Maybe we want two .bdrv_reopen_prepare: .bdrv_reopen_prepare_before_chil=
dren
>> and .bdrv_reopen_prepare_after_children. But to write something in
>> reopen_prepare, we need to move bdrv_set_perm from reopen_commit to
>> .. Is it possible?
> Getting the permission problems out of the way can be solved by changing
> permissions twice, like I said above: First to the combined permissions
> of old and new, and finally to only the new permissions.
>
> The problem I see with .bdrv_reopen_prepare_after_children is that I
> don't see how it actually buys you anything: Even if the children
> already prepared the reopen, any access of the child node still refers
> to the old file descriptor because the new one only becomes valid with
> .bdrv_reopen_commit.
>
>> Now, I've found the following workaround, what do you think about someth=
ing
>> like this as a temporary fix:
> I honestly don't understand why this workaround makes any difference.

with this patch, commit for children will be called earlier than for=20
parent, so, when reopening bitmaps rw (which is done in commit) bs->file=20
will be already completely reopened rw, and all works.

> Shouldn't all .bdrv_reopen_prepare() callbacks still work on the old
> version of the child node?

yes, but problem is with commit.

>
> Even if I understood the reason, it looks a bit too hacky probably.
> Maybe I'll change may opinion once I understand it.
>
> Kevin


--=20
Best regards,
Vladimir
