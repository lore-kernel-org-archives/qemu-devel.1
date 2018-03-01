Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erKv0-0004wb-KM
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erKuv-0003km-OH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:54:30 -0500
Received: from mail-ve1eur01on0701.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::701]:3425
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1erKut-0003jL-Lf
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:54:25 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<c2faa919-65c6-d5a3-508d-2f069f2ba61e@redhat.com>
	<1e3244d2-daea-6f3f-f852-642bdf216e17@virtuozzo.com>
	<d1e7c1c5-622c-ff78-4aec-ce62b0273d24@redhat.com>
	<20180228130816.GA19355@grep.be>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ca171dcb-4d7a-56f7-2d32-d0e29b50b1c8@virtuozzo.com>
Date: Thu, 1 Mar 2018 12:54:15 +0300
MIME-Version: 1.0
In-Reply-To: <20180228130816.GA19355@grep.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [Nbd] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>, Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Hi,

Sorry too for long delay.

28.02.2018 16:08, Wouter Verhelst wrote:
> Hi,
>
> Sorry, I forgot to reply to this earlier.
>
> On Fri, Feb 16, 2018 at 10:10:59AM -0600, Eric Blake wrote:
>> On 02/16/2018 07:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Good idea. But it would be tricky thing to maintain backward
>>> compatibility with published versions of virtuozzo product. And finally
>>> our implementation would be more complex because of this simplification.
>>> Hm. Finally, you suggested several changes (including already merged
>>> 56c77720 :( ). Suggestions are logical. But if they will be accepted, we
>>> (Virtuozzo) will have to invent tricky hard-to-maintain code, to
>>> distinguish by third factors our already published versions.
> Hrm. I wasn't aware you'd already published those versions; if you had
> told us, we could've reviewed the spec at that point and either merge it
> or update it to incorporate whatever changes you think seem like they
> are necessary.
>
> Note that the section "Experimental extensions" contains the following
> wording:
>
>      In addition to the normative elements of the specification set out
>      herein, various experimental non-normative extensions have been
>      proposed. These may not be implemented in any known server or
>      client, and are subject to change at any point. A full
>      implementation may require changes to the specifications, or cause
>      the specifications to be withdrawn altogether.
>
>      [...]
>
>      Implementors of these extensions are strongly suggested to contact
>      the mailinglist in order to help fine-tune the specifications before
>      committing to a particular implementation.
>
> i.e., what's in an "extension-" branch can be described as "we're
> thinking about it and it will probably happen as written, but we're not
> entirely sure yet". The idea behind this is that we don't want to limit
> ourselves to things that haven't been implemented (but that the fact of
> "implementing something" causes it to get written into stone, sortof).
>
> This is different from how most standards bodies work, I'm sure, but it
> seemed to work so far, and I wish you had let us know that the work you
> were doing was about to be reaching customers. Anyway.

Oh, it's my big mistake, I understand now. Discussion was (and continues 
to be=) too long, so we couldn't wait, but I of course should have 
announce it somehow, or use bigger experimental constants for the protocol.

>
> [...]
>> Also, the Virtuozzo product hasn't been mentioned on the NBD list, and while
>> you are preparing patches to the public qemu based on the Virtuozzo product,
>> I'm not sure if there is a public repository for the existing Virtuozzo
>> product out in the wild.  Is your product using NBD_OPT_LIST_META_CONTEXT,
>> or _just_ NBD_OPT_SET_META_CONTEXT?
> +1. What's published currently?

No, we don't have public repo. But our implementation is similar (in 
protocol) with sent patches. My first published implementation was 
written one year ago, in Feb 2017. I'm afraid I've missed later changes 
of the spec, will check. [hm, it's not very easy to do..]

_LIST_ is implemented in server, but only _SET_ is used in client.


---- checking for changes ----

Comparing 3118b21df (in extension-blockstatus, committed in Jan 2017) 
with current state of extension-blockstatus, don't see any significant 
changes for blockstatus, except command number 5->3, which we decided to 
rollback (thanks for this).


>
> [...]
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
>
> However, for future reference, Vladimir, I would prefer it if you could
> give us a heads-up if you're getting close to releasing something to
> the public that's still in an experimental branch, so that we can make
> updates if necessary and merge it to master.
>
> Thanks,
>


-- 
Best regards,
Vladimir
