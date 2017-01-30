Received: from eggs.gnu.org ([2001:4830:134:3::10]:54976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYIZE-00028l-WB
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYIZA-0008R9-1Q
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:28:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cYIZ9-0008Pn-R6
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 15:28:43 -0500
Date: Mon, 30 Jan 2017 22:28:41 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170130222539-mutt-send-email-mst@kernel.org>
References: <20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
	<6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
	<20170126205508-mutt-send-email-mst@kernel.org>
	<20170127141854.GA2524@morn.lan>
	<58bbf216-a2f1-481f-21b0-4ada4f73a5e5@redhat.com>
	<20170127154313.GB7213@morn.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170127154313.GB7213@morn.lan>
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
To: Kevin O'Connor <kevin@koconnor.net>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>

On Fri, Jan 27, 2017 at 10:43:13AM -0500, Kevin O'Connor wrote:
> On Fri, Jan 27, 2017 at 03:46:33PM +0100, Laszlo Ersek wrote:
> > On 01/27/17 15:18, Kevin O'Connor wrote:
> > > If an offset is going to be added, shouldn't both a source offset and
> > > destination offset be used?
> > > 
> > >         /*
> > >          * COMMAND_WRITE_POINTER - update a writeable file named
> > >          * @pointer.dest_file at @pointer.dest_offset, by writing pointer
> > >          * plus @pointer.src_offset to the blob originating from
> > >          * @src_file. 1,2,4 or 8 byte unsigned write is used depending
> > >          * on @pointer.size.
> > >          */
> > >         struct {
> > >             char dest_file[BIOS_LINKER_LOADER_FILESZ];
> > >             char src_file[BIOS_LINKER_LOADER_FILESZ];
> > >             uint32_t src_offset, dest_offset;
> > >             uint8_t size;
> > >         } pointer;
> > > 
> > > I doubt the offsets or size is really all that important though.
> > 
> > The offset into the fw_cfg file that receives the allocation address is
> > important, that allows the same file to receive several different
> > addresses (for different downloaded blobs), at different offsets.
> > 
> > OTOH, asking the firmware to add a constant to the address value before
> > writing it to the fw_cfg file is not necessary, in my opinion. The blob
> > that the firmware allocated and downloaded originates from QEMU to begin
> > with, so QEMU knows its internal structure.
> 
> I guess I'm missing why QEMU would want to use the same writable file
> for multiple pointers as well as why it would want support for
> pointers smaller than 8 bytes in size.  If it's because it may be
> easier to support an internal QEMU blob of a particular format, then
> adding a src_offset would facilitate that.
> 
> However, if it was done so that WRITE_POINTER mimicks ADD_POINTER then
> that's fine too.  I'm okay with either format.
> 
> -Kevin

Both reasons :) offset is because it's easier for QEMU not to have to add
more files (e.g. it simplifies cross-version migration if we don't).
size is to mimick ADD_POINTER.

-- 
MST
