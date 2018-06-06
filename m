Received: from eggs.gnu.org ([2001:4830:134:3::10]:36808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQUza-0002Ha-8i
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQUzY-0001jU-Qh
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 05:44:34 -0400
Date: Wed, 6 Jun 2018 10:44:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606094418.GC2660@work-vm>
References: <20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<20180605190324.GA11372@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605190324.GA11372@localhost.localdomain>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> On Tue, Jun 05, 2018 at 10:21:59AM +0100, Dr. David Alan Gilbert wrote:
> > <reawakening a fizzled out thread>
> > 
> > This seems to have fizzled out because of a lack of a concrete proposal;
> > so here is one based on a reply to Max's post:
> > 
> > * Max Reitz (mreitz@redhat.com) wrote:
> > 
> > <snip>
> > 
> > > The original problem was that you need to supply a machine type to qemu,
> > > and that multiple common architectures now have multiple machine types
> > > and not necessarily all work with a single image.  So far so good, but I
> > > have two issues here already:
> > > 
> > > (1) How is qemu supposed to interpret that information?  If it's stored
> > > in the image file, I don't see a nice way of retrieving it before the
> > > machine is initialized, at least not with qemu's current architecture.
> > 
> > <snip>
> > 
> > > (2) Again, I personally just really don't like saving such information
> > > in a disk image.  One actual argument I can bring up for that distaste
> > > is this: Suppose, you have multiple images attached to your VM.  Now the
> > > VM wants to store the machine type.  Where does it go?  Into all of
> > > them?
> > 
> > <snip>
> > 
> > > So I think if we decide to store the machine type, that is kind of a
> > > slippery slope and then there are good arguments for storing even more
> > > configuration options in the file, too.  But I really, really don't like
> > > that.
> > 
> > <snip>
> > 
> > > For another, how do we store the data?  key-value seems wrong if we want
> > > to store everything.  JSON might be fine.  But eventually we just want
> > > basically a qemu configuration file in there, I would think (which may
> > > support JSON at some point?).   So basically we would store the data as
> > > a binary blob and let the rest of qemu do its thing with it.  But then
> > > please tell me why I fought so valiantly against storing random bitmaps
> > > in qcow2 files.  I hate the idea of making qcow2 a random archive
> > > format.  We have tar for that.
> > 
> > <snip>
> > 
> > > tl;dr: I really don't get why it's so hard to supply a config file along
> > > with a qcow2 image.  Is it so hard for people to realize that a VM does
> > > not only consist of a disk?
> > 
> > Yes! Because in many cases that's all it needs, and it's ready to run
> > with no unpacking.
> > 
> > I think we should have:
> > 
> > --------------------------------------------------------------
> > Layer 0:
> >    QCOW provides a way to store a single string of arbitrary (but
> > limited?) length.
> >    QCOW provides a way to replace the string by a new string.
> >    The original or the new string will be stored after that;
> >    never some mix.
> >    Where a file 'b' has a backing file 'a', 'b' inherits the
> >    string from 'a' unless 'b' has it's own string.
> >    Snapshots inherit their string from the main unless they have
> >    their own string.
> > 
> > Layer 1:
> >    The string shall always be a JSON 'object'; i.e. of the form
> >     { "something": ... , "more": ... }
> > 
> >    The key strings shall be non-null and non-empty and shall
> >    be unique.
> > 
> 
> I'd prefer layer 0+1 to:
> 
> 1) Allow multiple entries to be stored (implemented by layer 1
>    in this proposal)
> 2) Identify each entry with a name (implemented by layer 1 in
>    this proposal)
> 3) Allow arbitrary binary data to be stored on an entry
>    (not possible with the JSON-based proposal, because JSON
>    strings are not blobs, but Unicode strings).
> 4) Make it easy to replace only one entry while keeping others
>    intact (not the case here, if all entries are stored in the
>    same JSON string)
> 
> I think it would be simpler if layer 0 simply provided a list of
> names/value pairs, where names are ascii strings, and values are
> binary data[1].  It would make layer 1 unnecessary, and allow (3)
> and (4) to happen.
> 
> [1] In other words, Rich's proposal of "named blobs":
> https://www.mail-archive.com/qemu-block@nongnu.org/msg37856.html

My reasoning was just one of simplicity; each layer in this is
almost trivial.
The downside to my proposal is it's more expensive if you want
to change a single key; but as yet no one has suggested why we'd
want to do it frequently enough to worry.

My suggestion of JSON was just to try and stop the bikeshedding;
we seem to be putting a lot of effort into inventing a new
storage definition for something that so far we need to hold
one rarely changing short string, which even with all the discussion
has moved upto maybe 3 or 4 rarely changing pieces of data.

Dave


> 
> 
> > Layer 2:
> >    '.'s in the key string shall indicate hierarchy
> >    
> >    Key strings shall be listed in qemu's 
> >       docs/specs/qcow-keys.rst
> > 
> >       that shall indicate their meaning and the meaning and
> >       valid formatting of the value associated with the,
> > 
> >    Key strings shall start with either:
> >       qemu.   in which case they must be listed in a file in
> >               the qemu source tree
> > 
> >       a reverse dotted name unique to the submitter, they may
> >               be listed in the same file in the source tree, e.g.
> >       com.redhat.
> > 
> 
> Based on this proposal for layer 2, it looks like you expect the
> number of keys used on layer 1 to become large.
> 
> I would prefer a solution that expects a very small set of keys
> for layer 0+1, and point to other specifications of how the blob
> can be interpreted for each key.  This way we can experiment with
> different solutions for layers 2-4, instead of deciding on a
> specific format like JSON.
> 
> 
> > Layer 3:
> >    QEMU shall, for a given qcow2 file be able to dump the
> >    key values.
> > 
> > Layer 4:
> >    On creating a VM by importing a qcow2, a management layer
> >    shall inspect the key/values to influence the configuration
> >    of the VM created.   Where it imports multiple qcow2's it
> >    shall inspect all the files and flag disagreements.
> > 
> >    Management layers shall, on creating a qcow2 shall set the
> >    keys based on the VM the qcow2 is created for.  If the qcow2
> >    is created as an additional disk for an exisitng VM it's
> >    fine to leave the string empty (e.g. for a data disk).
> > 
> > --------------------------------------------------------------
> >    
> > 
> > Some reasoning:
> >    a) I've avoided the problem of when QEMU interprets the value
> >       by ignoring it and giving it to management layers at the point
> >       of VM import.
> >    b) I hate JSON, but there again nailing down a fixed format
> >       seems easiest and it makes the job of QCOW easy - a single
> >       string.
> >       (I would suggest in layer2 that the keys are sorted, but
> >       that's a pain to do in some json creators)
> >    c) Forcing the registry of keys might avoid silly duplication.
> >       We can but hope.
> >    d) I've not said it's a libvirt XML file since that seems
> >       a bit prescriptive.
> > 
> > Some initial suggested keys:
> > 
> >    "qemu.machine-types": [ "q35", "i440fx" ]
> >    "qemu.min-ram-MB": 1024
> > 
> > 
> > Dave
> > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
> -- 
> Eduardo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
