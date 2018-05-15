Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIdsq-0002UO-Rn
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:37:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fIdsm-0007E8-Um
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:37:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fIdsm-0007Ds-QU
	for qemu-devel@nongnu.org; Tue, 15 May 2018 13:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4097A4201AE5
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 17:37:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1526395713-60357-1-git-send-email-imammedo@redhat.com>
	<20180515152641.7oaxop77wgzokr7h@kamzik.brq.redhat.com>
	<3543e1cb-85b9-7f50-f97f-e8f2b98b10e0@redhat.com>
Date: Tue, 15 May 2018 19:37:02 +0200
In-Reply-To: <3543e1cb-85b9-7f50-f97f-e8f2b98b10e0@redhat.com> (Eric Blake's
	message of "Tue, 15 May 2018 11:47:28 -0500")
Message-ID: <87eficu8g1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] numa: clarify error message when node
 index is out of range in -numa dist, ...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 05/15/2018 10:26 AM, Andrew Jones wrote:
>> On Tue, May 15, 2018 at 04:48:33PM +0200, Igor Mammedov wrote:
>>> When using following CLI:
>>>    -numa dist,src=128,dst=1,val=20
>>> user gets a rather confusing error message:
>>>     "Invalid node 128, max possible could be 128"
>>>
>>> Where 128 is number of nodes that QEMU supports (MAX_NODES),
>>> while src/dst is an index up to that limit, so it should be
>>> MAX_NODES - 1 in error message.
>>> Make error message to explicitly state valid range for node
>>> index to be more clear.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>>> ---
>
>>>       if (src >= MAX_NODES || dst >= MAX_NODES) {
>>>           error_setg(errp,
>>> -                   "Invalid node %d, max possible could be %d",
>>> -                   MAX(src, dst), MAX_NODES);
>>> +                   "Invalid node %d, The valid node range is [0 - %d]",
>>                                        ^ should be a '.'
>>
>> And maybe need a '.' at the end of the second sentence too, as it's not
>> an error phrase, but a real sentence.
>>
>>> +                   MAX(src, dst), MAX_NODES - 1);
>>>          return;
>>>      }
>
> Actually, error_setg() is documented as taking a single phrase (no '.'
> included), and that if you need a second sentence, it's better to use
> error_append_hint().

Correct.  Providing help on valid values is exactly what
error_append_hint() is for.

>                       Maybe Markus has an opinion on the best way to
> word this error message.

Yes: "Parameter 'src' expects an integer between 0 and 127"

Referring to an erroneous key=value by value is not nice.  What if the
value occurs in multiple places, and is valid in at least one?  key is
there, it's unique[*], so use it.


[*] Except in the few places that use repeated keys to form lists.  Ugh.
