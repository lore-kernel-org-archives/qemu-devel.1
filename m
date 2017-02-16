Received: from eggs.gnu.org ([2001:4830:134:3::10]:55161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ceNHn-0006I8-BE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ceNHi-0004Bp-B1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ceNHi-0004BV-2A
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:43:50 -0500
Date: Thu, 16 Feb 2017 16:43:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170216163756-mutt-send-email-mst@kernel.org>
References: <cover.1487224954.git.ben@skyportsystems.com>
	<4d92b9f92d2f5b702c23bf135222dfb226ec94a7.1487224954.git.ben@skyportsystems.com>
	<20170216104310.7bc059e2@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216104310.7bc059e2@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/8] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, lersek@redhat.com

On Thu, Feb 16, 2017 at 10:43:10AM +0100, Igor Mammedov wrote:
> On Wed, 15 Feb 2017 22:18:11 -0800
> ben@skyportsystems.com wrote:
> 
> > From: Ben Warren <ben@skyportsystems.com>
> > 
> > This is similar to the existing 'add pointer' functionality, but instead
> > of instructing the guest (BIOS or UEFI) to patch memory, it instructs
> > the guest to write the pointer back to QEMU via a writeable fw_cfg file.
> > 
> > Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > ---
> >  hw/acpi/bios-linker-loader.c         | 66 ++++++++++++++++++++++++++++++++++--
> >  include/hw/acpi/bios-linker-loader.h |  7 ++++
> >  2 files changed, 70 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
> > index d963ebe..d5fb703 100644
> > --- a/hw/acpi/bios-linker-loader.c
> > +++ b/hw/acpi/bios-linker-loader.c
> > @@ -78,6 +78,21 @@ struct BiosLinkerLoaderEntry {
> >              uint32_t length;
> >          } cksum;
> >  
> > +        /*
> > +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating from
> > +         * @dest_file) at @wr_pointer.offset, by adding a pointer to
> > +         * @src_offset within the table originating from @src_file.
> > +         * 1,2,4 or 8 byte unsigned addition is used depending on
> > +         * @wr_pointer.size.
> > +         */
> > +        struct {
> > +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
> > +            char src_file[BIOS_LINKER_LOADER_FILESZ];
> > +            uint32_t dst_offset;
> > +            uint32_t src_offset;
> > +            uint8_t size;
> > +        } wr_pointer;
> > +
> >          /* padding */
> >          char pad[124];
> Shouldn't padding be reduced by 4 bytes to keep 
> sizeof(BiosLinkerLoaderEntry) the same as before patch,
> so that old bios would be able to skip this unknown command
> and read the next at the right offset?

IMHO no - because it's a union.


> >      };
> > @@ -85,9 +100,10 @@ struct BiosLinkerLoaderEntry {
> >  typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
> >  
> >  enum {
> > -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     = 0x1,
> > -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  = 0x2,
> > -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM = 0x3,
> > +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
> > +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
> > +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
> > +    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     = 0x4,
> >  };
> >  
> >  enum {
> > @@ -278,3 +294,47 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
> >  
> >      g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
> >  }
> > +
> > +/*
> > + * bios_linker_loader_write_pointer: ask guest to write a pointer to the
> > + * source file into the destination file, and write it back to QEMU via
> > + * fw_cfg DMA.
> > + *
> > + * @linker: linker object instance
> > + * @dest_file: destination file that must be written
> > + * @dst_patched_offset: location within destination file blob to be patched
> > + *                      with the pointer to @src_file, in bytes
> > + * @dst_patched_offset_size: size of the pointer to be patched
> > + *                      at @dst_patched_offset in @dest_file blob, in bytes
> > + * @src_file: source file who's address must be taken
> > + * @src_offset: location within source file blob to which
> > + *              @dest_file+@dst_patched_offset will point to after
> > + *              firmware's executed WRITE_POINTER command
> > + */
> > +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> > +                                    const char *dest_file,
> > +                                    uint32_t dst_patched_offset,
> > +                                    uint8_t dst_patched_size,
> > +                                    const char *src_file,
> > +                                    uint32_t src_offset)
> > +{
> > +    BiosLinkerLoaderEntry entry;
> > +    const BiosLinkerFileEntry *source_file =
> > +        bios_linker_find_file(linker, src_file);
> > +
> > +    assert(source_file);
> > +    assert(src_offset <= source_file->blob->len);
> off by one, should be '<'
> 
> > +    memset(&entry, 0, sizeof entry);
> > +    strncpy(entry.wr_pointer.dest_file, dest_file,
> > +            sizeof entry.wr_pointer.dest_file - 1);
> > +    strncpy(entry.wr_pointer.src_file, src_file,
> > +            sizeof entry.wr_pointer.src_file - 1);
> > +    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
> > +    entry.wr_pointer.dst_offset = cpu_to_le32(dst_patched_offset);
> > +    entry.wr_pointer.src_offset = cpu_to_le32(dst_patched_offset);
> > +    entry.wr_pointer.size = dst_patched_size;
> > +    assert(dst_patched_size == 1 || dst_patched_size == 2 ||
> > +           dst_patched_size == 4 || dst_patched_size == 8);
> > +
> > +    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
> > +}
> > diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
> > index fa1e5d1..efe17b0 100644
> > --- a/include/hw/acpi/bios-linker-loader.h
> > +++ b/include/hw/acpi/bios-linker-loader.h
> > @@ -26,5 +26,12 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
> >                                      const char *src_file,
> >                                      uint32_t src_offset);
> >  
> > +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> > +                                      const char *dest_file,
> > +                                      uint32_t dst_patched_offset,
> > +                                      uint8_t dst_patched_size,
> > +                                      const char *src_file,
> > +                                      uint32_t src_offset);
> > +
> >  void bios_linker_loader_cleanup(BIOSLinker *linker);
> >  #endif
> 
> Taking in account comments above are corner cases.
>  1: old bios running on new QEMU with vmgenid device and OLD/not supported bios
>  2: assert check
> 
> It's ok fixes for above issues being fixed in follow up patch
> or as fixup while patch is staged in pci tree
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
