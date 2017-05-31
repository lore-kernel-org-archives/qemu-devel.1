Received: from eggs.gnu.org ([2001:4830:134:3::10]:33235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG4ct-0006uu-2B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dG4cn-0008BD-Hh
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:29:31 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2655 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dG4cn-0008Af-1B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:29:25 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
	<47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
	<18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <67feecd0-ef75-5e26-aa7c-a70b69fde0ef@virtuozzo.com>
Date: Wed, 31 May 2017 17:29:04 +0300
MIME-Version: 1.0
In-Reply-To: <18c4b1ad-bc30-a598-36b8-612c01b00dee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

31.05.2017 16:43, Max Reitz wrote:
> On 2017-05-30 08:50, Vladimir Sementsov-Ogievskiy wrote:
>> Thank you for this scenario. Hmm.
>>
>> So, as I need guarantee that image and bitmap are unchanged,
>> bdrv_set_dirty should return error and fail the whole write. Ok?
> I don't know. That would mean that you couldn't commit to an image that
> has a persistent auto-loading bitmap, which doesn't seem very nice to me.
>
> I'm not quite sure what to do myself. So first I'd definitely want the
> commit operation to succeed. That means we'd have to automatically make
> the bitmap non-readonly once we write to it. The "readonly" flag would
> then be an "unchanged" flag, rather, to signify that the bitmap has not
> been changed since it was loaded, which means that it does not need to
> be written back to the image file.
>
> Now the issue remains that if you modify a persistent bitmap that is
> stored in an image file that is opened RO when it's closed, you won't be
> able to write the modifications back.
>
> So in addition, I guess we'd need to "flush" all persistent bitmaps
> (that is, write all modifications back to the file and set the
> "unchanged" flag (you could also call it "dirty" and then mean the
> opposite) for each bitmap) not only when the image is closed or
> invalidated, but also when it is reopened read-only.
>
> (block-commit reopens the backing BDS R/W, then writes to them, thus
> modifying the dirty bitmaps, and finally reopens the BDS as read-only;
> before that happens, we will have to flush the modified bitmap data.)

Ok, understand.

We need to consider also setting in_use flag in the image. We _must not_ 
write to image with dirty bitmap,
if in_use flag of this dirty bitmap is not set, as in case of something 
fail we will have image with wrong bitmap with
unset in_use flag (which looks ok).

I see two ways to handle it:

variant 1:
1. readonly field stays as is (see v19, with normal errors, not only 
asserts)
2. immediately after reopening r/w we do "reopening bitmaps r/w", i.e. 
set in_use in the image and set BdrvDirtyBitmap.readonly = false
3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.e. 
save them into the image and set BdrvDirtyBitmap.readonly = true

variant 2:
1. instead of 'readonly' add 'dirty' field, set dirty to 0 for all 
bitmaps on create
2. before write/discard check this field in all related bitmaps, and if 
dirty=0 (and persistent=1), write IN_USE flag into the image first, set 
dirty=1, and only then do write. (if writing IN_USE=1 failed, fail the 
whole write)
3. in reopen_prepare, if reopening r-o do "reopening bitmaps r-o", i.e. 
save them into the image and set BdrvDirtyBitmap.dirty = 0


>
> Max
>
>> 29.05.2017 21:35, Max Reitz wrote:
>>> On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
>>>> It will be needed in following commits for persistent bitmaps.
>>>> If bitmap is loaded from read-only storage (and we can't mark it
>>>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>>>> read-only.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    block/dirty-bitmap.c         | 16 ++++++++++++++++
>>>>    include/block/dirty-bitmap.h |  3 +++
>>>>    2 files changed, 19 insertions(+)
>>> Revisiting this again after the whole series: So you never really make
>>> sure that the read-only bitmaps are not written to (except for these
>>> assertions). The idea is that you only set it for read-only BDS and
>>> read-only BDS are never written to. But that assumption is not true,
>>> generally, and can be broken e.g. using a commit job:
>>>
>>> $ ./qemu-img create -f qcow2 backing.qcow2 64M
>>> Formatting 'backing.qcow2', fmt=qcow2 size=67108864 encryption=off
>>>       cluster_size=65536 lazy_refcounts=off refcount_bits=16
>>> $ ./qemu-img create -f qcow2 -b backing.qcow2 top.qcow2
>>> Formatting 'top.qcow2', fmt=qcow2 size=67108864
>>>       backing_file=backing.qcow2 encryption=off cluster_size=65536
>>>       lazy_refcounts=off refcount_bits=16
>>> $ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
>>> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 9, "major": 2},
>>> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
>>> {'execute': 'qmp_capabilities'}
>>> {"return": {}}
>>> {'execute': 'blockdev-add',
>>>    'arguments': {'node-name': 'backing-node', 'driver': 'qcow2',
>>>                  'file': {'driver': 'file', 'filename': 'backing.qcow2'}}}
>>> {"return": {}}
>>> {'execute': 'block-dirty-bitmap-add',
>>>    'arguments': {'node': 'backing-node', 'name': 'foo',
>>>                  'persistent': true, 'autoload': true}}
>>> {"return": {}}
>>> {'execute': 'blockdev-del', 'arguments': {'node-name': 'backing-node'}}
>>> {"return": {}}
>>> {'execute': 'blockdev-add',
>>>    'arguments': {'node-name': 'top-node', 'driver': 'qcow2',
>>>                  'file': {'driver': 'file', 'filename': 'top.qcow2'}}}
>>> {"return": {}}
>>> {'execute': 'human-monitor-command',
>>>    'arguments': {'command-line': 'qemu-io top-node "write 0 64k"'}}
>>> wrote 65536/65536 bytes at offset 0
>>> 64 KiB, 1 ops; 0.0079 sec (7.852 MiB/sec and 125.6281 ops/sec)
>>> {"return": ""}
>>> {'execute': 'block-commit',
>>>    'arguments': {'device': 'top-node', 'job-id': 'commit-job'}}
>>> {"return": {}}
>>> qemu-system-x86_64: block/dirty-bitmap.c:571: bdrv_set_dirty: Assertion
>>> `!bdrv_dirty_bitmap_readonly(bitmap)' failed.
>>> [1]    10872 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
>>> stdio
>>>
>>> So there needs to be something else than just assertions to make sure
>>> that read-only bitmaps are never written to.
>>>
>>> Max
>>>
>

-- 
Best regards,
Vladimir
