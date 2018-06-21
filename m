Received: from eggs.gnu.org ([2001:4830:134:3::10]:58200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVz6O-0000is-1g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fVz6K-00065q-2G
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:54:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fVz6J-00065f-Rj
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:54:11 -0400
Date: Thu, 21 Jun 2018 14:54:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180621145405.197d5106@redhat.com>
In-Reply-To: <20180515121433.6112-4-marcandre.lureau@redhat.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 15 May 2018 14:14:32 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> The TPM Physical Presence interface consists of an ACPI part, a shared
> memory part, and code in the firmware. Users can send messages to the
> firmware by writing a code into the shared memory through invoking the
> ACPI code. When a reboot happens, the firmware looks for the code and
> acts on it by sending sequences of commands to the TPM.
>=20
> This patch adds the ACPI code. It is similar to the one in EDK2 but doesn=
't
> assume that SMIs are necessary to use. It uses a similar datastructure for
> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make u=
se
> of it. I extended the shared memory data structure with an array of 256
> bytes, one for each code that could be implemented. The array contains
> flags describing the individual codes. This decouples the ACPI implementa=
tion
> from the firmware implementation.
>=20
> The underlying TCG specification is accessible from the following page.
>=20
> https://trustedcomputinggroup.org/tcg-physical-presence-interface-specifi=
cation/
>=20
> This patch implements version 1.30.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> ---
>=20
> v4 (Marc-Andr=C3=A9):
>  - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
>     handling.
>  - replace 'return Package (..) {} ' with scoped variables, to fix
>    Windows ACPI handling.
>=20
> v3:
>  - add support for PPI to CRB
>  - split up OperationRegion TPPI into two parts, one containing
>    the registers (TPP1) and the other one the flags (TPP2); switched
>    the order of the flags versus registers in the code
>  - adapted ACPI code to small changes to the array of flags where
>    previous flag 0 was removed and now shifting right wasn't always
>    necessary anymore
>=20
> v2:
>  - get rid of FAIL variable; function 5 was using it and always
>    returns 0; the value is related to the ACPI function call not
>    a possible failure of the TPM function call.
>  - extend shared memory data structure with per-opcode entries
>    holding flags and use those flags to determine what to return
>    to caller
>  - implement interface version 1.3
> ---
>  include/hw/acpi/tpm.h |  21 +++
>  hw/i386/acpi-build.c  | 294 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 314 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index f79d68a77a..fc53f08827 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_PPI_VERSION_NONE        0
>  #define TPM_PPI_VERSION_1_30        1
> =20
> +struct tpm_ppi {
> +    uint8_t  func[256];      /* 0x000: per TPM function implementation f=
lags;
> +                                       set by BIOS */
> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> +    uint8_t ppin;            /* 0x100 : set by BIOS */
> +    uint32_t ppip;           /* 0x101 : set by ACPI; not used */
> +    uint32_t pprp;           /* 0x105 : response from TPM; set by BIOS */
> +    uint32_t pprq;           /* 0x109 : opcode; set by ACPI */
> +    uint32_t pprm;           /* 0x10d : parameter for opcode; set by ACP=
I */
> +    uint32_t lppr;           /* 0x111 : last opcode; set by BIOS */
> +    uint32_t fret;           /* 0x115 : set by ACPI; not used */
> +    uint8_t res1[0x40];      /* 0x119 : reserved for future use */
> +    uint8_t next_step;       /* 0x159 : next step after reboot; set by B=
IOS */
> +} QEMU_PACKED;
is this structure plant to be used for accessing data from within QEMU
or it is just used for convenience of calculating offsets/sizes for AML?


> +
>  #endif /* HW_ACPI_TPM_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f6d447f03a..95be4f0710 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -43,6 +43,7 @@
>  #include "hw/acpi/memory_hotplug.h"
>  #include "sysemu/tpm.h"
>  #include "hw/acpi/tpm.h"
> +#include "hw/tpm/tpm_ppi.h"
>  #include "hw/acpi/vmgenid.h"
>  #include "sysemu/tpm_backend.h"
>  #include "hw/timer/mc146818rtc_regs.h"
> @@ -1789,6 +1790,292 @@ static Aml *build_q35_osc_method(void)
>      return method;
>  }
> =20
> +static void
> +build_tpm_ppi(Aml *dev)
> +{
> +    Aml *method, *name, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> +    struct tpm_ppi *tpm_ppi =3D NULL;
> +    int i;
plain AML variables throughout the function make code rather unreadable
(well, like any other AML code would be).
Pls take a look at how build_legacy_cpu_hotplug_aml() uses intermediate
more or less sanely named variables to make it more understandable.
that also should allow to reduce LOC this function takes.

> +    /*
> +     * TPP1 is for the flags that indicate which PPI operations
> +     * are supported by the firmware. The firmware is expected to
> +     * write these flags.
> +     */
> +    aml_append(dev,
> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE),
> +                                    sizeof(tpm_ppi->func)));
> +    field =3D aml_field("TPP1", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> +    for (i =3D 0; i < sizeof(tpm_ppi->func); i++) {
> +        char *tmp =3D g_strdup_printf("FN%02X", i);
> +        aml_append(field, aml_named_field(tmp, BITS_PER_BYTE));
> +        g_free(tmp);
> +    }
> +    aml_append(dev, field);
> +
> +    /*
> +     * TPP2 is for the registers that ACPI code used to pass
> +     * the PPI code and parameter (PPRQ, PPRM) to the firmware.
> +     */
> +    aml_append(dev,
> +               aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE +
> +                                            offsetof(struct tpm_ppi, ppi=
n)),
> +                                    sizeof(struct tpm_ppi) -
> +                                        sizeof(tpm_ppi->func)));
> +    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> +    aml_append(field, aml_named_field("PPIN",
> +               sizeof(uint8_t) * BITS_PER_BYTE));
here you already don't use tpm_ppi for sizing, so it creates a confusing mix
of both approaches.

=46rom ACPI pov I'd prefer PPI table documented somewhere in spec docs=20
(similar docs/specs/acpi_mem_hotplug.txt) and would look like in
other use-cases:

   aml_append(field, aml_named_field("PPIN", 8)

and drop "struct tpm_ppi" altogether replacing places it was used by
explicit constants.

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
> +    aml_append(dev, field);
> +
> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
not quite sure how this method (supposed to ) work(s),
it could use nice comment explaining mechanics.

> +    {
> +        for (i =3D 0; i < sizeof(tpm_ppi->func); i++) {
> +            ifctx =3D aml_if(aml_equal(aml_int(i), aml_arg(0)));
> +            {
> +                aml_append(ifctx, aml_return(aml_name("FN%02X", i)));
> +            }
> +            aml_append(method, ifctx);
> +        }
> +        aml_append(method, aml_return(aml_int(0)));
> +    }
> +    aml_append(dev, method);
> +
> +    pak =3D aml_package(2);
> +    aml_append(pak, aml_int(0));
> +    aml_append(pak, aml_int(0));
> +    name =3D aml_name_decl("TPM2", pak);
> +    aml_append(dev, name);
> +
> +    pak =3D aml_package(3);
> +    aml_append(pak, aml_int(0));
> +    aml_append(pak, aml_int(0));
> +    aml_append(pak, aml_int(0));
> +    name =3D aml_name_decl("TPM3", pak);
> +    aml_append(dev, name);
> +
> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        uint8_t zerobyte[1] =3D { 0 };
> +
> +        ifctx =3D aml_if(
> +            aml_equal(aml_arg(0),
> +                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653")=
));
a comment pointing to a specific part/version of spec that documents this _=
DSM
for every uuid/function used here would help to review it.

> +        {
> +            aml_append(ifctx,
> +                       aml_store(aml_to_integer(aml_arg(2)), aml_local(0=
)));
> +
> +            /* standard DSM query function */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(0)));
> +            {
> +                uint8_t byte_list[2] =3D { 0xff, 0x01 };
> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* interface version: 1.3 */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(1)));
> +            {
> +                aml_append(ifctx2, aml_return(aml_string("1.3")));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit TPM operation */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(2)));
> +            {
> +                /* get opcode */
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MASK)=
, NULL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                aml_append(ifctx2, aml_store(aml_local(0), aml_name("PPR=
Q")));
> +                aml_append(ifctx2, aml_store(aml_int(0), aml_name("PPRM"=
)));
> +                /* 0: success */
> +                aml_append(ifctx2, aml_return(aml_int(0)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get pending TPM operation */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(3)));
> +            {
> +                /* revision to integer */
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_to_integer(aml_arg(1)),
> +                               aml_local(1)));
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(1)));
> +                {
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM2"), aml_int(1=
))));
> +                    aml_append(ifctx3, aml_return(aml_name("TPM2")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(2)));
> +                {
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM3"), aml_int(1=
))));
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRM"),
> +                                   aml_index(aml_name("TPM3"), aml_int(2=
))));
> +                    aml_append(ifctx3, aml_return(aml_name("TPM3")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get platform-specific action to transition to pre-OS env.=
 */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(4)));
> +            {
> +                /* reboot */
> +                aml_append(ifctx2, aml_return(aml_int(2)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get TPM operation response */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(5)));
> +            {
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_name("LPPR"),
> +                               aml_index(aml_name("TPM3"), aml_int(1))));
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_name("PPRP"),
> +                               aml_index(aml_name("TPM3"), aml_int(2))));
> +                aml_append(ifctx2, aml_return(aml_name("TPM3")));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit preferred user language */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(6)));
> +            {
> +                /* 3 =3D not implemented */
> +                aml_append(ifctx2, aml_return(aml_int(3)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* submit TPM operation v2 */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(7)));
> +            {
> +                /* get opcode */
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MASK)=
, NULL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MASK)=
, NULL),
> +                        aml_int(TPM_PPI_FUNC_BLOCKED)));
> +                {
> +                    /* 3: blocked by firmware */
> +                    aml_append(ifctx3, aml_return(aml_int(3)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                /* revision to integer */
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_to_integer(aml_arg(1)),
> +                               aml_local(1)));
> +
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(1)));
> +                {
> +                    /* revision 1 */
> +                    aml_append(ifctx3, aml_store(aml_local(0),
> +                                                 aml_name("PPRQ")));
> +                    aml_append(ifctx3, aml_store(aml_int(0),
> +                                                 aml_name("PPRM")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(2)));
> +                {
> +                    /* revision 2 */
> +                    aml_append(ifctx3,
> +                               aml_store(aml_local(0), aml_name("PPRQ"))=
);
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_derefof(aml_index(aml_arg(3),
> +                                                         aml_int(1))),
> +                                   aml_name("PPRM")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                /* 0: success */
> +                aml_append(ifctx2, aml_return(aml_int(0)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get user confirmation status for operation */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(8)));
> +            {
> +                /* get opcode */
> +                aml_append(ifctx2,
> +                           aml_store(aml_derefof(aml_index(aml_arg(3),
> +                                                           aml_int(0))),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                /* return confirmation status code */
> +                aml_append(ifctx2,
> +                           aml_return(
> +                               aml_and(aml_local(1),
> +                                       aml_int(TPM_PPI_FUNC_MASK), NULL)=
));
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
>  static void
>  build_dsdt(GArray *table_data, BIOSLinker *linker,
>             AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -2153,6 +2440,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                   */
>                  /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>                  aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +                build_tpm_ppi(dev);
> +
>                  aml_append(scope, dev);
>              }
> =20
> @@ -2172,6 +2462,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(method, aml_return(aml_int(0x0f)));
>          aml_append(dev, method);
> =20
> +        build_tpm_ppi(dev);
> +
>          aml_append(sb_scope, dev);
>      }
> =20
> @@ -2918,7 +3210,7 @@ void acpi_setup(void)
>          tpm_config =3D (FWCfgTPMConfig) {
>              .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
>              .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find())),
> -            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
what was the point of introducing TPM_PPI_VERSION_NONE if it would not be u=
sed?
maybe patch ordering is problem? what if we put fwcfg patch after this one?

> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_1_30)
>          };
>          fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
>                          &tpm_config, sizeof tpm_config);

hopefully patch would be more review-able with comments and nicely named
variables, so I could actually review it functionality wise without reading
whole TPM spec(s)
