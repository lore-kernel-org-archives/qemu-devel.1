Received: from eggs.gnu.org ([2001:4830:134:3::10]:50850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCEb-0001B7-C3
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fSCEZ-0000Fj-Fv
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:07:05 -0400
Date: Mon, 11 Jun 2018 05:06:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180611044053-mutt-send-email-mst@kernel.org>
References: <20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606175551-mutt-send-email-mst@kernel.org>
	<8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
	<20180608002005-mutt-send-email-mst@kernel.org>
	<5dc0b886-a7c3-50a6-e4db-bde26919af3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc0b886-a7c3-50a6-e4db-bde26919af3a@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

On Sat, Jun 09, 2018 at 11:34:03PM +0200, Max Reitz wrote:
> qemu would be very easy to use if it didn't offer any configuration
> options.  The problem is that is offers a huge load of configuration
> options and it is not reasonable to expect every user to know all of them.

Right but once one user id find a way to make a specific guest work in a
specific VM, it should not be as hard as it is to replicate the success.

...

> > This just means we should make it flexible enough to possibly
> > support more uses. It does not mean we need to make it
> > read mail on day 1.
> 
> So you are saying that we may end up with multiple parties storing
> (meta-)data independently in the qcow2 file?

Absolutely.

> before there are concrete design documents, and on why it doesn't matter
> that you focus on qemu whereas others focus on the management layer.

Right. That's what I'm saying.

> Though it would mean opaque storage, as I've said, and that storing data
> in the qcow2 file still probably does not make sense for some of the
> possible use cases.  For instance, you propose storing data for qemu
> proper without any management layer, but this poses the question again
> of who should interpret that data.  (A management layer may just query
> the image before launching qemu and then set the appropriate options,
> but it gets difficult for the block layer to open the qcow2 image and
> change the machine type when qemu is already running.  Though maybe you
> could at least error out when incompatible options have been used to
> launch qemu.  Hm.  Another question was who'd be supposed to store the
> data.)
> 
> [...]
> 
> >> And if you make the format decidedly qcow2-independent, the whole
> >> "putting it into qcow2 is the simplest implementation" argument becomes
> >> rather weak.
> > 
> > I don't see why. Yes I think it's a separate format that we should just
> > allow storing in qcow2 for usability.
> 
> It becomes weak because storing it in qcow2 would no longer be the
> simplest implementation if you'd need to be able to read it from a file
> outside of a qcow2 image anyway.
> 
> It still may be the easiest use case for users.
> 
> [...]
> 
> >> But all of that writing once again comes down to this: You are talking
> >> about qemu.  Dave is talking about something higher in the management
> >> layer.  Those are different things, and as I said, we first need to find
> >> common ground there.
> > 
> > The common ground is that both me and Dave find it useful to store meta-data
> > in the disk image.
> 
> Though it seems to me that you have very different ideas on how to store
> it.  As far as I have understood, Dave just wants to store a bit of data
> that might even go into the image header, whereas you'd prefer a
> full-blown infrastructure for binary storage and large objects, because
> someone might want that at some point.
> 
> That isn't to say I personally prefer either, it just means that those
> are different and deciding on one naturally changes what to do.
> 
> There may be even other approaches, I don't know.

I thought I heard Dave utter "key-value store" at some point,
which likely precludes "go directly into the header".


> And my idea was that we should evaluate the different use cases for
> storing arbitrary metadata in a qcow2 file, and then we'd see whether it
> does or doesn't make sense to do so, for each case.

As block guys maybe you could ask more specific questions then.
E.g. "would 1/2K of data be sufficient for these purposes"?
That's a more valid point than a generic "tells us what it's
for" question.

> I think making qemu store something in the qcow2 file doesn't bring too
> much because first, qemu couldn't really interpret that information by
> itself (it could at best detect conflicting configuration, though in my
> head checking qemu configuration in the qcow2 driver screams complexity;
> and storing that information automatically would be problematic); and
> secondly, I don't think that we can solve the complexity that is modern
> qemu configuration by just putting it into a qcow2 file.  That will only
> work as long as the user doesn't want to change anything.  There is
> probably much more to say, but all of that would deserve its own thread.

But I do think we can solve only doing it once and not per user
of an image.

> Regarding designing an appliance format, there has already been some
> discussion, so I won't say anything about that now, except that it too
> should go into its own thread so that people are aware and don't think
> it's just a qcow2 issue.
> 
> >> This is exactly why I said "where to store it heavily depends on what we
> >> want to store and how we want to use it."  As long as we don't know
> >> that, all of us are using strawman arguments where some other party
> >> suddenly chimes in and says "no, no, no, this is not what I'm talking
> >> about".  Yes, maybe you aren't, but someone else is.
> >>
> >> [...]
> > 
> > Looks like discussion has run its course.
> > 
> > I think it's time for someone motivated enough to send a patch.
> > If enough interested people ack it, we will know it addresses
> > some of their needs.
> 
> OK, but don't expect me to merge it at the current state of this
> discussion[2].  If you or someone else sends a patch, I may raise my
> concerns (though I will probably not NACK it) and I will defer the
> decision to Kevin.
> 
> [2] By that I mean that I will not merge a feature-adding patch with a
> justification of "We'll find a use for it later", which is exactly what
> you've said in this mail.  (Though Dave does have concrete intentions,
> so if he can expand on that, give an ACK and explain why this is worth
> the effort (and the effort depends on the implementation complexity),
> then things will probably be different.)
> 
> [...]

I'd expect a first patch to have ability to store and retrieve the
machine type used. Hopefully for qemu to check and warn if
it does not match the specified one, and probably using
as default if nothing was specified.


> >> So you want appliances, do I understand that correctly?  Because that is
> >> exactly what Dave doesn't want.
> > 
> > That's policy. I see no need to prevent people from building appliances,
> 
> Dave does.  He explicitly raised the idea of limiting the things that
> can be stored in a qcow2 file, precisely because he didn't want the
> feature to become too complex.
> 
> > though right now I'm not interested in building them myself.
> > We there's a mechanism both kinds of people can use, then great.
> 
> Such a flexible feature means complexity, and in my opinion a complex
> feature needs a reasonable justification.  "People will find a use for
> it" is not reasonable.
> 
> Although it really is not unlikely that I'm wrong and that a flexible
> metadata storage does not need to be complex.
> 
> [...]

I'm not saying people will find a use for it. I think we
already have one use for it and if it's generic enough
more people will find more uses for it.


> >>> Software developers are being paid for saving people's time.
> >>
> >> Very good point, but I did say something like this before: I do not
> >> oppose appliances whatsoever.  In fact, it seems like a nice thing to have.
> >>
> >> But, here's the deal: I do not think putting that data into qcow2 to be
> >> the best solution.  Furthermore, I have things to do that I consider
> >> more important than developing an appliance solution.  Therefore, it's
> >> not like I'm sitting around doing nothing when I could be developing a
> >> solution to this issue here.
> >>
> >> I kept saying that I consider all of this an inconvenience.  Yes, it
> >> would be nice to have.  But I have things on my to do list that are hard
> >> feature requests, things that people really do need.  We all have.  We
> >> all need to decide how we can use our own time as efficiently as
> >> possible.  And I do not think that developing an appliance solution
> >> would be the best use of my time.  (Until my manager disagrees.)
> > 
> > As long as you don't start sending nacks on the basis that it's also not
> > the best use of other's time, I don't mind.
> 
> No, but I'm one of the qcow2 maintainers, so any feature added to qcow2
> just is a burden to myself and may therefore cost me time.
>
> Luckily there is another qcow2 maintainer, so I will not NACK features
> based on the fact that they are just a burden.  If Kevin wants to merge
> a feature that I don't deem sufficiently useful, then he can go right ahead.
> 
> [...]
> >> And as I've said multiple times now, but I can't repeat myself often
> >> enough, I think it would be most efficient if we worried about what we
> >> want to store first, before we worry about where to store it.  I believe
> >> that once we have a hard requirement on what we want to store and how to
> >> use it (that most people agree on), we will have a set of constraints on
> >> how we can represent that data and where it needs to be stored, and this
> >> will give us a simple yes or no to the question whether the data needs
> >> to be stored in qcow2, or whether there is any better way (or whether it
> >> can be stored in qcow2, but need not be).
> > 
> > Well the subject says it, does it not? We want to store
> > machine data there.
> 
> Are you sure?
> 
> Firstly, that is not sufficiently precise.  Do you want an appliance,
> i.e. store everything?  Do you want to store just something and limit
> everyone in what can be stored (Dave's proposal)?  That is a difference,
> and that is exactly what I was asking.
> 
> Secondly, in this mail you even seemed to propose storing just any
> metadata that might be related to a VM (or maybe not even that).  This
> too has some (meta-?)influence on the design.
> 
> For instance, if you want to store only VM-related information, we can
> document those structures in the qcow2 specification in the qemu tree
> (or at least link to another document in the qemu tree).  But if you
> want to be able to store any metadata that just anyone wants to store,
> then that won't be possible.  (And this would have implications.  For
> instance, someone might decide on storing metadata that makes the qcow2
> image effectively unreadable (e.g. by storing a special backing link).
> I wouldn't like that, but we couldn't do anything about it if we'd allow
> storage of arbitrary metadata.)
> 
> [...]


And what if I say "whatever"? Yes I see a very specific usecase
which will be well served by adding a specific bit of data
in the disk image. Others see other uses.

> >>> Old QEMU can't handle tar files. You need to unpack them,
> >>> then figure out that there are two files in the tar, one
> >>> is just for new qemu versions, one is portable. At which point
> >>> you need to go figure out what is your QEMU version.
> >>
> >> And old qemu versions will just give you a blank screen for a qcow2 file
> >> with required non-default options.
> > 
> > Compatiblity is not worthless simply because we do not have time travel.
> 
> Dave was saying that the worst thing about the whole q35 thing is that
> users download an image and have no idea why it isn't working.  Figuring
> that out may take a long time, because nothing is even throwing an error
> message.
> 
> If we had a new format, users couldn't even run it in qemu, so they
> would quickly figure out that in order to run this VM, they need to
> update their stack.

Since then users of old software can't use your
image at all, then most people simply will not create
the new fangled image format.

> If we just add this information to qcow2, those users with outdated qemu
> versions would again have to figure out why the image isn't working.

By that metric compatibility is never worth it unless you have
ability to add new functionality retroactively to existing
software.

> 
> Sure, that is a minor issue that would solve itself by users slowly
> upgrading their qemu, but it goes to show that compatibility may not
> always be what is best.
> 
> Max
> 

Certainly in this case the feature is minor, so it's extremely
important.

-- 
MST
