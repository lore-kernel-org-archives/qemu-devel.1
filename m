Received: from eggs.gnu.org ([2001:4830:134:3::10]:39648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTAxq-0001xC-H6
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTAxp-00030N-IX
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:53:18 -0400
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
	<1486979689-230770-13-git-send-email-vsementsov@virtuozzo.com>
	<20170216130409.GA28784@lemon.lan>
	<d94f4e26-0979-f530-6a88-9ee655843d68@virtuozzo.com>
	<15ffeebf-075d-f540-ac82-0513f367b37b@redhat.com>
	<66e7f481-06f4-2a7e-77fb-1a5c9fc1f301@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <255b6c77-48e4-217d-f1da-d2544db5b646@redhat.com>
Date: Thu, 6 Jul 2017 13:53:00 -0400
MIME-Version: 1.0
In-Reply-To: <66e7f481-06f4-2a7e-77fb-1a5c9fc1f301@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/17] migration: add postcopy migration of
 dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, pbonzini@redhat.com, mreitz@redhat.com, dgilbert@redhat.com



On 07/06/2017 04:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.07.2017 00:46, John Snow wrote:
>>
>> On 07/05/2017 05:24 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> 16.02.2017 16:04, Fam Zheng wrote:
>>>>> +            dbms->node_name = bdrv_get_node_name(bs);
>>>>> +            if (!dbms->node_name || dbms->node_name[0] == '\0') {
>>>>> +                dbms->node_name = bdrv_get_device_name(bs);
>>>>> +            }
>>>>> +            dbms->bitmap = bitmap;
>>>> What protects the case that the bitmap is released before migration
>>>> completes?
>>>>
>>> What is the source of such deletion? qmp command? Theoretically
>>> possible.
>>>
>>> I see the following variants:
>>>
>>> 1. additional variable BdrvDirtyBItmap.migration, which forbids bitmap
>>> deletion
>>>
>>> 2. make bitmap anonymous (bdrv_dirty_bitmap_make_anon) - it will not be
>>> available through qmp
>>>
>> Making the bitmap anonymous would forbid us to query the bitmap, which
>> there is no general reason to do, excepting the idea that a third party
>> attempting to use the bitmap during a migration is probably a bad idea.
>> I don't really like the idea of "hiding" information from the user,
>> though, because then we'd have to worry about name collisions when we
>> de-anonymized the bitmap again. That's not so palatable.
>>
>>> what do you think?
>>>
>> The modes for bitmaps are getting messy.
>>
>> As a reminder, the officially exposed "modes" of a bitmap are currently:
>>
>> FROZEN: Cannot be reset/deleted. Implication is that the bitmap is
>> otherwise "ACTIVE."
>> DISABLED: Not recording any writes (by choice.)
>> ACTIVE: Actively recording writes.
>>
>> These are documented in the public API as possibilities for
>> DirtyBitmapStatus in block-core.json. We didn't add a new condition for
>> "readonly" either, which I think is actually required:
>>
>> READONLY: Not recording any writes (by necessity.)
>>
>>
>> Your new use case here sounds like Frozen to me, but it simply does not
>> have an anonymous successor to force it to be recognized as "frozen." We
>> can add a `bool protected` or `bool frozen` field to force recognition
>> of this status and adjust the json documentation accordingly.
> 
> Bitmaps are selected for migration when source is running, so we should
> protect them (from deletion (or frozing or disabling), not from chaning
> bits) before source stop, so that is not like frozen. Bitmaps may be
> changed in this state.
> It is more like ACTIVE.
> 

Right, it's not exactly like frozen's _implementation_ today, but...

> We can move bitmap selection on the point after precopy migration, after
> source stop, but I'm not sure that it would be good.
> 
>>
>> I think then we'd have four recognized states:
>>
>> FROZEN: Cannot be reset/deleted. Bitmap is in-use by a block job or
>> other internal process. Bitmap is otherwise ACTIVE.
> 
> ? Frozen means that all writes goes to the successor and frozen bitmap
> itself is unchanged, no?
> 

I was thinking from the point of view of the API. Of course internally,
you're correct; a "frozen bitmap" is one that is actually disabled and
has an anonymous successor, and that successor records IO.

>From the point of view of the API, a frozen bitmap is just "one bitmap"
that is still recording reads/writes, but is protected from being edited
from QMP.

It depends on if you're looking at bitmaps as opaque API objects or if
you're looking at the implementation.

>From an API point of view, protecting an Active bitmap from being
renamed/cleared/deleted is functionally identical to the existing case
of protecting a bitmap-and-successor pair during a backup job.

>> DISABLED: Not recording any writes (by choice.)
>> READONLY: Not able to record any writes (by necessity.)
>> ACTIVE: Normal bitmap status.
>>
>> Sound right?
> 
> 
