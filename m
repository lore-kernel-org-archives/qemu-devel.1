Received: from eggs.gnu.org ([2001:4830:134:3::10]:54854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYAMc-0003hU-UP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYAMX-0008Ro-OK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:20:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYAMX-0008PJ-Fn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:19:57 -0400
Date: Wed, 27 Jun 2018 15:19:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627151948.5779e60b@redhat.com>
In-Reply-To: <20180626122343.13473-5-marcandre.lureau@redhat.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/4] acpi: build TPM Physical Presence
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, 26 Jun 2018 14:23:43 +0200
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

I've made several suggestions below how to improve aml part of patch a bit,
will review v6 once it's done
/hopefully it would be more readable, considering that ASM language is horr=
ible to begin with/

>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>=20
> ---
>=20
> v6:
>  - more code documentation (Marc-Andr=C3=A9)
>  - use some explicit named variables to ease reading (Marc-Andr=C3=A9)
>  - use fixed size fields/memory regions, remove PPI struct (Marc-Andr=C3=
=A9)
>  - only add PPI ACPI methods if PPI is enabled (Marc-Andr=C3=A9)
>  - document the qemu/firmware ACPI memory region (Stefan)
>=20
> v5 (Marc-Andr=C3=A9):
>  - /struct tpm_ppi/struct TPMPPIData
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
>  include/hw/acpi/tpm.h |   8 +
>  hw/i386/acpi-build.c  | 423 +++++++++++++++++++++++++++++++++++++++++-
>  docs/specs/tpm.txt    |  79 ++++++++
>  3 files changed, 509 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index f79d68a77a..e0bd07862e 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -196,4 +196,12 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM_PPI_VERSION_NONE        0
>  #define TPM_PPI_VERSION_1_30        1
> =20
> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> +
>  #endif /* HW_ACPI_TPM_H */
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d9320845ed..d815af4eef 100644
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
> @@ -1789,6 +1790,421 @@ static Aml *build_q35_osc_method(void)
>      return method;
>  }
> =20
> +static void
> +build_tpm_ppi(Aml *dev)
> +{
> +    Aml *method, *name, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> +    int i;
> +
> +    if (!object_property_get_bool(OBJECT(tpm_find()), "ppi", &error_abor=
t)) {
if tpm_find() =3D=3D NULL -> BAAM???

I'd do it like this:
   tmp =3D tpm_find()
   if (TPM_IS_TIS(tpm) {
      ...
      if (object_property_get_bool(tpm), "ppi", &error_abort)) {
          build_tpm_ppi(tpm, dev)
      }
      ...
   }

   if (TPM_IS_CRB(tpm))
   {
      ....
   }

a bit more verbose but then the reader won't have to jump inside of
build_tpm_ppi() if he/she is not interested in it.

> +        return;
> +    }
> +    /*
> +     * TPP1 is for the flags that indicate which PPI operations
> +     * are supported by the firmware. The firmware is expected to
> +     * write these flags.
> +     */
> +    aml_append(dev,
> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> +                                    aml_int(TPM_PPI_ADDR_BASE), 0x100));
> +    field =3D aml_field("TPP1", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> +    for (i =3D 0; i < 0x100; i++) {
> +        char *tmp =3D g_strdup_printf("FN%02X", i);
> +        aml_append(field, aml_named_field(tmp, 8));
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
> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x100),
> +                                    0x5A));
> +    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
> +    aml_append(field, aml_named_field("PPIN", 8));
> +    aml_append(field, aml_named_field("PPIP", 32));
> +    aml_append(field, aml_named_field("PPRP", 32));
> +    aml_append(field, aml_named_field("PPRQ", 32));
> +    aml_append(field, aml_named_field("PPRM", 32));
> +    aml_append(field, aml_named_field("LPPR", 32));
> +    aml_append(dev, field);
> +
> +    /*
> +     * A function to return the value of DerefOf (FUNC [N]), by using
> +     * accessing the fields individually instead. This is a workaround
> +     * for what looks like a Windows ACPI bug in all versions so far
> +     * (fwiw, DerefOf (FUNC [N]) works on Linux).
> +     */
> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
> +    {
> +        for (i =3D 0; i < 0x100; i++) {
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
Aml one =3D aml_int(1)
Aml tpm3 =3D local(x)
aml_store(pak, tpm3)

... and then later ...

            {
             /* TPM2[1] =3D PPRQ */
             aml_append(ifctx3, aml_store(aml_name("PPRQ"), aml_index(tpm2,=
 one)));
             aml_append(ifctx3, aml_return(tpm2));

which would make code a bit more readable

> +    aml_append(dev, name);
both packages could be local vars as return is done by value

> +
> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        uint8_t zerobyte[1] =3D { 0 };
> +        Aml *func_idx, *rev, *op, *op_arg, *op_flags;
> +
> +        ifctx =3D aml_if(
> +            aml_equal(aml_arg(0),
> +                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653")=
));
aml_equal(uuid, aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))

> +        {
> +            func_idx =3D aml_local(0);
> +            aml_append(ifctx,
> +                       aml_store(aml_to_integer(aml_arg(2)), func_idx));
why do you need aml_to_integer() cast here?

Wouldn't following just work:
=20
   Aml function =3D aml_arg(2)

I'd suggest to use "function" for consistency with nvdimm _DSM

you can use the same naming approach for other arguments i.e.
arguments =3D aml_arg(3)

> +
> +            /* standard DSM query function */
> +            func_idx =3D aml_local(0);
I don't think you need to init it twice.

> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(0)));
> +            {
> +                uint8_t byte_list[2] =3D { 0xff, 0x01 };
> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_list)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.1 Get Physical Presence Interface Version
like Michael noted use version/chapter pair to as reference

ex: /* ACPI 1.0b: 16.2.5.2 Named Objects Encoding: DefOpRegion */

> +             *
> +             * Arg 2 (Integer): Function Index =3D 1
> +             * Arg 3 (Package): Arguments =3D Empty Package
> +             * Returns: Type: String
> +             */
> +            func_idx =3D aml_local(0);
not needed

> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(1)));
> +            {
> +                aml_append(ifctx2, aml_return(aml_string("1.3")));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.2 Submit TPM Operation Request to Pre-OS Environment
> +             *
> +             * Arg 2 (Integer): Function Index =3D 2
> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> +             *                              Operation Value of the Reque=
st
> +             * Returns: Type: Integer
> +             *          0: Success
> +             *          1: Operation Value of the Request Not Supported
> +             *          2: General Failure
> +             */
> +            func_idx =3D aml_local(0);
ditto and the same in other places=20

> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(2)));
> +            {
> +                /* get opcode */
> +                op =3D aml_derefof(aml_index(aml_arg(3), aml_int(0)));
> +                aml_append(ifctx2, aml_store(op, aml_local(0)));
                                                    ^^^ what this local(0) =
is? suggest to use named var here (in C sense)
> +
> +                /* get opcode flags */
> +                op =3D aml_local(0);
use other local to make ASL less confusion (i.e. try not to reuse local var=
s for something else)

> +                aml_append(ifctx2,
> +                           aml_store(aml_call1("TPFN", op), aml_local(1)=
));
                                                               ^^^ what thi=
s local(1) is?
                  =20
> +
> +                op_flags =3D aml_local(1);
I'd init all named vars at the top of function where it's easy to see what =
is what
and use them later. ex: nvdimm_build_common_dsm()


> +                /* if func[opcode] & TPM_PPI_FUNC_NOT_IMPLEMENTED */
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(op_flags, aml_int(TPM_PPI_FUNC_MASK), NU=
LL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
may be the same language as in above comment
  /* 1: Operation Value of the Request Not Supported */
same applies to other return values=20

> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                op =3D aml_local(0);
> +                aml_append(ifctx2, aml_store(op, aml_name("PPRQ")));
> +                aml_append(ifctx2, aml_store(aml_int(0), aml_name("PPRM"=
)));
> +                /* 0: success */
> +                aml_append(ifctx2, aml_return(aml_int(0)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.3 Get Pending TPM Operation Requested By the OS
> +             *
> +             * Arg 2 (Integer): Function Index =3D 3
> +             * Arg 3 (Package): Arguments =3D Empty Package
> +             * Returns: Type: Package of Integers
> +             *          Integer 1: Function Return code
> +             *                     0: Success
> +             *                     1: General Failure
> +             *          Integer 2: Pending operation requested by the OS
> +             *                     0: None
> +             *                    >0: Operation Value of the Pending Req=
uest
> +             *          Integer 3: Optional argument to pending operation
> +             *                     requested by the OS
> +             *                     0: None
> +             *                    >0: Argument Value of the Pending Requ=
est
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(3)));
> +            {
> +                /* revision to integer */
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_to_integer(aml_arg(1)),
same do you need cast here, by spec it's 'int' already?

> +                               aml_local(1)));
why store into local var, couldn't it be used directly ?

> +                /*
> +                 * Revision ID of 1, no integer parameter beyond
> +                 * parameter two are expected
> +                 */
> +                rev =3D aml_local(1);
> +                ifctx3 =3D aml_if(aml_equal(rev, aml_int(1)));
> +                {
> +                    /* TPM2[1] =3D PPRQ */
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM2"), aml_int(1=
))));
> +                    aml_append(ifctx3, aml_return(aml_name("TPM2")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                /*
> +                 * A return value of {0, 23, 1} indicates that
> +                 * operation 23 with argument 1 is pending.
> +                 */
> +                rev =3D aml_local(1);
> +                ifctx3 =3D aml_if(aml_equal(rev, aml_int(2)));
> +                {
> +                    /* TPM3[1] =3D PPRQ */
> +                    aml_append(ifctx3,
> +                               aml_store(
> +                                   aml_name("PPRQ"),
> +                                   aml_index(aml_name("TPM3"), aml_int(1=
))));
> +                    /* TPM3[2] =3D PPRM */
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
> +            /*
> +             * 8.1.4 Get Platform-Specific Action to Transition to
> +             *       Pre-OS Environment
> +             *
> +             * Arg 2 (Integer): Function Index =3D 4
> +             * Arg 3 (Package): Arguments =3D Empty Package
> +             * Returns: Type: Integer
> +             *          0: None
> +             *          1: Shutdown
> +             *          2: Reboot
> +             *          3: OS Vendor-specific
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(4)));
> +            {
> +                /* reboot */
> +                aml_append(ifctx2, aml_return(aml_int(2)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.5 Return TPM Operation Response to OS Environment
> +             *
> +             * Arg 2 (Integer): Function Index =3D 5
> +             * Arg 3 (Package): Arguments =3D Empty Package
> +             * Returns: Type: Package of Integer
> +             *          Integer 1: Function Return code
> +             *                     0: Success
> +             *                     1: General Failure
> +             *          Integer 2: Most recent operation request
> +             *                     0: None
> +             *                    >0: Operation Value of the most recent=
 request
> +             *          Integer 3: Response to the most recent operation=
 request
> +             *                     0: Success
> +             *                     0x00000001..0x00000FFF: Corresponding=
 TPM
> +             *                                             error code
> +             *                     0xFFFFFFF0: User Abort or timeout of =
dialog
> +             *                     0xFFFFFFF1: firmware Failure
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(5)));
> +            {
> +                /* TPM3[1] =3D LPPR */
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_name("LPPR"),
> +                               aml_index(aml_name("TPM3"), aml_int(1))));
> +                /* TPM3[2] =3D PPRP */
> +                aml_append(ifctx2,
> +                           aml_store(
> +                               aml_name("PPRP"),
> +                               aml_index(aml_name("TPM3"), aml_int(2))));
> +                aml_append(ifctx2, aml_return(aml_name("TPM3")));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.6 Submit preferred user language
> +             *
> +             * Arg 2 (Integer): Function Index =3D 6
> +             * Arg 3 (Package): Arguments =3D String Package
> +             *                  Preferred language code
> +             * Returns: Type: Integer
> +             * Function Return Code
> +             *          3: Not implemented
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(6)));
> +            {
> +                /* 3 =3D not implemented */
> +                aml_append(ifctx2, aml_return(aml_int(3)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.7 Submit TPM Operation Request to Pre-OS Environment 2
> +             *
> +             * Arg 2 (Integer): Function Index =3D 7
> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> +             *                  Integer 1: Operation Value of the Request
> +             *                  Integer 2: Argument for Operation (optio=
nal)
> +             * Returns: Type: Integer
> +             *          0: Success
> +             *          1: Not Implemented
> +             *          2: General Failure
> +             *          3: Operation blocked by current firmware settings
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(7)));
> +            {
> +                /* get opcode */
> +                op =3D aml_derefof(aml_index(aml_arg(3), aml_int(0)));
> +                aml_append(ifctx2, aml_store(op, aml_local(0)));
> +
> +                /* get opcode flags */
> +                op =3D aml_local(0);
> +                aml_append(ifctx2, aml_store(aml_call1("TPFN", op),
> +                                             aml_local(1)));
> +                /* if func[opcode] & TPM_PPI_FUNC_NOT_IMPLEMENTED */
> +                op_flags =3D aml_local(1);
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(op_flags, aml_int(TPM_PPI_FUNC_MASK), NU=
LL),
> +                        aml_int(TPM_PPI_FUNC_NOT_IMPLEMENTED)));
> +                {
> +                    /* 1: not implemented */
> +                    aml_append(ifctx3, aml_return(aml_int(1)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                /* if func[opcode] & TPM_PPI_FUNC_BLOCKED */
> +                op_flags =3D aml_local(1);
> +                ifctx3 =3D aml_if(
> +                    aml_equal(
> +                        aml_and(op_flags, aml_int(TPM_PPI_FUNC_MASK), NU=
LL),
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
> +                rev =3D aml_local(1);
> +                ifctx3 =3D aml_if(aml_equal(rev, aml_int(1)));
> +                {
> +                    /* revision 1 */
> +                    /* PPRQ =3D op */
> +                    op =3D aml_local(0);
> +                    aml_append(ifctx3, aml_store(op, aml_name("PPRQ")));
> +                    /* no argument, PPRM =3D 0 */
> +                    aml_append(ifctx3, aml_store(aml_int(0),
> +                                                 aml_name("PPRM")));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +
> +                rev =3D aml_local(1);
> +                ifctx3 =3D aml_if(aml_equal(rev, aml_int(2)));
> +                {
> +                    /* revision 2 */
> +                    /* PPRQ =3D op */
> +                    op =3D aml_local(0);
> +                    op_arg =3D aml_derefof(aml_index(aml_arg(3), aml_int=
(1)));
> +                    aml_append(ifctx3, aml_store(op, aml_name("PPRQ")));
> +                    /* PPRM =3D arg3[1] */
> +                    aml_append(ifctx3, aml_store(op_arg, aml_name("PPRM"=
)));
> +                }
> +                aml_append(ifctx2, ifctx3);
> +                /* 0: success */
> +                aml_append(ifctx2, aml_return(aml_int(0)));
> +            }
> +            aml_append(ifctx, ifctx2);
> +
> +            /*
> +             * 8.1.8 Get User Confirmation Status for Operation
> +             *
> +             * Arg 2 (Integer): Function Index =3D 8
> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
> +             *                  Operation Value that may need user confi=
rmation
> +             * Returns: Type: Integer
> +             *          0: Not implemented
> +             *          1: Firmware only
> +             *          2: Blocked for OS by firmware configuration
> +             *          3: Allowed and physically present user required
> +             *          4: Allowed and physically present user not requi=
red
> +             */
> +            func_idx =3D aml_local(0);
> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(8)));
> +            {
> +                /* get opcode */
> +                op =3D aml_derefof(aml_index(aml_arg(3), aml_int(0)));
> +                aml_append(ifctx2, aml_store(op, aml_local(0)));
> +
> +                /* get opcode flags */
> +                op =3D aml_local(0);
> +                aml_append(ifctx2, aml_store(aml_call1("TPFN", op),
> +                                             aml_local(1)));
> +                op_flags =3D aml_local(1);
> +                /* return confirmation status code */
> +                aml_append(ifctx2,
> +                           aml_return(
> +                               aml_and(op_flags,
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
> @@ -2153,6 +2569,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                   */
>                  /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>                  aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +                build_tpm_ppi(dev);
> +
>                  aml_append(scope, dev);
>              }
> =20
> @@ -2172,6 +2591,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(method, aml_return(aml_int(0x0f)));
>          aml_append(dev, method);
> =20
> +        build_tpm_ppi(dev);
> +
>          aml_append(sb_scope, dev);
>      }
> =20
> @@ -2920,7 +3341,7 @@ void acpi_setup(void)
>          tpm_config =3D (FWCfgTPMConfig) {
>              .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
>              .tpm_version =3D cpu_to_le32(tpm_get_version(tpm_find())),
> -            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_NONE)
> +            .tpmppi_version =3D cpu_to_le32(TPM_PPI_VERSION_1_30)
s/cpu_to_le32//

>          };
>          fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
>                          &tpm_config, sizeof tpm_config);
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 2ddb768084..c27762c723 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -62,6 +62,85 @@ URL:
> =20
>  https://trustedcomputinggroup.org/tcg-acpi-specification/
> =20
> +=3D=3D ACPI PPI Interface =3D=3D
> +
> +QEMU supports the Physical Presence Interface (PPI) for TPM 1.2 and TPM =
2. This
> +interface requires ACPI and firmware support. The specification can be f=
ound at
> +the following URL:
> +
> +https://trustedcomputinggroup.org/resource/tcg-physical-presence-interfa=
ce-specification/
> +
> +PPI enables a system administrator (root) to request a modification to t=
he
> +TPM upon reboot. The PPI specification defines the operation requests an=
d the
> +actions the firmware has to take. The system administrator passes the op=
eration
> +request number to the firmware through an ACPI interface which writes th=
is
> +number to a memory location that the firmware knows. Upon reboot, the fi=
rmware
> +finds the number and sends commands to the the TPM. The firmware writes =
the TPM
> +result code and the operation request number to a memory location that A=
CPI can
> +read from and pass the result on to the administrator.
> +
> +The PPI specification defines a set of mandatory and optional operations=
 for
> +the firmware to implement. The ACPI interface also allows an administrat=
or to
> +list the supported operations. In QEMU the ACPI code is generated by QEM=
U, yet
> +the firmware needs to implement support on a per-operations basis, and
> +different firmwares may support a different subset. Therefore, QEMU intr=
oduces
> +the virtual memory device for PPI where the firmware can indicate which
> +operations it supports and ACPI can enable the ones that are supported a=
nd
> +disable all others. This interface lies in main memory and has the follo=
wing
> +layout:
> +
> + +----------+--------+--------+-----------------------------------------=
--+
> + |  Field   | Length | Offset | Description                             =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | func     |  0x100 |  0x000 | Firmware sets values for each supported =
  |
> + |          |        |        | operation. See defined values below.    =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | ppin     |   0x1  |  0x100 | SMI interrupt to use. Set by firmware.  =
  |
> + |          |        |        | Not supported.                          =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | ppip     |   0x4  |  0x101 | ACPI function index to pass to SMM code.=
  |
> + |          |        |        | Set by ACPI. Not supported.             =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | pprp     |   0x4  |  0x105 | Result of last executed operation. Set b=
y |
> + |          |        |        | firmware. See function index 5 for value=
s.|
> + +----------+--------+--------+-----------------------------------------=
--+
> + | pprq     |   0x4  |  0x109 | Operation request number to execute. See=
  |
> + |          |        |        | 'Physical Presence Interface Operation  =
  |
> + |          |        |        | Summary' tables in specs. Set by ACPI.  =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | pprm     |   0x4  |  0x10d | Operation request optional parameter.   =
  |
> + |          |        |        | Values depend on operation. Set by ACPI.=
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | lppr     |   0x4  |  0x111 | Last executed operation request number. =
  |
> + |          |        |        | Copied from pprq field by firmware.     =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | fret     |   0x4  |  0x115 | Result code from SMM function.          =
  |
> + |          |        |        | Not supported.                          =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | res1     |  0x40  |  0x119 | Reserved for future use                 =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> + | next_step|   0x1  |  0x159 | Operation to execute after reboot by    =
  |
> + |          |        |        | firmware. Used by firmware.             =
  |
> + +----------+--------+--------+-----------------------------------------=
--+
> +
> +   The following values are supported for the 'func' field. They corresp=
ond
> +   to the values used by ACPI function index 8.
> +
> + +----------+-----------------------------------------------------------=
--+
> + | value    | Description                                               =
  |
> + +----------+-----------------------------------------------------------=
--+
> + | 0        | Operation is not implemented.                             =
  |
> + +----------+-----------------------------------------------------------=
--+
> + | 1        | Operation is only accessible through firmware.            =
  |
> + +----------+-----------------------------------------------------------=
--+
> + | 2        | Operation is blocked for OS by firmware configuration.    =
  |
> + +----------+-----------------------------------------------------------=
--+
> + | 3        | Operation is allowed and physically present user required.=
  |
> + +----------+-----------------------------------------------------------=
--+
> + | 4        | Operation is allowed and physically present user is not   =
  |
> + |          | required.                                                 =
  |
> + +----------+-----------------------------------------------------------=
--+
> +
> =20
>  QEMU files related to TPM ACPI tables:
>   - hw/i386/acpi-build.c
