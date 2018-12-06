Received: from eggs.gnu.org ([2001:4830:134:3::10]:38376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUwOK-00076g-Pg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:20:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUwOG-0002nh-1u
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:20:44 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-8-eblake@redhat.com>
	<a5cb2216-344d-8874-8801-f7260a755812@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <216643a4-029f-2bfc-a2f5-245ed4601398@redhat.com>
Date: Thu, 6 Dec 2018 10:20:07 -0600
MIME-Version: 1.0
In-Reply-To: <a5cb2216-344d-8874-8801-f7260a755812@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/14] nbd/client: Refactor
 nbd_negotiate_simple_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/6/18 7:20 AM, Vladimir Sementsov-Ogievskiy wrote:
> 01.12.2018 1:03, Eric Blake wrote:
>> Change the signature to make it easier for a future patch to
>> reuse this function for calling NBD_OPT_LIST_META_CONTEXT with
>> 0 or 1 queries.  Also, always allocate space for the received
>> name, even if it doesn't match expected lengths (no point
>> trying to optimize the unlikely error case, and tracing the
>> received rather than expected name can help debug a server
>> implementation).
>>
>> While there are now slightly different traces, and the error
>> message for a server replying with too many contexts is
>> different, there are no runtime-observable changes in behavior
>> for the more common case of the lone caller interacting with a
>> compliant server.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>    nbd/client.c     | 105 +++++++++++++++++++++++++++--------------------
>>    nbd/trace-events |   2 +-
>>    2 files changed, 61 insertions(+), 46 deletions(-)
>>
>> diff --git a/nbd/client.c b/nbd/client.c
>> index b5818a99d21..1dc8f83e19a 100644
>> --- a/nbd/client.c
>> +++ b/nbd/client.c
>> @@ -603,49 +603,57 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
>>    }
>>
>>    /* nbd_negotiate_simple_meta_context:
>> - * Set one meta context. Simple means that reply must contain zero (not
>> - * negotiated) or one (negotiated) contexts. More contexts would be considered
>> - * as a protocol error. It's also implied that meta-data query equals queried
>> - * context name, so, if server replies with something different than @context,
>> - * it is considered an error too.
>> - * return 1 for successful negotiation, context_id is set
>> - *        0 if operation is unsupported,
>> + * List or set meta context data for export @info->name, based on @opt.
> 
> hm, just list or set meta context? What is "data" about?

Okay, that's two different reviewers complaining. I'll do a bit more 
refactoring and comments for v2 to make it more obvious that I'm writing 
a common routine that can handle the bulk of the commonality between 
list and set; but maybe keep two wrappers so that the existing callers 
don't have to change their calls as drastically.

> 
>> + * For list, leave @context NULL for 0 queries, or supplied for a single
>> + * query; all replies are ignored, and the call merely traces server behavior.
>> + * For set, @context must result in at most one matching server reply, in
>> + * which case @info->meta_base_allocation_id is set to the resulting id.
> 
> Hmm, looks too cheating. Then it should be renamed to
> nbd_negotiate_base_allocation
> 
> and parameter @context should be renamed to @x_dirty_bitmap,
> 
> and if it is unset, we'll use "base:allocation" here.

No, the next patch uses "qemu:" as the context for LIST when recursing 
to work around qemu-nbd 3.0 not advertising the dirty-bitmap context 
under list with 0 queries.

> 
> but in this case, it still weird about opt=list case.. So, it should be named
> like nbd_negotiation_helper, as it is doing several different things, which
> I can't describe in one word.

Yes, I think a function rename will help.

> 
>> + * return 1 for successful negotiation,
>> + *        0 if operation is unsupported or context unavailable,
>>     *        -1 with errp set for any other error
> 
> this return value description looks not very related to opt=list case

It's related - but list returns 1 for a lot more cases than set (a 
successful negotiation for list meant that all server replies were 
processed, while a successful negotiation for set requires that the 
server replies with exactly the one context we requested).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
