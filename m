Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZTg-0001Ow-TR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZTc-0001g8-OM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:31:56 -0400
Date: Wed, 6 Jun 2018 15:31:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606143134.GG2660@work-vm>
References: <20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

* Max Reitz (mreitz@redhat.com) wrote:
> On 2018-06-06 14:00, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
> >>>>> <reawakening a fizzled out thread>

<snip>

> >>> The problem with having a separate file is that you either have to copy
> >>> it around with the image 
> >>
> >> Which is just an inconvenience.
> > 
> > It's more than that;  if it's a separate file then the tools can't
> > rely on users supplying it, and frankly they won't and they'll still
> > just supply an image.
> 
> At which point you throw an error and tell them to specify the config file.

No:
   a) At the moment they get away with it for images since they're all
      'pc' and the management layers do the right thing.
   b) They'll give the wrong config file - then you'd need to add a flag
     to detect that - which means you'd need to add something to the
     qcow to match it to the config; loop back to teh start!

We should make this EASY for users.

> >> I understand it is an inconvenience and it would be nice to change it,
> >> but please understand that I do not want qcow2 to become a filesystem
> >> just to relieve an inconvenience.
> > 
> > I very much don't want it to be a filesystem; my reason for writing
> > down my spec the way I did was to make it clear that the only
> > thing I want of qcow2 is a single blob, no more; I don't want naming
> > of the blob or anything else.
> > 
> >> (Note: I understand that you may not want qcow2 to become a filesystem,
> >> but I do get the impression from others.)
> > 
> > My aim was to specify it to fulfill the requirements that everyone
> > else had asked for, but still only having one unmodifiable blob in qcow.
> > 
> >>>                           or have an archive. If you have an archive
> >>> you have to have an unpacking step which then copies, potentially a lot
> >>> of data taking some reasonable amount of time.
> >>
> >> I'm sure this can be optimized, but yes, I get that.
> >>
> >> (If you use e.g. tar and store the image data starting on an FS cluster
> >> boundary (64 kB should be more than sufficient), I assume there is a way
> >> to extract that data into a new file without copying anything.)
> > 
> > But then we have to modify all the current things that know how to
> > handle a qcow2.
> 
> Not in this case because it'd still be a flat qcow2 file in a simple tar
> archive.
> 
> But you're right if we had a more complex format (like chunks stored in
> a tar file).

My only problem with using the tar like that is that all tools
everywhere would need to be updated to be able to parse them.
(Note if adding a blob to qcow2 like I'm asking for would break existing
qcow2 users then I don't want it either).

> >>>                                                 Storing a simple bit
> >>> of data with the image avoids that.
> >>
> >> It is not a simple bit of data, as evidenced by the discussion about
> >> storing binary blobs and MIME types going on.
> > 
> > All of the things they've suggested can be done inside that one blob;
> > even inside the json (or any other structure in that blob).
> 
> Right, from qcow2's perspective it's a blob of data.  But you can put a
> whole filesystem into a blob of data, and I get the impression that this
> is what some are trying to do.
> 
> Once we store larger amounts of binary data in that blob (which is what
> I'm fearing from comments on MIME types and PNG images), people will
> realize that always having to re-store the whole blob if you modify
> something in the middle is inefficient and that it needs to be
> optimized.  I don't think you want to do that, but we haven't
> implemented any of this yet and people are already asking for such
> binary data inside of the blob.
> 
> I suspect it'll only get worse over time.
> I think the most difficult thing about this discussion is that there are
> different targets.
> 
> You just want to store a bit of information.  OK, good, but then I'd say
> we could even just prepend that to the image file in a small header.


I think you're over-reading what people are asking for.
I think the PNG suggestion is again the 'label on the front' for a logo.
I've not seen anything that's not for either:
  a) The user to know what the image is
  b) The management layer to know what type of VM to create

> (Note that extending that header would not even be too complicated,
> because you can easily move the qcow2 header somewhere else.  Say you
> move it back by one cluster (e.g. 64 kB), then you just put the cluster
> that was there originally to the end of the file, which is pretty much
> trivial.  Then you copy that original data there and overwrite it with
> the image header.  Done.)
> 
> Others want to store more binary data.  Then this may get inefficient
> and insufficient.  But I'd think at this point it gets really
> problematic to put the data into the qcow2 file because it really
> doesn't belong there.  (I can't imagine anything that would warrant a
> MIME type.)

No, I can't imagine why anyone wants a MIME type either.

> Then I've heard proposals of storing multiple disk images.  Yes, you
> could store multiple disks inside of a single qcow2 file, but it would
> be basically exactly the same as storing just multiple qcow2 files, so...

No, completely agree.

> And really, I still believe in my slippery slope argument, which means
> that even if you just want to innocently store a machine type, we will
> end up with something vastly more complex in the end.
> 
> Finally, it appears to me that you have a simple problem, found one
> possible solution, and now you just focus on that solution instead of
> taking a step back and looking at the problem again.
> 
> The problem: You want to store a binary blob and a disk image together.
> 
> Your solution: qcow2 has refcounting and thus "occupation bits".  You
> can put data into it and it will leave it alone, as long as that area is
> marked as occupied.  Let's put the data into the qcow2 file.
> 
> OK, let's look at the problem and its constraints again.
> 
> Hard constraint: Store a single file.
> (I don't think this is a hard constraint, because I haven't been
> convinced yet that handling more than a single file is so bad.)

See above; I think it is.
My other hard contraint is that no tool has to change unless
it wants to make use of the new data.

> Soft constraint: Max doesn't like storing blobs in qcow2.
> 
> So one solution is to ignore the soft constraint.  OK, valid solution, I
> give you that.  But it doesn't leave me content, probably understandably so.
> 
> 
> So let me try to understand how we end up with qcow2 as a result...  We
> need a single file that needs to contain both the disk data and a binary
> blob.  Or, well, even better would be if that file can store multiple
> arbitrary objects, in a format of your choosing, but that makes things
> more complicated, so let's leave that off for now.
> 
> So all you need is object storage (probably with a single root object
> that references the rest in a custom format) and a way to tell which
> areas of the file are occupied.  Now the issue is that both the disk
> image and the blob may grow.  So both need mutual understanding of which
> areas are occupied and which can be used for growth.  For the disk
> image, the block layer would definitely need a driver to handle that,
> which is not impossible.  But qcow2 would automatically handle it.
> 
> So, OK, for now this is my result.  If we create a new format, we'd need
> a block driver for it (underneath qcow2) that handles the allocation.
> With qcow2, we'd get it for free.
> 
> 
> Hm, OK.
> 
> The simplest implementation for such an additional layer would get away
> without actual occupation bits and just always allocate new storage at
> the end of the file.  That should be sufficient, it would be quick and
> not very complex.  But I see that it is additional complexity when
> compared with just adding the blob to qcow2.
> 
> 
> Well, in a sense, because we'd need block layer interfaces for
> extracting the information from a qcow2 file through qemu-img.  So maybe
> adding another block driver would actually mean less complexity...
> 
> 
> [...]
> 
> >>>> But I really, really, really do not like storing arbitrary data in qcow2
> >>>> files.  I hated it badly enough when qemu knew what to do with it, but I
> >>>> hate it even more when even qemu has no idea what to do with it.
> >>>>
> >>>> Having a specification of what everything means in the qemu tree makes
> >>>> things less unbearable, but not to my liking still.
> >>>
> >>> Have you said why you hate it so much?
> >>> Your hate for it seems to be making a simple solution hard.
> >>
> >> Because it's a disk image format.  Data therein should be relevant to
> >> the disk image.  I see qcow2 as a representation of data stored on a
> >> physical storage medium.
> > 
> > What we're missing here is the notes scribbled on the sticky label on
> > the disc;  you rarely need them on a physical drive in a computer,
> > LUNs on a SAN don't need them that much because they have a full
> > filesystem and don't move about much.  Here we're talking about an image
> > being downloaded or sent between people.
> 
> Well, qcow2 doesn't even describe the device type, so the sticky label
> may be off limits.
> 
> But really, if you create a VM, you need a configuration.  Like if you
> set up a new computer, you need to know what you want.  Usually there is
> no sticky label, but you just have to know and input it manually.  Maybe
> you have a sheet of paper, which I'd call the configuration file.

Most things are figurable-out by the management tools/defaults or
are dependent on the whim of the user - we're only trying to stop the
user doing things that wont work.
Simpler example; what stops you trying to put the PPC qcow image into
your x86 VM system - nothing that I know of.  I just want to stop the
users shooting themselves in the foot.

> >> Some metadata associated directly with that is fine (such as dirty
> >> bitmaps, backing chains, things like that).  But configuring the whole
> >> VM seems out of scope to me.
> >>
> >> Also, making qcow2 a filesystem is not a simple solution.
> >>
> >> ...OK, let me back off here, I may be over-interpreting things and
> >> throwing opinions of different people into one pot.
> >>
> >> Maybe you don't want qcow2 to be a filesystem, and you just want to
> >> store a single binary blob.  Well, OK, that's not that bad.  But in any
> >> case, I wouldn't call it a simple solution anymore.
> >>
> >> Yes, storing just the machine type somewhere would be possible with a
> >> simple solution; but as I said (and the whole thread shows since then),
> >> this is a slippery slope, and suddenly we arrive at storing arbitrary
> >> binary data (like images?!) along with MIME types.  That will not be
> >> possible with a simple solution anymore, I don't think.
> > 
> > Right; I was thinking we were too far down that slope to get rid
> > of all of those requirements, but I was trying to force it back to
> > being a single blob as far as QCOW2 saw it.
> 
> A valiant effort, but I myself cannot see why we should forbid storing
> more data once we started storing some data.  I myself do think that if
> we store some VM configuration, we should be able to store all of it,
> and allow for arbitrarily complex scenarios.
> 
> >>>>> --------------------------------------------------------------
> >>>>>    
> >>>>>
> >>>>> Some reasoning:
> >>>>>    a) I've avoided the problem of when QEMU interprets the value
> >>>>>       by ignoring it and giving it to management layers at the point
> >>>>>       of VM import.
> >>>>
> >>>> Yes, but in the process you've made it completely opaque to qemu,
> >>>> basically, which doesn't really make it better for me.  Not that
> >>>> qemu-specific information in qcow2 files would be what I want, but, well.
> >>>>
> >>>> But it does solve technical issues, I concede that.
> >>>>
> >>>>>    b) I hate JSON, but there again nailing down a fixed format
> >>>>>       seems easiest and it makes the job of QCOW easy - a single
> >>>>>       string.
> >>>>
> >>>> Not really.  The string can be rather long, so you probably don't want
> >>>> to store it in the image header, and thus it's just a binary blob from
> >>>> qcow2's perspective, essentially.
> >>>
> >>> Yes, but it's a single blob - I'm not asking for multiple keyed blobs
> >>> or the ability to update individual blobs; just one blob that I can
> >>> replace.
> >>
> >> OK, you aren't, but others seem to be.
> >>
> >> Or, well, you call it a single blob.  But actually the current ideas
> >> seem to be to store a rather large configuration tree with binary data
> >> in that blob, so to me personally there is absolutely no functional
> >> difference to just storing a tar file in that blob.
> >>
> >> So correct me if I'm wrong, but to me it appears that you effectively
> >> want to store a filesystem in qcow2.[1]  Well, that's better than making
> >> qcow2 the filesystem, but it still appears just the wrong way around to me.
> > 
> > It's different in the sense that what we end up with is still a qcow2;
> > anything that just handles qcow2's and can pass them through doesn't
> > need to do anything different; users don't need to do anything
> > different.  No one has to pack/unpack the file.
> 
> Packing/unpacking is a strawman because I'm doing my best to give
> proposals that completely avoid that.
> 
> Users do need to do something different, because users do need to
> realize that today there is no way to store VM configuration and disk
> data in a single file.  So if they already start VMs just based on a
> disk, then they are assuming behavior we do not have and that I'd call
> naive.  But that is a strawman from my side, sorry.  Keeping naive users
> happy is probably OK.

Remember this all works fine now and has done for many years;
it's the addition of q35 that breaks that assumption.
The users can already blidly pick up the qcow2 image and stuff it in and
it all works; all I want is for that to keep working.

> Keeping tools working is a good argument, but I'm not exactly sure what
> the use cases are.  What I'd want is that in the end we have a way of
> configuring a whole VM in a single file.[1]  Then, that file is no
> longer just a disk image, it is a whole VM.  So maybe those tools need
> to be adjusted anyway.
> 
> I assume that we have tools that work on disk images, and we trivially
> want to keep them working on that VM's disk image without having to
> incorporate a block layer.  Depending on the format we choose, that may
> be very simple (maybe just use an offset for the qcow2 header).
> 
> But if we want to store a whole VM in a single file, then storing
> multiple disk images in that single file does not seem too far off to
> me, and that would mean breaking those tools anyway.
> 
> [1] I still don't quite see the point, because just using more than a
> single file is so much easier.
> 
> >> [1] Yes, I know that the guest disk already contains an FS. :-P
> >>
> >>>>>       (I would suggest in layer2 that the keys are sorted, but
> >>>>>       that's a pain to do in some json creators)
> >>>>>    c) Forcing the registry of keys might avoid silly duplication.
> >>>>>       We can but hope.
> >>>>>    d) I've not said it's a libvirt XML file since that seems
> >>>>>       a bit prescriptive.
> >>>>>
> >>>>> Some initial suggested keys:
> >>>>>
> >>>>>    "qemu.machine-types": [ "q35", "i440fx" ]
> >>>>>    "qemu.min-ram-MB": 1024
> >>>>
> >>>> I still don't understand why you'd want to put the configuration into
> >>>> qcow2 instead of the other way around.
> >>>>
> >>>> Or why you'd want to use a single file at all, because as this whole
> >>>> thread shows, a disk image alone is clearly not sufficient to describe a VM.
> >>>>
> >>>> (Or it may be in simple cases, but then that's because you don't need
> >>>> any configuration.)
> >>>
> >>> Because it avoids the unpacking associated with archives.
> >>
> >> I'm not talking about unpacking.  I'm talking about a potentially new
> >> format which allows accessing the qcow2 file in-place.  It would
> >> probably be trivial to write a block driver to allow this.
> >>
> >> (And as I wrote in my response to Michal, I suspect that tar could
> >> actually allow this, even though it would probably not be the ideal format.)
> > 
> > As above, I don't think this is trivial; you have to change all the
> > layers;  lets say it was a tar; you'd have to somehow know that you're
> > importing one of these special tars,
> 
> Which is trivial because it's just "Hey, look, it's a tar with that
> description file".

Trivial? It's taking 100+ mails to add a tag to a qcow2 file! Can you
imagine what it takes to change libvirt, openstack, ovirt and the rest?


> >                                      you also have to have a tool to
> > create them;
> 
> Also trivial.  Non-trivial is modifying them.
> 
> The workflow would be to create the tar with an empty qcow2 file, the VM
> description you want, and then just using it.
> 
> Yes, using is more difficult, but it wouldn't be an own tool, it would
> be built into qemu.  I can't say how difficult that implementation would
> be, but it would not be trivial, that is correct.
> 
> >              and you have to worry about whether that alignment
> > is correct for the storage/memory you're using it with.
> 
> Which would be difficult with tar, right.  But we don't have to use tar.
> 
> (And, no, I don't think creating a new container format is not worse for
> interoperability than adding a blob to qcow2.)

If you were going to do this then you'd end up just using OVA.
You couldn't justify yet another format.

Dave

> Max
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
