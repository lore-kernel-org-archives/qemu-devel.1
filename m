Received: from eggs.gnu.org ([2001:4830:134:3::10]:39902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cX7Mj-0002pN-U6
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cX7Mg-00074T-J5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:19:01 -0500
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:33896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1cX7Mg-00072p-DU
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:18:58 -0500
Received: by mail-yw0-x241.google.com with SMTP id v73so24137796ywg.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:18:56 -0800 (PST)
Date: Fri, 27 Jan 2017 09:18:54 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170127141854.GA2524@morn.lan>
References: <dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
	<827795cf-5399-7092-267e-e912141931f3@redhat.com>
	<29F9E21E-D768-47D8-8E7F-BBC9DC4F72DD@skyportsystems.com>
	<20170125202812-mutt-send-email-mst@kernel.org>
	<2497755c-8616-1f42-ff36-ad75f6778a52@redhat.com>
	<20170126165015-mutt-send-email-mst@kernel.org>
	<adbfd67b-bcbc-2da2-78be-810eb35781ec@redhat.com>
	<20170126201124-mutt-send-email-mst@kernel.org>
	<6d15ef62-3184-3293-dd83-da67dd48dab0@redhat.com>
	<20170126205508-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170126205508-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>

On Thu, Jan 26, 2017 at 08:59:04PM +0200, Michael S. Tsirkin wrote:
> On Thu, Jan 26, 2017 at 07:25:22PM +0100, Laszlo Ersek wrote:
> > On 01/26/17 19:15, Michael S. Tsirkin wrote:
> > > On Thu, Jan 26, 2017 at 06:43:22PM +0100, Laszlo Ersek wrote:
> > >> On 01/26/17 16:20, Michael S. Tsirkin wrote:
> > >>> On Thu, Jan 26, 2017 at 01:48:37AM +0100, Laszlo Ersek wrote:
> > >>
> > >>>> But, again, I'd like to keep COMMAND_ALLOCATE_RETURN_ADDR 8-byte wide.
> > >>>
> > >>>
> > >>> What is COMMAND_ALLOCATE_RETURN_ADDR? I'm only familiar with
> > >>> COMMAND_ALLOCATE.
> > >>
> > >> It's a new command being introduced in this series, at my suggestion. It
> > >> does the exact same thing as COMMAND_ALLOCATE, except once the
> > >> allocation / download is carried out by the firmware, the firmware
> > >> writes back the allocation address to the fw_cfg file that is named in
> > >> an additional field of the COMMAND_ALLOCATE_RETURN_ADDR structure. (This
> > >> is how QEMU learns where the blob in GPA space was placed by the
> > >> firmware.) The format for this address-receiving fw_cfg file is supposed
> > >> to be 8-byte, little endian.
> > > 
> > > I see. I really think it's better as a separate command though.
> > > E.g. COMMAND_WRITE_PTR?
> > 
> > Sure, but please provide specifics, otherwise Ben & myself will have a
> > hard time divining & implementing your intent :)
> > 
> > Thanks,
> > Laszlo
> 
> I would say a variant of ADD_POINTER:
> 
>         /*
> 	 * COMMAND_WRITE_POINTER - update a writeable file named
> 	 * @pointer.dest_file at @pointer.offset, by writing pointer to
> 	 * the table originating from @src_file. 1,2,4 or 8 byte
> 	 * unsigned write is used depending on @pointer.size.
>          */
>         struct {
>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>             uint32_t offset;
>             uint8_t size;
>         } pointer;
> 

I'm okay with this approach.

If an offset is going to be added, shouldn't both a source offset and
destination offset be used?

        /*
         * COMMAND_WRITE_POINTER - update a writeable file named
         * @pointer.dest_file at @pointer.dest_offset, by writing pointer
         * plus @pointer.src_offset to the blob originating from
         * @src_file. 1,2,4 or 8 byte unsigned write is used depending
         * on @pointer.size.
         */
        struct {
            char dest_file[BIOS_LINKER_LOADER_FILESZ];
            char src_file[BIOS_LINKER_LOADER_FILESZ];
            uint32_t src_offset, dest_offset;
            uint8_t size;
        } pointer;

I doubt the offsets or size is really all that important though.

-Kevin
