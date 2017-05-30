Received: from eggs.gnu.org ([2001:4830:134:3::10]:57661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFiMm-0008O8-Gj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dFiMj-0004yQ-TY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dFiMj-0004wA-Jg
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:43:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40F6A3D978
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:43:20 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-7-git-send-email-vyasevic@redhat.com>
	<87bmqahcx4.fsf@secure.mitica>
	<959a41db-7fcd-6f0e-0072-30a570dcb1c3@redhat.com>
	<87h902fmmq.fsf@secure.mitica>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <3aa8bbe9-c615-c293-e78b-b3463ef78016@redhat.com>
Date: Tue, 30 May 2017 10:43:13 -0400
MIME-Version: 1.0
In-Reply-To: <87h902fmmq.fsf@secure.mitica>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/12] qmp: Expose qemu_announce_self as a
 qmp command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

On 05/30/2017 10:24 AM, Juan Quintela wrote:
> Vlad Yasevich <vyasevic@redhat.com> wrote:
>> On 05/30/2017 06:11 AM, Juan Quintela wrote:
>>> Vladislav Yasevich <vyasevic@redhat.com> wrote:
>>>> Add a qmp command that can trigger guest announcements.
>>>>
>>>> Based on work of Germano Veit Michel <germano@redhat.com>
>>>>
>>>> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
>>>> ---
>>>>  migration/savevm.c | 14 ++++++++++++++
>>>>  qapi-schema.json   | 19 +++++++++++++++++++
>>>>  2 files changed, 33 insertions(+)
>>>>
>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>> index a4097c9..b55ce6a 100644
>>>> --- a/migration/savevm.c
>>>> +++ b/migration/savevm.c
>>>> @@ -265,6 +265,20 @@ void qemu_announce_self(AnnounceParameters *params)
>>>>      qemu_announce_self_once(timer);
>>>>  }
>>>>  
>>>> +void qmp_announce_self(bool has_params, AnnounceParameters *params,
>>>> +                       Error **errp)
>>>> +{
>>>> +    AnnounceParameters announce_params;
>>>> +
>>>> +    memcpy(&announce_params, qemu_get_announce_params(),
>>>> +           sizeof(announce_params));
>>>> +
>>>> +    if (has_params)
>>>> +        qemu_set_announce_parameters(&announce_params, params);
>>>> +
>>>> +    qemu_announce_self(&announce_params);
>>>
>>> Are I missreading qemu_annouce_self()?
>>> My reading is that it passes announce_params to a timer (i.e. async
>>> function), but here announce_params is a local variable here, no?
>>>
>>
>> The AnnounceTimer holds a copy since each timer may have it's own values.
> 
> 
> 
>> AnnounceTimer *qemu_announce_timer_new(AnnounceParameters *params,
>>                                        QEMUClockType type)
>> {
>>    AnnounceTimer *timer = g_new(AnnounceTimer, 1);
>>
>>    timer->params = *params;
> 
> I have to remomember that C has learn how to copy structures long ago.
> 
> <repeat myself one hundred times>
> 
> I was missing the "*" on my previous reading, sorry for the noise.

that actually changed, since as Eric Pointed out, shallow copies shouldn't
be used.  In the v2 code, this uses qemu_set_announce_paramters(), but the copy
essentially remains.

-vlad
> 
>>    timer->round = params->rounds;
>>    timer->type = type;
>>
>>    return timer;
>> }
> 
> 
