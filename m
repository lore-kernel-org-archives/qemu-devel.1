Received: from eggs.gnu.org ([2001:4830:134:3::10]:47669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWFEK-00080e-1T
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWFEG-00024W-Ke
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:30:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWFEG-00024R-Bz
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 23:30:40 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<01f010147f8faaf7bd7c4ea94a364a584f323b0a.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6550884f-e5f7-f99e-8d35-b6ff0697313f@redhat.com>
Date: Wed, 25 Jan 2017 05:30:36 +0100
MIME-Version: 1.0
In-Reply-To: <01f010147f8faaf7bd7c4ea94a364a584f323b0a.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/9] linker-loader: Add new 'allocate
 and return address' cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This adds a new linker-loader command to instruct the guest to allocate
> memory for a fw_cfg file and write the address back into another
> writeable fw_cfg file.  Knowing this address, QEMU can then write into
> guest memory at runtime.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/acpi/bios-linker-loader.c         | 71 ++++++++++++++++++++++++++++++++++--
>  include/hw/acpi/bios-linker-loader.h |  7 ++++
>  2 files changed, 75 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader.c
> index d963ebe..1d991ba 100644
> --- a/hw/acpi/bios-linker-loader.c
> +++ b/hw/acpi/bios-linker-loader.c
> @@ -78,6 +78,22 @@ struct BiosLinkerLoaderEntry {
>              uint32_t length;
>          } cksum;
>  
> +        /*
> +         * COMMAND_ALLOCATE_RETURN_ADDR - allocate a table from @alloc_ret_file
> +         * subject to @alloc_ret_align alignment (must be power of 2)
> +         * and @alloc_ret_zone (can be HIGH or FSEG) requirements.
> +         * Additionally, return the address of the allocation in
> +         * @addr_file.
> +         *
> +         * This may be used instead of COMMAND_ALLOCATE
> +         */
> +        struct {
> +            char alloc_ret_file[BIOS_LINKER_LOADER_FILESZ];
> +            uint32_t alloc_ret_align;
> +            uint8_t alloc_ret_zone;
> +            char alloc_ret_addr_file[BIOS_LINKER_LOADER_FILESZ];
> +        };
> +
>          /* padding */
>          char pad[124];
>      };

(1) I remember that, when we discussed this command first, I provided
you with an explicit list of fields, for the new command structure.
Nonetheless, I suggest rephrasing both the comment block and the
structure definition in terms of the existent COMMAND_ALLOCATE:

- please give an actual struct tag to the structure that describes
COMMAND_ALLOCATE,
- reuse that type, as the first field, of the new structure,
- only add the new, last "addr_file" field explicitly.
  (This name is also simpler than "alloc_ret_addr_file".)

(2) Furthermore, the new union member lacks a name. It should be called
"alloc_ret_addr".

(3) The documentation can say something like,

  COMMAND_ALLOCATE_RETURN_ADDR - perform the COMMAND_ALLOCATE request
  described in @alloc_ret_addr.alloc, then write the resultant 8-byte
  allocation address, in little-endian encoding, to the fw_cfg file
  denoted by @alloc_ret_addr.addr_file.

> @@ -85,9 +101,10 @@ struct BiosLinkerLoaderEntry {
>  typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
>  
>  enum {
> -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     = 0x1,
> -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  = 0x2,
> -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM = 0x3,
> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          = 0x1,
> +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       = 0x2,
> +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      = 0x3,
> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE_RET_ADDR = 0x4,
>  };
>  
>  enum {
> @@ -278,3 +295,51 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
>  
>      g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
>  }
> +
> +/*
> + * bios_linker_loader_alloc_ret_addr: ask guest to load file into guest memory
> + * and patch the address in another file

(4) I suggest: "and return the allocation address in another file".

> + *
> + * @linker: linker object instance
> + * @data_file: name of the file blob to be loaded
> + * @file_blob: pointer to blob corresponding to @file_name

(5) You renamed @file_name to @data_file, but then the reference on the
next line wasn't updated. I suggest the following names:

@data_file_name
@data_file_blob

and consistent references.

> + * @alloc_align: required minimal alignment in bytes. Must be a power of 2.
> + * @alloc_fseg: request allocation in FSEG zone (useful for the RSDP ACPI table)
> + * @addr_file: destination file that will contain the address.
> + *             This must already exist

(6) For consistency, I suggest @addr_file_name.

> + *
> + * Note: this command must precede any other linker command that uses
> + * the data file.
> + */
> +void bios_linker_loader_alloc_ret_addr(BIOSLinker *linker,
> +                              const char *data_file,
> +                              GArray *file_blob,
> +                              uint32_t alloc_align,
> +                              bool alloc_fseg,
> +                              const char *addr_file)

(7) White space should be updated to line up the parameters with the
opening paren.

> +{
> +    BiosLinkerLoaderEntry entry;
> +    BiosLinkerFileEntry d_file = { g_strdup(data_file), file_blob};
> +
> +    /* Address file is expected to already be loaded */
> +    const BiosLinkerFileEntry *a_file =
> +        bios_linker_find_file(linker, addr_file);

(8) That's incorrect. The fw_cfg file that receives the allocation
address is to be written-to by the firmware; it doesn't need to be
downloaded into any firmware-allocated array. Therefore we shouldn't try
to enforce that @addr_file_name has been appended to "linker->file_list".

The "a_file" variable can be dropped IMO.

> +
> +    assert(!(alloc_align & (alloc_align - 1)));
> +    assert(a_file);
> +
> +    g_array_append_val(linker->file_list, d_file);

(9) I think the assertion is worth preserving (from
bios_linker_loader_alloc()) that the data file name doesn't exist yet.

> +
> +    memset(&entry, 0, sizeof entry);
> +    strncpy(entry.alloc_ret_file, data_file,
> +            sizeof entry.alloc_ret_file - 1);
> +    strncpy(entry.alloc_ret_addr_file, addr_file,
> +            sizeof entry.alloc_ret_addr_file - 1);
> +    entry.command = cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_ALLOCATE_RET_ADDR);
> +    entry.alloc.align = cpu_to_le32(alloc_align);
> +    entry.alloc.zone = alloc_fseg ? BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG :
> +                                    BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH;
> +
> +    /* Alloc entries must come first, so prepend them */
> +    g_array_append_vals(linker->cmd_blob, &entry, sizeof entry);
> +}

(10) The logic is messy here. The code mixes direct access to fields of
the new, unnamed, union member structure -- see point (2) near the top
--, with access to fields of the "entry.alloc" union member that
corresponds to COMMAND_ALLOCATE.

Instead, please give an explicit name to the new union member (see (2)
again), i.e., "alloc_ret_addr", and then refer to the following fields:

- entry.alloc_ret_addr.alloc.file
- entry.alloc_ret_addr.alloc.align
- entry.alloc_ret_addr.alloc.zone
- entry.alloc_ret_addr.addr_file

You can of course use pointers to the sub-structures, for saving source
code text.

Thanks!
Laszlo

> diff --git a/include/hw/acpi/bios-linker-loader.h b/include/hw/acpi/bios-linker-loader.h
> index fa1e5d1..69953e6 100644
> --- a/include/hw/acpi/bios-linker-loader.h
> +++ b/include/hw/acpi/bios-linker-loader.h
> @@ -26,5 +26,12 @@ void bios_linker_loader_add_pointer(BIOSLinker *linker,
>                                      const char *src_file,
>                                      uint32_t src_offset);
>  
> +void bios_linker_loader_alloc_ret_addr(BIOSLinker *linker,
> +                                       const char *data_file,
> +                                       GArray *file_blob,
> +                                       uint32_t alloc_align,
> +                                       bool alloc_fseg,
> +                                       const char *addr_file);
> +
>  void bios_linker_loader_cleanup(BIOSLinker *linker);
>  #endif
> 
