Received: from eggs.gnu.org ([2001:4830:134:3::10]:55415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQ9rr-00033D-0V
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQ9rp-0002yu-Lm
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 06:06:39 -0400
Date: Wed, 28 Jun 2017 12:06:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170628100621.GA5378@noname.redhat.com>
References: <20170627163145.GC4792@noname.redhat.com>
	<71a641e8-4701-58bf-29c5-090f30d59d91@redhat.com>
	<87mv8sd1tt.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mv8sd1tt.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [RFC] QMP design: Fixing query-block and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com

Am 28.06.2017 um 09:10 hat Markus Armbruster geschrieben:
> Eric Blake <eblake@redhat.com> writes:
> > On 06/27/2017 11:31 AM, Kevin Wolf wrote:
> >> If that's what we're going to do, I think I can figure out something
> >> nice for block nodes. That shouldn't be too hard. The only question
> >> would be whether we want a command to query one node or whether we would
> >> keep returning all of them.
> >
> > The age-old filtering question. It's also plausible to have a single
> > command, with an optional argument, and which always returns an array:
> > the full array if the argument was omitted, or an array of one matching
> > the argument when one was provided.  Adding filtering is an easy patch
> > on top once it is proven to make life easier for a client, and I'm okay
> > with a first approach that does not filter.
> 
> The graph may change.  Querying node by node would have to cope with
> changes somehow, which I'd expect to be complex and fragile.  I think we
> really need a way to get a complete, consistent graph.  So let's
> implement that first.  If we still want server-side filtering once
> that's done, we can add some on top.
> 
> As usual, I doubt we really need server-side filtering, and I dislike
> the interface complexity it brings.

I didn't really think of it as filtering. Every other operation is done
on a single object, so querying a single object would be the natural
extension. I mean, we also don't consider it "filtering" that we have
many separate query commands instead of a 'query-qemu-state'.

But you have a good point with the necessary atomicity, so we'll return
everything at once.

> >> I am, however, a bit less confident about BBs. As I said above, I
> >> consider them part of the qdev devices.
> 
> They weren't meant to be when I created them, but I guess it's what they
> evolved to be.
> 
> >>                                         As far as I know, there is no
> >> high-level infrastructure to query runtime state of devices and qdev
> >> properties are supposed to be read-only. Maybe non-qdev QOM properties
> >> can be used somehow?
> 
> Since qdev properties are implemented as QOM property, there are no
> non-qdev QOM properties.

You got the logic wrong here: "All qdev properties are QOM properties"
doesn't imply "All QOM properties are qdev properties". Now I don't say
that it's not true anyway, I don't know enough about QOM and qdev to say
much about it.

I always had the impression that qdev provided some wrappers around QOM
that add magic that makes properties configurable in -device and things
like that, which you wouldn't want for these properties. I also know
that devices aren't supposed to change qdev properties at runtime
(whereas I remember QOM not to have trouble with that), but I'm not sure
if there is a technical reason for this.

> >>                      But QOM isn't really nice to use as you need to
> >> query each property individually.
> 
> qom-get returns 'any'.  A read-only property with a complex value is
> already possible.  But it's awkward when you also want to get or set
> parts of the complex value.
> 
> Perhaps we could provide a way to get whole containers in addition to
> single properties.  Would that do?

You could query a device with a single command then, sounds much nicer.
Actually, your argument from above applies here, too: You want the
returned data to be consistent, so querying needs to be atomic. This
means that getting whole containers isn't only more convenient, but
actually more correct.

Another thought I have when comparing this with querying block nodes:
Wouldn't you still consider querying just a single device filtering?

> >> Another option would be to have a QMP command that takes a qdev ID of a
> >> block device and queries its BB. Or maybe it should stay like
> >> query-block and return an array of all of them, but include the qdev
> >> device name. Actually, maybe query-block can stay as it contains only
> >> two fields that are useless in the new world.
> >
> > Being able to query all the devices (with their BB's, and only a name
> > reference to the top-level BDS in use by the BB), separately from being
> > able to query all BDS, seems like a reasonable thing.  After all,
> > sometimes you care about what the guest sees (what devices have a BB),
> > and sometimes you care about what the host is exposing (what BDS are in
> > use).
> 
> No argument.  But let's not focus narrowly on block devices, or even
> devices.  If QOM "isn't really nice" for block devices, it probably
> isn't nice for lots of other things.  If we can address that at the QOM
> level, we should.

That's exactly what I think. Unfortunately, my knowledge about QOM is
seriously lacking. Even more unfortunately, everyone else seems to have
the same problem.

> >> I think this has become long enough now, so any opinions? On anything I
> >> said above, but preferably also about what a new interface should look
> >> like?
> >
> > Our existing interface is definitely awkward, with lots of redundancy in
> > some places and missing information in others, and a new interface does
> > seem like we can do better at designing it right up front rather than
> > bolting on yet more information to the existing queries (which results
> > in that much more noise to churn through to get to the desired information).
> 
> Replacing an interface that could be evolved to serve is a mistake.
> 
> Not replacing an interface when it has reached its design limits is also
> a mistake.
> 
> I normally advise against the first mistake.  But in this case, I think
> we have to avoid the second.  The interface has evolved into a confusing
> mess.  The gap between how the interface presents the block layer and
> how it actually works has become too large.  Sufficiently sophisticated
> clients have to bridge the gap somehow, and that's painful.

Thanks, the feedback so far is already very helpful in that everyone
agreed that we need something completely new. Now we just need to figure
out what it should look like. :-)

Kevin
