Received: from eggs.gnu.org ([2001:4830:134:3::10]:55401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFRq3-0008RZ-T5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFRq2-00087h-UZ
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:36:47 -0500
References: <20171110175457.30173-1-vsementsov@virtuozzo.com>
	<20171110200245.GJ5466@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <7ea276e4-1d42-9f86-07cf-4a565976f2d0@redhat.com>
Date: Thu, 16 Nov 2017 16:36:35 -0500
MIME-Version: 1.0
In-Reply-To: <20171110200245.GJ5466@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: test clearing
 unknown autoclear_features by qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, den@openvz.org, mreitz@redhat.com



On 11/10/2017 03:02 PM, Kevin Wolf wrote:
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
>>     block: Fix write/resize permissions for inactive images
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
> 
> I don't think you need to move the parent->role->activate() callback,
> but just the bdrv_set_perm() so that we request the correct permissions
> for operation without the BDRV_O_INACTIVE flag.
> 
> The following seems to work for me (including a fix for the test case,
> we don't seem to get a RESUME event). I'm not sure about the error paths
> yet. We should probably try do undo the permission changes there. I can
> have a closer look into this next week.
> 
> Kevin
> 

What's the status here, something we need to be paying attention to for
2.11?
