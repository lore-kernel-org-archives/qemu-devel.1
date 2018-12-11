Received: from eggs.gnu.org ([2001:4830:134:3::10]:54741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gWla4-00017Q-O1
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gWlZu-0005qA-Sg
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gWlZr-0005kK-Ks
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:12:12 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so5042907iti.2
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 09:12:06 -0800 (PST)
MIME-Version: 1.0
References: <1544049446-6359-1-git-send-email-liam.merwick@oracle.com>
	<1544049446-6359-4-git-send-email-liam.merwick@oracle.com>
In-Reply-To: <1544049446-6359-4-git-send-email-liam.merwick@oracle.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 11 Dec 2018 18:11:52 +0100
Message-ID: <CAGxU2F4j11wVoDktowJwXDy42_PWbjwF0qAueFg+He4Tb86wgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 3/3] pvh: Boot uncompressed kernel using
 direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liam.merwick@oracle.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, rth@twiddle.net, xen-devel@lists.xenproject.org, mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, maran.wilson@oracle.com

Hi Liam,
in order to support PVH also with SeaBIOS, I'm going to work on a new
option rom (like linuxboot/multiboot) that can be used in this case.

I'll keep you updated on it!

Cheers,
Stefano
On Wed, Dec 5, 2018 at 11:38 PM Liam Merwick <liam.merwick@oracle.com> wrote:
>
> These changes (along with corresponding qboot and Linux kernel changes)
> enable a guest to be booted using the x86/HVM direct boot ABI.
>
> This commit adds a load_elfboot() routine to pass the size and
> location of the kernel entry point to qboot (which will fill in
> the start_info struct information needed to to boot the guest).
> Having loaded the ELF binary, load_linux() will run qboot
> which continues the boot.
>
> The address for the kernel entry point has already been read
> from an ELF Note in the uncompressed kernel binary earlier
> in pc_memory_init().
>
> Signed-off-by: George Kennedy <George.Kennedy@oracle.com>
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  hw/i386/pc.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 056aa46d99b9..d3012cbd8597 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -54,6 +54,7 @@
>  #include "sysemu/qtest.h"
>  #include "kvm_i386.h"
>  #include "hw/xen/xen.h"
> +#include "hw/xen/start_info.h"
>  #include "ui/qemu-spice.h"
>  #include "exec/memory.h"
>  #include "exec/address-spaces.h"
> @@ -1098,6 +1099,50 @@ done:
>      return pvh_start_addr != 0;
>  }
>
> +static bool load_elfboot(const char *kernel_filename,
> +                   int kernel_file_size,
> +                   uint8_t *header,
> +                   size_t pvh_xen_start_addr,
> +                   FWCfgState *fw_cfg)
> +{
> +    uint32_t flags = 0;
> +    uint32_t mh_load_addr = 0;
> +    uint32_t elf_kernel_size = 0;
> +    uint64_t elf_entry;
> +    uint64_t elf_low, elf_high;
> +    int kernel_size;
> +
> +    if (ldl_p(header) != 0x464c457f) {
> +        return false; /* no elfboot */
> +    }
> +
> +    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
> +    flags = elf_is64 ?
> +        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
> +
> +    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
> +        error_report("elfboot unsupported flags = %x", flags);
> +        exit(1);
> +    }
> +
> +    kernel_size = load_elf(kernel_filename, NULL, NULL, &elf_entry,
> +                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                           0, 0);
> +
> +    if (kernel_size < 0) {
> +        error_report("Error while loading elf kernel");
> +        exit(1);
> +    }
> +    mh_load_addr = elf_low;
> +    elf_kernel_size = elf_high - elf_low;
> +
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_xen_start_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
> +
> +    return true;
> +}
> +
>  static void load_linux(PCMachineState *pcms,
>                         FWCfgState *fw_cfg)
>  {
> @@ -1138,6 +1183,33 @@ static void load_linux(PCMachineState *pcms,
>      if (ldl_p(header+0x202) == 0x53726448) {
>          protocol = lduw_p(header+0x206);
>      } else {
> +        /* If the kernel address for using the x86/HVM direct boot ABI has
> +         * been saved then proceed with booting the uncompressed kernel */
> +        if (pvh_start_addr) {
> +            if (load_elfboot(kernel_filename, kernel_size,
> +                             header, pvh_start_addr, fw_cfg)) {
> +                struct hvm_modlist_entry ramdisk_mod = { 0 };
> +
> +                fclose(f);
> +
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
> +                    strlen(kernel_cmdline) + 1);
> +                fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> +
> +                assert(machine->device_memory != NULL);
> +                ramdisk_mod.paddr = machine->device_memory->base;
> +                ramdisk_mod.size =
> +                    memory_region_size(&machine->device_memory->mr);
> +
> +                fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, &ramdisk_mod,
> +                                 sizeof(ramdisk_mod));
> +                fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, sizeof(header));
> +                fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA,
> +                                 header, sizeof(header));
> +
> +                return;
> +            }
> +        }
>          /* This looks like a multiboot kernel. If it is, let's stop
>             treating it like a Linux kernel. */
>          if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
> --
> 1.8.3.1
>


-- 
Stefano Garzarella
Red Hat
