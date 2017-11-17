Received: from eggs.gnu.org ([2001:4830:134:3::10]:48849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFbv7-0001Nl-U1
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:22:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFbv6-00066I-BN
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 03:22:41 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
Date: Fri, 17 Nov 2017 11:22:26 +0300
MIME-Version: 1.0
In-Reply-To: <8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com

17.11.2017 06:10, John Snow wrote:
>
> On 11/16/2017 03:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.11.2017 00:20, John Snow wrote:
>>> On 11/13/2017 11:20 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Hi all.
>>>>
>>>> There are three qmp commands, needed to implement external backup API.
>>>>
>>>> Using these three commands, client may do all needed bitmap
>>>> management by
>>>> hand:
>>>>
>>>> on backup start we need to do a transaction:
>>>>    {disable old bitmap, create new bitmap}
>>>>
>>>> on backup success:
>>>>    drop old bitmap
>>>>
>>>> on backup fail:
>>>>    enable old bitmap
>>>>    merge new bitmap to old bitmap
>>>>    drop new bitmap
>>>>
>>> Can you give me an example of how you expect these commands to be used,
>>> and why they're required?
>>>
>>> I'm a little weary about how error-prone these commands might be and the
>>> potential for incorrect usage seems... high. Why do we require them?
>> It is needed for incremental backup. It looks like bad idea to export
>> abdicate/reclaim functionality, it is simpler
>> and clearer to allow user to merge/enable/disable bitmaps by hand.
>>
>> usage is like this:
>>
>> 1. we have dirty bitmap bitmap0 for incremental backup.
>>
>> 2. prepare image fleecing (create temporary image with backing=our_disk)
>> 3. in qmp transaction:
>>      - disable bitmap0
>>      - create bitmap1
>>      - start image fleecing (backup sync=none our_disk -> temp_disk)
> This could probably just be its own command, though:
>
> block-job-fleece node=foobar bitmap=bitmap0 etc=etera etc=etera
>
> Could handle forking the bitmap. I'm not sure what the arguments would
> look like, but we could name the NBD export here, too. (Assuming the
> server is already started and we just need to create the share.)
>
> Then, we can basically do what mirror does:
>
> (1) Cancel
> (2) Complete
>
> Cancel would instruct QEMU to keep the bitmap changes (i.e. roll back),
> and Complete would instruct QEMU to discard the changes.
>
> This way we don't need to expose commands like split or merge that will
> almost always be dangerous to use over QMP.
>
> In fact, a fleecing job would be really convenient even without a
> bitmap, because it'd still be nice to have a convenience command for it.
> Using an existing infrastructure and understood paradigm is just a bonus.

1. If I understand correctly, Kevin and Max said in their report in 
Prague about new block-job approach,
   using filter nodes, so I'm not sure that this is a good Idea to 
introduce now new old-style block-job, where we can
   do without it.

2. there is the following scenario: customers needs a possibility to 
create a backup of data changed since some
point in time. So, maintaining several static and one (or several) activ 
bitmaps with a possiblity of merge some of them
and create a backup using this merged bitmap may be convenient.

3. And I don't see any danger here: we already can create, delete and 
clear dirty bitmaps through qmp. Some additional
operations should not be bad.

4. Interesting: "disabled" field looks like never used..

>
>> 4. export temp_disk (it looks like a snapshot) and bitmap0 through NBD
>>
>> === external tool can get bitmap0 and then copy some clusters through
>> NBD ===
>>
>> on successful backup external tool can drop bitmap0. or can save it and
>> reuse somehow
>>
>> on failed backup external tool can do the following:
>>      - enable bitmap0
>>      - merge bitmap1 to bitmap0
>>      - drop bitmap1
>>


-- 
Best regards,
Vladimir
