Received: from eggs.gnu.org ([2001:4830:134:3::10]:43243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFbQa-0001oa-Aa
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFbQZ-0001nR-0h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 02:51:08 -0500
References: <20171110175457.30173-1-vsementsov@virtuozzo.com>
	<20171110200245.GJ5466@localhost.localdomain>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3482183c-0a63-334c-4147-835a76802360@virtuozzo.com>
Date: Fri, 17 Nov 2017 10:50:54 +0300
MIME-Version: 1.0
In-Reply-To: <20171110200245.GJ5466@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: test clearing unknown
 autoclear_features by qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, dgilbert@redhat.com, quintela@redhat.com, den@openvz.org

10.11.2017 23:02, Kevin Wolf wrote:
> Am 10.11.2017 um 18:54 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Test clearing unknown autoclear_features by qcow2 on incoming
>> migration.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Hi all!
>>
>> This patch shows degradation, added in 2.10 in commit
>>
>> commit 9c5e6594f15b7364624a3ad40306c396c93a2145
>> Author: Kevin Wolf <kwolf@redhat.com>
>> Date:   Thu May 4 18:52:40 2017 +0200
>>
>>      block: Fix write/resize permissions for inactive images
>>
>> The problem:
>> When on incoming migration with shared storage we reopen image to RW mode
>> we call bdrv_invalidate_cache it firstly call drv->bdrv_invalidate_cache and
>> only after it, through "parent->role->activate(parent, &local_err);" we set
>> appropriate RW permission.
>>
>> Because of this, if drv->bdrv_invalidate_cache wants to write something
>> (image is RW and BDRV_O_INACTIVE is not set) it goes into
>> "bdrv_aligned_pwritev: Assertion `child->perm & BLK_PERM_WRITE' failed"
>>
>> One case, when qcow2_invalidate_cache wants to write
>> something - when it wants to clear some unknown autoclear features. So,
>> here is a test for it.
>>
>> Another case is when we try to migrate persistent dirty bitmaps through
>> shared storage, on invalidate_cache qcow2 will try to set DIRTY bit in
>> all loaded bitmaps.
>>
>> Kevin, what do you think? I understand that operation order should be changed
>> somehow in bdrv_invalidate_cache, but I'm not sure about how "parent->role->.."
>> things works and can we safely move this part from function end to the middle.
> I don't think you need to move the parent->role->activate() callback,
> but just the bdrv_set_perm() so that we request the correct permissions
> for operation without the BDRV_O_INACTIVE flag.
>
> The following seems to work for me (including a fix for the test case,
> we don't seem to get a RESUME event).

hmm, it works for me with RESUME..

> I'm not sure about the error paths
> yet. We should probably try do undo the permission changes there. I can
> have a closer look into this next week.
>
> Kevin
>
>
> diff --git a/block.c b/block.c
> index edc5bb9f9b..f530b630b6 100644
> --- a/block.c
> +++ b/block.c
> @@ -4178,7 +4178,17 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
>           }
>       }
>   
> +    /* Update permissions, they may differ for inactive nodes */
>       bs->open_flags &= ~BDRV_O_INACTIVE;
> +    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
> +    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_err);
> +    if (ret < 0) {
> +        bs->open_flags |= BDRV_O_INACTIVE;
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    bdrv_set_perm(bs, perm, shared_perm);
> +
>       if (bs->drv->bdrv_invalidate_cache) {
>           bs->drv->bdrv_invalidate_cache(bs, &local_err);
>           if (local_err) {
> @@ -4195,16 +4205,6 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
>           return;
>       }
>   
> -    /* Update permissions, they may differ for inactive nodes */
> -    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
> -    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_err);
> -    if (ret < 0) {
> -        bs->open_flags |= BDRV_O_INACTIVE;
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> -    bdrv_set_perm(bs, perm, shared_perm);
> -
>       QLIST_FOREACH(parent, &bs->parents, next_parent) {
>           if (parent->role->activate) {
>               parent->role->activate(parent, &local_err);
> diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
> index 9ffbc723c2..4116ebc92b 100755
> --- a/tests/qemu-iotests/196
> +++ b/tests/qemu-iotests/196
> @@ -53,7 +53,10 @@ class TestInvalidateAutoclear(iotests.QMPTestCase):
>               f.write(b'\xff')
>   
>           self.vm_b.launch()
> -        self.assertNotEqual(self.vm_b.event_wait("RESUME"), None)
> +        while True:
> +            result = self.vm_b.qmp('query-status')
> +            if result['return']['status'] == 'running':
> +                break
>   
>           with open(disk, 'rb') as f:
>               f.seek(88)


-- 
Best regards,
Vladimir
