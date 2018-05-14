Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIAdn-0003vx-2s
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIAdm-0007bK-0z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 06:23:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
	<20180514064139.GB16389@lemon.usersys.redhat.com>
	<9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
Message-ID: <37ec5d93-9830-8d49-d1db-74d3d359b2ca@virtuozzo.com>
Date: Mon, 14 May 2018 13:23:21 +0300
MIME-Version: 1.0
In-Reply-To: <9a59b786-2351-e8ae-f582-5e436ce0383c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Restoring bitmaps after failed/cancelled migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

14.05.2018 13:09, Vladimir Sementsov-Ogievskiy wrote:
> 14.05.2018 09:41, Fam Zheng wrote:
>> On Wed, 04/18 17:00, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all.
>>>
>>> We now have the following problem:
>>>
>>> If dirty-bitmaps migration capability is enabled, persistance flag is
>>> dropped for all migrated bitmaps, to prevent their storing to the 
>>> storage on
>>> inactivate.
>> Why do we prevent source storing persistent bitmaps by clearing the 
>> flag instead
>> of making the bitmap code more BDRV_O_INACTIVE-aware, so it is _not_ 
>> stored
>> when/after inactivation?
>
> Bitmaps are stored exactly on inactivation. So, we need some
> flag, that on following inactivation, we don't want to save them. And 
> this flag
> is .persistent flag.
>
> Of course, we can't save them if BDRV_O_INACTIVE is already set
>
>>
>>> It works ok, persistence itself is migrated through the
>>> migration channel. But on source, bitmaps becomes not persistent, so 
>>> if we,
>>> for some reasons, want to continue using source vm, we'll lose 
>>> bitmaps on
>>> stop/start.
>>>
>>> It's simple to fix it: just make bitmaps persistent again on invalidate
>>> [1].. But I have some questions.
>>>
>>> 1. What are possible cases? I think about the following:
>>>
>>> a. migration cancel or fail, then invalidate
>>> b. migration success, then qmp cont => invalidate
>> Is this "cont" on the source even though dst is already up? How will 
>> this work?
>> Isn't it expected that dst is using the image?
>
> Dr. David described this case, look at his answer.
>
>>
>>> c. migration success, then stop/start (there was no invalidate, so 
>>> [1] will
>>> not work)
>>>
>>>
>>> 2. Is it safe at all, saving bitmaps after inactivate, even without
>>> persistence?
>> This is not safe. No I/O should be done to the image after inactivation.
>>
>>> Inactive disk implies, that it may be changed by somebody other, 
>>> isn't it?
>> Yes.
>>
>>> Is it possible, that target will change the disk, and then we return 
>>> control
>>> to the source? In this case bitmaps will be invalid. So, should not 
>>> we drop
>>> all the bitmaps on inactivate?
>> Yes, dropping all live bitmaps upon inactivate sounds reasonable. If 
>> the dst
>> fails to start, and we want to resume VM at src, we could 
>> (optionally?) reload
>> the persistent bitmaps, I guess.
>
> Reload from where? We didn't store them.
>
> So, you agree, that dropping all bitmaps after inactivation is good 
> idea.. The second question, is it possible to not drop them? Is there 
> a way, to check that disk was not changed after pair of 
> inactivate-invalidate? I have an idea:
> we can create small-bitmap, which will not migrate through migration 
> channel, but remain persistent. It will be very small (big 
> granularity, to not increase downtime of migration), so after 
> invalidate we can check this bitmap. If it is empty, we are happy, we 
> can "activate" all our bitmaps and make them persistent again. If not, 
> we have two ways:
>
> 1. drop all bitmaps
> 2. merge small-bitmap to all our bitmaps

However, we must not start source, if disk was changed, as memory and 
devices states will not correspond to disk. So, such a small bitmap may 
be used to check, can we start source or not.

>
>>
>>> -- 
>>> Best regards,
>>> Vladimir
>>>
>
>


-- 
Best regards,
Vladimir
