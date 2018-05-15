Received: from eggs.gnu.org ([2001:4830:134:3::10]:59902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbkH-0007DS-JT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbkB-0003aN-HW
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:20:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbkB-0003a4-C9
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:20:03 -0400
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
	<1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
	<87h8n9l7wq.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95ab24a5-d600-67b5-9c7e-e5290f42f520@redhat.com>
Date: Tue, 15 May 2018 10:20:01 -0500
MIME-Version: 1.0
In-Reply-To: <87h8n9l7wq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: allow flat unions with empty
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 05/15/2018 02:01 AM, Markus Armbruster wrote:

>>> QAPI language design alternatives:
>>>
>>> 1. Having unions cover all discriminator values explicitly is useful.

>>> 2. Having unions repeat all the discriminator values explicitly is not
>>> useful.  All we need is replacing the code enforcing that by code
>>> defaulting missing ones to the empty type.
>>>
>>> 3. We can't decide, so we do both (this patch).
>>>

> I'd prefer a more opinionated design here.
> 
> Either we opine making people repeat the tag values is an overall win.
> Then make them repeat them always, don't give them the option to not
> repeat them.  Drop this patch.  To reduce verbosity, we can add a
> suitable way to denote a predefined empty type.
> 
> Or we opine it's not.  Then let them not repeat them, don't give them
> the option to make themselves repeat them.  Evolve this patch into one
> that makes flat union variants optional and default to empty.  If we
> later find we still want a way to denote a predefined empty type, we can
> add it then.
> 
> My personal opinion is it's not.

I followed the arguments up to the last sentence, but then I got lost on 
whether you meant:

This patch is not an overall win, so let's drop it and keep status quo 
and/or implement a way to write 'branch':{} (option 1 above)

or

Forcing repetition is not an overall win, so let's drop that requirement 
by using something similar to this patch (option 2 above) but without 
adding a 'partial-data' key.

But you've convinced me that option 3 (supporting a compact branch 
representation AND supporting missing branches as defaulting to an empty 
type) is more of a maintenance burden (any time there is more than one 
way to write something, it requires more testing that both ways continue 
to work) and thus not worth doing without strong evidence that we need 
both ways (which we do not currently have).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
