Received: from eggs.gnu.org ([2001:4830:134:3::10]:53989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fAia1-00088G-RX
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1fAia0-0001Dl-Oa
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:00:57 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1fAia0-0001DY-IC
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:00:56 -0400
Received: by mail-oi0-x244.google.com with SMTP id f63-v6so15665352oic.4
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 14:00:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
References: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Apr 2018 14:00:53 -0700
Message-ID: <CAPcyv4hsBEVWaTv8bfwZVU2CCUFMnBhHM6Jnp9H2gsC3ffxS3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFC: altering the NVDIMM acpi table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "He,
	Junyan" <junyan.he@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Mon, Apr 23, 2018 at 1:35 PM, Schmauss, Erik <erik.schmauss@intel.com> wrote:
> Hello,
>
> I work on ACPICA and we have recently made changes to the behavior of
> the Linux AML interpreter to match other OS implementations. After
> sending the patches to upstream Linux, we have identified that
> hw/acpi/nvdimm.c specifies an ACPI table with a forward reference
>  (MEMA is a forward reference that is no longer supported as of Linux
> 4.17-rc1).
>
> We would like to change this file to move the declaration of Name
> (MEMA,...) to appear as the very first declaration in the SSDT. Below is a patch outlining the change that I would like to make.
> However, I am having a hard time getting make check to run
>  to completion in a reasonable amount of time. It always seems to fail
> on some sort of checksum test... It would be great if you could let me
> know what you think of the change and what I can do to speed up the
> execution time of make check...
>
>
> Thanks,
>
> Erik Schmauss
>
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 59d6e4254c..7c9efd9ac7 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -1234,6 +1234,9 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>      ssdt = init_aml_allocator();
>      acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
>
> +    mem_addr_offset = build_append_named_dword(table_data,
> +                                               NVDIMM_ACPI_MEM_ADDR);
> +
>      sb_scope = aml_scope("\\_SB");
>
>      dev = aml_device("NVDR");
> @@ -1266,9 +1269,6 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
>
>      /* copy AML table into ACPI tables blob and patch header there */
>      g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
> -    mem_addr_offset = build_append_named_dword(table_data,
> -                                               NVDIMM_ACPI_MEM_ADDR);
> -
>      bios_linker_loader_alloc(linker,
>                               NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
>                               sizeof(NvdimmDsmIn), false /* high memory */);

I gave this a shot and it appears to breaking some assumption of where
this device is mapped relative to System RAM:

 ioremap on RAM at 0x00000000bffe0000 - 0x000000019ffe1fff
 WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166
__ioremap_caller+0x28b/0x300
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.17.0-rc1+ #1734
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
 RIP: 0010:__ioremap_caller+0x28b/0x300
 RSP: 0000:ffffffff82603db0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 00000000bffe0000 RCX: 0000000000000006
 RDX: 0000000000000168 RSI: ffffffff82618f90 RDI: 0000000000000246
 RBP: 00000000e0002000 R08: 0000000000000000 R09: 0000000000000000
 R10: ffff88043e7d8000 R11: 0000000000000000 R12: 0000000000000000
 R13: 00000000bffe0000 R14: ffffffff81a731e9 R15: ffffffff82603ee4
 FS:  0000000000000000(0000) GS:ffff880431400000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000ffffffff CR3: 0000000002610000 CR4: 00000000000406b0
 Call Trace:
  ? acpi_os_map_iomem+0x7b/0x1c0
  acpi_os_map_iomem+0x189/0x1c0
  acpi_tb_acquire_table+0x39/0x64
  acpi_tb_validate_table+0x21/0x33
  acpi_tb_verify_temp_table+0x37/0x213
  acpi_reallocate_root_table+0xe1/0x112
  acpi_early_init+0x4b/0x102
  start_kernel+0x419/0x4ee
  secondary_startup_64+0xa5/0xb0
