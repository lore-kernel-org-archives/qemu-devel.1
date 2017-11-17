Received: from eggs.gnu.org ([2001:4830:134:3::10]:58096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eFgxw-00036e-5B
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eFgxt-0004MA-Iw
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:45:56 -0500
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
	<20171117123059.GB4795@localhost.localdomain>
	<75e64a04-dfd4-2e66-dad6-95c8f012ad6f@openvz.org>
	<20171117134247.GE4795@localhost.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <097511ea-ec81-c801-6a39-07f77663abde@openvz.org>
Date: Fri, 17 Nov 2017 16:45:46 +0300
MIME-Version: 1.0
In-Reply-To: <20171117134247.GE4795@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com

On 11/17/2017 04:42 PM, Kevin Wolf wrote:
> Am 17.11.2017 um 13:58 hat Denis V. Lunev geschrieben:
>> On 11/17/2017 03:30 PM, Kevin Wolf wrote:
>>> Am 23.10.2017 um 11:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> Snapshot-switch actually changes active state of disk so it should
>>>> reflect on dirty bitmaps. Otherwise next incremental backup using
>>>> these bitmaps will be invalid.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> We discussed this quite a while ago, and I'm still not convinced that
>>> this approach makes sense.
>>>
>>> Can you give just one example of a use case where dirtying the whole
>>> bitmap while loading a snapshot is the desired behaviour?
>>>
>>> I think the most useful behaviour would be something where the bitmaps
>>> themselves are snapshotted, too. But for the time being, the easiest and
>>> safest solution might just be to error out in any snapshot operations
>>> if any bitmaps are in use.
>>>
>> The problem is that snapshotting of bitmaps will just provide wrong
>> result.
> Only if the user does the wrong thing. :-)
>
>> Let us assume that we have bitmap named A.
>>
>> The user has started it and made full backup B.
>> The user made snapshot S. At this moment bitmap A is saved as A' to bitmap.
>> The user has made incremental backup B1. A is reset to 0.
>> The user has made incremental backup B2. A is reset to 0 again.
>>
>> At this moment the user has reverted to snapshot S.
>> What we need to make incremental backup at the moment?
> The important point here is that the backup that you should make is not
> incremental compared to B2, but to B (i.e. the last backup at the point
> when the snapshot was made).
>
> If your snapshot chain branches, your backups have to branch, too.
>
>> The difference in between states B2 and S. This is __for sure__
>> not A'. Thus saving of the bitmap at the moment is quite
>> useless and we need to reset bitmap to full.
> A' still contains the differences between B and the point when S was
> created. So if you take a new incremental backup B'1 based on B, the
> correct bitmap to use would be A'.
>
> But I agree that this is complicated and probably easy to misuse, so
> just erroring out is a serious option. And if we do this, at least we
> don't set a bad solution in stone and can always add a better solution
> if we can later think of one.
>
> I just don't think that marking everything dirty is a good solution. It
> forces the user to make a full backup, so we could just as well ask the
> user to delete the bitmap before they load a snapshot.
>
> Kevin
Agree. This is also an option.

Den
