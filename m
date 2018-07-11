Received: from eggs.gnu.org ([2001:4830:134:3::10]:40546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdHvV-0005x2-Af
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fdHvS-0001vn-2E
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:25:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fdHvR-0001vX-Rd
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 12:25:09 -0400
Date: Wed, 11 Jul 2018 18:25:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180711182505.673a6e1e@redhat.com>
In-Reply-To: <CAJ+F1CKrFKCcmUYMRK1vYyUnbC4oqu7=iJusOed00WeC+=JeLg@mail.gmail.com>
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
	<20180628172657.11646-5-marcandre.lureau@redhat.com>
	<20180704173944.681a9a14@redhat.com>
	<CAJ+F1CKrFKCcmUYMRK1vYyUnbC4oqu7=iJusOed00WeC+=JeLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 4/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 4 Jul 2018 18:00:41 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> HI
>=20
> On Wed, Jul 4, 2018 at 5:39 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Thu, 28 Jun 2018 19:26:57 +0200
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> > =20
> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> The TPM Physical Presence interface consists of an ACPI part, a shared
> >> memory part, and code in the firmware. Users can send messages to the
> >> firmware by writing a code into the shared memory through invoking the
> >> ACPI code. When a reboot happens, the firmware looks for the code and
> >> acts on it by sending sequences of commands to the TPM.
> >>
> >> This patch adds the ACPI code. It is similar to the one in EDK2 but do=
esn't
> >> assume that SMIs are necessary to use. It uses a similar datastructure=
 for
> >> the shared memory as EDK2 does so that EDK2 and SeaBIOS could both mak=
e use
> >> of it. I extended the shared memory data structure with an array of 256
> >> bytes, one for each code that could be implemented. The array contains
> >> flags describing the individual codes. This decouples the ACPI impleme=
ntation
> >> from the firmware implementation.
> >>
> >> The underlying TCG specification is accessible from the following page.
> >>
> >> https://trustedcomputinggroup.org/tcg-physical-presence-interface-spec=
ification/
> >>
> >> This patch implements version 1.30.
> >>
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> [ Marc-Andr=C3=A9 - ACPI code improvements and windows fixes ]
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> ---
> >>
> >> v7: (Marc-Andr=C3=A9)
> >>  - use first spec version/section in code comments
> >>  - use more variables for ASL code building
> >>  - remove unnecessering ToInteger() calls
> >>
> >> v6:
> >>  - more code documentation (Marc-Andr=C3=A9)
> >>  - use some explicit named variables to ease reading (Marc-Andr=C3=A9)
> >>  - use fixed size fields/memory regions, remove PPI struct (Marc-Andr=
=C3=A9)
> >>  - only add PPI ACPI methods if PPI is enabled (Marc-Andr=C3=A9)
> >>  - document the qemu/firmware ACPI memory region (Stefan)
> >>
> >> v5 (Marc-Andr=C3=A9):
> >>  - /struct tpm_ppi/struct TPMPPIData
> >>
> >> v4 (Marc-Andr=C3=A9):
> >>  - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
> >>     handling.
> >>  - replace 'return Package (..) {} ' with scoped variables, to fix
> >>    Windows ACPI handling.
> >>
> >> v3:
> >>  - add support for PPI to CRB
> >>  - split up OperationRegion TPPI into two parts, one containing
> >>    the registers (TPP1) and the other one the flags (TPP2); switched
> >>    the order of the flags versus registers in the code
> >>  - adapted ACPI code to small changes to the array of flags where
> >>    previous flag 0 was removed and now shifting right wasn't always
> >>    necessary anymore
> >>
> >> v2:
> >>  - get rid of FAIL variable; function 5 was using it and always
> >>    returns 0; the value is related to the ACPI function call not
> >>    a possible failure of the TPM function call.
> >>  - extend shared memory data structure with per-opcode entries
> >>    holding flags and use those flags to determine what to return
> >>    to caller
> >>  - implement interface version 1.3
> >> ---
> >>  include/hw/acpi/tpm.h |   8 +
> >>  hw/i386/acpi-build.c  | 403 +++++++++++++++++++++++++++++++++++++++++-
> >>  docs/specs/tpm.txt    |  79 +++++++++
> >>  3 files changed, 487 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> index f79d68a77a..e0bd07862e 100644
> >> --- a/include/hw/acpi/tpm.h
> >> +++ b/include/hw/acpi/tpm.h
> >> @@ -196,4 +196,12 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >>  #define TPM_PPI_VERSION_NONE        0
> >>  #define TPM_PPI_VERSION_1_30        1
> >>
> >> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> >> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> >> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> >> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> >> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> >> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> >> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> >> +
> >>  #endif /* HW_ACPI_TPM_H */
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index ebd64c4818..263677f3e4 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -43,6 +43,7 @@
> >>  #include "hw/acpi/memory_hotplug.h"
> >>  #include "sysemu/tpm.h"
> >>  #include "hw/acpi/tpm.h"
> >> +#include "hw/tpm/tpm_ppi.h"
> >>  #include "hw/acpi/vmgenid.h"
> >>  #include "sysemu/tpm_backend.h"
> >>  #include "hw/timer/mc146818rtc_regs.h"
> >> @@ -1789,6 +1790,396 @@ static Aml *build_q35_osc_method(void)
> >>      return method;
> >>  }
> >>
> >> +static void
> >> +build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >> +{
> >> +    Aml *method, *field, *ifctx, *ifctx2, *ifctx3;
> >> +    Aml *pak, *tpm2, *tpm3, *pprm, *pprq;
> >> +    int i;
> >> +
> >> +    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
> >> +        return;
> >> +    } =20
> > I'd prefer this being checked by caller, like:
> >
> > @@ -2194,6 +2194,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >      int root_bus_limit =3D 0xFF;
> >      PCIBus *bus =3D NULL;
> >      TPMIf *tpm =3D tpm_find();
> > +    bool has_ppi =3D object_property_get_bool(OBJECT(tpm), "ppi", &err=
or_abort); =20
>=20
> it will need an additional "tpm ? .. : false". I'd rather keep it away
> from build_dsdt(), but your call.
ok, keep it as it is now

>=20
> >      int i;
> >
> >      dsdt =3D init_aml_allocator();
> > @@ -2545,8 +2546,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >                   */
> >                  /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> >                  aml_append(dev, aml_name_decl("_CRS", crs));
> > -
> > -                build_tpm_ppi(tpm, dev);
> > +                if (has_ppi) {
> > +                    build_tpm_ppi(tpm, dev);
> > +                }
> >
> >                  aml_append(scope, dev);
> >              }
> > @@ -2567,7 +2569,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >          aml_append(method, aml_return(aml_int(0x0f)));
> >          aml_append(dev, method);
> >
> > -        build_tpm_ppi(tpm, dev);
> > +        if (has_ppi) {
> > +            build_tpm_ppi(tpm, dev);
> > +        }
> >
> >          aml_append(sb_scope, dev);
> >      }
> > =20
> >> +    /*
> >> +     * TPP1 is for the flags that indicate which PPI operations
> >> +     * are supported by the firmware. The firmware is expected to
> >> +     * write these flags.
> >> +     */
> >> +    aml_append(dev,
> >> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
> >> +                                    aml_int(TPM_PPI_ADDR_BASE), 0x100=
));
> >> +    field =3D aml_field("TPP1", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE=
);
> >> +    for (i =3D 0; i < 0x100; i++) {
> >> +        char *tmp =3D g_strdup_printf("FN%02X", i);
> >> +        aml_append(field, aml_named_field(tmp, 8));
> >> +        g_free(tmp);
> >> +    } =20
> > this and TPFN takes more than 4K.
> > Have you tried to declare only one filed of size TPP1, which makes
> > field Buffer type, which could be used with Index and would take only
> > several bytes to in AML. See ACPI 6.2a 19.6.61.2 Index with Buffers.
> > It also looks very portable (but we should test with win xp just to be =
safe) =20
>=20
> You mean like Stefan originally did? Yes, problem described in
> http://www.osronline.com/showThread.CFM?link=3D288617.

we have cpu hotplug that uses this approach, but it has IO based OpReg.

Looks like DerefOf in windows is broken wrt SYSTEM_MEMORY originated field =
buffer
(debugger shows a correct object returned from Index() but DerefOf reads
junk, sometimes it returns the last byte of buffer address).

but do not give up yet,
one can use dynamic operation region inside of method for indexing
so here goes dirty draft idea:
    TPFN(op)
        aml_append(method, aml_operation_region(
          "TPP1",
          AML_SYSTEM_MEMORY,
          aml_add(aml_int(TPM_PPI_ADDR_BASE), op, NULL),
          0x1));
        field =3D aml_field("TPP1", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE)=
;      =20
        aml_append(field, aml_named_field("TPPF", 8));                     =
     =20
        aml_append(method, field);                                         =
     =20
        aml_append(method, aml_return(aml_name("TPPF")));

result of addition probably should be stored in sanely named local var,
but idea stays the same (use address in OpRegion as index) and if 'op'
is user defined, we probably should have bounds check as well.

I don't like dynamic OpRegions but in general, but it savs us a lot of RAM
and much faster then walking 'if..else' chain multiple times.


> > =20
> >> +    aml_append(dev, field);
> >> +
> >> +    /*
> >> +     * TPP2 is for the registers that ACPI code used to pass
> >> +     * the PPI code and parameter (PPRQ, PPRM) to the firmware.
> >> +     */
> >> +    aml_append(dev,
> >> +               aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
> >> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x100=
),
> >> +                                    0x5A));
> >> +    field =3D aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE=
);
> >> +    aml_append(field, aml_named_field("PPIN", 8));
> >> +    aml_append(field, aml_named_field("PPIP", 32));
> >> +    aml_append(field, aml_named_field("PPRP", 32));
> >> +    aml_append(field, aml_named_field("PPRQ", 32));
> >> +    aml_append(field, aml_named_field("PPRM", 32));
> >> +    aml_append(field, aml_named_field("LPPR", 32));
> >> +    aml_append(dev, field);
> >> +    pprq =3D aml_name("PPRQ");
> >> +    pprm =3D aml_name("PPRM");
> >> +
> >> +    /*
> >> +     * A function to return the value of DerefOf (FUNC [N]), by using
> >> +     * accessing the fields individually instead. This is a workaround
> >> +     * for what looks like a Windows ACPI bug in all versions so far
> >> +     * (fwiw, DerefOf (FUNC [N]) works on Linux).
> >> +     */
> >> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED);
> >> +    {
> >> +        for (i =3D 0; i < 0x100; i++) {
> >> +            ifctx =3D aml_if(aml_equal(aml_int(i), aml_arg(0)));
> >> +            {
> >> +                aml_append(ifctx, aml_return(aml_name("FN%02X", i)));
> >> +            }
> >> +            aml_append(method, ifctx);
> >> +        }
> >> +        aml_append(method, aml_return(aml_int(0)));
> >> +    }
> >> +    aml_append(dev, method);
> >> +
> >> +    pak =3D aml_package(2);
> >> +    aml_append(pak, aml_int(0));
> >> +    aml_append(pak, aml_int(0));
> >> +    aml_append(dev, aml_name_decl("TPM2", pak));
> >> +    tpm2 =3D aml_name("TPM2");
> >> +
> >> +    pak =3D aml_package(3);
> >> +    aml_append(pak, aml_int(0));
> >> +    aml_append(pak, aml_int(0));
> >> +    aml_append(pak, aml_int(0));
> >> +    aml_append(dev, aml_name_decl("TPM3", pak));
> >> +    tpm3 =3D aml_name("TPM3"); =20
> > looks like above 2 packages  are used only by _DSM,
> > so you don't need to make them global, just use local variables within =
_DSM for it
> > =20
>=20
> That would also fail on Windows. Fwiw (this time I am sure) my up to
> date t460p uses the same global variables trick, presumably to satisfy
> Windows as well.
ok, could you add a comment about it here so that we won't optimize it
out in future.

> btw, not only it took me a while to find the shortcomings with Windows
> ACPI, but testing any change in the ACPI code takes ~1.5h (with manual
> intervention ever 10 minutes or so, not a lot of fun)
don't tell me, I just killed a bunch of time first to setup debug
environment with broken serial for this series and then to
find a solution that would work (~15min per ACPI change)

>=20
> >> +
> >> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
> >> +    {
> >> +        uint8_t zerobyte[1] =3D { 0 };
> >> +        Aml *function, *arguments, *rev, *op, *op_arg, *op_flags, *uu=
id;
> >> +
> >> +        uuid =3D aml_arg(0);
> >> +        rev =3D aml_arg(1);
> >> +        function =3D aml_arg(2);
> >> +        ifctx =3D aml_if(
> >> +            aml_equal(uuid,
> >> +                      aml_touuid("3DDDFAA6-361B-4EB4-A424-8D10089D165=
3")));
> >> +        { =20
> > it would be better to exit immediately if UUID doesn't match (less inde=
ntation and if contexts)
> > btw, one should return something if uuid doesn't match method,
> >
> > if (LNotEqual(uuid, ToUUID(=E2=80=9C893f00a6-660c-494e-bcfd-3043f4fb67c=
0=E2=80=9D))) {
> >     return(Buffer(){0})
> > }
> > =20
>=20
> Except that the next patch has another uuid to check (and it's not a
> common ACPI style to return early it seems).
ok, keep it as is

>=20
> >> +            /* standard DSM query function */
> >> +            ifctx2 =3D aml_if(aml_equal(function, aml_int(0))); =20
> > constants aml_int(0..3) are used multiple times, suggest to declare them
> > along with rev/function/..., like:
> >
> >  Aml *one =3D aml_int(0);
> >  ...
> >
> > and then use them through code. =20
>=20
> I don't see that as an improvement tbh, it makes the code
> inconsistent. So you would like to have zero and one, but not others?
it will be consistent with cpu/mem hotplug ACPI code and ASL
since 0 and 1 have their own magic names (Zero, One) in gramar

[...]
