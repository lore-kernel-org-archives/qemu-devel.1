Received: from eggs.gnu.org ([2001:4830:134:3::10]:59721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fbSon-0007Cz-TE
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:38:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fbSom-00011C-QJ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:38:45 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-3-vsementsov@virtuozzo.com>
	<79b1dc41-b230-3958-8057-4061c18a7814@redhat.com>
	<63c582e8-4646-ad59-3d89-ce07f78e390c@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <43e22b35-39c3-f596-5a0a-f899376911ad@redhat.com>
Date: Fri, 6 Jul 2018 11:38:34 -0400
MIME-Version: 1.0
In-Reply-To: <63c582e8-4646-ad59-3d89-ce07f78e390c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 07/06/2018 06:12 AM, Vladimir Sementsov-Ogievskiy wrote:
> 
> Ok, let's go this way for now, I'll rewrite it.
> 
> Last requirement looks a bit strange for me in transaction context. We
> should not assume that action is done before commit.
> What is main idea of transaction action, do everything which will not
> fail in commit, or do everything which may be undone in prepare? Is
> there more formal way to manage dependencies between actions in one
> transaction?

Honestly, that's what I was wondering -- is there some formal model
people would be familiar with to help explain inter-dependencies between
transactional actions?

I don't know of one, presently, so I'm making it up as I go along.

I think this statement is intuitively true, though:

"For actions that are affected by other actions, the order of those two
actions matter, with the first action having an effect on the second."

We process actions in a linear order, first .prepare and then .commit --
so actions that come first in the list do have their callbacks executed
first. There's no way to express priority otherwise unless we give
certain actions a priority score, which we don't have right now.

Next, backup actions take ownership of the bitmap in .prepare()... so in
order for bitmap manipulation commands to affect these actions, they
also need to modify the bitmap in .prepare().

This may feel counter-intuitive to how transactions appear to be
designed to work, but on this subject Stefan said (May 2015):

> The ambiguity is whether "commit the changes" for .commit() means
> "changes take effect" or "discard stashed state, making undo
> impossible".
> 
> I think the "discard stashed state, making undo impossible"
> interpretation is good because .commit() is not allowed to fail.  That
> function should only do things that never fail.

I think this is probably the correct way to proceed, and we ought to
formalize this model. I think it's actually nearly impossible to do it
the other way around, too.

Let's say we've got two actions that both do error-checking in .prepare,
but perform their actual stateful changes in .commit, but are
interdependent.

{ a, b }

- a.prepare() checks state and confirms we will be able to proceed, but
changes no state.
- b.prepare() checks state and confirms it will be able to proceed, but
can't see what a is planning to do.
- a.commit() succeeds as expected.
- b.commit() does not fail as it is not allowed to, but the effects are
undetermined because we have not checked the state change from a.commit()

In general we can get around this, but the more actions we add, the
harder it is to do proper error checking while considering the
hypothetical state after some actions have committed.

I think the model where we take effect in .prepare() and undo it if
necessary in .abort() is actually easier to model in your head, because
error checking is simpler. That's probably the right model, then.



At the very least, I think that's correct for 3.0 and the immediate
future. If you disagree, please speak up because I've long been
particularly uncertain about this aspect.

--John
