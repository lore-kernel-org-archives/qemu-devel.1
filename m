Received: from eggs.gnu.org ([2001:4830:134:3::10]:54343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1elF5U-0007a9-D2
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1elF5Q-0006B5-2q
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:28:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1elF5P-00069Y-Qr
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 09:28:03 -0500
Date: Mon, 12 Feb 2018 15:27:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180212152745.2e333fa6@redhat.com>
In-Reply-To: <1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-5-git-send-email-stefanb@linux.vnet.ibm.com>
	<1e1dd3a3-7d87-38b1-cab3-5be375787896@linux.vnet.ibm.com>
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
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, kevin@koconnor.net, lersek@redhat.com, mst@redhat.com

On Fri, 9 Feb 2018 15:19:31 -0500
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 01/16/2018 10:51 AM, Stefan Berger wrote:
> > The TPM Physical Presence interface consists of an ACPI part, a shared
> > memory part, and code in the firmware. Users can send messages to the
> > firmware by writing a code into the shared memory through invoking the
> > ACPI code. When a reboot happens, the firmware looks for the code and
> > acts on it by sending sequences of commands to the TPM.
> >
> > This patch adds the ACPI code. It is similar to the one in EDK2 but doesn't
> > assume that SMIs are necessary to use. It uses a similar datastructure for
> > the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make use
> > of it. I extended the shared memory data structure with an array of 256
> > bytes, one for each code that could be implemented. The array contains
> > flags describing the individual codes. This decouples the ACPI implementation
> > from the firmware implementation.
> >
> > The underlying TCG specification is accessible from the following page.
> >
> > https://trustedcomputinggroup.org/tcg-physical-presence-interface-specification/
> >
> > This patch implements version 1.30.  
> 
> I have played around with this patch and some modifications to EDK2. 
> Though for EDK2 the question is whether to try to circumvent their 
> current implementation that uses SMM or use SMM. With this patch so far 
> I circumvent it, which is maybe not a good idea.
> 
> The facts for EDK2's PPI:
> 
> - from within the OS a PPI code is submitted to ACPI and ACPI enters SMM 
> via an SMI and the PPI code is written into a UEFI variable. For this 
> ACPI uses the memory are at 0xFFFF 0000 to pass parameters from the OS 
> (via ACPI) to SMM. This is declared in ACPI with an OperationRegion() at 
> that address. Once the machine is rebooted, UEFI reads the variable and 
> finds the PPI code and reacts to it.
> 
> 
> The facts for SeaBIOS:
> - we cannot use the area at 0xFFFF 0000 since SeaBIOS is also mapped to 
> this address. So we would have to use the PPI memory device's memory 
> region, which is currently at 0xFED4 5000. SeaBIOS doesn't have 
> persistent memory like NVRAM where it stores varaibles. So to pass the 
> PPI code here the OS would invoke ACPI, which in turn would write the 
> PPI code into the PPI memory directly. Upon reboot SeaBIOS would find 
> the PPI code in the PPI memory device and react to it.
> 
> The PPI device in this patch series allocates 0x400 bytes. 0x200 bytes 
> are used by the OperationRegion() in this patch series. The rest was 
> thought of for future extensions.
> 
> To allow both firmwares to use PPI, we would need to be able to have the 
> OperationRegion() be flexible and located at 0xFFFF 0000 for EDK2 and 
> 0xFED4 5000 for SeaBIOS, per choice of the firmware. One way to achieve 
> this would be to have the firmwares choose their operation region base 
> address by writing into the PPI memory device at offset 0x200 (for 
> example). A '1' there would mean that we want the OperationRegion() at 
> 0xFFFF 0000, and a '2' would mean at the base address of the PPI device 
> (0xFED4 5000). This could be achieved by declaring a 2nd 
> OperationRegion() in the ACPI code that is located at 0xFED4 5200 and we 
> declare that 1st OperationRegion()'s address based on findings from 
> there. Further, a flags variable at offset 0x201 could indicate whether 
> an SMI is needed to enter SMM or not. Obviously, the ACPI code would 
> become more complex to be able to support both firmwares at the same time.
> This is a lot of details but I rather post this description before 
> posting more patches. To make these changes and get it to work with at 
> least SeaBIOS is probably fairly easy. But is this acceptable?

You could use hw/acpi/vmgenid.c as example,

use following command to instruct firmware to write address back to QEMU:

    bios_linker_loader_write_pointer(linker,                                     
        TMP_PPI_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),                           
        TPM_PPI_MEM_FW_CFG_FILE, TPM_PPI_MEM_OFFSET); 

then when address is written into fwcfg, a callback in QEMU would be called due to

    /* Create a read-write fw_cfg file for Address */                            
    fw_cfg_add_file_callback(s, TPM_PPI_ADDR_FW_CFG_FILE, ...);  

when CB is called you could map persistent overlay memory region
(PPI memory device) at address written by firmware.

As for OperationRegion, you can instruct firmware to patch address
in AML as well, using bios_linker_loader_add_pointer() linker command.
what I'd suggest is to use dedicated TPM SSDT table and
at its start put a DWORD/QWORD variable where address would be patched in
and then use that variable as argument to OperationRegion

 ssdt = init_aml_allocator();
 ...
 addr_offset = table_data->len + build_append_named_dword(ssdt->buf, "PPIA");
 ...
 ... aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
                      aml_name("PPIA"), TPM_PPI_STRUCT_SIZE)
 ...
 bios_linker_loader_add_pointer(linker,                                       
       ACPI_BUILD_TABLE_FILE, addr_offset, sizeof(uint32_t),                    
       TPM_PPI_MEM_FW_CFG_FILE, 0);

This way both UEFI and Seabios would use the same implementation and
work the same way.

aml_operation_region("TPPI",..., aml_name("PPIA"), ...)
might work but it's not per spec, so it would be better to add
an API similar to build_append_named_dword() but only for
OperationRegion() which would return its offset within the table.
And skip on intermediate dword variable.


Wrt migration, you'd need to migrate address where PPI memory device
is mapped and its memory region.

As for giving up control to from OS (APCI) to firmware that would be
target depended, one could use writing to SMM port to trigger SMI
for example and something else in case of ARM or x86 SMM-less design.

>     Stefan
> 
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >
> > ---
> >   v1->v2:
> >     - get rid of FAIL variable; function 5 was using it and always
> >       returns 0; the value is related to the ACPI function call not
> >       a possible failure of the TPM function call.
> >     - extend shared memory data structure with per-opcode entries
> >       holding flags and use those flags to determine what to return
> >       to caller
> >     - implement interface version 1.3
> > ---
> >   hw/i386/acpi-build.c        | 273 ++++++++++++++++++++++++++++++++++++++++++++
> >   include/hw/acpi/acpi-defs.h |   2 +
> >   include/hw/acpi/tpm.h       |  31 +++++
> >   3 files changed, 306 insertions(+)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 522d6d2..f8c2d01 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -42,6 +42,7 @@
> >   #include "hw/acpi/memory_hotplug.h"
> >   #include "sysemu/tpm.h"
> >   #include "hw/acpi/tpm.h"
> > +#include "hw/tpm/tpm_ppi.h"
> >   #include "hw/acpi/vmgenid.h"
> >   #include "sysemu/tpm_backend.h"
> >   #include "hw/timer/mc146818rtc_regs.h"
> > @@ -1860,6 +1861,276 @@ static Aml *build_q35_osc_method(void)
> >   }
> >
> >   static void
> > +build_tpm_ppi(Aml *dev, TPMVersion tpm_version)
> > +{
> > +    Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> > +
> > +    aml_append(dev,
> > +               aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
> > +                                    aml_int(TPM_PPI_ADDR_BASE),
> > +                                    TPM_PPI_STRUCT_SIZE));
> > +
> > +    field = aml_field("TPPI", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> > +    aml_append(field, aml_named_field("PPIN",
> > +               sizeof(uint8_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_named_field("PPIP",
> > +               sizeof(uint32_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_named_field("PPRP",
> > +               sizeof(uint32_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_named_field("PPRQ",
> > +               sizeof(uint32_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_named_field("PPRM",
> > +               sizeof(uint32_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_named_field("LPPR",
> > +               sizeof(uint32_t) * BITS_PER_BYTE));
> > +    aml_append(field, aml_reserved_field(
> > +               sizeof(uint32_t) * BITS_PER_BYTE /* FRET */ +
> > +               sizeof(uint8_t) * BITS_PER_BYTE /* MCIN */ +
> > +               sizeof(uint32_t) * BITS_PER_BYTE * 4 /* MCIP .. UCRQ */ +
> > +               sizeof(uint8_t) * BITS_PER_BYTE * 214));
> > +    aml_append(field, aml_named_field("FUNC",
> > +               sizeof(uint8_t) * BITS_PER_BYTE * 256));
> > +    aml_append(dev, field);
> > +
> > +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> > +    {
> > +        uint8_t zerobyte[1] = { 0 };
> > +
> > +        ifctx = aml_if(
> > +                  aml_equal(aml_arg(0),
> > +                            aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))
> > +                );
> > +        {
> > +            aml_append(ifctx,
> > +                       aml_store(aml_to_integer(aml_arg(2)), aml_local(0)));
> > +
> > +            /* standard DSM query function */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(0)));
> > +            {
> > +                uint8_t byte_list[2] = { 0xff, 0x01 };
> > +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* interface version: 1.3 */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(1)));
> > +            {
> > +                aml_append(ifctx2, aml_return(aml_string("1.3")));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* submit TPM operation */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(2)));
> > +            {
> > +                /* get opcode */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> > +                                                           aml_int(0))),
> > +                                     aml_local(0)));
> > +                /* get opcode flags */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
> > +                                                           aml_local(0))),
> > +                                     aml_local(1)));
> > +                ifctx3 = aml_if(
> > +                              aml_equal(
> > +                                  aml_and(aml_local(1),
> > +                                          aml_int(TPM_PPI_FUNC_IMPLEMENTED),
> > +                                          NULL),
> > +                                  aml_int(0)
> > +                              )
> > +                         );
> > +                {
> > +                    /* 1: not implemented */
> > +                    aml_append(ifctx3, aml_return(aml_int(1)));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +                aml_append(ifctx2, aml_store(aml_local(0), aml_name("PPRQ")));
> > +                aml_append(ifctx2, aml_store(aml_int(0), aml_name("PPRM")));
> > +                /* 0: success */
> > +                aml_append(ifctx2, aml_return(aml_int(0)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* get pending TPM operation */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(3)));
> > +            {
> > +                /* revision to integer */
> > +                aml_append(ifctx2,
> > +                           aml_store(
> > +                             aml_to_integer(aml_arg(1)),
> > +                             aml_local(1)));
> > +                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(1)));
> > +                {
> > +                    pak = aml_package(2);
> > +                    aml_append(pak, aml_int(0));
> > +                    aml_append(pak, aml_name("PPRQ"));
> > +                    aml_append(ifctx3, aml_return(pak));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +
> > +                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(2)));
> > +                {
> > +                    pak = aml_package(3);
> > +                    aml_append(pak, aml_int(0));
> > +                    aml_append(pak, aml_name("PPRQ"));
> > +                    aml_append(pak, aml_name("PPRM"));
> > +                    aml_append(ifctx3, aml_return(pak));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* get platform-specific action to transition to pre-OS env. */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(4)));
> > +            {
> > +                /* get opcode */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_name("PPRQ"),
> > +                                     aml_local(0)));
> > +                /* get opcode flags */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
> > +                                                           aml_local(0))),
> > +                                     aml_local(1)));
> > +                /* return action flags */
> > +                aml_append(ifctx2,
> > +                           aml_return(
> > +                               aml_shiftright(
> > +                                   aml_and(aml_local(1),
> > +                                           aml_int(TPM_PPI_FUNC_ACTION_MASK),
> > +                                           NULL),
> > +                                   aml_int(1),
> > +                                   NULL)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* get TPM operation response */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(5)));
> > +            {
> > +                pak = aml_package(3);
> > +
> > +                aml_append(pak, aml_int(0));
> > +                aml_append(pak, aml_name("LPPR"));
> > +                aml_append(pak, aml_name("PPRP"));
> > +
> > +                aml_append(ifctx2, aml_return(pak));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* submit preferred user language */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(6)));
> > +            {
> > +                /* 3 = not implemented */
> > +                aml_append(ifctx2, aml_return(aml_int(3)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* submit TPM operation v2 */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(7)));
> > +            {
> > +                /* get opcode */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> > +                                                           aml_int(0))),
> > +                                     aml_local(0)));
> > +                /* get opcode flags */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
> > +                                                           aml_local(0))),
> > +                                     aml_local(1)));
> > +                ifctx3 = aml_if(
> > +                              aml_equal(
> > +                                  aml_and(aml_local(1),
> > +                                          aml_int(TPM_PPI_FUNC_MASK),
> > +                                          NULL),
> > +                                  aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)
> > +                              )
> > +                         );
> > +                {
> > +                    /* 1: not implemented */
> > +                    aml_append(ifctx3, aml_return(aml_int(1)));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +
> > +                ifctx3 = aml_if(
> > +                              aml_equal(
> > +                                  aml_and(
> > +                                      aml_local(1),
> > +                                      aml_int(TPM_PPI_FUNC_MASK),
> > +                                      NULL),
> > +                                  aml_int(TPM_PPI_FUNC_BLOCKED)
> > +                              )
> > +                         );
> > +                {
> > +                    /* 3: blocked by firmware */
> > +                    aml_append(ifctx3, aml_return(aml_int(3)));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +
> > +                /* revision to integer */
> > +                aml_append(ifctx2,
> > +                           aml_store(
> > +                             aml_to_integer(aml_arg(1)),
> > +                             aml_local(1)));
> > +
> > +                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(1)));
> > +                {
> > +                    /* revision 1 */
> > +                    aml_append(ifctx3, aml_store(aml_local(0), aml_name("PPRQ")));
> > +                    aml_append(ifctx3, aml_store(aml_int(0), aml_name("PPRM")));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +
> > +                ifctx3 = aml_if(aml_equal(aml_local(1), aml_int(2)));
> > +                {
> > +                    /* revision 2 */
> > +                    aml_append(ifctx3, aml_store(aml_local(0), aml_name("PPRQ")));
> > +                    aml_append(ifctx3, aml_store(
> > +                                         aml_derefof(
> > +                                           aml_index(aml_arg(3),
> > +                                                     aml_int(1))),
> > +                                         aml_name("PPRM")));
> > +                }
> > +                aml_append(ifctx2, ifctx3);
> > +                /* 0: success */
> > +                aml_append(ifctx2, aml_return(aml_int(0)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            /* get user confirmation status for operation */
> > +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(8)));
> > +            {
> > +                /* get opcode */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> > +                                                           aml_int(0))),
> > +                                     aml_local(0)));
> > +                /* get opcode flags */
> > +                aml_append(ifctx2,
> > +                           aml_store(aml_derefof(aml_index(aml_name("FUNC"),
> > +                                                           aml_local(0))),
> > +                                     aml_local(1)));
> > +                /* return confirmation status code */
> > +                aml_append(ifctx2,
> > +                           aml_return(
> > +                               aml_shiftright(
> > +                                   aml_and(aml_local(1),
> > +                                           aml_int(TPM_PPI_FUNC_MASK),
> > +                                           NULL),
> > +                                   aml_int(3),
> > +                                   NULL)));
> > +            }
> > +            aml_append(ifctx, ifctx2);
> > +
> > +            aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> > +        }
> > +        aml_append(method, ifctx);
> > +    }
> > +    aml_append(dev, method);
> > +}
> > +
> > +static void
> >   build_dsdt(GArray *table_data, BIOSLinker *linker,
> >              AcpiPmInfo *pm, AcpiMiscInfo *misc,
> >              Range *pci_hole, Range *pci_hole64, MachineState *machine)
> > @@ -2218,6 +2489,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >                    */
> >                   /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> >                   aml_append(dev, aml_name_decl("_CRS", crs));
> > +                build_tpm_ppi(dev, misc->tpm_version);
> >                   aml_append(scope, dev);
> >               }
> >
> > @@ -2636,6 +2908,7 @@ static void build_qemu(GArray *table_data, BIOSLinker *linker,
> >       if (tpm_version != TPM_VERSION_UNSPEC) {
> >           qemu->tpmppi_addr = TPM_PPI_ADDR_BASE;
> >           qemu->tpm_version = tpm_version;
> > +        qemu->tpmppi_version = TPM_PPI_VERSION_1_30;
> >       }
> >
> >       build_header(linker, table_data,
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 98764c1..a182194 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -578,6 +578,8 @@ struct AcpiTableQemu {
> >       ACPI_TABLE_HEADER_DEF
> >       uint32_t tpmppi_addr;
> >       uint8_t tpm_version; /* 1 = 1.2, 2 = 2 */
> > +    uint8_t tpmppi_version;
> > +#define TPM_PPI_VERSION_1_30  1
> >   };
> >   typedef struct AcpiTableQemu AcpiTableQemu;
> >
> > diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> > index 16227bc..130a039 100644
> > --- a/include/hw/acpi/tpm.h
> > +++ b/include/hw/acpi/tpm.h
> > @@ -37,4 +37,35 @@
> >   #define TPM_PPI_ADDR_SIZE           0x400
> >   #define TPM_PPI_ADDR_BASE           0xfffef000
> >
> > +struct tpm_ppi {
> > +    uint8_t ppin;            /*  0: set by BIOS */
> > +    uint32_t ppip;           /*  1: set by ACPI; not used */
> > +    uint32_t pprp;           /*  5: response from TPM; set by BIOS */
> > +    uint32_t pprq;           /*  9: opcode; set by ACPI */
> > +    uint32_t pprm;           /* 13: parameter for opcode; set by ACPI */
> > +    uint32_t lppr;           /* 17: last opcode; set by BIOS */
> > +    uint32_t fret;           /* 21: set by ACPI; not used */
> > +    uint8_t res1;            /* 25: reserved */
> > +    uint32_t res2[4];        /* 26: reserved */
> > +    uint8_t  res3[214];      /* 42: reserved */
> > +    uint8_t  func[256];      /* 256: per TPM function implementation flags;
> > +                                     set by BIOS */
> > +/* indication whether function is implemented; bit 0 */
> > +#define TPM_PPI_FUNC_IMPLEMENTED       (1 << 0)
> > +/* actions OS should take to transition to the pre-OS env.; bits 1, 2 */
> > +#define TPM_PPI_FUNC_ACTION_SHUTDOWN   (1 << 1)
> > +#define TPM_PPI_FUNC_ACTION_REBOOT     (2 << 1)
> > +#define TPM_PPI_FUNC_ACTION_VENDOR     (3 << 1)
> > +#define TPM_PPI_FUNC_ACTION_MASK       (3 << 1)
> > +/* whether function is blocked by BIOS settings; bits 3,4,5 */
> > +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 3)
> > +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 3)
> > +#define TPM_PPI_FUNC_BLOCKED             (2 << 3)
> > +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 3)
> > +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 3)
> > +#define TPM_PPI_FUNC_MASK                (7 << 3)
> > +} QEMU_PACKED;
> > +
> > +#define TPM_PPI_STRUCT_SIZE  sizeof(struct tpm_ppi)
> > +
> >   #endif /* HW_ACPI_TPM_H */  
> 
> 
> 
