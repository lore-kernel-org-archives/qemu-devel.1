Received: from eggs.gnu.org ([2001:4830:134:3::10]:55203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWoaa-0002se-SL
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cWoaV-0007jw-RO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:16:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cWoaV-0007jm-Ir
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:15:59 -0500
Date: Thu, 26 Jan 2017 20:15:57 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170126201124-mutt-send-email-mst@kernel.org>
References: <cover.1485308342.git.ben@skyportsystems.com>
	<dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ben Warren <ben@skyportsystems.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Thu, Jan 26, 2017 at 06:43:22PM +0100, Laszlo Ersek wrote:
> On 01/26/17 16:20, Michael S. Tsirkin wrote:
> > On Thu, Jan 26, 2017 at 01:48:37AM +0100, Laszlo Ersek wrote:
> 
> >> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
> > 
> > 
> > What is COMMAND_ALLOCATE_RETURN_ADDR? I'm only familiar with
> > COMMAND_ALLOCATE.
> 
> It's a new command being introduced in this series, at my suggestion. It
> does the exact same thing as COMMAND_ALLOCATE, except once the
> allocation / download is carried out by the firmware, the firmware
> writes back the allocation address to the fw_cfg file that is named in
> an additional field of the COMMAND_ALLOCATE_RETURN_ADDR structure. (This
> is how QEMU learns where the blob in GPA space was placed by the
> firmware.) The format for this address-receiving fw_cfg file is supposed
> to be 8-byte, little endian.

I see. I really think it's better as a separate command though.
E.g. COMMAND_WRITE_PTR?

> My request above is simply that we stick with the 8-byte size for this
> fw_cfg file, for receiving a guest allocation address. Regardless of the
> fact that currently all such allocation addresses fit in 4 bytes.
>
> > If we want to allow this stuff in high 64 bit, as you
> > correctly say we will need a new zone to allocate 64 bit memory.
> > As for XP support - might it be reasonable to require that
> > these machines have less than 4G RAM at boot?
> 
> Perhaps; I'm not sure. At the moment I have zero concrete use cases in
> mind. I just want COMMAND_ALLOCATE_RETURN_ADDR to promise the firmware
> that the firmware will be able to return 8 bytes / LE as the allocation
> address. How this will interact with any new zones and RAM sizes vs.
> guest OSes is TBD in the future.
> 
> >> In the future we might introduce more allocation hints (for the "zone"
> >> field) that would enable the firmware to allocate from the full 64-bit
> >> address space.
> > 
> > The difficulty with new commands always was compatibility with old
> > firmware. I guess now that we have writeable fw cfg we will be
> > able to support negotiation cleanly.
> 
> Specifically for the zone field of COMMAND_ALLOCATE (and identically,
> COMMAND_ALLOCATE_RETURN_ADDR), I think we might not need full-blown
> negotiation; there aren't that many firmwares to check compatibility
> with -- OVMF and SeaBIOS. If old versions of those happen to handle a
> new zone value gracefully (such as "not fseg", simply), i.e. they'd
> behave the same as now, then we shouldn't need negotiation. Otherwise,
> we'll need it (once we have a particular use case).
> 
> > Should we start now?
> 
> No, I don't think so. I don't have any use case for 64-bit allocation;
> what we have now works perfectly. I just wanted to emphasize that
> permitting an 8-byte width for the alloc address to be returned is more
> "future proof" than a 4-byte size, for COMMAND_ALLOCATE_RETURN_ADDR;
> independently of what size we choose right here for VGIA.
> 
> Thanks,
> Laszlo

I agree here.

-- 
MST
