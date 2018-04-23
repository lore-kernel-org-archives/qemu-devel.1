Received: from eggs.gnu.org ([2001:4830:134:3::10]:56183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fAikb-0001qq-QA
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fAikW-000673-Ro
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:11:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fAikW-00065X-Lp
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 17:11:48 -0400
Date: Tue, 24 Apr 2018 00:11:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180424000615-mutt-send-email-mst@kernel.org>
References: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53973A6AF@ORSMSX110.amr.corp.intel.com>
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
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Williams, Dan J" <dan.j.williams@intel.com>, "He, Junyan" <junyan.he@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Mon, Apr 23, 2018 at 08:35:45PM +0000, Schmauss, Erik wrote:
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

Hmm I suspect this won't work because you are appending to
table_data, but the ssdt header isn't there yet - it's
in ssdt at this point.

Look at hw/acpi/vmgenid.c for how to do it right:

    vgia_offset = table_data->len +
        build_append_named_dword(ssdt->buf, "VGIA");

ugly, but works.


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
