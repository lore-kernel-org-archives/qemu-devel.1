Received: from eggs.gnu.org ([2001:4830:134:3::10]:38683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d6Crs-00072p-MY
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d6Crn-00027w-Lv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:16:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d6Crn-000230-33
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:16:07 -0400
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
	<20170428165522.GG3276@work-vm> <87vapht37i.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <590AF10B.9020207@huawei.com>
Date: Thu, 4 May 2017 17:14:51 +0800
MIME-Version: 1.0
In-Reply-To: <87vapht37i.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

Hi,

On 2017/5/4 16:51, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> * Juan Quintela (quintela@redhat.com) wrote:
>>> We have change in the previous patch to use migration capabilities for
>>> it.  Notice that we continue using the old command line flags from
>>> migrate command from the time being.  Remove the set_params method as
>>> now it is empty.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---
>>>   include/migration/migration.h |  3 +--
>>>   migration/block.c             | 17 ++---------------
>>>   migration/colo.c              |  3 ---
>>>   migration/migration.c         |  8 +++++---
>>>   migration/savevm.c            |  2 --
>>>   5 files changed, 8 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/migration/colo.c b/migration/colo.c
>>> index c19eb3f..5c6c2f0 100644
>>> --- a/migration/colo.c
>>> +++ b/migration/colo.c
>>> @@ -332,9 +332,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>>>           goto out;
>>>       }
>>>   
>>> -    /* Disable block migration */
>>> -    s->params.blk = 0;
>>> -    s->params.shared = 0;
>> Hmm you don't seem to have replaced this with anything.
>> I think that's a behavioural change; the trick COLO did (I'm not sure if this
>> is still the way it works) is that they initiate the first migration
>> with block migration enabled so that the two hosts (with non-shared storage)
>> get sync'd storage, and then at the completion of that first migration
>> they then switch into the checkpointing mode where they're only
>> doing updates - that's why it gets switched off at this point
>> prior to the 1st checkpoint.
>
> Weird, really.
>
> I did't catch that.
>
> Will investigate.

Yes, Dave is right, for non-shared disk, we need to enable block migration for first cycle,
to sync the disks of two sides. After that, qemu will go into COLO state which we need to
disable block migration.

Thanks,
Hailiang


> Thanks.
>
> .
>
