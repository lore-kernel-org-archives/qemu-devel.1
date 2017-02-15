Received: from eggs.gnu.org ([2001:4830:134:3::10]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ce4Fw-0005tD-Ut
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ce4Fs-00085j-QN
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:24:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ce4Fs-00085I-HW
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 13:24:40 -0500
Date: Wed, 15 Feb 2017 19:24:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170215192436.2695b9f6@nial.brq.redhat.com>
In-Reply-To: <20170215194647-mutt-send-email-mst@kernel.org>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<20170215194647-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, ben@skyportsystems.com

On Wed, 15 Feb 2017 20:04:40 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Feb 15, 2017 at 06:43:09PM +0100, Igor Mammedov wrote:
> > On Wed, 15 Feb 2017 18:39:06 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Mammedov wrote:  
> > > > On Wed, 15 Feb 2017 17:30:00 +0200
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >     
> > > > > On Wed, Feb 15, 2017 at 04:22:25PM +0100, Igor Mammedov wrote:    
> > > > > > On Wed, 15 Feb 2017 15:13:20 +0100
> > > > > > Laszlo Ersek <lersek@redhat.com> wrote:
> > > > > >       
> > > > > > > Commenting under Igor's reply for simplicity
> > > > > > > 
> > > > > > > On 02/15/17 11:57, Igor Mammedov wrote:      
> > > > > > > > On Tue, 14 Feb 2017 22:15:43 -0800
> > > > > > > > ben@skyportsystems.com wrote:
> > > > > > > >         
> > > > > > > >> From: Ben Warren <ben@skyportsystems.com>
> > > > > > > >>
> > > > > > > >> This is similar to the existing 'add pointer' functionality, but instead
> > > > > > > >> of instructing the guest (BIOS or UEFI) to patch memory, it instructs
> > > > > > > >> the guest to write the pointer back to QEMU via a writeable fw_cfg file.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > > > > > > >> ---
> > > > > > > >>  hw/acpi/bios-linker-loader.c         | 58 ++++++++++++++++++++++++++++++++++--
> > > > > > > >>  include/hw/acpi/bios-linker-loader.h |  6 ++++
> > > > > > > >>  2 files changed, 61 insertions(+), 3 deletions(-)
> > > > > > > >>
> > > > > > > >> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
> > > > > > > >> index d963ebe..5030cf1 100644
> > > > > > > >> --- a/hw/acpi/bios-linker-loader.c
> > > > > > > >> +++ b/hw/acpi/bios-linker-loader.c
> > > > > > > >> @@ -78,6 +78,19 @@ struct BiosLinkerLoaderEntry {
> > > > > > > >>              uint32_t length;
> > > > > > > >>          } cksum;
> > > > > > > >>  
> > > > > > > >> +        /*
> > > > > > > >> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
> > > > > > > >> +         * @dest_file) at @wr_pointer.offset, by adding a pointer to the table
> > > > > > > >> +         * originating from @src_file. 1,2,4 or 8 byte unsigned
> > > > > > > >> +         * addition is used depending on @wr_pointer.size.
> > > > > > > >> +         */        
> > > > > > > 
> > > > > > > The words "adding" and "addition" are causing confusion here.
> > > > > > > 
> > > > > > > In all of the previous discussion, *addition* was out of scope from
> > > > > > > WRITE_POINTER. Again, the firmware is specifically not required to
> > > > > > > *read* any part of the fw_cfg blob identified by "dest_file".
> > > > > > > 
> > > > > > > WRITE_POINTER instructs the firmware to return the allocation address of
> > > > > > > the downloaded "src_file" to QEMU. Any necessary runtime subscripting
> > > > > > > within "src_file" is to be handled by QEMU code dynamically.
> > > > > > > 
> > > > > > > For example, consider that "src_file" has *several* fields that QEMU
> > > > > > > wants to massage; in that case, indexing within QEMU code with field
> > > > > > > offsets is simply unavoidable.      
> > > > > > what I don't like here is that this indexing would be rather fragile
> > > > > > and has to be done in different parts of QEMU /device, AML/.
> > > > > > 
> > > > > > I'd prefer this helper function to have the same @src_offset
> > > > > > behavior as ADD_POINTER where patched address could point to
> > > > > > any part of src_file i.e. not just beginning.      
> > > > > 
> > > > > 
> > > > > 
> > > > >         /*
> > > > >          * COMMAND_ADD_POINTER - patch the table (originating from
> > > > >          * @dest_file) at @pointer.offset, by adding a pointer to the table
> > > > >          * originating from @src_file. 1,2,4 or 8 byte unsigned
> > > > >          * addition is used depending on @pointer.size.
> > > > >          */
> > > > >  
> > > > > so the way ADD works is
> > > > > 	read at offset
> > > > > 	add table address
> > > > > 	write result at offset
> > > > > 
> > > > > in other words it is always beginning of table that is added.    
> > > > more exactly it's, read at 
> > > >   src_offset = *(dst_blob_ptr+dst_offset)
> > > >   *(dst_blob+dst_offset) = src_blob_ptr + src_offset
> > > >     
> > > > > Would the following be acceptable?
> > > > > 
> > > > > 
> > > > >          * COMMAND_WRITE_POINTER - update the fw_cfg file (originating from
> > > > >          * @dest_file) at @wr_pointer.offset, by writing a pointer to the table
> > > > >          * originating from @src_file. 1,2,4 or 8 byte unsigned value
> > > > >          * is written depending on @wr_pointer.size.    
> > > > it looses 'adding' part of ADD_POINTER command which handles src_offset,
> > > > however implementing adding part looks a bit complicated
> > > > as patched blob (dst) is not in guest memory but in QEMU and
> > > > on reset *(dst_blob+dst_offset) should be reset to src_offset.
> > > > Considering dst file could be device specific memory (field/blob/whatever)
> > > > it could be hard to track/notice proper reset behavior.
> > > > 
> > > > So now I'm not sure if src_offset is worth adding.    
> > > 
> > > Right. Let's just do this math in QEMU if we have to.  
> > Math complicates QEMU code though and not only QMEMU but AML code as well.
> > Considering that we are adding a new command and don't have to keep
> > any sort of compatibility we can pass src_offset as part
> > of command instead of hiding it inside of dst_file.
> > Something like this:
> > 
> >         /*
> >          * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
> >          * @dest_file) at @wr_pointer.offset, by writing a pointer to @src_offset
> >          * within the table originating from @src_file. 1,2,4 or 8 byte unsigned
> >          * addition is used depending on @wr_pointer.size.
> >          */
> >         struct {
> >              char dest_file[BIOS_LINKER_LOADER_FILESZ];
> >              char src_file[BIOS_LINKER_LOADER_FILESZ];
> > -            uint32_t offset;
> > +            uint32_t dst_offset;
> > +            uint32_t src_offset;
> >              uint8_t size;
> >         } wr_pointer;  
> 
> 
> As long as all users pass in 0 though there's a real possibility guests
> will implement this incorrectly.
We are here to ensure that at least Seabios (I'll review it)
and OVMF (Laszlo would take care of it I suppose) do it right,
and if there are other firmwares, they should do it correctly
as described fix their own bugs later wrt randomly written
implementation.

> I guess we can put in the offset just
> behind the zero-filled padding we have there.
I've assumed padding was there to make commands fixed size and give
a room for future extensions so hunk changing BiosLinkerLoaderEntry
would look like:

diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
index d963ebe..6983713 100644
--- a/hw/acpi/bios-linker-loader.c
+++ b/hw/acpi/bios-linker-loader.c
@@ -49,6 +49,7 @@ struct BiosLinkerLoaderEntry {
             char file[BIOS_LINKER_LOADER_FILESZ];
             uint32_t align;
             uint8_t zone;
+            uint32_t padding;
         } alloc;
 
         /*
@@ -62,6 +63,7 @@ struct BiosLinkerLoaderEntry {
             char src_file[BIOS_LINKER_LOADER_FILESZ];
             uint32_t offset;
             uint8_t size;
+            uint32_t padding;
         } pointer;
 
         /*
@@ -76,10 +78,25 @@ struct BiosLinkerLoaderEntry {
             uint32_t offset;
             uint32_t start;
             uint32_t length;
+            uint32_t padding;
         } cksum;
 
+        /*
+         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
+         * @dest_file) at @wr_pointer.offset, by writing a pointer to @src_offset
+         * within the table originating from @src_file. 1,2,4 or 8 byte unsigned
+         * addition is used depending on @wr_pointer.size.
+         */
+         struct {
+             char dest_file[BIOS_LINKER_LOADER_FILESZ];
+             char src_file[BIOS_LINKER_LOADER_FILESZ];
+             uint32_t dst_offset;
+             uint32_t src_offset;
+             uint8_t size;
+        } wr_pointer;
+
         /* padding */
-        char pad[124];
+        char pad[120];
     };
 } QEMU_PACKED;
 typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;

 
> I'm mostly concerned we are adding new features to something
> that has been through 25 revisions already.
It's ABI so it's worth extra effort,
it looks like only one more revision is left and there is
about a week left to post and merge it.

> 
> 
> > >   
> > > > > 
> > > > >     
> > > > > > 
> > > > > >       
> > > > > > > (1) So, the above looks correct, but please replace "adding" with
> > > > > > > "storing", and "unsigned addition" with "store".
> > > > > > > 
> > > > > > > Side point: the case for ADD_POINTER is different; there we patch
> > > > > > > several individual ACPI objects. The fact that I requested explicit
> > > > > > > addition within the ADDR method, as opposed to pre-setting VGIA to a
> > > > > > > nonzero offset, is an *incidental* limitation (coming from the OVMF ACPI
> > > > > > > SDT header probe suppressor), and we'll likely fix that up later, with
> > > > > > > ALLOCATE command hints or something like that. However, in
> > > > > > > WRITE_POINTER, asking for the exact allocation address of "src_file" is
> > > > > > > an *inherent* characteristic.
> > > > > > > 
> > > > > > > For reference, this is the command's description from the (not as yet
> > > > > > > posted) OVMF series:
> > > > > > > 
> > > > > > > // QemuLoaderCmdWritePointer: the bytes at
> > > > > > > // [PointerOffset..PointerOffset+PointerSize) in the writeable fw_cfg
> > > > > > > // file PointerFile are to receive the absolute address of PointeeFile,
> > > > > > > // as allocated and downloaded by the firmware. Store the base address
> > > > > > > // of where PointeeFile's contents have been placed (when
> > > > > > > // QemuLoaderCmdAllocate has been executed for PointeeFile) to this
> > > > > > > // portion of PointerFile.
> > > > > > > //
> > > > > > > // This command is similar to QemuLoaderCmdAddPointer; the difference is
> > > > > > > // that the "pointer to patch" does not exist in guest-physical address
> > > > > > > // space, only in "fw_cfg file space". In addition, the "pointer to
> > > > > > > // patch" is not initialized by QEMU with a possibly nonzero offset
> > > > > > > // value: the base address of the memory allocated for downloading
> > > > > > > // PointeeFile shall not increment the pointer, but overwrite it.
> > > > > > > 
> > > > > > > In the last SeaBIOS patch series, namely
> > > > > > > 
> > > > > > > [SeaBIOS] [PATCH v3 2/2] QEMU fw_cfg: Add command to write back address
> > > > > > >                          of file
> > > > > > > 
> > > > > > > function romfile_loader_write_pointer() implemented just that plain
> > > > > > > store (not an addition), and that was exactly right.
> > > > > > > 
> > > > > > > Continuing:
> > > > > > >       
> > > > > > > >> +        struct {
> > > > > > > >> +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
> > > > > > > >> +            char src_file[BIOS_LINKER_LOADER_FILESZ];
> > > > > > > >> +            uint32_t offset;
> > > > > > > >> +            uint8_t size;
> > > > > > > >> +        } wr_pointer;
> > > > > > > >> +
> > > > > > > >>          /* padding */
> > > > > > > >>          char pad[124];
> > > > > > > >>      };
> > > > > > > >> @@ -85,9 +98,10 @@ struct BiosLinkerLoaderEntry {
> > > > > > > >>  typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
> > > > > > > >>  
> > > > > > > >>  enum {
> > > > > > > >> -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     = 0x1,
> > > > > > > >> -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  = 0x2,
> > > > > > > >> -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM = 0x3,
> > > > > > > >> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
> > > > > > > >> +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
> > > > > > > >> +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
> > > > > > > >> +    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     = 0x4,
> > > > > > > >>  };
> > > > > > > >>  
> > > > > > > >>  enum {
> > > > > > > >> @@ -278,3 +292,41 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
> > > > > > > >>  
> > > > > > > >>      g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
> > > > > > > >>  }
> > > > > > > >> +
> > > > > > > >> +/*
> > > > > > > >> + * bios_linker_loader_write_pointer: ask guest to write a pointer to the
> > > > > > > >> + * source file into the destination file, and write it back to QEMU via
> > > > > > > >> + * fw_cfg DMA.
> > > > > > > >> + *
> > > > > > > >> + * @linker: linker object instance
> > > > > > > >> + * @dest_file: destination file that must be written
> > > > > > > >> + * @dst_patched_offset: location within destination file blob to be patched
> > > > > > > >> + *                      with the pointer to @src_file, in bytes
> > > > > > > >> + * @dst_patched_offset_size: size of the pointer to be patched
> > > > > > > >> + *                      at @dst_patched_offset in @dest_file blob, in bytes
> > > > > > > >> + * @src_file: source file who's address must be taken
> > > > > > > >> + */
> > > > > > > >> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> > > > > > > >> +                                    const char *dest_file,
> > > > > > > >> +                                    uint32_t dst_patched_offset,
> > > > > > > >> +                                    uint8_t dst_patched_size,
> > > > > > > >> +                                    const char *src_file)        
> > > > > > > > API is missing "src_offset" even though it's not used in this series,
> > > > > > > > a patch on top to fix it up is ok for me as far as Seabios/OVMF
> > > > > > > > counterpart can handle src_offset correctly from starters.        
> > > > > > > 
> > > > > > > According to the above, it is the right thing not to add "src_offset"
> > > > > > > here. The documentation on the command is slightly incorrect (and causes
> > > > > > > confusion), but the helper function's signature and comments are okay.
> > > > > > >       
> > > > > > > >         
> > > > > > > >> +{
> > > > > > > >> +    BiosLinkerLoaderEntry entry;
> > > > > > > >> +    const BiosLinkerFileEntry *source_file =
> > > > > > > >> +        bios_linker_find_file(linker, src_file);
> > > > > > > >> +
> > > > > > > >> +    assert(source_file);        
> > > > > > > 
> > > > > > > I wish we kept the following asserts from bios_linker_loader_add_pointer():
> > > > > > > 
> > > > > > >     assert(dst_patched_offset < dst_file->blob->len);
> > > > > > >     assert(dst_patched_offset + dst_patched_size <= dst_file->blob->len);
> > > > > > > 
> > > > > > > Namely, just because the dst_file is never supposed to be downloaded by
> > > > > > > the firmware, it still remains a requirement that the "dst file offset
> > > > > > > range" that is to be rewritten *do fall* within the dst file.
> > > > > > > 
> > > > > > > Nonetheless, this is not critical. (OVMF at least verifies it anyway.)
> > > > > > > 
> > > > > > > Summary (from my side anyway): I feel that the documentation of the new
> > > > > > > command is very important. Please fix it up as suggested under (1), in
> > > > > > > v7. Regarding the asserts, I'll let you decide.
> > > > > > > 
> > > > > > > With the documentation fixed up:
> > > > > > > 
> > > > > > > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > > > > > > 
> > > > > > > (If you don't wish to post a v7, I'm also completely fine if Michael or
> > > > > > > someone else fixes up the docs as proposed in (1), before committing the
> > > > > > > patch.)
> > > > > > > 
> > > > > > > Thanks!
> > > > > > > Laszlo
> > > > > > >       
> > > > > > > >> +    memset(&entry, 0, sizeof entry);
> > > > > > > >> +    strncpy(entry.wr_pointer.dest_file, dest_file,
> > > > > > > >> +            sizeof entry.wr_pointer.dest_file - 1);
> > > > > > > >> +    strncpy(entry.wr_pointer.src_file, src_file,
> > > > > > > >> +            sizeof entry.wr_pointer.src_file - 1);
> > > > > > > >> +    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
> > > > > > > >> +    entry.wr_pointer.offset = cpu_to_le32(dst_patched_offset);
> > > > > > > >> +    entry.wr_pointer.size = dst_patched_size;
> > > > > > > >> +    assert(dst_patched_size == 1 || dst_patched_size == 2 ||
> > > > > > > >> +           dst_patched_size == 4 || dst_patched_size == 8);
> > > > > > > >> +
> > > > > > > >> +    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
> > > > > > > >> +}
> > > > > > > >> diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
> > > > > > > >> index fa1e5d1..f9ba5d6 100644
> > > > > > > >> --- a/include/hw/acpi/bios-linker-loader.h
> > > > > > > >> +++ b/include/hw/acpi/bios-linker-loader.h
> > > > > > > >> @@ -26,5 +26,11 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
> > > > > > > >>                                      const char *src_file,
> > > > > > > >>                                      uint32_t src_offset);
> > > > > > > >>  
> > > > > > > >> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> > > > > > > >> +                                      const char *dest_file,
> > > > > > > >> +                                      uint32_t dst_patched_offset,
> > > > > > > >> +                                      uint8_t dst_patched_size,
> > > > > > > >> +                                      const char *src_file);
> > > > > > > >> +
> > > > > > > >>  void bios_linker_loader_cleanup(BIOSLinker *linker);
> > > > > > > >>  #endif        
> > > > > > > >         
> > > > > > >       
> > >   
