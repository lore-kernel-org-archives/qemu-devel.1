Received: from eggs.gnu.org ([2001:4830:134:3::10]:60787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cfzU9-0008P6-3q
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 20:43:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cfzU6-0003gO-1R
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 20:43:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cfzU5-0003cy-Ou
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 20:43:17 -0500
Date: Tue, 21 Feb 2017 03:43:12 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170221034053-mutt-send-email-mst@kernel.org>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
	<20170220201923.GM2372@work-vm>
	<d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
	<0488d90c-f73c-916c-f84c-a1ffd2bad592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0488d90c-f73c-916c-f84c-a1ffd2bad592@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 4/8] ACPI: Add Virtual Machine
 Generation ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com

On Mon, Feb 20, 2017 at 09:55:40PM +0100, Laszlo Ersek wrote:
> On 02/20/17 21:45, Eric Blake wrote:
> > On 02/20/2017 02:19 PM, Dr. David Alan Gilbert wrote:
> >> * Eric Blake (eblake@redhat.com) wrote:
> >>> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
> >>>> * Laszlo Ersek (lersek@redhat.com) wrote:
> >>>>> CC Dave
> >>>>
> >>>> This isn't an area I really understand; but if I'm
> >>>> reading this right then 
> >>>>    vmgenid is stored in fw_cfg?
> >>>>    fw_cfg isn't migrated
> >>>>
> >>>> So why should any changes to it get migrated, except if it's already
> >>>> been read by the guest (and if the guest reads it again aftwards what's
> >>>> it expected to read?)
> >>>
> >>> Why are we expecting it to change on migration?  You want a new value
> >>
> >> I'm not; I was asking why a change made prior to migration would be
> >> preserved across migration.
> > 
> > Okay, so you're asking what happens if the source requests the vmgenid
> > device, and sets an id, but the destination of the migration does not
> > request anything
> 
> This should never happen, as it means different QEMU command lines on
> source vs. target hosts. (Different as in "incorrectly different".)
> 
> Dave writes, "a change made prior to migration". Change made to what?
> 
> - the GUID cannot be changed via the monitor once QEMU has been started.
> We dropped the monitor command for that, due to lack of a good use case,
> and due to lifecycle complexities. We have figured out a way to make it
> safe, but until there's a really convincing use case, we shouldn't add
> that complexity.

True but we might in the future, and it seems prudent to make
migration stream future-proof for that.

> - the address of the GUID is changed (the firmware programs it from
> "zero" to an actual address, in a writeable fw_cfg file), and that piece
> of info is explicitly migrated, as part of the vmgenid device's vmsd.
> 
> Thanks
> Laszlo
> 
> 
> > - how does the guest on the destination see the same id
> > as was in place on the source at the time migration started.
> > 
> >>
> >>
> >>> when you load state from disk (you don't know how many times the same
> >>> state has been loaded previously, so each load is effectively forking
> >>> the VM and you want a different value), but for a single live migration,
> >>> you aren't forking the VM and don't need a new generation ID.
> >>>
> >>> I guess it all boils down to what command line you're using: if libvirt
> >>> is driving a live migration, it will request the same UUID in the
> >>> command line of the destination as what is on the source; while if
> >>> libvirt is loading from a [managed]save to restore state from a file, it
> >>> will either request a new UUID directly or request auto to let qemu
> >>> generate the new id.
> >>
> >> Hmm now I've lost it a bit; I thought we would preserve the value
> >> transmitted from the source, not the value on the command line of the destination.
> > 
> > I guess I'm trying to figure out whether libvirt MUST read the current
> > id and explicitly tell the destination of migration to reuse that id, or
> > if libvirt can omit the id on migration and everything just works
> > because the id was migrated from the source.
> > 
