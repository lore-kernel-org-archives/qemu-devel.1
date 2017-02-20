Received: from eggs.gnu.org ([2001:4830:134:3::10]:59429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfnmh-0008SV-UO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfnme-0004HI-Ns
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:13:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cfnme-0004GS-Fa
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 08:13:40 -0500
Date: Mon, 20 Feb 2017 14:13:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170220141335.3bbb9681@nial.brq.redhat.com>
In-Reply-To: <1b2ce22b-3085-af08-332c-9519322b207e@redhat.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<88232638f9ff3b17b54987624468678ea14a3037.1487286467.git.ben@skyportsystems.com>
	<20170217114321.6c8577e1@nial.brq.redhat.com>
	<918524f7-26cf-3fce-d9e3-7316ca69285b@redhat.com>
	<20170220102304.GC2372@work-vm>
	<1ea5fff1-6216-8a8f-1e98-571253a3f596@redhat.com>
	<20170220110014.GD2372@work-vm>
	<1b2ce22b-3085-af08-332c-9519322b207e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com, mst@redhat.com

On Mon, 20 Feb 2017 12:38:06 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/20/17 12:00, Dr. David Alan Gilbert wrote:
> > * Laszlo Ersek (lersek@redhat.com) wrote:  
> >> On 02/20/17 11:23, Dr. David Alan Gilbert wrote:  
> >>> * Laszlo Ersek (lersek@redhat.com) wrote:  
> >>>> CC Dave  
> >>>
> >>> This isn't an area I really understand; but if I'm
> >>> reading this right then 
> >>>    vmgenid is stored in fw_cfg?
> >>>    fw_cfg isn't migrated
> >>>
> >>> So why should any changes to it get migrated, except if it's already
> >>> been read by the guest (and if the guest reads it again aftwards what's
> >>> it expected to read?)  
> >>
> >> This is what we have here:
> >> - QEMU formats read-only fw_cfg blob with GUID
> >> - guest downloads blob, places it in guest RAM
> >> - guest tells QEMU the guest-side address of the blob
> >> - during migration, guest RAM is transferred
> >> - after migration, in the device's post_load callback, QEMU overwrites
> >>   the GUID in guest RAM with a different value, and injects an SCI
> >>
> >> I CC'd you for the following reason: Igor reported that he didn't see
> >> either the fresh GUID or the SCI in the guest, on the target host, after
> >> migration. I figured that perhaps there was an ordering issue between
> >> RAM loading and post_load execution on the target host, and so I
> >> proposed to delay the RAM overwrite + SCI injection a bit more;
> >> following the pattern seen in your commit 90c647db8d59.
> >>
> >> However, since then, both Ben and myself tested the code with migration
> >> (using "virsh save" (Ben) and "virsh managedsave" (myself)), with
> >> Windows and Linux guests, and it works for us; there seems to be no
> >> ordering issue with the current code (= overwrite RAM + inject SCI in
> >> the post_load callback()).
> >>
> >> For now we don't understand why it doesn't work for Igor (Igor used
> >> exec/gzip migration to/from a local file using direct QEMU monitor
> >> commands / options, no libvirt). And, copying the pattern seen in your
> >> commit 90c647db8d59 didn't help in his case (while it wasn't even
> >> necessary for success in Ben's and my testing).  
> > 
> > One thing I noticed in Igor's test was that he did a 'stop' on the source
> > before the migate, and so it's probably still paused on the destination
> > after the migration is loaded, so anything the guest needs to do might
> > not have happened until it's started.  
> 
> Interesting! I hope Igor can double-check this!
I've retested v7, and it reliably fails (vmgenid_wait doesn't see change)
then I tested v8(qemu) + (seabios v5/v4) with the same steps as before
and it appears to work as expected, i.e. vmgenid_wait reports GUID
change after executing 'continue' monitor command so something
has been fixed in v8.


> 
> In the virsh docs, before doing my tests, I read that "managedsave"
> optionally took --running or --paused:
> 
>     Normally, starting a managed save will decide between running or
>     paused based on the state the domain was in when the save was done;
>     passing either the --running or --paused flag will allow overriding
>     which state the start should use.
> 
> I didn't pass any such flag ultimately, and I didn't stop the guests
> before the managedsave. Indeed they continued execution right after
> being loaded with "virsh start".
> 
> (Side point: managedsave is awesome. :) )
> 
> > 
> > You say;
> >    'guest tells QEMU the guest-side address of the blob'
> > how is that stored/migrated/etc ?  
> 
> It is a uint8_t[8] array (little endian representation), linked into
> another (writeable) fw_cfg entry, and it's migrated explicitly (it has a
> descriptor in the device's vmstate descriptor). The post_load callback
> relies on this array being restored before the migration infrastructure
> calls post_load.
> 
> Thanks
> Laszlo
> 
