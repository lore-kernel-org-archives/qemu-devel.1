Received: from eggs.gnu.org ([2001:4830:134:3::10]:49693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceN1o-00076i-9y
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceN1m-00052p-R0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:27:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ceN1m-00051p-IQ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:27:22 -0500
Date: Thu, 16 Feb 2017 15:27:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170216152717.71f03695@nial.brq.redhat.com>
In-Reply-To: <5cf80b35-6119-7f18-b761-cb4e4fb3be48@redhat.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<678c203f-3768-7e65-6e48-6729473b6ffa@redhat.com>
	<20170215220837-mutt-send-email-mst@kernel.org>
	<e7e9cf57-a5b4-4f2b-36e5-3e08dee70d68@redhat.com>
	<20170216130800.1f2833aa@nial.brq.redhat.com>
	<5cf80b35-6119-7f18-b761-cb4e4fb3be48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/7] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ben@skyportsystems.com, qemu-devel@nongnu.org

On Thu, 16 Feb 2017 14:29:28 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 02/16/17 13:08, Igor Mammedov wrote:
> > On Wed, 15 Feb 2017 21:52:55 +0100
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >   
> >> On 02/15/17 21:09, Michael S. Tsirkin wrote:  
> >>> On Wed, Feb 15, 2017 at 08:47:48PM +0100, Laszlo Ersek wrote:    
> >>
> >> [snip]
> >>  
> >>>> For patches #1, #3, #4 and #5:
> >>>>
> >>>> Tested-by: Laszlo Ersek <lersek@redhat.com>
> >>>>
> >>>> I'll soon post the OVMF patches.
> >>>>
> >>>> Thanks!
> >>>> Laszlo    
> >>>
> >>>
> >>> How do you feel about Igor's request to change WRITE_POINTER to add
> >>> offset in there, so guest can pass in the address of GUID and
> >>> not start of table? Would that be a lot of work to add?    
> >>
> >> I think it's doable in practice: simply add a constant from the command
> >> itself, for passing the value back to QEMU, and also for saving the
> >> fw_cfg write commend for S3 resume time.
> >>
> >> But, I disagree with it from a design POV.
> >>
> >> Igor's point is:
> >>  
> >>> Math complicates QEMU code though and not only QMEMU but AML code as
> >>> well.    
> >>
> >> As I understand it, the goal is to push the addition to the firmware
> >> (which is "one place"), rather than having to implement it twice in
> >> QEMU, i.e., in two places ((a) native QEMU logic, (b) AML generator).
> >>
> >> Here's my counter-argument:
> >>
> >> (a) As I mentioned earlier, assume a complex communication structure
> >> between the guest OS and QEMU. Currently our shared structure consists
> >> of a single field (the GUID), but next time it might contain several fields.
> >>
> >> For such a multi-field shared structure, QEMU will have to do manual
> >> offsetting into the guest RAM anyway, for accessing fields F1, F2, and
> >> F3. We will not create three separate WRITE_POINTER commands and let the
> >> firmware calculate and return the absolute GPAs of the fields F1, F2 and
> >> F3. Instead, there will be one WRITE_POINTER command, and QEMU will do
> >> the offsetting manually, minimally for fields F2 and F3.
> >>
> >> "src_offset" looks tempting now only because we have a shared structure
> >> with only one field, the GUID at offset 40 decimal.  
> > 
> > benefits of having src_offset from QEMU POV I see are:
> >  a) (biggest one) firmware and device code are clearly separated where:
> >      - VMGENID_GUID_OFFSET would be used only by firmware side, such as:
> >          WRITE_POINTER and AML addition to help OVMF detect non ACPI blob
> >      - device doesn't have to assume/or have a knowledge about
> >        layout of GUID blob except of size of data it's needs
> >        to access at location provided by WRITE_POINTER as v7 shows it.
> > 
> >  b) wrt shared blob I've envisioned slightly different approach,
> >     where multiple WRITE_POINTER commands are used instead of one
> >     with following workflow to extend shared blob:
> >      1) firmware part of QEMU (acpi-build.c):
> >           if (device_foo_present) {
> >              fw_cfg_add_file_callback('/etc/device_foo_addr', device_foo->addr_storage)
> > 
> >              shared_off = device_foo->align(next_free_shared_offset)
> >              WRITE_POINTER('/etc/device_foo_addr', 0,
> >                            '/etc/shared_blob, shared_off)
> > 
> >              next_free_shared_offset = shared_off + device_foo->data_size;
> >           }
> >      2) device_foo accesses data at device_foo->addr_storage directly
> >         * there is no need to spread knowledge of shared_blob
> >           layout to device code anymore.  
> 
> This is where I disagree, I think. Above you mention
> device_foo->data_size. If "data_size" covers multiple fields, then the
> device code itself will have to add relative offsets, for accessing
> those different fields in guest RAM.
> 
> With the current command, the only difference is that the device code
> has to receive a "base offset" from the outside, pointing into the
> shared blob, and then add the field offsets to that. Thus the addition
> cannot be avoided anyway.
instead of explicit offsets for base offset, device will probably use
struct cast to access fields.


> You do have a point about sharing the same area between different
> devices though. The above pseudo-code looks like a good pattern. This
> way "acpi-build.c" won't have to hand out the shared blob offsets to
> existing device instances directly; instead, the blob offsets are handed
> down to the firmware, and the devices will get their struct base
> addresses from the firmware. Using one WRITE_POINTER command for that,
> per device, seems fine.
> 
> I'll update the OVMF patches.
Thanks!

> 
> Thanks
> Laszlo
> 
> >         * no need to care where in shared_blob data will be placed,
> >         * shared space is used only when device is present
> >         * since there is no shared_writeback_blob, there isn't 
> >           need in mechanism to propagate written data to device
> >           or notify device about write
> >      
> >    drawback in this approach is that a device would consume
> >    a file slot if fw_cfg and space for WRITE_POINTER in
> >    linker file when present.
> > 
> >    
> >> (b) Regarding the runtime addition in the AML code:  
> > as you pointed out WRITE_POINTER has nothing to do with addition
> > on AML side which is influenced by ADD_POINTER and OVMF and could
> > be fixed with flags down the road, so there is nothing to argue
> > about on this bullet.
> > 
> >   
> >> As discussed before, the main reason *now*, for not pointing VGIA (and
> >> other named integer objects) with ADD_POINTER commands directly to
> >> "meaningful" fields, is that OVMF probes the targets of ADD_POINTER
> >> commands for patterns that look like ACPI table headers. And, for the
> >> time being, we want to suppress any mis-recognitions by prepending some
> >> padding.
> >>
> >> Igor was right to dislike this, and we agreed that *down the road* we
> >> should add allocation flags, or further allocation commands, to supplant
> >> this kind of heuristics in OVMF. But:
> >>
> >> - we don't have time to do it now, plus
> >>
> >> - please observe that the runtime addition in AML relates to the
> >>   ADD_POINTER and the ALLOCATE commands. It does not relate to
> >>   WRITE_POINTER at all.
> >>
> >>   Whatever we change on WRITE_POINTER will do nothing for suppressing
> >>   OVMF's table header probing -- because that is tied to ADD_POINTER
> >>   --, therefore WRITE_POINTER tweaks cannot eliminate the "need to add"
> >>   in AML.
> >>
> >>
> >> In summary, I think the proposed WRITE_POINTER modification is
> >> implementable, but I think it will not pay off, because:
> >>
> >> (a) for QEMU logic, it will not prove useful as soon as we have a
> >> multi-field shared structure (QEMU will have to add field offsets anyway),
> >>
> >> (b) and for eliminating the AML addition (which is a consequence of the
> >> current ADD_POINTER handling in OVMF), it does nothing.
> >>
> >> Thanks
> >> Laszlo  
> >   
> 
