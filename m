Received: from eggs.gnu.org ([209.51.188.92]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2KWM-0003DJ-PJ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2KWL-0002Ge-Vj
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:47:02 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-8-jsnow@redhat.com>
	<1055b446-a34d-2413-3e0c-85b433ae15b7@virtuozzo.com>
	<5c1f1971-5050-9678-f7f4-d8d4c4b53709@redhat.com>
	<ba994232-719e-1d6c-c502-23e0ad1532e5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0542e9a0-fc62-a184-564a-9401506e3966@redhat.com>
Date: Fri, 8 Mar 2019 13:46:44 -0500
MIME-Version: 1.0
In-Reply-To: <ba994232-719e-1d6c-c502-23e0ad1532e5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block/dirty-bitmaps: implement
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>



On 3/7/19 11:37 AM, Eric Blake wrote:
> On 3/6/19 3:46 PM, John Snow wrote:
> 
>>> I think, inconsistent bitmaps should have readonly flag always set or always unset, independently on can_write,
>>> as we are not going to write something related to inconsistent bitmaps.
>>>
>>
>> We'll never change metadata for inconsistent bitmaps, no. We might
>> delete them which causes a metadata change, though -- and right now the
>> readonly check stops that in blockdev.c before we attempt (and fail) the
>> operation. It does have at least a light usage.
>>
>> It's not a crucial feature, but I think the error message is nicer.
>>
>>> And I think, better is always unset, to have inconsistent bitmaps as something unrelated to readonly.
>>>
>>
>> The way I think of it is as unrelated, which is why I set readonly and
>> inconsistent orthogonally.
>>
>>> Readonly are bitmaps, which are not marked IN_USE on open for some reason..
>>>
>>
>> I tend to think of readonly bitmaps as persistent bitmaps attached to
>> storage we are unable to write back to, so we must prevent their
>> modification.
> 
> I like that wording (keeping read-only and inconsistent orthogonal),
> 
>>
>> I suppose the IN_USE viewpoint works too; "This is a bitmap that we have
>> not marked as IN_USE so it must not be used."
>>
> 
> Yes, it does work, but it is a bit more of a stretch, so I'm not quite
> as sure about using it.
> 
>>> I understand, that inconsistent bitmaps are some kind of readonly too, as we can't write to them..
>>> But we can't read too anyway, and we don't interfere with reopen logic at all. So again, better is
>>> don't mark inconsistent bitmaps as readonly.
>>>
>>
>> Hm, so in your model; we just NEVER set readonly for persistent bitmaps,
>> which incurs some changes at load time, but allows the reload_rw
>> function to go completely unmodified.
>>
>> That's not unreasonable in terms of SLOC, but semantically I am not sure
>> which approach is better. I'm leaning towards keeping this as written
>> for now, but... well. Any thoughts, Eric? Would you like to flip a coin?
> 
> No strong preferences, other than let's get it in before soft freeze, to
> make sure we don't miss out on it entirely due to waiting for the coin
> flip :)
> 
> 

OK. I have a slight preference for keeping the flag meanings orthogonal
and logically consistent, because I believe it keeps the code less
surprising to anyone who isn't Eric, Vlad, or myself.

So I think I will stage this as-is, and if it poses a problem I will
accept counter-proposals during freeze to shore it up if necessary.

--js
