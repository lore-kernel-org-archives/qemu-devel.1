Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcKpb-0008U0-Ha
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 20:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcKpa-0008BF-EB
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 20:14:39 -0400
References: <20170711170821.24669-1-ppandit@redhat.com>
	<29e5dd08-80e7-ae0d-7179-73f5d34c3485@redhat.com>
	<20170721154712.GM18014@stefanha-x1.localdomain>
	<b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e8a30256-9b83-1c58-d8e6-9ec5192604b6@redhat.com>
Date: Mon, 31 Jul 2017 20:14:30 -0400
MIME-Version: 1.0
In-Reply-To: <b3ba0182-8700-76fc-5d20-97c054137ef9@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: check BlockDriverState
 object before dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Kieron Shorrock <kshorrock@paloaltonetworks.com>, Prasad J Pandit <pjp@fedoraproject.org>, Markus Armbruster <armbru@redhat.com>



On 07/23/2017 10:36 AM, Paolo Bonzini wrote:
> On 21/07/2017 17:47, Stefan Hajnoczi wrote:
>> Hmm...BlockDriverState still has bdrv_is_inserted() even though
>> BlockBackend->root can be NULL?  CCing Markus in case he has thoughts on
>> the BB/BDS split.
>>
>> I find it weird that block-backend.c calls bdrv_inc_in_flight() and then
>> bdrv_co_flush() will call it again.  Perhaps we need to do this so that
>> blk_drain() works correctly but it's odd that they share the same
>> counter variable.
> 
> See here:
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02305.html
> 

>> I need to count requests at the BB level because the blk_aio_*
>> operations have a separate bottom half that is invoked if either 1) they
>> never reach BDS (because of an error); or 2) the bdrv_co_* call
>> completes without yielding.  The count must be >0 when blk_aio_*
>> returns, or bdrv_drain (and thus blk_drain) won't loop.  Because
>> bdrv_drain and blk_drain are conflated, the counter must be the BDS one.
>>
>> In turn, the BDS counter is needed because of the lack of isolated
>> sections.  The right design would be for blk_isolate_begin to call
>> blk_drain on *other* BlockBackends reachable in a child-to-parent visit.
>>  Instead, until that is implemented, we have bdrv_drained_begin that
>> emulates that through the same-named callback, followed by a
>> parent-to-child bdrv_drain that is almost always unnecessary.

OK, so you have some justifications for why it needs to be at the BB
level...

> 
> The full explanation of the long-term plans and what "isolated section"
> means is at
> https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg02016.html.
> (Unfortunately, since then we've reintroduced the "double aio_poll" hack
> in BDRV_POLL_WHILE...).
> 
> Paolo
> 

I may need some nudging towards understanding what the right solution
here is, though. Should the blk_aio_flush assume that there always is a
root BDS? should it not assume that?

It's difficult for me to understand right now if the bug is in the
expectation for the blk_ functions and the caller should be amended, or
if you need changes to the way the blk_ functions are trying to
increment a counter that doesn't exist.

I can handle the former fairly easily; if it's the latter, I'm afraid
it's stuck in the middle of some of your changes and I'd need a stronger
hint.

John
