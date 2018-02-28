Received: from eggs.gnu.org ([2001:4830:134:3::10]:56638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er8Jc-00077W-9I
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er8JY-0006vf-QI
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:27:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er8JY-0006vI-Ju
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 15:27:00 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
	<1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
	<d1e7c1c5-622c-ff78-4aec-ce62b0273d24@redhat.com>
	<20180228130816.GA19355@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf2357b2-deed-46d3-3306-5eabf0a0abae@redhat.com>
Date: Wed, 28 Feb 2018 14:26:56 -0600
MIME-Version: 1.0
In-Reply-To: <20180228130816.GA19355@grep.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 02/28/2018 07:08 AM, Wouter Verhelst wrote:

>> Or, we can revert the change in commit 56c77720, and keep
>> NBD_REPLY_TYPE_BLOCK_STATUS at 5 (it leaves a hole in the NBD_REPLY_TYPE
>> numbering, where 3 and 4 might be filled in by other future extensions, or
>> permanently skipped).  This works IF there are no OTHER incompatible changes
>> made to the rest of the block status extension as part of promoting it to
>> current (where we still haven't finished that debate, given my question on
>> whether 32-bit lengths and colon-separated namespace:leaf in a single string
>> is the best representation).
>>
>> So, I'd like some feedback from Alex or Wouter on which alternatives seem
>> nicest at this point.
> 
> I'm thinking that reverting at least the number change seems like a good
> idea. If Vladimir can shed some light on what's been published so far,
> we can see what damage has been done and try to limit further damage.
> 
> It makes no sense to ignore that the spec has been implemented; the
> whole point of writing a spec is so that third parties can implement it
> and be compatible. If we ignore that just because there was a
> misunderstanding, then I think we're throwing away the kid with the
> bathwater.
> 
> Since I don't think a gap in numbers is that much of a problem, I'm
> happy reverting the renumbering part of 56c77720 and keep it at 5. I'd
> also like to know what it is exactly that Virtuozzo implemented, so we
> can update the extension-blockstatus (if necessary) and then merge that
> to master.

Okay, I've gone ahead and reverted the renumbering; NBD_INFO_BLOCK_SIZE 
is back to 5 (we have a gap in the numbering, but it doesn't hurt). 
There's still the open question of whether we want to keep a single 
string that requires parsing into "namespace:leaf" sections, or to split 
things into two separate strings for ease of handing an unknown 
namespace; and whether a 16-bit length is sufficient instead of burning 
32-bit length fields.  But if we decide that any of those changes are 
worth making, we'd also want to do something else to make it obviously 
different from Virtuozzo's initial implementation (my idea about 
reserving NBD_OPT_ value 10 as unused, and renumbering 
NBD_OPT_SET_META_CONTEXT to 11 along with any other changes we make, is 
still reasonable for that point).

I'd also like to promote extension-structured-reply to current (now that 
it is implemented by qemu), while keeping extension-blockstatus as a 
separate branch for just a bit longer.

I'll post another thread on other possible doc changes that have come up 
during this thread.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
