Received: from eggs.gnu.org ([2001:4830:134:3::10]:60723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCRx-0008Gt-7t
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 13:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHCRs-0001Md-Cd
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 13:02:53 -0400
References: <20170530081723.29205-1-vsementsov@virtuozzo.com>
	<20170530081723.29205-10-vsementsov@virtuozzo.com>
	<04df6354-c902-9514-f56f-9063168a6a75@redhat.com>
	<72e09ee4-ef22-ed79-b881-bed1ad255392@virtuozzo.com>
	<c232fd02-524c-29c4-6577-37101a2638e5@redhat.com>
	<d587d556-4807-46ff-3596-4c1c99edbcef@virtuozzo.com>
	<b5d84158-b1f9-d497-3231-be76565cb3b3@virtuozzo.com>
	<30533fc6-e32f-9d9c-6030-d923e0734ce7@virtuozzo.com>
	<450ae852-a5c4-17f1-2027-f68bf91262aa@redhat.com>
From: Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
Message-ID: <c35f6975-428b-8d07-9f37-bdb8a1e06bdf@virtuozzo.com>
Date: Sat, 3 Jun 2017 20:02:39 +0300
MIME-Version: 1.0
In-Reply-To: <450ae852-a5c4-17f1-2027-f68bf91262aa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02.06.2017 21:46, John Snow wrote:
>
> On 06/02/2017 05:45 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 02.06.2017 12:01, Vladimir Sementsov-Ogievskiy wrote:
>>> 02.06.2017 11:56, Vladimir Sementsov-Ogievskiy wrote:
>>>> 02.06.2017 02:25, John Snow wrote:
>>>>> On 06/01/2017 03:30 AM, Sementsov-Ogievskiy Vladimir wrote:
>>>>>> Hi John!
>>>>>>
>>>>>> Look at our discussion about this in v18 thread.
>>>>>>> Shortly: readonly is not the same as disabled. disabled= bitmap just
>>>>>> ignores all writes. readonly= writes are not allowed at all.
>>>>>>
>>>>>> And I think, I'll try to go through way 2: "dirty" field instead of
>>>>>> "readonly" (look at v18 discussion), as it a bit more flexible.
>>>>>>
>>>>> Not sure which I prefer...
>>>>>
>>>>> Method 1 is attractive in that it is fairly simple, and enforces fairly
>>>>> loudly the inability to write to devices with RO bitmaps. It's a
>>>>> natural
>>>>> extension of your current approach.
>>>> For now I decided to realize this one, I think I'll publish it today.
>>>> Also, I'm going to rename s/readonly/in_use - to avoid the confuse
>>>> with disabled. So let this field just be mirror of IN_USE in the
>>>> image and just say "persistent storage knows, that bitmap is in use
>>>> and may be dirty".
>> Finally it would be readonly. in_use is bad for created (not loaded)
>> bitmaps. I'll add more descriptive comments for disabled and readonly.
>>
> Makes sense. It sounds like "readonly" is simply a stricter superset of
> "disabled," where "disabled" doesn't care if the bitmap gets out of sync
> with the data, but "readonly" attempts to preserve that semantic
> relationship.

should we add separate "READONLY" bitmap status for qapi? I'm sure that 
I don't want to call them "disabled" as it is not the same. "active" is 
better (as when image is RW they are active, when image is RO, they are 
active in RO image - not bad too I think. So, may be such addition to 
qapi would be redundant.

>
>>>> Also, optimization with 'dirty' flag may be added later.
> Yes, I agree.
>
>>> And, also, I don't want to influence this "first write", on which we
>>> will set "IN_USE" in all bitmaps (for way (2). Reopening rw is less
>>> performance-demanding place than write.
>>>
> "And, also," -- I think you've been reading my emails too much, you're
> picking up my 'isms ;)
>
> Thanks,
> --John

-- 
Best regards,
Vladimir.
