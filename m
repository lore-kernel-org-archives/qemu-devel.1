Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea1rO-0006Tn-Rz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea1rM-0005Dh-Tu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:07:14 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea1rM-0005Cl-JU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:07:12 -0500
Received: by mail-wm0-x234.google.com with SMTP id x4so3018466wmc.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 08:07:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1bc0d808-a29e-03de-2a37-e2585c54385f@linux.vnet.ibm.com>
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-4-git-send-email-stefanb@linux.vnet.ibm.com>
	<1bc0d808-a29e-03de-2a37-e2585c54385f@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 17:07:10 +0100
Message-ID: <CAJ+F1CK4umAVmPvPLunjXf10UcL_gVqENgu94eO17h82BPQzRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, kevin@koconnor.net, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Jan 10, 2018 at 7:49 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 01/10/2018 01:35 PM, Stefan Berger wrote:
>>
>> The TPM Physical Presence interface consists of an ACPI part, a shared
>> memory part, and code in the firmware. Users can send messages to the
>> firmware by writing a code into the shared memory through invoking the
>> ACPI code. When a reboot happens, the firmware looks for the code and
>> acts on it by sending sequences of commands to the TPM.
>>
>> This patch adds the ACPI code. It is similar to the one in EDK2 but
>> doesn't
>> assume that SMIs are necessary to use. Besides that it tests the code
>> entered by the user and checks whether it is supported. The range of cod=
es
>> supported matches the range of codes supported in SeaBIOS. It uses the
>> same
>> datastructure for the shared memory as EDK2 does so that EDK2 and SeaBIO=
S
>> could both make use of the shared memory.
>>
>> The underlying TCG specification is accessible from the following page.
>>
>>
>> https://trustedcomputinggroup.org/tcg-physical-presence-interface-specif=
ication/
>>
>> This patch implements version 1.20.
>
>
> The below ACPI code is partly a translation to C from a previous posted
> patch:
>
> https://lists.gnu.org/archive/html/qemu-devel/2015-05/msg05353.html
>
>

And fwiw, this is the acpi dump disassembled:

            Device (ISA.TPM)
            {
                Name (_HID, EisaId ("PNP0C31"))  // _HID: Hardware ID
                Name (_STA, 0x0F)  // _STA: Status
                Name (_CRS, ResourceTemplate ()  // _CRS: Current
Resource Settings
                {
                    Memory32Fixed (ReadWrite,
                        0xFED40000,         // Address Base
                        0x00005000,         // Address Length
                        )
                })
                OperationRegion (TPPI, SystemMemory, 0xFFFF0000, 0x31)
                Field (TPPI, AnyAcc, NoLock, Preserve)
                {
                    PPIN,   8,
                    PPIP,   32,
                    PPRP,   32,
                    PPRQ,   32,
                    PPRM,   32,
                    LPPR,   32,
                    FRET,   32,
                    RES1,   8,
                    RES2,   128,
                    FAIL,   32
                }

                Method (WRAM, 2, Serialized)
                {
                    PPRQ =3D Arg0
                    PPRM =3D Arg1
                    Return (Zero)
                }

                Method (CKOP, 1, NotSerialized)
                {
                    If ((Arg0 =3D=3D Zero))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Meth=
od
                {
                    If ((Arg0 =3D=3D ToUUID
("3dddfaa6-361b-4eb4-a424-8d10089d1653") /* Physical Presence
Interface */))
                    {
                        Local0 =3D ToInteger (Arg2)
                        If ((Local0 =3D=3D Zero))
                        {
                            Return (Buffer (0x02)
                            {
                                 0xFF, 0x01
           // ..
                            })
                        }

                        If ((Local0 =3D=3D One))
                        {
                            Return ("1.2")
                        }

                        If ((Local0 =3D=3D 0x02))
                        {
                            Local0 =3D DerefOf (Arg3 [Zero])
                            If (CKOP (Local0))
                            {
                                Return (WRAM (Local0, Zero))
                            }

                            Return (One)
                        }

                        If ((Local0 =3D=3D 0x03))
                        {
                            Return (Package (0x02)
                            {
                                Zero,
                                PPRQ
                            })
                        }

                        If ((Local0 =3D=3D 0x04))
                        {
                            Return (0x02)
                        }

                        If ((Local0 =3D=3D 0x05))
                        {
                            Return (Package (0x03)
                            {
                                FAIL,
                                LPPR,
                                PPRP
                            })
                        }

                        If ((Local0 =3D=3D 0x06))
                        {
                            Return (0x03)
                        }

                        If ((Local0 =3D=3D 0x07))
                        {
                            Local0 =3D DerefOf (Arg3 [Zero])
                            If (CKOP (Local0))
                            {
                                Local1 =3D WRAM (Local0, Zero)
                                Return (Local1)
                            }

                            Return (One)
                        }

                        If ((Local0 =3D=3D 0x08))
                        {
                            Local0 =3D DerefOf (Arg3 [Zero])
                            If (CKOP (Local0))
                            {
                                Return (0x04)
                            }

                            Return (Zero)
                        }

                        Return (Buffer (One)
                        {
                             0x00
       // .
                        })
                    }
                }

Linux PPI driver seems to be happy about it, looking at
/sys/devices/pnp0/00\:06/tpm/tpm0/ppi/.

I haven't done further testing. Is there anything using this on Linux?
tpm2-tools doesn't seem to use it. I suppose I should be able to write
something to /sys/devices/pnp0/00\:06/tpm/tpm0/ppi/request.

Any help appreciated :)

>    Stefan
>
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   hw/i386/acpi-build.c  | 227
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/acpi/tpm.h |  15 ++++
>>   2 files changed, 242 insertions(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 18b939e..e3905a3 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -42,6 +42,7 @@
>>   #include "hw/acpi/memory_hotplug.h"
>>   #include "sysemu/tpm.h"
>>   #include "hw/acpi/tpm.h"
>> +#include "hw/tpm/tpm_ppi.h"
>>   #include "hw/acpi/vmgenid.h"
>>   #include "sysemu/tpm_backend.h"
>>   #include "hw/timer/mc146818rtc_regs.h"
>> @@ -1860,6 +1861,231 @@ static Aml *build_q35_osc_method(void)
>>   }
>>
>>   static void
>> +build_tpm_ppi(Aml *dev, TPMVersion tpm_version)
>> +{
>> +    Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *pak;
>> +
>> +    aml_append(dev,
>> +               aml_operation_region("TPPI", AML_SYSTEM_MEMORY,
>> +                                    aml_int(TPM_PPI_ADDR_BASE),
>> +                                    TPM_PPI_STRUCT_SIZE));
>> +
>> +    field =3D aml_field("TPPI", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
>> +    aml_append(field, aml_named_field("PPIN",
>> +               sizeof(uint8_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("PPIP",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("PPRP",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("PPRQ",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("PPRM",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("LPPR",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("FRET",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("RES1",
>> +               sizeof(uint8_t) * BITS_PER_BYTE));
>> +    aml_append(field, aml_named_field("RES2",
>> +               sizeof(uint32_t) * BITS_PER_BYTE * 4));
>> +    aml_append(field, aml_named_field("FAIL",
>> +               sizeof(uint32_t) * BITS_PER_BYTE));
>> +    aml_append(dev, field);
>> +
>> +    /*
>> +     * Write the given operations code into 'PPRQ'.
>> +     */
>> +    method =3D aml_method("WRAM", 2, AML_SERIALIZED);
>> +    {
>> +        aml_append(method, aml_store(aml_arg(0), aml_name("PPRQ")));
>> +        aml_append(method, aml_store(aml_arg(1), aml_name("PPRM")));
>> +        /* 0 =3D Success */
>> +        aml_append(method, aml_return(aml_int(0)));
>> +    }
>> +    aml_append(dev, method);
>> +
>> +    /*
>> +     * CKOP: Check whether the opcode is valid
>> +     */
>> +    if (tpm_version =3D=3D TPM_VERSION_1_2) {
>> +        method =3D aml_method("CKOP", 1, AML_NOTSERIALIZED);
>> +        {
>> +            ifctx =3D aml_if(
>> +                      aml_or(
>> +                        aml_or(
>> +                          aml_and(
>> +                            aml_lgreater_equal(aml_arg(0), aml_int(0)),
>> +                            aml_lless_equal(aml_arg(0), aml_int(11)),
>> +                            NULL
>> +                          ),
>> +                          aml_equal(aml_arg(0), aml_int(14)),
>> +                          NULL
>> +                        ),
>> +                        aml_and(
>> +                          aml_lgreater_equal(aml_arg(0), aml_int(21)),
>> +                          aml_lless_equal(aml_arg(0), aml_int(22)),
>> +                          NULL
>> +                       ),
>> +                       NULL
>> +                      )
>> +                    );
>> +            {
>> +                aml_append(ifctx, aml_return(aml_int(1)));
>> +            }
>> +            aml_append(method, ifctx);
>> +
>> +            aml_append(method, aml_return(aml_int(0)));
>> +        }
>> +    } else {
>> +        method =3D aml_method("CKOP", 1, AML_NOTSERIALIZED);
>> +        {
>> +            ifctx =3D aml_if(
>> +                      aml_equal(aml_arg(0), aml_int(0))
>> +                    );
>> +            {
>> +                aml_append(ifctx, aml_return(aml_int(1)));
>> +            }
>> +            aml_append(method, ifctx);
>> +
>> +            aml_append(method, aml_return(aml_int(0)));
>> +        }
>> +    }
>> +    aml_append(dev, method);
>> +
>> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
>> +    {
>> +        uint8_t zerobyte[1] =3D { 0 };
>> +
>> +        ifctx =3D aml_if(
>> +                  aml_equal(aml_arg(0),
>> +
>> aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))
>> +                );
>> +        {
>> +            aml_append(ifctx,
>> +                       aml_store(aml_to_integer(aml_arg(2)),
>> aml_local(0)));
>> +
>> +            /* standard DSM query function */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(0)));
>> +            {
>> +                uint8_t byte_list[2] =3D { 0xff, 0x01 };
>> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list))=
);
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* interface version: 1.2 */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(1)));
>> +            {
>> +                aml_append(ifctx2, aml_return(aml_string("1.2")));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* submit TPM operation */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(2)));
>> +            {
>> +                aml_append(ifctx2,
>> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
>> +                                                           aml_int(0)))=
,
>> +                                     aml_local(0)));
>> +                ifctx3 =3D aml_if(aml_call1("CKOP", aml_local(0)));
>> +                {
>> +                    aml_append(ifctx3,
>> +                               aml_return(aml_call2("WRAM",
>> +                                                    aml_local(0),
>> +                                                    aml_int(0))));
>> +                }
>> +                aml_append(ifctx2, ifctx3);
>> +                aml_append(ifctx2, aml_return(aml_int(1)));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* get pending TPM operation */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(3)));
>> +            {
>> +                pak =3D aml_package(2);
>> +                aml_append(pak, aml_int(0));
>> +                aml_append(pak, aml_name("PPRQ"));
>> +                aml_append(ifctx2, aml_return(pak));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* get platform-specific action to transition to pre-OS env=
.
>> */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(4)));
>> +            {
>> +                /* 2 =3D reboot */
>> +                aml_append(ifctx2, aml_return(aml_int(2)));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* get TPM operation response */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(5)));
>> +            {
>> +                pak =3D aml_package(3);
>> +
>> +                aml_append(pak, aml_name("FAIL"));
>> +                aml_append(pak, aml_name("LPPR"));
>> +                aml_append(pak, aml_name("PPRP"));
>> +
>> +                aml_append(ifctx2, aml_return(pak));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* submit preferred user language */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(6)));
>> +            {
>> +                /* 3 =3D not implemented */
>> +                aml_append(ifctx2, aml_return(aml_int(3)));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* submit TPM operation v2 */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(7)));
>> +            {
>> +                aml_append(ifctx2,
>> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
>> +                                                           aml_int(0)))=
,
>> +                                     aml_local(0)));
>> +                ifctx3 =3D aml_if(aml_call1("CKOP", aml_local(0)));
>> +                {
>> +                    aml_append(ifctx3,
>> +                               aml_store(aml_call2("WRAM",
>> +                                                   aml_local(0),
>> +                                                   aml_int(0)),
>> +                                         aml_local(1)));
>> +                    aml_append(ifctx3, aml_return(aml_local(1)));
>> +                }
>> +                aml_append(ifctx2, ifctx3);
>> +                /* 1 =3D requested operation not implemented */
>> +                aml_append(ifctx2, aml_return(aml_int(1)));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /* get user confirmation status for operation */
>> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(8)));
>> +            {
>> +                aml_append(ifctx2,
>> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
>> +                                                           aml_int(0)))=
,
>> +                                     aml_local(0)));
>> +                ifctx3 =3D aml_if(aml_call1("CKOP", aml_local(0)));
>> +                {
>> +                    /* 4 =3D Allowed and physically present user not
>> required */
>> +                    aml_append(ifctx3, aml_return(aml_int(4)));
>> +                }
>> +                aml_append(ifctx2, ifctx3);
>> +                /* 0 =3D requested operation not implemented */
>> +                aml_append(ifctx2, aml_return(aml_int(0)));
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
>> +        }
>> +        aml_append(method, ifctx);
>> +    }
>> +    aml_append(dev, method);
>> +}
>> +
>> +static void
>>   build_dsdt(GArray *table_data, BIOSLinker *linker,
>>              AcpiPmInfo *pm, AcpiMiscInfo *misc,
>>              Range *pci_hole, Range *pci_hole64, MachineState *machine)
>> @@ -2218,6 +2444,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>                    */
>>                   /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>>                   aml_append(dev, aml_name_decl("_CRS", crs));
>> +                build_tpm_ppi(dev, misc->tpm_version);
>>                   aml_append(scope, dev);
>>               }
>>
>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> index d9b7452..23f5da1 100644
>> --- a/include/hw/acpi/tpm.h
>> +++ b/include/hw/acpi/tpm.h
>> @@ -37,4 +37,19 @@
>>   #define TPM_PPI_ADDR_SIZE           0x100
>>   #define TPM_PPI_ADDR_BASE           0xffff0000
>>
>> +struct tpm_ppi {
>> +    uint8_t ppin;            /* set by BIOS; currently initialization
>> flag */
>> +    uint32_t ppip;           /* set by ACPI; not used */
>> +    uint32_t pprp;           /* response from TPM; set by BIOS */
>> +    uint32_t pprq;           /* opcode; set by ACPI */
>> +    uint32_t pprm;           /* parameter for opcode; set by ACPI */
>> +    uint32_t lppr;           /* last opcode; set by BIOS */
>> +    uint32_t fret;           /* set by ACPI; not used*/
>> +    uint32_t res1;           /* reserved */
>> +    uint32_t res2[4];        /* reserved */
>> +    uint32_t fail;           /* set by BIOS (0 =3D success) */
>> +} QEMU_PACKED;
>> +
>> +#define TPM_PPI_STRUCT_SIZE  sizeof(struct tpm_ppi)
>> +
>>   #endif /* HW_ACPI_TPM_H */
>
>
>
>

otherwise, patch looks good.

--=20
Marc-Andr=C3=A9 Lureau
