Received: from eggs.gnu.org ([2001:4830:134:3::10]:58013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW5vT-00089C-6A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fW5vP-0006yi-0u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:11:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43876
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fW5vO-0006yD-P5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 16:11:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5LKA56t097163
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:11:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jrfvdf6q7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 16:11:21 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 21 Jun 2018 16:11:21 -0400
References: <20180621115530.11069-1-marcandre.lureau@redhat.com>
	<20180621115530.11069-5-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 16:11:16 -0400
MIME-Version: 1.0
In-Reply-To: <20180621115530.11069-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <9d02acd4-8a60-1ac3-00d9-8c99940254a2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/21/2018 07:55 AM, Marc-Andr=C3=A9 Lureau wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> The TPM Physical Presence interface consists of an ACPI part, a shared
> memory part, and code in the firmware. Users can send messages to the
> firmware by writing a code into the shared memory through invoking the
> ACPI code. When a reboot happens, the firmware looks for the code and
> acts on it by sending sequences of commands to the TPM.
>
> This patch adds the ACPI code. It is similar to the one in EDK2 but doe=
sn't
> assume that SMIs are necessary to use. It uses a similar datastructure =
for
> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both make=
 use
> of it. I extended the shared memory data structure with an array of 256
> bytes, one for each code that could be implemented. The array contains
> flags describing the individual codes. This decouples the ACPI implemen=
tation
> from the firmware implementation.
>
> The underlying TCG specification is accessible from the following page.
>
> https://trustedcomputinggroup.org/tcg-physical-presence-interface-speci=
fication/
>
> This patch implements version 1.30.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> ---
>
> v5 (Marc-Andr=C3=A9):
>   - /struct tpm_ppi/struct TPMPPIData
>
> v4 (Marc-Andr=C3=A9):
>   - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
>      handling.
>   - replace 'return Package (..) {} ' with scoped variables, to fix
>     Windows ACPI handling.
>
> v3:
>   - add support for PPI to CRB
>   - split up OperationRegion TPPI into two parts, one containing
>     the registers (TPP1) and the other one the flags (TPP2); switched
>     the order of the flags versus registers in the code
>   - adapted ACPI code to small changes to the array of flags where
>     previous flag 0 was removed and now shifting right wasn't always
>     necessary anymore
>
> v2:
>   - get rid of FAIL variable; function 5 was using it and always
>     returns 0; the value is related to the ACPI function call not
>     a possible failure of the TPM function call.
>   - extend shared memory data structure with per-opcode entries
>     holding flags and use those flags to determine what to return
>     to caller
>   - implement interface version 1.3
> ---
>   include/hw/acpi/tpm.h |  21 +++
>   hw/i386/acpi-build.c  | 294 +++++++++++++++++++++++++++++++++++++++++=
-
>   2 files changed, 314 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index f79d68a77a..430605a8e5 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -196,4 +196,25 @@ REG32(CRB_DATA_BUFFER, 0x80)
>   #define TPM_PPI_VERSION_NONE        0
>   #define TPM_PPI_VERSION_1_30        1
>
> +struct TPMPPIData {
> +    uint8_t  func[256];      /* 0x000: per TPM function implementation=
 flags;
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
> +    uint32_t pprp;           /* 0x105 : response from TPM; set by BIOS=
 */
> +    uint32_t pprq;           /* 0x109 : opcode; set by ACPI */
> +    uint32_t pprm;           /* 0x10d : parameter for opcode; set by A=
CPI */
> +    uint32_t lppr;           /* 0x111 : last opcode; set by BIOS */
> +    uint32_t fret;           /* 0x115 : set by ACPI; not used */
> +    uint8_t res1[0x40];      /* 0x119 : reserved for future use */
> +    uint8_t next_step;       /* 0x159 : next step after reboot; set by=
 BIOS */
> +} QEMU_PACKED;
> +
>   #endif /* HW_ACPI_TPM_H */

Here's a description of this interface. The SMM related fields, ppin,=20
ppip and fret could be
renamed to reserved fields since we are not supporting SMM.

diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index c230c4c93e..17d811f633 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -42,6 +42,73 @@ URL:

 =C2=A0https://trustedcomputinggroup.org/tcg-acpi-specification/

+=3D=3D ACPI PPI Interface =3D=3D
+
+QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TPM=20
2. This
+interface requires ACPI and firmware support. The specification can be=20
found at
+the following URL:
+
+https://trustedcomputinggroup.org/resource/tcg-physical-presence-interfa=
ce-specification/
+
+PPI enables a system administrator (root) to request a modification to t=
he
+TPM upon reboot. The PPI specification defines the operation requests=20
and the
+actions the firmware has to take. The system administrator passes the=20
operation
+request number to the firmware through an ACPI interface which writes th=
is
+number to a memory location that the firmware knows. Upon reboot, the=20
firmware
+finds the number and sends commands to the the TPM. The firmware writes=20
the TPM
+result code and the operation request number to a memory location that=20
ACPI can
+read from and pass the result on to the administrator.
+
+The PPI specification defines a set of mandatory and optional=20
operations for
+the firmware to implement. The ACPI interface also allows an=20
administrator to
+list the supported operations. In QEMU the ACPI code is generated by=20
QEMU, yet
+the firmware needs to implement support on a per-operations basis, and
+different firmwares may support a different subset. Therefore, QEMU=20
introduces
+the virtual memory device for PPI where the firmware can indicate which
+operations it supports and ACPI can enable the ones that are supported a=
nd
+disable all others. This interface lies in main memory and has the=20
following
+layout:
+
+=C2=A0=C2=A0=C2=A0 struct TPMPPIData {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0 func[256];=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x000 */
+=C2=A0=C2=A0=C2=A0 /* whether function is blocked by BIOS settings; bits=
 0, 1, 2 */
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_NOT_IMPLEMENTED=C2=A0=C2=A0=C2=A0=
=C2=A0 (0 << 0)
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_BIOS_ONLY=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 0)
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_BLOCKED=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (2 << 0)
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_ALLOWED_USR_REQ=C2=A0=C2=A0=C2=A0=
=C2=A0 (3 << 0)
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
+=C2=A0=C2=A0=C2=A0 #define TPM_PPI_FUNC_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (7 << 0)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t ppin;=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x100 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ppip;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x101 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pprp;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x105 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pprq;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x109 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t pprm;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x10d */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t lppr;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x111 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t fret;=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x115 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t res1[0x40];=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x119 */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t next_step;=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x159 */
+=C2=A0=C2=A0=C2=A0 } QEMU_PACKED;
+
+For each code the firmware suppports, the firmware needs to set the=20
appropriate
+flags in the func array. The number of the operation serves as the=20
index for the
+array.
+
+The operation request's number is written into the pprq field. Any optio=
nal
+additional parameters needed by an operation request must be written int=
o
+the pprm field.
+
+The firmware indicates the last executed command in the lppr field and
+writes the result into the pprp field.
+
+For SMM support, the field ppin describes the software SMI interrupt to=20
use.
+This field needs to be written by the firmware. The ppip field is used
+to pass the ACPI function number to the SMM code. This field needs to be
+written by ACPI. The fret field holds the result of the SMM operation an=
d
+needs to be set by SMM code.
+
+Some operations require the firmware to reboot the machine before it can
+send more commands to the TPM. For this, the firmware can use the next_s=
tep
+field to remember what operation to execute after the reboot.

 =C2=A0QEMU files related to TPM ACPI tables:
 =C2=A0 - hw/i386/acpi-build.c


> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d9320845ed..4cb3ac9000 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -43,6 +43,7 @@
>   #include "hw/acpi/memory_hotplug.h"
>   #include "sysemu/tpm.h"
>   #include "hw/acpi/tpm.h"
> +#include "hw/tpm/tpm_ppi.h"
>   #include "hw/acpi/vmgenid.h"
>   #include "sysemu/tpm_backend.h"
>   #include "hw/timer/mc146818rtc_regs.h"
> @@ -1789,6 +1790,292 @@ static Aml *build_q35_osc_method(void)
>       return method;
>   }
>
> +static void
> +build_tpm_ppi(Aml *dev)
> +{
> +    Aml *method, *name, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> +    struct TPMPPIData *tpm_ppi =3D NULL;
> +    int i;
> +
> +    /*
> +     * TPP1 is for the flags that indicate which PPI operations
> +     * are supported by the firmware. The firmware is expected to
> +     * write these flags.
> +     */
> +    aml_append(dev,
> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE),
> +                                    sizeof(tpm_ppi->func)));
> +    field =3D aml_field("TPP1", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE)=
;
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
> +                                            offsetof(struct TPMPPIData=
, ppin)),
> +                                    sizeof(struct TPMPPIData) -
> +                                        sizeof(tpm_ppi->func)));
> +    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE)=
;
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
> +    aml_append(dev, field);
> +
> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
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
> +                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653=
")));
> +        {
> +            aml_append(ifctx,
> +                       aml_store(aml_to_integer(aml_arg(2)), aml_local=
(0)));
> +
> +            /* standard DSM query function */
> +            ifctx2 =3D aml_if(aml_equal(aml_local(0), aml_int(0)));
> +            {
> +                uint8_t byte_list[2] =3D { 0xff, 0x01 };
> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)=
));
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
> +                                                           aml_int(0))=
),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MAS=
K), NULL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                aml_append(ifctx2, aml_store(aml_local(0), aml_name("P=
PRQ")));
> +                aml_append(ifctx2, aml_store(aml_int(0), aml_name("PPR=
M")));
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
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(1)))=
;
> +                {
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM2"), aml_int=
(1))));
> +                    aml_append(ifctx3, aml_return(aml_name("TPM2")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(2)))=
;
> +                {
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM3"), aml_int=
(1))));
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRM"),
> +                                   aml_index(aml_name("TPM3"), aml_int=
(2))));
> +                    aml_append(ifctx3, aml_return(aml_name("TPM3")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /* get platform-specific action to transition to pre-OS en=
v. */
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
> +                               aml_index(aml_name("TPM3"), aml_int(1))=
));
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_name("PPRP"),
> +                               aml_index(aml_name("TPM3"), aml_int(2))=
));
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
> +                                                           aml_int(0))=
),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MAS=
K), NULL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(aml_local(1), aml_int(TPM_PPI_FUNC_MAS=
K), NULL),
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
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(1)))=
;
> +                {
> +                    /* revision 1 */
> +                    aml_append(ifctx3, aml_store(aml_local(0),
> +                                                 aml_name("PPRQ")));
> +                    aml_append(ifctx3, aml_store(aml_int(0),
> +                                                 aml_name("PPRM")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                ifctx3 =3D aml_if(aml_equal(aml_local(1), aml_int(2)))=
;
> +                {
> +                    /* revision 2 */
> +                    aml_append(ifctx3,
> +                               aml_store(aml_local(0), aml_name("PPRQ"=
)));
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
> +                                                           aml_int(0))=
),
> +                                     aml_local(0)));
> +                /* get opcode flags */
> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", aml_local(0)),
> +                                     aml_local(1)));
> +                /* return confirmation status code */
> +                aml_append(ifctx2,
> +                           aml_return(
> +                               aml_and(aml_local(1),
> +                                       aml_int(TPM_PPI_FUNC_MASK), NUL=
L)));
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
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker,
>              AcpiPmInfo *pm, AcpiMiscInfo *misc,
> @@ -2153,6 +2440,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>                    */
>                   /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>                   aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +                build_tpm_ppi(dev);
> +
>                   aml_append(scope, dev);
>               }
>
> @@ -2172,6 +2462,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>           aml_append(method, aml_return(aml_int(0x0f)));
>           aml_append(dev, method);
>
> +        build_tpm_ppi(dev);
> +
>           aml_append(sb_scope, dev);
>       }
>
> @@ -2920,7 +3212,7 @@ void acpi_setup(void)
>           tpm_config =3D (FWCfgTPMConfig) {
>               .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
>               .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find()))=
,
> -            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_1_30)
>           };
>           fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
>                           &tpm_config, sizeof tpm_config);
