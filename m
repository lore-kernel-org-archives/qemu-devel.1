Received: from eggs.gnu.org ([2001:4830:134:3::10]:49139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLRE-00042s-HV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eZLRB-0001ro-6K
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:49:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eZLRA-0001rE-PL
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 13:49:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0AIme8P146199
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:49:19 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fdn2h2a7f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:49:17 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 13:49:16 -0500
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-4-git-send-email-stefanb@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 10 Jan 2018 13:49:13 -0500
MIME-Version: 1.0
In-Reply-To: <1515609318-1897-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <1bc0d808-a29e-03de-2a37-e2585c54385f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] acpi: Build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, kevin@koconnor.net, marcandre.lureau@redhat.com

On 01/10/2018 01:35 PM, Stefan Berger wrote:
> The TPM Physical Presence interface consists of an ACPI part, a shared
> memory part, and code in the firmware. Users can send messages to the
> firmware by writing a code into the shared memory through invoking the
> ACPI code. When a reboot happens, the firmware looks for the code and
> acts on it by sending sequences of commands to the TPM.
>
> This patch adds the ACPI code. It is similar to the one in EDK2 but doesn't
> assume that SMIs are necessary to use. Besides that it tests the code
> entered by the user and checks whether it is supported. The range of codes
> supported matches the range of codes supported in SeaBIOS. It uses the same
> datastructure for the shared memory as EDK2 does so that EDK2 and SeaBIOS
> could both make use of the shared memory.
>
> The underlying TCG specification is accessible from the following page.
>
> https://trustedcomputinggroup.org/tcg-physical-presence-interface-specification/
>
> This patch implements version 1.20.

The below ACPI code is partly a translation to C from a previous posted 
patch:

https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg05353.html


    Stefan
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>   hw/i386/acpi-build.c  | 227 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/acpi/tpm.h |  15 ++++
>   2 files changed, 242 insertions(+)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 18b939e..e3905a3 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -42,6 +42,7 @@
>   #include "hw/acpi/memory_hotplug.h"
>   #include "sysemu/tpm.h"
>   #include "hw/acpi/tpm.h"
> +#include "hw/tpm/tpm_ppi.h"
>   #include "hw/acpi/vmgenid.h"
>   #include "sysemu/tpm_backend.h"
>   #include "hw/timer/mc146818rtc_regs.h"
> @@ -1860,6 +1861,231 @@ static Aml *build_q35_osc_method(void)
>   }
>
>   static void
> +build_tpm_ppi(Aml *dev, TPMVersion tpm_version)
> +{
> +    Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> +
> +    aml_append(dev,
> +               aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE),
> +                                    TPM_PPI_STRUCT_SIZE));
> +
> +    field = aml_field("TPPI", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> +    aml_append(field, aml_named_field("PPIN",
> +               sizeof(uint8_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("PPIP",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("PPRP",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("PPRQ",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("PPRM",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("LPPR",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("FRET",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("RES1",
> +               sizeof(uint8_t) * BITS_PER_BYTE));
> +    aml_append(field, aml_named_field("RES2",
> +               sizeof(uint32_t) * BITS_PER_BYTE * 4));
> +    aml_append(field, aml_named_field("FAIL",
> +               sizeof(uint32_t) * BITS_PER_BYTE));
> +    aml_append(dev, field);
> +
> +    /*
> +     * Write the given operations code into 'PPRQ'.
> +     */
> +    method = aml_method("WRAM", 2, AML_SERIALIZED);
> +    {
> +        aml_append(method, aml_store(aml_arg(0), aml_name("PPRQ")));
> +        aml_append(method, aml_store(aml_arg(1), aml_name("PPRM")));
> +        /* 0 = Success */
> +        aml_append(method, aml_return(aml_int(0)));
> +    }
> +    aml_append(dev, method);
> +
> +    /*
> +     * CKOP: Check whether the opcode is valid
> +     */
> +    if (tpm_version == TPM_VERSION_1_2) {
> +        method = aml_method("CKOP", 1, AML_NOTSERIALIZED);
> +        {
> +            ifctx = aml_if(
> +                      aml_or(
> +                        aml_or(
> +                          aml_and(
> +                            aml_lgreater_equal(aml_arg(0), aml_int(0)),
> +                            aml_lless_equal(aml_arg(0), aml_int(11)),
> +                            NULL
> +                          ),
> +                          aml_equal(aml_arg(0), aml_int(14)),
> +                          NULL
> +                        ),
> +                        aml_and(
> +                          aml_lgreater_equal(aml_arg(0), aml_int(21)),
> +                          aml_lless_equal(aml_arg(0), aml_int(22)),
> +                          NULL
> +                       ),
> +                       NULL
> +                      )
> +                    );
> +            {
> +                aml_append(ifctx, aml_return(aml_int(1)));
> +            }
> +            aml_append(method, ifctx);
> +
> +            aml_append(method, aml_return(aml_int(0)));
> +        }
> +    } else {
> +        method = aml_method("CKOP", 1, AML_NOTSERIALIZED);
> +        {
> +            ifctx = aml_if(
> +                      aml_equal(aml_arg(0), aml_int(0))
> +                    );
> +            {
> +                aml_append(ifctx, aml_return(aml_int(1)));
> +            }
> +            aml_append(method, ifctx);
> +
> +            aml_append(method, aml_return(aml_int(0)));
> +        }
> +    }
> +    aml_append(dev, method);
> +
> +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        uint8_t zerobyte[1] = { 0 };
> +
> +        ifctx = aml_if(
> +                  aml_equal(aml_arg(0),
> +                            aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))
> +                );
> +        {
> +            aml_append(ifctx,
> +                       aml_store(aml_to_integer(aml_arg(2)), aml_local(0)));
> +
> +            /* standard DSM query function */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(0)));
> +            {
> +                uint8_t byte_list[2] = { 0xff, 0x01 };
> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* interface version: 1.2 */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(1)));
> +            {
> +                aml_append(ifctx2, aml_return(aml_string("1.2")));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit TPM operation */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(2)));
> +            {
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                ifctx3 = aml_if(aml_call1("CKOP", aml_local(0)));
> +                {
> +                    aml_append(ifctx3,
> +                               aml_return(aml_call2("WRAM",
> +                                                    aml_local(0),
> +                                                    aml_int(0))));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                aml_append(ifctx2, aml_return(aml_int(1)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get pending TPM operation */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(3)));
> +            {
> +                pak = aml_package(2);
> +                aml_append(pak, aml_int(0));
> +                aml_append(pak, aml_name("PPRQ"));
> +                aml_append(ifctx2, aml_return(pak));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get platform-specific action to transition to pre-OS env. */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(4)));
> +            {
> +                /* 2 = reboot */
> +                aml_append(ifctx2, aml_return(aml_int(2)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get TPM operation response */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(5)));
> +            {
> +                pak = aml_package(3);
> +
> +                aml_append(pak, aml_name("FAIL"));
> +                aml_append(pak, aml_name("LPPR"));
> +                aml_append(pak, aml_name("PPRP"));
> +
> +                aml_append(ifctx2, aml_return(pak));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit preferred user language */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(6)));
> +            {
> +                /* 3 = not implemented */
> +                aml_append(ifctx2, aml_return(aml_int(3)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit TPM operation v2 */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(7)));
> +            {
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                ifctx3 = aml_if(aml_call1("CKOP", aml_local(0)));
> +                {
> +                    aml_append(ifctx3,
> +                               aml_store(aml_call2("WRAM",
> +                                                   aml_local(0),
> +                                                   aml_int(0)),
> +                                         aml_local(1)));
> +                    aml_append(ifctx3, aml_return(aml_local(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                /* 1 = requested operation not implemented */
> +                aml_append(ifctx2, aml_return(aml_int(1)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get user confirmation status for operation */
> +            ifctx2 = aml_if(aml_equal(aml_local(0), aml_int(8)));
> +            {
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                ifctx3 = aml_if(aml_call1("CKOP", aml_local(0)));
> +                {
> +                    /* 4 = Allowed and physically present user not required */
> +                    aml_append(ifctx3, aml_return(aml_int(4)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                /* 0 = requested operation not implemented */
> +                aml_append(ifctx2, aml_return(aml_int(0)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
> +        }
> +        aml_append(method, ifctx);
> +    }
> +    aml_append(dev, method);
> +}
> +
> +static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker,
>              AcpiPmInfo *pm, AcpiMiscInfo *misc,
>              Range *pci_hole, Range *pci_hole64, MachineState *machine)
> @@ -2218,6 +2444,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                    */
>                   /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>                   aml_append(dev, aml_name_decl("_CRS", crs));
> +                build_tpm_ppi(dev, misc->tpm_version);
>                   aml_append(scope, dev);
>               }
>
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d9b7452..23f5da1 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -37,4 +37,19 @@
>   #define TPM_PPI_ADDR_SIZE           0x100
>   #define TPM_PPI_ADDR_BASE           0xffff0000
>
> +struct tpm_ppi {
> +    uint8_t ppin;            /* set by BIOS; currently initialization flag */
> +    uint32_t ppip;           /* set by ACPI; not used */
> +    uint32_t pprp;           /* response from TPM; set by BIOS */
> +    uint32_t pprq;           /* opcode; set by ACPI */
> +    uint32_t pprm;           /* parameter for opcode; set by ACPI */
> +    uint32_t lppr;           /* last opcode; set by BIOS */
> +    uint32_t fret;           /* set by ACPI; not used*/
> +    uint32_t res1;           /* reserved */
> +    uint32_t res2[4];        /* reserved */
> +    uint32_t fail;           /* set by BIOS (0 = success) */
> +} QEMU_PACKED;
> +
> +#define TPM_PPI_STRUCT_SIZE  sizeof(struct tpm_ppi)
> +
>   #endif /* HW_ACPI_TPM_H */
