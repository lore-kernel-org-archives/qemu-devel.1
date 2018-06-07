Received: from eggs.gnu.org ([2001:4830:134:3::10]:35098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2gc-0002sr-2a
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2gZ-0004x0-Hb
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:43:14 -0400
Date: Fri, 8 Jun 2018 00:43:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608002005-mutt-send-email-mst@kernel.org>
References: <20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606175551-mutt-send-email-mst@kernel.org>
	<8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc775cd-f98c-c795-3935-855e56f01b68@redhat.com>
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

On Wed, Jun 06, 2018 at 07:06:27PM +0200, Max Reitz wrote:
> On 2018-06-06 17:09, Michael S. Tsirkin wrote:
> > On Wed, Jun 06, 2018 at 04:51:39PM +0200, Max Reitz wrote:
> >> On 2018-06-06 16:31, Dr. David Alan Gilbert wrote:
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>> On 2018-06-06 14:00, Dr. David Alan Gilbert wrote:
> >>>>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>>>> On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
> >>>>>>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>>>>>> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
> >>>>>>>>> <reawakening a fizzled out thread>
> >>>
> >>> <snip>
> >>>
> >>>>>>> The problem with having a separate file is that you either have to copy
> >>>>>>> it around with the image 
> >>>>>>
> >>>>>> Which is just an inconvenience.
> >>>>>
> >>>>> It's more than that;  if it's a separate file then the tools can't
> >>>>> rely on users supplying it, and frankly they won't and they'll still
> >>>>> just supply an image.
> >>>>
> >>>> At which point you throw an error and tell them to specify the config file.
> >>>
> >>> No:
> >>>    a) At the moment they get away with it for images since they're all
> >>>       'pc' and the management layers do the right thing.
> >>
> >> So so far nobody has complained?  I don't really see the problem then.
> >>
> >> If deploying a disk and using all the defaults works out for users,
> >> great.  If they want more options, apparently they already know they
> >> have to provide some config.
> > 
> > QEMU's usability is terrible. There are tons of tools out there to try
> > to tame it, but of course they lack the knowledge of the VM internals
> > that QEMU has.
> 
> Er, yeah, OK.  But it was my understanding that we decided that we have
> a management layer on top of qemu to make things simple.

Who's we? I don't think the QEMU community completely gave up on people
using QEMU directly. It will need to be much more user-friendly than it
is right now. But it's possible. Fabrice built an emulator in
javascript, you go to a URL bam it runs a VM.

> Also, this is once more a case of first deciding what we want at all.

Who's we here again? Different people want different things. Enough
people seem to want to store tagged data with a disk image that it might
be worth someone's while to try to add that capability for starters to
qemu-img.

> Dave wants configuration options for the upper management layer which
> are completely opaque to qemu.  That has nothing to do whatsoever with
> the usability of qemu itself.

That's why I keep saying, let's start with implementing a mechanism,
worry about policy later if at all.

> >>>    b) They'll give the wrong config file - then you'd need to add a flag
> >>>      to detect that - which means you'd need to add something to the
> >>>      qcow to match it to the config; loop back to teh start!
> >>
> >> I'm not sure how seriously I should take this argument.  Do stupid
> >> things, win stupid prizes.
> >>
> >> If that's the issue, add a UUID to qcow2 files and reference it from the
> >> config file.
> >>
> >>> We should make this EASY for users.
> >>
> >> To me, having a simple config file they can edit manually certainly
> >> seems simpler than having to use specific tools to edit it inside of the
> >> qcow2 file.
> > 
> > I think you are one of the happy users familiar with qemu intricacies
> > and/or using a tool on top that does it for you.
> 
> Yeah, virt-manager and sometimes libvirt directly.  Works nicely.  In
> any case, having to manage more than a single file was never one of my
> worries.  In fact, I never had to manage any file because both tools do
> it for me.
> 
> And again, I don't know what the usability of qemu has to do with what
> Dave is proposing.
> 
> [...]

I think what we are seeing here is many people jumping on the
bandwagon and finding more and more uses for ability to store
meta-data in the qcow2 file.

This just means we should make it flexible enough to possibly
support more uses. It does not mean we need to make it
read mail on day 1.

> >> Because I think (maybe I'm wrong, though) where to store it heavily
> >> depends on what we want to store and how we want to use it.
> > 
> > I don't really see why.
> 
> For instance, supporting full-blown appliances would mean supporting
> multiple images.  Maybe in multiple formats.  Maybe the user wants
> runtime performance and is willing to give up a bit of installation time
> for that (e.g. for unpacking an archive).
> 
> In any case, if we want to be able to configure every kind of VM, tying
> everything to qcow2 seems like a bad idea.  First defining a format and
> then deciding on whether it makes sense to be able to put it into qcow2
> for certain subcases seems much more reasonable.
> 
> And if you make the format decidedly qcow2-independent, the whole
> "putting it into qcow2 is the simplest implementation" argument becomes
> rather weak.

I don't see why. Yes I think it's a separate format that we should just
allow storing in qcow2 for usability.


> >>> I've not seen anything that's not for either:
> >>>   a) The user to know what the image is
> >>
> >> I thought the use case was they just downloaded it.
> >>
> >> Otherwise, they should manage their filenames reasonably, come on.
> >> Seriously, adding a cute picture because users are too stupid to manage
> >> their VMs is *not* qcow2's problem.
> > 
> > QEMU is hard to use right and it is QEMU's problem. Users aren't stupid
> > but neither do they have the time to learn internals of the tools they
> > use.
> 
> Technically, it's the users' problem.
>  It may be qemu's fault, though.

I find solving peoblems interesting. I don't find assigning blame
interesting.

> 
> I will not say it is qemu's fault, because I was always told we have a
> management layer to make things simple again.  "qemu worries about
> execution, management layer worries about policy" is what I was told.
> 
> Also, I have no idea what you are talking about.  I gave a very specific
> example.  How is adding a picture to a VM disk image going to help
> anyone?  If that's the issue people are facing, I would argue they
> probably have a multitude of different issues with using qemu, because I
> fully agree with you on that point -- using qemu for complex cases is
> hard.  Well, no, it's simple, really, but then you probably won't get
> the best out of it.  (As can be seen by the fact that some people seem
> to start their VM just based on a disk image, and that seems to work...)
> 
> So, using qemu in the best way possible is hard.  But a pictogram in a
> disk image will not solve that problem.  I was always told that using a
> management layer solves the problem.  And as I understood, this was what
> Dave's proposal was about, the management layer, not qemu.
> 
> I would expect from the management layer to at least make managing VMs
> easy.  The management layer can give names.  It can present pictures.
> It can manage files.  It can export a config file + disk image so that
> it can be imported somewhere else.
> 
> Therefore, I don't know what you mean by "learn internals of the tools
> they use".  They don't need to do that, if they use a management layer.
> All they need to do is to supply everything the management layer may ask
> of them, and I do not understand why it is too difficult to request a
> plain config file that the user doesn't even need to understand.  They
> just need to download it along with the disk image.
> 
> 
> But all of that writing once again comes down to this: You are talking
> about qemu.  Dave is talking about something higher in the management
> layer.  Those are different things, and as I said, we first need to find
> common ground there.

The common ground is that both me and Dave find it useful to store meta-data
in the disk image.

> This is exactly why I said "where to store it heavily depends on what we
> want to store and how we want to use it."  As long as we don't know
> that, all of us are using strawman arguments where some other party
> suddenly chimes in and says "no, no, no, this is not what I'm talking
> about".  Yes, maybe you aren't, but someone else is.
> 
> [...]

Looks like discussion has run its course.

I think it's time for someone motivated enough to send a patch.
If enough interested people ack it, we will know it addresses
some of their needs.


> >>>> But really, if you create a VM, you need a configuration.  Like if you
> >>>> set up a new computer, you need to know what you want.  Usually there is
> >>>> no sticky label, but you just have to know and input it manually.  Maybe
> >>>> you have a sheet of paper, which I'd call the configuration file.
> >>>
> >>> Most things are figurable-out by the management tools/defaults or
> >>> are dependent on the whim of the user - we're only trying to stop the
> >>> user doing things that wont work.
> >>
> >> But what's so bad about an empty screen because the user hasn't read the
> >> download description?
> > 
> > Because user just learns to avoid QEMU as being too hard in the future.
> 
> So you want appliances, do I understand that correctly?  Because that is
> exactly what Dave doesn't want.

That's policy. I see no need to prevent people from building appliances,
though right now I'm not interested in building them myself.
We there's a mechanism both kinds of people can use, then great.

> Furthermore, another case of "qemu is too hard to use".  I will not
> argue against you there, because that may very well be true, but I will
> once again say that I was of the impression that we had management
> layers to handle that complexity.
> 
> >>> Simpler example; what stops you trying to put the PPC qcow image into
> >>> your x86 VM system - nothing that I know of.  I just want to stop the
> >>> users shooting themselves in the foot.
> >>
> >> They haven't shot themselves in the foot, they've just wasted a bit of
> >> their time, which could've been avoided by reading before clicking.
> >>
> >> [...]
> > 
> > Software developers are being paid for saving people's time.
> 
> Very good point, but I did say something like this before: I do not
> oppose appliances whatsoever.  In fact, it seems like a nice thing to have.
> 
> But, here's the deal: I do not think putting that data into qcow2 to be
> the best solution.  Furthermore, I have things to do that I consider
> more important than developing an appliance solution.  Therefore, it's
> not like I'm sitting around doing nothing when I could be developing a
> solution to this issue here.
> 
> I kept saying that I consider all of this an inconvenience.  Yes, it
> would be nice to have.  But I have things on my to do list that are hard
> feature requests, things that people really do need.  We all have.  We
> all need to decide how we can use our own time as efficiently as
> possible.  And I do not think that developing an appliance solution
> would be the best use of my time.  (Until my manager disagrees.)

As long as you don't start sending nacks on the basis that it's also not
the best use of other's time, I don't mind.

> >>>>>>>>> --------------------------------------------------------------
> >>>>>>>>>    
> >>>>>>>>>
> >>>>>>>>> Some reasoning:
> >>>>>>>>>    a) I've avoided the problem of when QEMU interprets the value
> >>>>>>>>>       by ignoring it and giving it to management layers at the point
> >>>>>>>>>       of VM import.
> >>>>>>>>
> >>>>>>>> Yes, but in the process you've made it completely opaque to qemu,
> >>>>>>>> basically, which doesn't really make it better for me.  Not that
> >>>>>>>> qemu-specific information in qcow2 files would be what I want, but, well.
> >>>>>>>>
> >>>>>>>> But it does solve technical issues, I concede that.
> >>>>>>>>
> >>>>>>>>>    b) I hate JSON, but there again nailing down a fixed format
> >>>>>>>>>       seems easiest and it makes the job of QCOW easy - a single
> >>>>>>>>>       string.
> >>>>>>>>
> >>>>>>>> Not really.  The string can be rather long, so you probably don't want
> >>>>>>>> to store it in the image header, and thus it's just a binary blob from
> >>>>>>>> qcow2's perspective, essentially.
> >>>>>>>
> >>>>>>> Yes, but it's a single blob - I'm not asking for multiple keyed blobs
> >>>>>>> or the ability to update individual blobs; just one blob that I can
> >>>>>>> replace.
> >>>>>>
> >>>>>> OK, you aren't, but others seem to be.
> >>>>>>
> >>>>>> Or, well, you call it a single blob.  But actually the current ideas
> >>>>>> seem to be to store a rather large configuration tree with binary data
> >>>>>> in that blob, so to me personally there is absolutely no functional
> >>>>>> difference to just storing a tar file in that blob.
> >>>>>>
> >>>>>> So correct me if I'm wrong, but to me it appears that you effectively
> >>>>>> want to store a filesystem in qcow2.[1]  Well, that's better than making
> >>>>>> qcow2 the filesystem, but it still appears just the wrong way around to me.
> >>>>>
> >>>>> It's different in the sense that what we end up with is still a qcow2;
> >>>>> anything that just handles qcow2's and can pass them through doesn't
> >>>>> need to do anything different; users don't need to do anything
> >>>>> different.  No one has to pack/unpack the file.
> >>>>
> >>>> Packing/unpacking is a strawman because I'm doing my best to give
> >>>> proposals that completely avoid that.
> >>>>
> >>>> Users do need to do something different, because users do need to
> >>>> realize that today there is no way to store VM configuration and disk
> >>>> data in a single file.  So if they already start VMs just based on a
> >>>> disk, then they are assuming behavior we do not have and that I'd call
> >>>> naive.  But that is a strawman from my side, sorry.  Keeping naive users
> >>>> happy is probably OK.
> >>>
> >>> Remember this all works fine now and has done for many years;
> >>> it's the addition of q35 that breaks that assumption.
> >>> The users can already blidly pick up the qcow2 image and stuff it in
> >>
> >> Which probably was blind luck already.  And if it wasn't, that means
> >> they knew the defaults are what they want.  So now they'd know they
> >> aren't and they have to offer a config file along with the disk image.
> >>
> >>> and it all works; all I want is for that to keep working.
> >>
> >> And all I say is that it's not unreasonable to expect users to realize
> >> that a VM is more than a disk image, just like a computer is more than a
> >> disk drive; and that handling two files really is not the end of the world.
> >>
> >> (And neither is wasting someone's time because they can't read.)
> >>
> >> Firstly, I agree it's a nice thing to have, but it's not worth it if we
> >> don't come up with clear rules on how to prevent developing a full
> >> appliance format.
> >>
> >> Or maybe we want that (because I still believe that you can always come
> >> up with obscure options without which the VM won't boot in your specific
> >> case), but then this is beyond just storing a tiny bit of data in a
> >> qcow2 image.
> >>
> >> [...]
> > 
> > Either we'll add more and more data later or we won't. Why worry about
> > it from the start? We'll never get anywhere if we do.
> 
> That is not a very good argument.  Adding things always means having to
> support them later.  It does make a lot of sense to worry about this
> burden before starting, and thus trying to find the best possible
> solution for the future, not the easiest hack for now.
> 
> And as I've said multiple times now, but I can't repeat myself often
> enough, I think it would be most efficient if we worried about what we
> want to store first, before we worry about where to store it.  I believe
> that once we have a hard requirement on what we want to store and how to
> use it (that most people agree on), we will have a set of constraints on
> how we can represent that data and where it needs to be stored, and this
> will give us a simple yes or no to the question whether the data needs
> to be stored in qcow2, or whether there is any better way (or whether it
> can be stored in qcow2, but need not be).

Well the subject says it, does it not? We want to store
machine data there.


> >>>>>> [1] Yes, I know that the guest disk already contains an FS. :-P
> >>>>>>
> >>>>>>>>>       (I would suggest in layer2 that the keys are sorted, but
> >>>>>>>>>       that's a pain to do in some json creators)
> >>>>>>>>>    c) Forcing the registry of keys might avoid silly duplication.
> >>>>>>>>>       We can but hope.
> >>>>>>>>>    d) I've not said it's a libvirt XML file since that seems
> >>>>>>>>>       a bit prescriptive.
> >>>>>>>>>
> >>>>>>>>> Some initial suggested keys:
> >>>>>>>>>
> >>>>>>>>>    "qemu.machine-types": [ "q35", "i440fx" ]
> >>>>>>>>>    "qemu.min-ram-MB": 1024
> >>>>>>>>
> >>>>>>>> I still don't understand why you'd want to put the configuration into
> >>>>>>>> qcow2 instead of the other way around.
> >>>>>>>>
> >>>>>>>> Or why you'd want to use a single file at all, because as this whole
> >>>>>>>> thread shows, a disk image alone is clearly not sufficient to describe a VM.
> >>>>>>>>
> >>>>>>>> (Or it may be in simple cases, but then that's because you don't need
> >>>>>>>> any configuration.)
> >>>>>>>
> >>>>>>> Because it avoids the unpacking associated with archives.
> >>>>>>
> >>>>>> I'm not talking about unpacking.  I'm talking about a potentially new
> >>>>>> format which allows accessing the qcow2 file in-place.  It would
> >>>>>> probably be trivial to write a block driver to allow this.
> >>>>>>
> >>>>>> (And as I wrote in my response to Michal, I suspect that tar could
> >>>>>> actually allow this, even though it would probably not be the ideal format.)
> >>>>>
> >>>>> As above, I don't think this is trivial; you have to change all the
> >>>>> layers;  lets say it was a tar; you'd have to somehow know that you're
> >>>>> importing one of these special tars,
> >>>>
> >>>> Which is trivial because it's just "Hey, look, it's a tar with that
> >>>> description file".
> >>>
> >>> Trivial? It's taking 100+ mails to add a tag to a qcow2 file! Can you
> >>> imagine what it takes to change libvirt, openstack, ovirt and the rest?
> >>
> >> :-)
> >>
> >> The implementation is trivial is what I meant, just like the
> >> implementation would be rather simple for qcow2 to store a binary blob
> >> and completely ignore it.
> > 
> > Old QEMU can't handle tar files. You need to unpack them,
> > then figure out that there are two files in the tar, one
> > is just for new qemu versions, one is portable. At which point
> > you need to go figure out what is your QEMU version.
> 
> And old qemu versions will just give you a blank screen for a qcow2 file
> with required non-default options.
> 
> Max

Compatiblity is not worthless simply because we do not have time travel.

-- 
MST
