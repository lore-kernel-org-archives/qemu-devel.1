Received: from eggs.gnu.org ([2001:4830:134:3::10]:48515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNeUT-0001sv-Ny
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fNeUP-0001Tw-GX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:16:41 -0400
Date: Tue, 29 May 2018 10:16:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180529131621.GX8988@localhost.localdomain>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180524113251.GB4660@redhat.com>
	<d9bb2cb9-d9dc-8fe0-a767-10d9cbbab803@redhat.com>
	<20180528183058.GG2209@redhat.com>
	<20180528183833.GJ4580@localhost.localdomain>
	<bbd19001-3e42-565b-bd48-c4370204c5ff@redhat.com>
	<20180528190915.GK4580@localhost.localdomain>
	<233d8d33-1865-9100-aa1e-07979473f495@redhat.com>
	<20180529101428.GB4756@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529101428.GB4756@localhost.localdomain>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, May 29, 2018 at 12:14:28PM +0200, Kevin Wolf wrote:
> Am 29.05.2018 um 11:23 hat Max Reitz geschrieben:
> > On 2018-05-28 21:09, Kevin Wolf wrote:
> > > Am 28.05.2018 um 20:44 hat Max Reitz geschrieben:
> > >> On 2018-05-28 20:38, Kevin Wolf wrote:
> > >>> Am 28.05.2018 um 20:30 hat Richard W.M. Jones geschrieben:
> > >>>> On Mon, May 28, 2018 at 08:10:32PM +0200, Max Reitz wrote:
> > >>>>> As someone who is just naive and doesn't see the big picture, I don't
> > >>>>> see what's wrong with using a tar file that contains the image and
> > >>>>> additional data.
> > >>>>
> > >>>> FWIW an OVA file is exactly this: an uncompressed tar file containing
> > >>>> disk image(s) and metadata.
> > >>>
> > >>> If we combine VM configuration and the disk image this way, I would
> > >>> still want to directly use that combined thing without having to extract
> > >>> its components first.
> > >>>
> > >>> Just accessing the image file within a tar archive is possible and we
> > >>> could write a block driver for that (I actually think we should do
> > >>> this), but it restricts you because certain operations like resizing
> > >>> aren't really possible in tar. Unfortunately, resizing is a really
> > >>> common operation for non-raw image formats.
> > >>>
> > >>> And if I think of a file format that can contain several different
> > >>> things that can be individually resized etc., I end up with qcow2 in the
> > >>> simple case or a full file system in the more complex case.
> > >>
> > >> Well, you end up with VMDK.
> > > 
> > > I don't think VMDK can save several different objects? It can have some
> > > metadata in the descriptor, and it can spread the contents of a single
> > > object across multiple files (with extents), but I don't think it has
> > > something comparable to e.g. qcow2 snapshots, which are separate objects
> > > with an individual size that can dynamically change.
> > 
> > Right, I tried to be funny and was over-simplifying in the process.
> > 
> > What I meant is: You end up with an image format that is spread on a
> > filesystem, like VMDK is (usually).  Then you have some metadata
> > descriptor file that describes the rest and multiple data object files.
> > 
> > (For completeness's sake: And you can use an external or an internal
> > filesystem, that is, use multiple files (like VMDK) or have an internal
> > filesystem (like tar, except tar doesn't allow fragmentation).)
> 
> Let's call the libvirt XML the image file and the qcow2 files its
> data object files and we're done?

libvirt XML doesn't seems to be a solution for the problem, but a
separate VM specification file could work anyway.


> 
> I'm afraid spreading things across multiple files doesn't meet the
> requirements for the problem at hand, though...

Yeah, I wanted to make this an extension of qcow2, so people
don't have Yet Another file format to choose from.  We could also
let libvirt automatically write hints to disk images so things
would Just Work if you copied a disk image from an existing VM.

But I'm not the one working on management layers or guest image
tools, so I will just trust Richard's and Daniel's opinions on
this.

-- 
Eduardo
