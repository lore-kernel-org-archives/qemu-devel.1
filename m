Received: from eggs.gnu.org ([2001:4830:134:3::10]:55401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cgBCp-0008Ea-Qi
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cgBCk-0003MV-Nx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:61822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cgBCk-0003M2-Et
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:14:10 -0500
Date: Tue, 21 Feb 2017 16:14:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170221161048-mutt-send-email-mst@kernel.org>
References: <88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<3fb8499e-884c-99e8-b295-3d4603921075@redhat.com>
	<20170220201923.GM2372@work-vm>
	<d51d4a21-5558-d4e5-5b7e-08f729fc1a5e@redhat.com>
	<0488d90c-f73c-916c-f84c-a1ffd2bad592@redhat.com>
	<20170221034053-mutt-send-email-mst@kernel.org>
	<5676cac1-b161-0500-e7ed-e93c273cc178@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5676cac1-b161-0500-e7ed-e93c273cc178@redhat.com>
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

On Tue, Feb 21, 2017 at 10:58:05AM +0100, Laszlo Ersek wrote:
> On 02/21/17 02:43, Michael S. Tsirkin wrote:
> > On Mon, Feb 20, 2017 at 09:55:40PM +0100, Laszlo Ersek wrote:
> >> On 02/20/17 21:45, Eric Blake wrote:
> >>> On 02/20/2017 02:19 PM, Dr. David Alan Gilbert wrote:
> >>>> * Eric Blake (eblake@redhat.com) wrote:
> >>>>> On 02/20/2017 04:23 AM, Dr. David Alan Gilbert wrote:
> >>>>>> * Laszlo Ersek (lersek@redhat.com) wrote:
> >>>>>>> CC Dave
> >>>>>>
> >>>>>> This isn't an area I really understand; but if I'm
> >>>>>> reading this right then 
> >>>>>>    vmgenid is stored in fw_cfg?
> >>>>>>    fw_cfg isn't migrated
> >>>>>>
> >>>>>> So why should any changes to it get migrated, except if it's already
> >>>>>> been read by the guest (and if the guest reads it again aftwards what's
> >>>>>> it expected to read?)
> >>>>>
> >>>>> Why are we expecting it to change on migration?  You want a new value
> >>>>
> >>>> I'm not; I was asking why a change made prior to migration would be
> >>>> preserved across migration.
> >>>
> >>> Okay, so you're asking what happens if the source requests the vmgenid
> >>> device, and sets an id, but the destination of the migration does not
> >>> request anything
> >>
> >> This should never happen, as it means different QEMU command lines on
> >> source vs. target hosts. (Different as in "incorrectly different".)
> >>
> >> Dave writes, "a change made prior to migration". Change made to what?
> >>
> >> - the GUID cannot be changed via the monitor once QEMU has been started.
> >> We dropped the monitor command for that, due to lack of a good use case,
> >> and due to lifecycle complexities. We have figured out a way to make it
> >> safe, but until there's a really convincing use case, we shouldn't add
> >> that complexity.
> > 
> > True but we might in the future, and it seems prudent to make
> > migration stream future-proof for that.
> 
> It is already.
> 
> The monitor command, if we add it, can be implemented incrementally. I
> described it as "approach (iii)" elsewhere in the thread. This is a more
> detailed recap:
> 
> - introduce a new device property (internal only), such as
>   "x-enable-set-vmgenid". Make it reflect whether a given machine type
>   supports the monitor command.

This is the part we can avoid at no real cost just
by making sure the guid is migrated.


> - change the /etc/vmgenid_guid fw_cfg blob from callback-less to one
>   with a selection callback
> 
> - add a new boolean latch to the vmgenid device, called
>   "guid_blob_selected" or something similar
> 
> - the reset handler sets the latch to FALSE
>   (NB: the reset handler already sets /etc/vmgenid_addr to zero)
> 
> - the select callback for /etc/vmgenid_guid sets the latch to TRUE
> 
> - the latch is added to the migration stream as a subsection *if*
>   x-enable-set-vmgenid is TRUE
> 
> - the set-vmgenid monitor command checks all three of:
>   x-enable-set-vmgenid, the latch, and the contents of
>   /etc/vmgenid_addr:
> 
>   - if x-enable-set-vmgenid is FALSE, the monitor command returns
>     QERR_UNSUPPORTED (this is a generic error class, with an
>     "unsupported" error message). Otherwise,
> 
>   - if the latch is TRUE *and* /etc/vmgenid_addr is zero, then the
>     guest firmware has executed (or started executing) ALLOCATE for
>     /etc/vmgenid_guid, but it has not executed WRITE_POINTER yet.
>     In this case updating the VMGENID from the monitor is unsafe
>     (we cannot guarantee informing the guest successfully), so in this
>     case the monitor command fails with ERROR_CLASS_DEVICE_NOT_ACTIVE.
>     The caller should simply try a bit later. (By which time the
>     firmware will likely have programmed /etc/vmgenid_addr.)

This makes no sense to me. Just update it in qemu memory
and write when guest asks for it.


>     Libvirt can recognize this error specifically, because it is not the
>     generic error class. ERROR_CLASS_DEVICE_NOT_ACTIVE stands for
>     "EAGAIN", practically, in this case.
> 
>   - Otherwise -- meaning latch is FALSE *or* /etc/vmgenid_addr is
>     nonzero, that is, the guest has either not run ALLOCATE since
>     reset, *or* it has, but it has also run WRITE_POINTER):
> 
>     - refresh the GUID within the fw_cfg blob for /etc/vmgenid_guid
>       in-place -- the guest will see this whenever it runs ALLOCATE for
>       /etc/vmgenid_guid, *AND*
> 
>     - if /etc/vmgenid_addr is not zero, then update the guest (that is,
>       RAM write + SCI)
> 
> Thanks
> Laszlo

Seems way more painful than it has to be. Just migrate the guid
and then management can write it at any time.


> > 
> >> - the address of the GUID is changed (the firmware programs it from
> >> "zero" to an actual address, in a writeable fw_cfg file), and that piece
> >> of info is explicitly migrated, as part of the vmgenid device's vmsd.
> >>
> >> Thanks
> >> Laszlo
> >>
> >>
> >>> - how does the guest on the destination see the same id
> >>> as was in place on the source at the time migration started.
> >>>
> >>>>
> >>>>
> >>>>> when you load state from disk (you don't know how many times the same
> >>>>> state has been loaded previously, so each load is effectively forking
> >>>>> the VM and you want a different value), but for a single live migration,
> >>>>> you aren't forking the VM and don't need a new generation ID.
> >>>>>
> >>>>> I guess it all boils down to what command line you're using: if libvirt
> >>>>> is driving a live migration, it will request the same UUID in the
> >>>>> command line of the destination as what is on the source; while if
> >>>>> libvirt is loading from a [managed]save to restore state from a file, it
> >>>>> will either request a new UUID directly or request auto to let qemu
> >>>>> generate the new id.
> >>>>
> >>>> Hmm now I've lost it a bit; I thought we would preserve the value
> >>>> transmitted from the source, not the value on the command line of the destination.
> >>>
> >>> I guess I'm trying to figure out whether libvirt MUST read the current
> >>> id and explicitly tell the destination of migration to reuse that id, or
> >>> if libvirt can omit the id on migration and everything just works
> >>> because the id was migrated from the source.
> >>>
