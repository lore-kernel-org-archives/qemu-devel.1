Received: from eggs.gnu.org ([2001:4830:134:3::10]:38484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQX7t-0001ab-RR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQX7l-0001AX-3N
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:01:17 -0400
Date: Wed, 6 Jun 2018 13:00:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606120050.GB2661@work-vm>
References: <20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
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
> On 2018-06-06 13:14, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote:
> >> On 2018-06-05 11:21, Dr. David Alan Gilbert wrote:
> >>> <reawakening a fizzled out thread>
> >>>
> >>> This seems to have fizzled out because of a lack of a concrete proposal;
> >>> so here is one based on a reply to Max's post:
> >>>
> >>> * Max Reitz (mreitz@redhat.com) wrote:
> >>>
> >>> <snip>
> >>>
> >>>> The original problem was that you need to supply a machine type to qemu,
> >>>> and that multiple common architectures now have multiple machine types
> >>>> and not necessarily all work with a single image.  So far so good, but I
> >>>> have two issues here already:
> >>>>
> >>>> (1) How is qemu supposed to interpret that information?  If it's stored
> >>>> in the image file, I don't see a nice way of retrieving it before the
> >>>> machine is initialized, at least not with qemu's current architecture.
> >>>
> >>> <snip>
> >>>
> >>>> (2) Again, I personally just really don't like saving such information
> >>>> in a disk image.  One actual argument I can bring up for that distaste
> >>>> is this: Suppose, you have multiple images attached to your VM.  Now the
> >>>> VM wants to store the machine type.  Where does it go?  Into all of
> >>>> them?
> >>>
> >>> <snip>
> >>>
> >>>> So I think if we decide to store the machine type, that is kind of a
> >>>> slippery slope and then there are good arguments for storing even more
> >>>> configuration options in the file, too.  But I really, really don't like
> >>>> that.
> >>>
> >>> <snip>
> >>>
> >>>> For another, how do we store the data?  key-value seems wrong if we want
> >>>> to store everything.  JSON might be fine.  But eventually we just want
> >>>> basically a qemu configuration file in there, I would think (which may
> >>>> support JSON at some point?).   So basically we would store the data as
> >>>> a binary blob and let the rest of qemu do its thing with it.  But then
> >>>> please tell me why I fought so valiantly against storing random bitmaps
> >>>> in qcow2 files.  I hate the idea of making qcow2 a random archive
> >>>> format.  We have tar for that.
> >>>
> >>> <snip>
> >>>
> >>>> tl;dr: I really don't get why it's so hard to supply a config file along
> >>>> with a qcow2 image.  Is it so hard for people to realize that a VM does
> >>>> not only consist of a disk?
> >>>
> >>> Yes! Because in many cases that's all it needs, and it's ready to run
> >>> with no unpacking.
> >>
> >> It clearly is not, or we would not have this discussion.
> >>
> >> The disk image is only enough if you want the default values for all of
> >> qemu's configuration options, because today (and if I were to decide, in
> >> the future, too) disk images do not configure the VM (well, they
> >> configure the guest, but not the VM itself).
> > 
> > The problem with having a separate file is that you either have to copy
> > it around with the image 
> 
> Which is just an inconvenience.

It's more than that;  if it's a separate file then the tools can't
rely on users supplying it, and frankly they won't and they'll still
just supply an image.

> I understand it is an inconvenience and it would be nice to change it,
> but please understand that I do not want qcow2 to become a filesystem
> just to relieve an inconvenience.

I very much don't want it to be a filesystem; my reason for writing
down my spec the way I did was to make it clear that the only
thing I want of qcow2 is a single blob, no more; I don't want naming
of the blob or anything else.

> (Note: I understand that you may not want qcow2 to become a filesystem,
> but I do get the impression from others.)

My aim was to specify it to fulfill the requirements that everyone
else had asked for, but still only having one unmodifiable blob in qcow.

> >                           or have an archive. If you have an archive
> > you have to have an unpacking step which then copies, potentially a lot
> > of data taking some reasonable amount of time.
> 
> I'm sure this can be optimized, but yes, I get that.
> 
> (If you use e.g. tar and store the image data starting on an FS cluster
> boundary (64 kB should be more than sufficient), I assume there is a way
> to extract that data into a new file without copying anything.)

But then we have to modify all the current things that know how to
handle a qcow2.

> >                                                 Storing a simple bit
> > of data with the image avoids that.
> 
> It is not a simple bit of data, as evidenced by the discussion about
> storing binary blobs and MIME types going on.

All of the things they've suggested can be done inside that one blob;
even inside the json (or any other structure in that blob).

> >>> I think we should have:
> >>>
> >>> --------------------------------------------------------------
> >>> Layer 0:
> >>>    QCOW provides a way to store a single string of arbitrary (but
> >>> limited?) length.
> >>>    QCOW provides a way to replace the string by a new string.
> >>>    The original or the new string will be stored after that;
> >>>    never some mix.
> >>>    Where a file 'b' has a backing file 'a', 'b' inherits the
> >>>    string from 'a' unless 'b' has it's own string.
> >>>    Snapshots inherit their string from the main unless they have
> >>>    their own string.
> >>>
> >>> Layer 1:
> >>>    The string shall always be a JSON 'object'; i.e. of the form
> >>>     { "something": ... , "more": ... }
> >>>
> >>>    The key strings shall be non-null and non-empty and shall
> >>>    be unique.
> >>>
> >>> Layer 2:
> >>>    '.'s in the key string shall indicate hierarchy
> >>
> >> I don't understand why we we'd need dotted syntax when we already have
> >> JSON, but that's not my issue.
> > 
> > I think someone earlier in the thread had asked about how we handled
> > hierarchy so I added it.
> > 
> >>>    Key strings shall be listed in qemu's 
> >>>       docs/specs/qcow-keys.rst
> >>>
> >>>       that shall indicate their meaning and the meaning and
> >>>       valid formatting of the value associated with the,
> >>>
> >>>    Key strings shall start with either:
> >>>       qemu.   in which case they must be listed in a file in
> >>>               the qemu source tree
> >>>
> >>>       a reverse dotted name unique to the submitter, they may
> >>>               be listed in the same file in the source tree, e.g.
> >>>       com.redhat.
> >>
> >> So this is just another configuration file format.
> >>
> >>> Layer 3:
> >>>    QEMU shall, for a given qcow2 file be able to dump the
> >>>    key values.
> >>>
> >>> Layer 4:
> >>>    On creating a VM by importing a qcow2, a management layer
> >>>    shall inspect the key/values to influence the configuration
> >>>    of the VM created.   Where it imports multiple qcow2's it
> >>>    shall inspect all the files and flag disagreements.
> >>>
> >>>    Management layers shall, on creating a qcow2 shall set the
> >>>    keys based on the VM the qcow2 is created for.  If the qcow2
> >>>    is created as an additional disk for an exisitng VM it's
> >>>    fine to leave the string empty (e.g. for a data disk).
> >>
> >> This at least solves the issue of where qemu should store the data (qemu
> >> doesn't care), and how qemu should interpret it (not at all).
> >>
> >> But I really, really, really do not like storing arbitrary data in qcow2
> >> files.  I hated it badly enough when qemu knew what to do with it, but I
> >> hate it even more when even qemu has no idea what to do with it.
> >>
> >> Having a specification of what everything means in the qemu tree makes
> >> things less unbearable, but not to my liking still.
> > 
> > Have you said why you hate it so much?
> > Your hate for it seems to be making a simple solution hard.
> 
> Because it's a disk image format.  Data therein should be relevant to
> the disk image.  I see qcow2 as a representation of data stored on a
> physical storage medium.

What we're missing here is the notes scribbled on the sticky label on
the disc;  you rarely need them on a physical drive in a computer,
LUNs on a SAN don't need them that much because they have a full
filesystem and don't move about much.  Here we're talking about an image
being downloaded or sent between people.

> Some metadata associated directly with that is fine (such as dirty
> bitmaps, backing chains, things like that).  But configuring the whole
> VM seems out of scope to me.
> 
> Also, making qcow2 a filesystem is not a simple solution.
> 
> ...OK, let me back off here, I may be over-interpreting things and
> throwing opinions of different people into one pot.
> 
> Maybe you don't want qcow2 to be a filesystem, and you just want to
> store a single binary blob.  Well, OK, that's not that bad.  But in any
> case, I wouldn't call it a simple solution anymore.
> 
> Yes, storing just the machine type somewhere would be possible with a
> simple solution; but as I said (and the whole thread shows since then),
> this is a slippery slope, and suddenly we arrive at storing arbitrary
> binary data (like images?!) along with MIME types.  That will not be
> possible with a simple solution anymore, I don't think.

Right; I was thinking we were too far down that slope to get rid
of all of those requirements, but I was trying to force it back to
being a single blob as far as QCOW2 saw it.

> >>> --------------------------------------------------------------
> >>>    
> >>>
> >>> Some reasoning:
> >>>    a) I've avoided the problem of when QEMU interprets the value
> >>>       by ignoring it and giving it to management layers at the point
> >>>       of VM import.
> >>
> >> Yes, but in the process you've made it completely opaque to qemu,
> >> basically, which doesn't really make it better for me.  Not that
> >> qemu-specific information in qcow2 files would be what I want, but, well.
> >>
> >> But it does solve technical issues, I concede that.
> >>
> >>>    b) I hate JSON, but there again nailing down a fixed format
> >>>       seems easiest and it makes the job of QCOW easy - a single
> >>>       string.
> >>
> >> Not really.  The string can be rather long, so you probably don't want
> >> to store it in the image header, and thus it's just a binary blob from
> >> qcow2's perspective, essentially.
> > 
> > Yes, but it's a single blob - I'm not asking for multiple keyed blobs
> > or the ability to update individual blobs; just one blob that I can
> > replace.
> 
> OK, you aren't, but others seem to be.
> 
> Or, well, you call it a single blob.  But actually the current ideas
> seem to be to store a rather large configuration tree with binary data
> in that blob, so to me personally there is absolutely no functional
> difference to just storing a tar file in that blob.
> 
> So correct me if I'm wrong, but to me it appears that you effectively
> want to store a filesystem in qcow2.[1]  Well, that's better than making
> qcow2 the filesystem, but it still appears just the wrong way around to me.

It's different in the sense that what we end up with is still a qcow2;
anything that just handles qcow2's and can pass them through doesn't
need to do anything different; users don't need to do anything
different.  No one has to pack/unpack the file.

> [1] Yes, I know that the guest disk already contains an FS. :-P
> 
> >>>       (I would suggest in layer2 that the keys are sorted, but
> >>>       that's a pain to do in some json creators)
> >>>    c) Forcing the registry of keys might avoid silly duplication.
> >>>       We can but hope.
> >>>    d) I've not said it's a libvirt XML file since that seems
> >>>       a bit prescriptive.
> >>>
> >>> Some initial suggested keys:
> >>>
> >>>    "qemu.machine-types": [ "q35", "i440fx" ]
> >>>    "qemu.min-ram-MB": 1024
> >>
> >> I still don't understand why you'd want to put the configuration into
> >> qcow2 instead of the other way around.
> >>
> >> Or why you'd want to use a single file at all, because as this whole
> >> thread shows, a disk image alone is clearly not sufficient to describe a VM.
> >>
> >> (Or it may be in simple cases, but then that's because you don't need
> >> any configuration.)
> > 
> > Because it avoids the unpacking associated with archives.
> 
> I'm not talking about unpacking.  I'm talking about a potentially new
> format which allows accessing the qcow2 file in-place.  It would
> probably be trivial to write a block driver to allow this.
> 
> (And as I wrote in my response to Michal, I suspect that tar could
> actually allow this, even though it would probably not be the ideal format.)

As above, I don't think this is trivial; you have to change all the
layers;  lets say it was a tar; you'd have to somehow know that you're
importing one of these special tars, you also have to have a tool to
create them; and you have to worry about whether that alignment
is correct for the storage/memory you're using it with.

Dave

> Max
> 


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
