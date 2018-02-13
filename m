Received: from eggs.gnu.org ([2001:4830:134:3::10]:56221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ela2q-0004If-39
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ela2l-0006CV-3h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:50:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ela2k-0006CJ-Tr
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:50:43 -0500
Date: Tue, 13 Feb 2018 13:50:39 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180213135039.28813f33@redhat.com>
In-Reply-To: <cc3261c2-1d72-42d0-15c6-3163c36aac69@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
	<20180212152745.2e333fa6@redhat.com>
	<89bd0c08-f00d-e6c7-c548-1d80fb951b8d@linux.vnet.ibm.com>
	<20180212185229.2eea53b9@redhat.com>
	<cc3261c2-1d72-42d0-15c6-3163c36aac69@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: marcandre.lureau@redhat.com, kevin@koconnor.net, lersek@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Mon, 12 Feb 2018 13:45:17 -0500
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 02/12/2018 12:52 PM, Igor Mammedov wrote:
> > On Mon, 12 Feb 2018 11:44:16 -0500
> > Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >  
> >> On 02/12/2018 09:27 AM, Igor Mammedov wrote:  
> >>> On Fri, 9 Feb 2018 15:19:31 -0500
> >>> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> >>>     
> >>>> On 01/16/2018 10:51 AM, Stefan Berger wrote:  
> >>>>> The TPM Physical Presence interface consists of an ACPI part, a shared
> >>>>> memory part, and code in the firmware. Users can send messages to the
> >>>>> firmware by writing a code into the shared memory through invoking the
> >>>>> ACPI code. When a reboot happens, the firmware looks for the code and
> >>>>> acts on it by sending sequences of commands to the TPM.
> >>>>>
> >>>>> This patch adds the ACPI code. It is similar to the one in EDK2 but doesn't
> >>>>> assume that SMIs are necessary to use. It uses a similar datastructure for
> >>>>> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make use
> >>>>> of it. I extended the shared memory data structure with an array of 256
> >>>>> bytes, one for each code that could be implemented. The array contains
> >>>>> flags describing the individual codes. This decouples the ACPI implementation
> >>>>> from the firmware implementation.
> >>>>>
> >>>>> The underlying TCG specification is accessible from the following page.
> >>>>>
> >>>>> https://trustedcomputinggroup.org/tcg-physical-presence-interface-specification/
> >>>>>
> >>>>> This patch implements version 1.30.  
> >>>> I have played around with this patch and some modifications to EDK2.
> >>>> Though for EDK2 the question is whether to try to circumvent their
> >>>> current implementation that uses SMM or use SMM. With this patch so far
> >>>> I circumvent it, which is maybe not a good idea.
> >>>>
> >>>> The facts for EDK2's PPI:
> >>>>
> >>>> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM
> >>>> via an SMI and the PPI code is written into a UEFI variable. For this
> >>>> ACPI uses the memory are at 0xFFFF 0000 to pass parameters from the OS
> >>>> (via ACPI) to SMM. This is declared in ACPI with an OperationRegion() at
> >>>> that address. Once the machine is rebooted, UEFI reads the variable and
> >>>> finds the PPI code and reacts to it.
> >>>>
> >>>>
> >>>> The facts for SeaBIOS:
> >>>> - we cannot use the area at 0xFFFF 0000 since SeaBIOS is also mapped to
> >>>> this address. So we would have to use the PPI memory device's memory
> >>>> region, which is currently at 0xFED4 5000. SeaBIOS doesn't have
> >>>> persistent memory like NVRAM where it stores varaibles. So to pass the
> >>>> PPI code here the OS would invoke ACPI, which in turn would write the
> >>>> PPI code into the PPI memory directly. Upon reboot SeaBIOS would find
> >>>> the PPI code in the PPI memory device and react to it.
> >>>>
> >>>> The PPI device in this patch series allocates 0x400 bytes. 0x200 bytes
> >>>> are used by the OperationRegion() in this patch series. The rest was
> >>>> thought of for future extensions.
> >>>>
> >>>> To allow both firmwares to use PPI, we would need to be able to have the
> >>>> OperationRegion() be flexible and located at 0xFFFF 0000 for EDK2 and
> >>>> 0xFED4 5000 for SeaBIOS, per choice of the firmware. One way to achieve
> >>>> this would be to have the firmwares choose their operation region base
> >>>> address by writing into the PPI memory device at offset 0x200 (for
> >>>> example). A '1' there would mean that we want the OperationRegion() at
> >>>> 0xFFFF 0000, and a '2' would mean at the base address of the PPI device
> >>>> (0xFED4 5000). This could be achieved by declaring a 2nd
> >>>> OperationRegion() in the ACPI code that is located at 0xFED4 5200 and we
> >>>> declare that 1st OperationRegion()'s address based on findings from
> >>>> there. Further, a flags variable at offset 0x201 could indicate whether
> >>>> an SMI is needed to enter SMM or not. Obviously, the ACPI code would
> >>>> become more complex to be able to support both firmwares at the same time.
> >>>> This is a lot of details but I rather post this description before
> >>>> posting more patches. To make these changes and get it to work with at
> >>>> least SeaBIOS is probably fairly easy. But is this acceptable?  
> >>> You could use hw/acpi/vmgenid.c as example,
> >>>
> >>> use following command to instruct firmware to write address back to QEMU:
> >>>
> >>>       bios_linker_loader_write_pointer(linker,
> >>>           TMP_PPI_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
> >>>           TPM_PPI_MEM_FW_CFG_FILE, TPM_PPI_MEM_OFFSET);
> >>>
> >>> then when address is written into fwcfg, a callback in QEMU would be called due to
> >>>
> >>>       /* Create a read-write fw_cfg file for Address */
> >>>       fw_cfg_add_file_callback(s, TPM_PPI_ADDR_FW_CFG_FILE, ...);
> >>>
> >>> when CB is called you could map persistent overlay memory region
> >>> (PPI memory device) at address written by firmware.  
> >>  
> >>> As for OperationRegion, you can instruct firmware to patch address
> >>> in AML as well, using bios_linker_loader_add_pointer() linker command.
> >>> what I'd suggest is to use dedicated TPM SSDT table and
> >>> at its start put a DWORD/QWORD variable where address would be patched in
> >>> and then use that variable as argument to OperationRegion
> >>>
> >>>    ssdt = init_aml_allocator();
> >>>    ...
> >>>    addr_offset = table_data->len + build_append_named_dword(ssdt->buf, "PPIA");
> >>>    ...
> >>>    ... aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
> >>>                         aml_name("PPIA"), TPM_PPI_STRUCT_SIZE)
> >>>    ...
> >>>    bios_linker_loader_add_pointer(linker,
> >>>          ACPI_BUILD_TABLE_FILE, addr_offset, sizeof(uint32_t),
> >>>          TPM_PPI_MEM_FW_CFG_FILE, 0);
> >>>
> >>> This way both UEFI and Seabios would use the same implementation and
> >>> work the same way.  
> >> Thanks for this sample code. Though it only applies to how they write
> >> the base address for the OperationRegion() and not the behaviour of the
> >> code when it comes to SMI versus non-SMI.  
> >  From what I've gathered from discussions around the topic
> > is that untrusted guest code writes request into PPI memory
> > and then FW on reboot should act on it somehow (i.e. ask
> > user a terminal id changes are ok).
> >
> > So I'd say, SMI versus non-SMI is a separate issue and we shouldn't
> > mix it with how firmware allocates PPI memory.
> >  
> >>> aml_operation_region("TPPI",..., aml_name("PPIA"), ...)
> >>> might work but it's not per spec, so it would be better to add
> >>> an API similar to build_append_named_dword() but only for
> >>> OperationRegion() which would return its offset within the table.
> >>> And skip on intermediate dword variable.
> >>>
> >>>
> >>> Wrt migration, you'd need to migrate address where PPI memory device
> >>> is mapped and its memory region.  
> >> So today the PPI memory device is located at some address A. If we
> >> decided that we need to move it to address B due to a collision with
> >> another device, then are we going to be able to update the ACPI
> >> OperationRegion base address post-migration to move it from address A to
> >> address B? Or should we refuse the migration ? Keeping it at address A
> >> seems wrong due to the collision.  
> > Rule of the thumb is that HW on src and dst must be the same,
> > which implies the same address.  
> 
> Following this we don't need to migrate the address, do we ? My current 
> implementation doesn't and uses a constant to set the subregion.
see below why migrating address might be necessary
 
> +void tpm_ppi_init_io(TPMPPI *tpmppi, struct MemoryRegion *m, Object *obj)
> +{
> +    memory_region_init_io(&tpmppi->mmio, obj, &tpm_ppi_memory_ops,
> +                          tpmppi, "tpm-ppi-mmio",
> +                          TPM_PPI_ADDR_SIZE);
> +
> +    memory_region_add_subregion(m, TPM_PPI_ADDR_BASE, &tpmppi->mmio);
In QEMU typically it's not acceptable for device to map itself at some
fixed address. (but there are exceptions). Usually mapping in
common address space is done by board that uses device.

> +}
> 
> 
> Here TPM_PPI_ADDR_BASE is set to 0xfed4 5000. Is that wrong and would 
> have to be dynamic?I must admit I haven't spent much thought on EDK2's 
> 0xffff 0000 area and how that would be handled. It may very well have to 
> be yet another region because in the current PPI memory is more data 
> stored than what EDK2 uses in the 0xffff 0000 region.
If you in advance take in account that address might be different
depending on target/board/FW kind or even version. Starting
with flexible allocation makes more sense, since one won't have
to redo implementation once something else beside SeaBIOS
needed to be supported. And there won't be need to introduce
negotiation mechanism on top to allow FW specify which of fixed
addresses to use. With all this building up, a simplistic
fixed address impl. becomes rather complex.

> > Also note that firmware on src is in RAM and it's also
> > migrated including address it's allocated/reported to QEMU on src.
> > So above mismatch nor collision isn't possible.  
> 
> > Though, more important point is that QEMU doesn't have to
> > give a damn (besides migrating this values from src to dst and
> > remapping overlay PPI memory region at that address (PCI code does
> > similar thing for migrated BARs)) about where in RAM this address
> > is allocated (it's upto firmware and should eliminate cross
> > version QEMU migration issues).
> > On new boot dst could get a new firmware which might allocate
> > region somewhere else and it would still work if it's migrated
> > back to the old host.  
> 
> That it can get a region somewhere else would depend on 'what'? Would 
> the firmware decide the address of the PPI device?
Yes, firmware would decide where to put it
For example EDK could write 0xffff0000 into fwcgf file
while SeaBIOS could write there something else.

If bios_linker API is used to allocate region, then that address
is taken from RAM address space that firmware reserves for ACPI
tables (i.e. it doesn't conflict with anything and won't be used
by guest OS as it's reported as reserved in E802 table).

> So the call 
> 'memory_region_add_subregion(m, TPM_PPI_ADDR_BASE, &tpmppi->mmio)' above 
> would have to be called by that callback ?
the callback, attached to file, will map PPI device memory
at written address:
  memory_region_add_subregion(m, fw_reported_ppi_addr, &tpmppi->mmio)

> I don't understand the part why 'it would still work if it's migrated 
> back to the old host.'  Maybe there's more flexibility with moving 
> addresses between migrations than what I currently know how to 
> implement. My understanding is that the base address of the PPI device 
> cannot change and both source and destination QEMU need to have it at 
> the same address. As I point out above, I am working with a hard coded 
> address that may have to be changed (=edited in the .h file) if we ever 
> were to detect a collision with another device.
And that changing 'fixed' address is the problem in case of
cross version migrations, as fixed address implies lockstep
update in both QEMU and firmware.
In case firmware with OLD constant is migrated to newer QEMU
with another address and vice verse, things will break.
Then to overcome issue you would have to migrate address as
device state anyway (but that would work only one way since
older QEMU with simple fixed address didn't have a clue about
it, plus other surrounding compat glue for supporting
old/new/other firmware).

If you go dynamic approach from the begging, you'll have
address as migrated state from the starters and QEMU won't
have any fixed address built in so there won't be any
dependency between QEMU and firmware. It won't matter
whether it's old or new QEMU is used, as firmware decides
how to program TMP/PPI device (allocates address from its
free address pool).

Considering you already have 2 different addresses depending
on firmware and there might be 3rd when ARM comes in
picture, I'm trying to persuade you to use dynamic approach
from the beginning to avoid compatibility/migration issues
in future.

Maybe instead of rewriting PPI series again, you could
just start with a simple prototype that would implement
this allocation logic in QEMU/SeaBIOS/EDK. And once that
is settled, fill it in with TPM specific logic.

PS:
I can guide you wrt usage of bios_liker API if hw/acpi/vmgenid.c
isn't enough of example.

> >>> As for giving up control to from OS (APCI) to firmware that would be
> >>> target depended, one could use writing to SMM port to trigger SMI
> >>> for example and something else in case of ARM or x86 SMM-less design.  
> >> Though to support these different cases, we either need to be able to
> >> generate different ACPI code or make it configurable via some sort of
> >> register. If we cannot get rid of these flag to let the firmware for
> >> example choose between non-SMI and SMI, then do we need to use the above
> >> shown callback mechanisms to avoid a 2nd field that lets one choose the
> >> base address of the PPI memory device?  
> > I'm sorry this is long discussion across several threads and
> > I've lost track of SMI vs SMI-less issue.
> > Could you point it out to me or describe here again what's the
> > problem and why we would need one vs another.  
> 
> See the explanation above. With SeaBIOS we wouldn't need SMM since we 
> wouldn't write the data in anything else than PPI. EDK2 uses SMM to 
> write the data into UEFI variables and ACPI would transition to it via 
> that interrupt.
I think Kevin did nice sum up of design.
