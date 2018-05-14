Received: from eggs.gnu.org ([2001:4830:134:3::10]:57835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIACh-0001jW-Al
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fIACg-0003dG-7G
	for qemu-devel@nongnu.org; Mon, 14 May 2018 05:55:39 -0400
References: <8739e95e-1900-d4e3-7ac8-77e3aa8b927e@virtuozzo.com>
	<3828666d-c929-de15-9160-4089d237d323@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a514125e-1b19-5abc-c602-b406fbc9c403@virtuozzo.com>
Date: Mon, 14 May 2018 12:55:25 +0300
MIME-Version: 1.0
In-Reply-To: <3828666d-c929-de15-9160-4089d237d323@redhat.com>
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
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "gilbert >> Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Juan Q >> Juan Jose Quintela Carreira" <quintela@redhat.com>

12.05.2018 00:23, John Snow wrote:
>
> On 04/18/2018 10:00 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> We now have the following problem:
>>
>> If dirty-bitmaps migration capability is enabled, persistance flag is
>> dropped for all migrated bitmaps, to prevent their storing to the
>> storage on inactivate. It works ok, persistence itself is migrated
>> through the migration channel. But on source, bitmaps becomes not
>> persistent, so if we, for some reasons, want to continue using source
>> vm, we'll lose bitmaps on stop/start.
>>
> Sorry for not following along more carefully, which kind of migration
> are we talking about in this case?

Any migration with dirty-bitmaps capability enabled..

>
>> It's simple to fix it: just make bitmaps persistent again on invalidate
>> [1].. But I have some questions.
>>
>> 1. What are possible cases? I think about the following:
>>
>> a. migration cancel or fail, then invalidate
>> b. migration success, then qmp cont => invalidate
>> c. migration success, then stop/start (there was no invalidate, so [1]
>> will not work)
>>
>>
>> 2. Is it safe at all, saving bitmaps after inactivate, even without
>> persistence?
>>
>> Inactive disk implies, that it may be changed by somebody other, isn't
>> it? Is it possible, that target will change the disk, and then we return
>> control to the source? In this case bitmaps will be invalid. So, should
>> not we drop all the bitmaps on inactivate?
>>


-- 
Best regards,
Vladimir
