Received: from eggs.gnu.org ([2001:4830:134:3::10]:45107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du6dX-0002Xu-QW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1du6dR-000805-LB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:43:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1du6dR-0007yA-Bt
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:43:33 -0400
References: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a7e7471a-7c55-59cb-b6ae-a6c11d4d93c2@redhat.com>
Date: Mon, 18 Sep 2017 20:43:28 -0400
MIME-Version: 1.0
In-Reply-To: <CAJoBWHyqyFiFi_feH=316fJRUbb9T8b4bbYzp-5eUF6dHtpNCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Disk Image Read Location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Derrick McKee <derrick.mckee@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 09/18/2017 02:47 PM, Derrick McKee wrote:
> Hi,
> 

Hi Derrick;

> I am trying to figure out if a particular disk operation is reading from
> the same location in an image file.  I am simulating a USB disk, and during

Which device handles the USB disk emulation? hw/usb/dev-storage.c?
("usb-storage")?

> an operation the guest OS performs, I would like to know how many times the
> backing image file is read.  I have identified the function
> address_space_write as the function that writes the data to the guest OS
> from the image, but I am not sure what to compare with past writes.  There
> are AddressSpace*, MemoryRegion*, and hwaddr types in that function.  Can
> any of those be used to compare image read locations?  I am hoping that if,
> for example, the AddressSpace* passed into address_space_write during one
> invocation equals the AddressSpace* of another invocation means that the
> same location within the image file was read twice.  Any help would be
> appreciated.
> 
> - Derrick McKee
>

address_space_write is merely the function that is handling guest writes
to memory, not guest writes to disk.

Likely, your guest is writing some kind of disk IO command to whatever
sort of disk controller you have, and this process is dispatched by a
write to a register somewhere. If you wanted to snoop the disk activity
at this high of a level, you'd have to understand the protocol the
hardware uses to perform IO, look at the value being written to the
HWAddr, and re-interpret the state of the device and so on to see what
data is being read/written. The addresses you see here are likely just
registers that belong to the disk controller, so they don't reflect disk
offsets.

What I'd suggest instead is that you take a look at the dispatch for
address_space_write and follow it to the handler for the device emulator
that is actually handling the write and trace through the device
emulator code to find where the actual reading/writing is taking place.
The disk emulation code being employed is likely a good and logical
place to enable tracing of particular offsets at the logical level.

If you want to know about reads/writes at a more concrete level after
translation for offsets for file formats and so on and so forth -- if
you were curious to know how many literal, actual read calls get issued
-- keep looking down the stack.

>From the device emulator, calls to QEMU's generic block layer are made.
Usually blk_aio_preadv or dma_blk_read, something along these lines.
Ultimately, if you're reading from qcow2 or raw files on a locally
mounted hard disk, you'll probably trace the modular block layer read
calls all the way down to raw_co_preadv, then to raw_co_prw, then to
either laio_co_submit (if linux_aio is enabled) or paio_submit_co if it
isn't.

Then maybe you'll trace, say, paio_submit_co down (eventually) to the
constituent pwrite/pread calls.

Hard to know exactly what you want. Tracking guest IO activity and
tracking QEMU IO activity become slightly different things due to cache,
alignment and other protocol/format translations QEMU might be
performing. Hopefully this sets you on the right path. Other folks will
correct me if I've taken too many liberties at distilling all the stuff
going on inside of QEMU. ;)

Hope this helps,
John.
