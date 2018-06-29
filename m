Received: from eggs.gnu.org ([2001:4830:134:3::10]:51924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYuFD-0003R0-TU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fYuFB-0001Nj-Hn
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:19:27 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fYuFB-0001Ln-5i
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:19:25 -0400
Received: by mail-wm0-x244.google.com with SMTP id w137-v6so2395987wmw.1
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:19:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629160937.6c09c130@redhat.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-5-marcandre.lureau@redhat.com>
	<20180627151948.5779e60b@redhat.com>
	<CAJ+F1CKKaw0GyD_94bvpC97NheYqstUF6NLDbeGaRj0BUw_H7g@mail.gmail.com>
	<20180629160937.6c09c130@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Jun 2018 16:19:22 +0200
Message-ID: <CAJ+F1CLDK7jS9wy-1eWeAPfwwHa5QgkO1jvNoVmm3eAMXrGNEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, Jun 29, 2018 at 4:09 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 28 Jun 2018 17:24:47 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
>> Hi
>>
>> On Wed, Jun 27, 2018 at 3:19 PM, Igor Mammedov <imammedo@redhat.com> wro=
te:
>> > On Tue, 26 Jun 2018 14:23:43 +0200
>> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>> >
>> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> >>
>> >> The TPM Physical Presence interface consists of an ACPI part, a share=
d
>> >> memory part, and code in the firmware. Users can send messages to the
>> >> firmware by writing a code into the shared memory through invoking th=
e
>> >> ACPI code. When a reboot happens, the firmware looks for the code and
>> >> acts on it by sending sequences of commands to the TPM.
>> >>
>> >> This patch adds the ACPI code. It is similar to the one in EDK2 but d=
oesn't
>> >> assume that SMIs are necessary to use. It uses a similar datastructur=
e for
>> >> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both ma=
ke use
>> >> of it. I extended the shared memory data structure with an array of 2=
56
>> >> bytes, one for each code that could be implemented. The array contain=
s
>> >> flags describing the individual codes. This decouples the ACPI implem=
entation
>> >> from the firmware implementation.
>> >>
>> >> The underlying TCG specification is accessible from the following pag=
e.
>> >>
>> >> https://trustedcomputinggroup.org/tcg-physical-presence-interface-spe=
cification/
>> >>
>> >> This patch implements version 1.30.
>> >
>> > I've made several suggestions below how to improve aml part of patch a=
 bit,
>> > will review v6 once it's done
>> > /hopefully it would be more readable, considering that ASM language is=
 horrible to begin with/
>> >
>> >>
>> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> >>
>> >> ---
>> >>
>> >> v6:
>> >>  - more code documentation (Marc-Andr=C3=A9)
>> >>  - use some explicit named variables to ease reading (Marc-Andr=C3=A9=
)
>> >>  - use fixed size fields/memory regions, remove PPI struct (Marc-Andr=
=C3=A9)
>> >>  - only add PPI ACPI methods if PPI is enabled (Marc-Andr=C3=A9)
>> >>  - document the qemu/firmware ACPI memory region (Stefan)
>> >>
>> >> v5 (Marc-Andr=C3=A9):
>> >>  - /struct tpm_ppi/struct TPMPPIData
>> >>
>> >> v4 (Marc-Andr=C3=A9):
>> >>  - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
>> >>     handling.
>> >>  - replace 'return Package (..) {} ' with scoped variables, to fix
>> >>    Windows ACPI handling.
>> >>
>> >> v3:
>> >>  - add support for PPI to CRB
>> >>  - split up OperationRegion TPPI into two parts, one containing
>> >>    the registers (TPP1) and the other one the flags (TPP2); switched
>> >>    the order of the flags versus registers in the code
>> >>  - adapted ACPI code to small changes to the array of flags where
>> >>    previous flag 0 was removed and now shifting right wasn't always
>> >>    necessary anymore
>> >>
>> >> v2:
>> >>  - get rid of FAIL variable; function 5 was using it and always
>> >>    returns 0; the value is related to the ACPI function call not
>> >>    a possible failure of the TPM function call.
>> >>  - extend shared memory data structure with per-opcode entries
>> >>    holding flags and use those flags to determine what to return
>> >>    to caller
>> >>  - implement interface version 1.3
>> >> ---
>> >>  include/hw/acpi/tpm.h |   8 +
>> >>  hw/i386/acpi-build.c  | 423 ++++++++++++++++++++++++++++++++++++++++=
+-
>> >>  docs/specs/tpm.txt    |  79 ++++++++
>> >>  3 files changed, 509 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> >> index f79d68a77a..e0bd07862e 100644
>> >> --- a/include/hw/acpi/tpm.h
>> >> +++ b/include/hw/acpi/tpm.h
>> >> @@ -196,4 +196,12 @@ REG32(CRB_DATA_BUFFER, 0x80)
>> >>  #define TPM_PPI_VERSION_NONE        0
>> >>  #define TPM_PPI_VERSION_1_30        1
>> >>
>> >> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
>> >> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
>> >> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
>> >> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
>> >> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
>> >> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
>> >> +#define TPM_PPI_FUNC_MASK                (7 << 0)
>> >> +
>> >>  #endif /* HW_ACPI_TPM_H */
>> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> >> index d9320845ed..d815af4eef 100644
>> >> --- a/hw/i386/acpi-build.c
>> >> +++ b/hw/i386/acpi-build.c
>> >> @@ -43,6 +43,7 @@
>> >>  #include "hw/acpi/memory_hotplug.h"
>> >>  #include "sysemu/tpm.h"
>> >>  #include "hw/acpi/tpm.h"
>> >> +#include "hw/tpm/tpm_ppi.h"
>> >>  #include "hw/acpi/vmgenid.h"
>> >>  #include "sysemu/tpm_backend.h"
>> >>  #include "hw/timer/mc146818rtc_regs.h"
>> >> @@ -1789,6 +1790,421 @@ static Aml *build_q35_osc_method(void)
>> >>      return method;
>> >>  }
>> >>
>> >> +static void
>> >> +build_tpm_ppi(Aml *dev)
>> >> +{
>> >> +    Aml *method, *name, *field, *ifctx, *ifctx2, *ifctx3, *pak;
>> >> +    int i;
>> >> +
>> >> +    if (!object_property_get_bool(OBJECT(tpm_find()), "ppi", &error_=
abort)) {
>> > if tpm_find() =3D=3D NULL -> BAAM???
>> >
>> > I'd do it like this:
>> >    tmp =3D tpm_find()
>> >    if (TPM_IS_TIS(tpm) {
>> >       ...
>> >       if (object_property_get_bool(tpm), "ppi", &error_abort)) {
>> >           build_tpm_ppi(tpm, dev)
>> >       }
>> >       ...
>> >    }
>> >
>> >    if (TPM_IS_CRB(tpm))
>> >    {
>> >       ....
>> >    }
>> >
>> > a bit more verbose but then the reader won't have to jump inside of
>> > build_tpm_ppi() if he/she is not interested in it.
>>
>> ok, I pass the tpm to build_tpm_ppi() for the ppi property check, and
>> avoid extra lookup.
>>
>> >
>> >> +        return;
>> >> +    }
>> >> +    /*
>> >> +     * TPP1 is for the flags that indicate which PPI operations
>> >> +     * are supported by the firmware. The firmware is expected to
>> >> +     * write these flags.
>> >> +     */
>> >> +    aml_append(dev,
>> >> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
>> >> +                                    aml_int(TPM_PPI_ADDR_BASE), 0x10=
0));
>> >> +    field =3D aml_field("TPP1", AML_ANY_ACC, AML_NOLOCK, AML_PRESERV=
E);
>> >> +    for (i =3D 0; i < 0x100; i++) {
>> >> +        char *tmp =3D g_strdup_printf("FN%02X", i);
>> >> +        aml_append(field, aml_named_field(tmp, 8));
>> >> +        g_free(tmp);
>> >> +    }
>> >> +    aml_append(dev, field);
>> >> +
>> >> +    /*
>> >> +     * TPP2 is for the registers that ACPI code used to pass
>> >> +     * the PPI code and parameter (PPRQ, PPRM) to the firmware.
>> >> +     */
>> >> +    aml_append(dev,
>> >> +               aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
>> >> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x10=
0),
>> >> +                                    0x5A));
>> >> +    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERV=
E);
>> >> +    aml_append(field, aml_named_field("PPIN", 8));
>> >> +    aml_append(field, aml_named_field("PPIP", 32));
>> >> +    aml_append(field, aml_named_field("PPRP", 32));
>> >> +    aml_append(field, aml_named_field("PPRQ", 32));
>> >> +    aml_append(field, aml_named_field("PPRM", 32));
>> >> +    aml_append(field, aml_named_field("LPPR", 32));
>> >> +    aml_append(dev, field);
>> >> +
>> >> +    /*
>> >> +     * A function to return the value of DerefOf (FUNC [N]), by usin=
g
>> >> +     * accessing the fields individually instead. This is a workarou=
nd
>> >> +     * for what looks like a Windows ACPI bug in all versions so far
>> >> +     * (fwiw, DerefOf (FUNC [N]) works on Linux).
>> >> +     */
>> >> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
>> >> +    {
>> >> +        for (i =3D 0; i < 0x100; i++) {
>> >> +            ifctx =3D aml_if(aml_equal(aml_int(i), aml_arg(0)));
>> >> +            {
>> >> +                aml_append(ifctx, aml_return(aml_name("FN%02X", i)))=
;
>> >> +            }
>> >> +            aml_append(method, ifctx);
>> >> +        }
>> >> +        aml_append(method, aml_return(aml_int(0)));
>> >> +    }
>> >> +    aml_append(dev, method);
>> >> +
>> >> +    pak =3D aml_package(2);
>> >> +    aml_append(pak, aml_int(0));
>> >> +    aml_append(pak, aml_int(0));
>> >> +    name =3D aml_name_decl("TPM2", pak);
>> >> +    aml_append(dev, name);
>> >> +
>> >> +    pak =3D aml_package(3);
>> >> +    aml_append(pak, aml_int(0));
>> >> +    aml_append(pak, aml_int(0));
>> >> +    aml_append(pak, aml_int(0));
>> >> +    name =3D aml_name_decl("TPM3", pak);
>> > Aml one =3D aml_int(1)
>> > Aml tpm3 =3D local(x)
>> > aml_store(pak, tpm3)
>> >
>> > ... and then later ...
>> >
>> >             {
>> >              /* TPM2[1] =3D PPRQ */
>> >              aml_append(ifctx3, aml_store(aml_name("PPRQ"), aml_index(=
tpm2, one)));
>> >              aml_append(ifctx3, aml_return(tpm2));
>> >
>> > which would make code a bit more readable
>> >
>>
>> But you would have to create aml_int(), aml_local() for every usage. I
>> don't think we gain in readability.
> Aml* variables can be reused as aml_append/aml_foo copies input arguments=
.
> Take look at build_cpus_aml() how it makes code more readable.
>
>> >> +    aml_append(dev, name);
>> > both packages could be local vars as return is done by value
>> >
>> >> +
>> >> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
>> >> +    {
>> >> +        uint8_t zerobyte[1] =3D { 0 };
>> >> +        Aml *func_idx, *rev, *op, *op_arg, *op_flags;
>> >> +
>> >> +        ifctx =3D aml_if(
>> >> +            aml_equal(aml_arg(0),
>> >> +                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D16=
53")));
>> > aml_equal(uuid, aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D1653"))
>>
>> Ok
>>
>> >
>> >> +        {
>> >> +            func_idx =3D aml_local(0);
>> >> +            aml_append(ifctx,
>> >> +                       aml_store(aml_to_integer(aml_arg(2)), func_id=
x));
>> > why do you need aml_to_integer() cast here?
>> >
>> > Wouldn't following just work:
>> >
>> >    Aml function =3D aml_arg(2)
>> >
>> > I'd suggest to use "function" for consistency with nvdimm _DSM
>>
>> ok
>>
>> >
>> > you can use the same naming approach for other arguments i.e.
>> > arguments =3D aml_arg(3)
>> >
>>
>> ok
>>
>> >> +
>> >> +            /* standard DSM query function */
>> >> +            func_idx =3D aml_local(0);
>> > I don't think you need to init it twice.
>> >
>>
>> That looks right, and it's the way nvdimm ACPI code is written, but is
>> not following the usual convention to give up the ownership when given
>> as argument to other AML building function.
>
> That's misunderstanding of how it works, there isn't such convention
> input argument is copied into output AML element.
>
>
>> Sad we don't stick to a single usage pattern (giving up ownership).
>> Some day, someone will look at fixing the leaks, and that may make its
>> work easier if the code was consistent...
> Aml* pointers aren't leaked, see aml_alloc() which stores all allocations
> into a list which is freed later by free_aml_allocator() when table
> is build.
>

oh ok, GC magic :)

>
>> But I'll follow your advise for now.
>>
>> >> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(0)));
>> >> +            {
>> >> +                uint8_t byte_list[2] =3D { 0xff, 0x01 };
>> >> +                aml_append(ifctx2, aml_return(aml_buffer(2, byte_lis=
t)));
>> >> +            }
>> >> +            aml_append(ifctx, ifctx2);
>> >> +
>> >> +            /*
>> >> +             * 8.1.1 Get Physical Presence Interface Version
>> > like Michael noted use version/chapter pair to as reference
>> >
>> > ex: /* ACPI 1.0b: 16.2.5.2 Named Objects Encoding: DefOpRegion */
>>
>> ok
>>
>> >
>> >> +             *
>> >> +             * Arg 2 (Integer): Function Index =3D 1
>> >> +             * Arg 3 (Package): Arguments =3D Empty Package
>> >> +             * Returns: Type: String
>> >> +             */
>> >> +            func_idx =3D aml_local(0);
>> > not needed
>> >
>> >> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(1)));
>> >> +            {
>> >> +                aml_append(ifctx2, aml_return(aml_string("1.3")));
>> >> +            }
>> >> +            aml_append(ifctx, ifctx2);
>> >> +
>> >> +            /*
>> >> +             * 8.1.2 Submit TPM Operation Request to Pre-OS Environm=
ent
>> >> +             *
>> >> +             * Arg 2 (Integer): Function Index =3D 2
>> >> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
>> >> +             *                              Operation Value of the R=
equest
>> >> +             * Returns: Type: Integer
>> >> +             *          0: Success
>> >> +             *          1: Operation Value of the Request Not Suppor=
ted
>> >> +             *          2: General Failure
>> >> +             */
>> >> +            func_idx =3D aml_local(0);
>> > ditto and the same in other places
>> >
>> >> +            ifctx2 =3D aml_if(aml_equal(func_idx, aml_int(2)));
>> >> +            {
>> >> +                /* get opcode */
>> >> +                op =3D aml_derefof(aml_index(aml_arg(3), aml_int(0))=
);
>> >> +                aml_append(ifctx2, aml_store(op, aml_local(0)));
>> >                                                     ^^^ what this loca=
l(0) is? suggest to use named var here (in C sense)
>> >> +
>> >> +                /* get opcode flags */
>> >> +                op =3D aml_local(0);
>> > use other local to make ASL less confusion (i.e. try not to reuse loca=
l vars for something else)
>>
>> I must say I get a bit confused by the code style change you request.
>> The original code from Stefan was more straightforward to me. Now it
>> seems C variables adds another layer of complexity. I think it's
>> easier if you come up with a follow-up patch for further cleanup
>> iterations, as I find it hard to match your wanted style.
>
> Whole point of review is to merge code that doesn't need to be
> rewritten later on and to show preferred style for ACPI code
> so I wouldn't be the only one who knows how it is supposed to work.
>
> Now about my original comment.
> What we have in this patch:
>   func_idx =3D aml_local(0);
>   ...
>   op =3D aml_local(0);
> so resulting AML decompiled in to ASL would (re)use Local0 with different=
 meanings
> what I've suggested is:
>   Aml *func_idx =3D aml_local(0);
>   Aml *op =3D aml_local(1);
>   Aml *foo =3D aml_local(X);
>
> where ASL would retain LocalX meaning throughout method, making it a bit =
readable.
>

Ok, hopefully last iteration is closer to that goal.

>
>> >> +                aml_append(ifctx2,
>> >> +                           aml_store(aml_call1("TPFN", op), aml_loca=
l(1)));
>> >                                                                ^^^ wha=
t this local(1) is?
>> >
>> >> +
>> >> +                op_flags =3D aml_local(1);
>> > I'd init all named vars at the top of function where it's easy to see =
what is what
>> > and use them later. ex: nvdimm_build_common_dsm()
>>
>> But the arguments depend on the function.
> some maybe, but
> function index is common, arguments also, so one could do following:
>
> Aml *func =3D aml_arg(2);
> Aml *args =3D aml_arg(3);
>
> without storing them in locals, and then use them within the method as ne=
cessary

I did that for aml_arg(0..2). just now reading ACPI DSM spec, I
realize aml_arg(3) is always supposed to be optional arguments
package. So I agree, and my last iteration can be further improved in
that direction.

thanks


--=20
Marc-Andr=C3=A9 Lureau
