Received: from eggs.gnu.org ([2001:4830:134:3::10]:51934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbXNV-0006G6-0u
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 16:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbXNT-0002nb-Up
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 16:30:53 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-3-vsementsov@virtuozzo.com>
	<79b1dc41-b230-3958-8057-4061c18a7814@redhat.com>
	<63c582e8-4646-ad59-3d89-ce07f78e390c@virtuozzo.com>
	<43e22b35-39c3-f596-5a0a-f899376911ad@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74c5daf1-cef1-e2b0-4107-eab3f24778d2@redhat.com>
Date: Fri, 6 Jul 2018 15:30:37 -0500
MIME-Version: 1.0
In-Reply-To: <43e22b35-39c3-f596-5a0a-f899376911ad@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: add transaction support for
 x-block-dirty-bitmap-merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>

On 07/06/2018 10:38 AM, John Snow wrote:

>> I think the "discard stashed state, making undo impossible"
>> interpretation is good because .commit() is not allowed to fail.  That
>> function should only do things that never fail.
> 
> I think this is probably the correct way to proceed, and we ought to
> formalize this model. I think it's actually nearly impossible to do it
> the other way around, too.
> 
> Let's say we've got two actions that both do error-checking in .prepare,
> but perform their actual stateful changes in .commit, but are
> interdependent.
> 
> { a, b }
> 
> - a.prepare() checks state and confirms we will be able to proceed, but
> changes no state.
> - b.prepare() checks state and confirms it will be able to proceed, but
> can't see what a is planning to do.
> - a.commit() succeeds as expected.
> - b.commit() does not fail as it is not allowed to, but the effects are
> undetermined because we have not checked the state change from a.commit()

I'm also trying to figure out if we guarantee that .abort is always 
called in reverse order of .prepare.  If we have { a, b, c }, where 
'a'.prepare makes one change, 'b'.prepare makes another that 'a' cannot 
directly undo, then 'c' fails, we're still okay if 'b'.abort can roll 
back to the state it had during prepare, so that 'a'.abort can then undo 
state cleanly.  And for consistency, I'd argue that .commit should have 
the same ordering as .abort (that is, every .prepare - .abort/.commit 
pair is a nested stack to track for unwinding purposes, and should be 
unwound in reverse order of setting aside resources up front).

> 
> In general we can get around this, but the more actions we add, the
> harder it is to do proper error checking while considering the
> hypothetical state after some actions have committed.
> 
> I think the model where we take effect in .prepare() and undo it if
> necessary in .abort() is actually easier to model in your head, because
> error checking is simpler. That's probably the right model, then.
> 

Yes, I'm also leaning heavily towards strong guarantees.  In addition to 
our examples of which operations depend on which bitmaps, we have this 
additional case:

{ blockdev-snapshot, blockdev-snapshot-internal-sync }

vs.

{ blockdev-snapshot-internal-sync, blockdev-snapshot }

Yes, I know that mixing internal and external snapshots is currently 
VERY dangerous 
(https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00865.html) if 
you aren't careful - but there are two plausible outcomes that can be 
chosen, where the order matters.  In the first instance, we want to 
create a new external snapshot (going from 'A' to 'A <- B') and THEN 
create an internal snapshot (image 'B' gets an internal snapshot); in 
the second instance we want to create an internal snapshot (image 'A' 
gets an internal snapshot) and THEN create an external snapshot (going 
from 'A' to 'A <- B').  Since the file where the internal snapshot is 
created is indeterminate unless we strictly process the transaction in 
the order that it was given, that argues that we want the strong order 
guarantees.

> 
> 
> At the very least, I think that's correct for 3.0 and the immediate
> future. If you disagree, please speak up because I've long been
> particularly uncertain about this aspect.
> 
> --John
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
