Received: from eggs.gnu.org ([2001:4830:134:3::10]:53088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIJFK-0001sK-Qg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIJFH-0003ZD-UX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:34:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIJFH-0003XB-Oa
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:34:55 -0400
References: <1526029534-35771-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1526029534-35771-2-git-send-email-anton.nefedov@virtuozzo.com>
	<877eo6nm99.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1839ed60-ffd9-42c1-bf52-6d6121abb224@redhat.com>
Date: Mon, 14 May 2018 14:34:53 -0500
MIME-Version: 1.0
In-Reply-To: <877eo6nm99.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

On 05/14/2018 01:08 PM, Markus Armbruster wrote:
> Anton Nefedov <anton.nefedov@virtuozzo.com> writes:
> 
>> The patch makes possible to avoid introducing dummy empty types
>> for the flat union branches that have no data.
>>

> 
> Some unions have no variant members for certain discriminator values.
> We currently have to use an empty type there, and we've accumulated
> several just for the purpose, which is annoying.
> 
> QAPI language design alternatives:
> 
> 1. Having unions cover all discriminator values explicitly is useful.
> All we need is a more convenient way to denote empty types.  Eric
> proposed {}, as in 'foo: {}.

And even posted a patch for it once:
https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg00311.html

although it was late enough in that series with other churn in the 
meantime that it would need serious revisiting to apply today.

> 
> 2. Having unions repeat all the discriminator values explicitly is not
> useful.  All we need is replacing the code enforcing that by code
> defaulting missing ones to the empty type.
> 
> 3. We can't decide, so we do both (this patch).
> 
> Preferences?

Here's some tradeoffs to consider:

Allowing 'foo':{} makes your intent explicit - "I know this branch of 
the union exists, but it specifically adds no further members".  But 
it's a lot of redundant typing - "I already had to type all the branch 
names when declaring the enum type, why do it again here?"

Allowing an easy way to mark all non-listed members of an enum default 
to the empty type is compact - "I told you the enum, so you are 
permitted to fill in an empty type with every branch that does not 
actually need further members; and I had to opt in to that behavior, so 
that I purposefully get an error if I did not opt in but forgot an enum 
member".  But if the enum is likely to change, it can lead to forgotten 
additions later on - "I'm adding member 'bar' to an enum that already 
has member 'foo'; therefore, grepping for 'foo' should tell me all 
places where I should add handling for 'bar', except that it doesn't 
work when handling for 'foo' was implicit but handling for 'bar' should 
not be".

Having said that, my personal preference is that opting in to an 
explicit way to do less typing ("all branches of the enum listed here 
are valid, and add no further members") seems like a nice syntactic 
sugar trick; and the easiest way to actually implement it is to probably 
already have support for an explicit 'foo':{} branch notation.  That 
way, you can always change your mind later and undo the opt-in 
"data-partial" flag and rewrite the union with explicit empty branches 
when needed, to match how the sugar was expanded on your behalf.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
