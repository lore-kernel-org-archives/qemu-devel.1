Received: from eggs.gnu.org ([2001:4830:134:3::10]:58191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFazq-0006qb-06
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFazo-00034G-Ve
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:51:14 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:23579 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFazo-00033v-KB
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:51:12 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
	<33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <47488066-bd0f-834d-85d8-63d7289cb0fd@virtuozzo.com>
Date: Tue, 30 May 2017 09:50:57 +0300
MIME-Version: 1.0
In-Reply-To: <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
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

Thank you for this scenario. Hmm.

So, as I need guarantee that image and bitmap are unchanged, 
bdrv_set_dirty should return error and fail the whole write. Ok?

29.05.2017 21:35, Max Reitz wrote:
> On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
>> It will be needed in following commits for persistent bitmaps.
>> If bitmap is loaded from read-only storage (and we can't mark it
>> "in use" in this storage) corresponding BdrvDirtyBitmap should be
>> read-only.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/dirty-bitmap.c         | 16 ++++++++++++++++
>>   include/block/dirty-bitmap.h |  3 +++
>>   2 files changed, 19 insertions(+)
> Revisiting this again after the whole series: So you never really make
> sure that the read-only bitmaps are not written to (except for these
> assertions). The idea is that you only set it for read-only BDS and
> read-only BDS are never written to. But that assumption is not true,
> generally, and can be broken e.g. using a commit job:
>
> $ ./qemu-img create -f qcow2 backing.qcow2 64M
> Formatting 'backing.qcow2', fmt=qcow2 size=67108864 encryption=off
>      cluster_size=65536 lazy_refcounts=off refcount_bits=16
> $ ./qemu-img create -f qcow2 -b backing.qcow2 top.qcow2
> Formatting 'top.qcow2', fmt=qcow2 size=67108864
>      backing_file=backing.qcow2 encryption=off cluster_size=65536
>      lazy_refcounts=off refcount_bits=16
> $ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 9, "major": 2},
> "package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
> {'execute': 'qmp_capabilities'}
> {"return": {}}
> {'execute': 'blockdev-add',
>   'arguments': {'node-name': 'backing-node', 'driver': 'qcow2',
>                 'file': {'driver': 'file', 'filename': 'backing.qcow2'}}}
> {"return": {}}
> {'execute': 'block-dirty-bitmap-add',
>   'arguments': {'node': 'backing-node', 'name': 'foo',
>                 'persistent': true, 'autoload': true}}
> {"return": {}}
> {'execute': 'blockdev-del', 'arguments': {'node-name': 'backing-node'}}
> {"return": {}}
> {'execute': 'blockdev-add',
>   'arguments': {'node-name': 'top-node', 'driver': 'qcow2',
>                 'file': {'driver': 'file', 'filename': 'top.qcow2'}}}
> {"return": {}}
> {'execute': 'human-monitor-command',
>   'arguments': {'command-line': 'qemu-io top-node "write 0 64k"'}}
> wrote 65536/65536 bytes at offset 0
> 64 KiB, 1 ops; 0.0079 sec (7.852 MiB/sec and 125.6281 ops/sec)
> {"return": ""}
> {'execute': 'block-commit',
>   'arguments': {'device': 'top-node', 'job-id': 'commit-job'}}
> {"return": {}}
> qemu-system-x86_64: block/dirty-bitmap.c:571: bdrv_set_dirty: Assertion
> `!bdrv_dirty_bitmap_readonly(bitmap)' failed.
> [1]    10872 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
> stdio
>
> So there needs to be something else than just assertions to make sure
> that read-only bitmaps are never written to.
>
> Max
>

-- 
Best regards,
Vladimir
