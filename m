Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBSA-0006Hd-13
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYBS4-0004X3-SM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:29:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYBS4-0004Ww-Mg
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:29:44 -0400
Date: Wed, 27 Jun 2018 16:29:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627162941.5664796e@redhat.com>
In-Reply-To: <d267de24-a62b-c1b8-bc4f-c8049a447772@linux.vnet.ibm.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-5-marcandre.lureau@redhat.com>
	<20180627151948.5779e60b@redhat.com>
	<d267de24-a62b-c1b8-bc4f-c8049a447772@linux.vnet.ibm.com>
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 27 Jun 2018 10:06:18 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> On 06/27/2018 09:19 AM, Igor Mammedov wrote:
> > On Tue, 26 Jun 2018 14:23:43 +0200
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
> >> This patch implements version 1.30. =20
> > I've made several suggestions below how to improve aml part of patch a =
bit,
> > will review v6 once it's done
> > /hopefully it would be more readable, considering that ASM language is =
horrible to begin with/
> > =20
> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>
> >> ---
> >>
> >> v6:
> >>   - more code documentation (Marc-Andr=C3=A9)
> >>   - use some explicit named variables to ease reading (Marc-Andr=C3=A9)
> >>   - use fixed size fields/memory regions, remove PPI struct (Marc-Andr=
=C3=A9)
> >>   - only add PPI ACPI methods if PPI is enabled (Marc-Andr=C3=A9)
> >>   - document the qemu/firmware ACPI memory region (Stefan)
> >>
> >> v5 (Marc-Andr=C3=A9):
> >>   - /struct tpm_ppi/struct TPMPPIData
> >>
> >> v4 (Marc-Andr=C3=A9):
> >>   - replace 'DerefOf (FUNC [N])' with a function, to fix Windows ACPI
> >>      handling.
> >>   - replace 'return Package (..) {} ' with scoped variables, to fix
> >>     Windows ACPI handling.
> >>
> >> v3:
> >>   - add support for PPI to CRB
> >>   - split up OperationRegion TPPI into two parts, one containing
> >>     the registers (TPP1) and the other one the flags (TPP2); switched
> >>     the order of the flags versus registers in the code
> >>   - adapted ACPI code to small changes to the array of flags where
> >>     previous flag 0 was removed and now shifting right wasn't always
> >>     necessary anymore
> >>
> >> v2:
> >>   - get rid of FAIL variable; function 5 was using it and always
> >>     returns 0; the value is related to the ACPI function call not
> >>     a possible failure of the TPM function call.
> >>   - extend shared memory data structure with per-opcode entries
> >>     holding flags and use those flags to determine what to return
> >>     to caller
> >>   - implement interface version 1.3
> >> ---
> >>   include/hw/acpi/tpm.h |   8 +
> >>   hw/i386/acpi-build.c  | 423 ++++++++++++++++++++++++++++++++++++++++=
+-
> >>   docs/specs/tpm.txt    |  79 ++++++++
> >>   3 files changed, 509 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >> index f79d68a77a..e0bd07862e 100644
> >> --- a/include/hw/acpi/tpm.h
> >> +++ b/include/hw/acpi/tpm.h
> >> @@ -196,4 +196,12 @@ REG32(CRB_DATA_BUFFER, 0x80)
> >>   #define TPM_PPI_VERSION_NONE        0
> >>   #define TPM_PPI_VERSION_1_30        1
> >>  =20
> >> +/* whether function is blocked by BIOS settings; bits 0, 1, 2 */
> >> +#define TPM_PPI_FUNC_NOT_IMPLEMENTED     (0 << 0)
> >> +#define TPM_PPI_FUNC_BIOS_ONLY           (1 << 0)
> >> +#define TPM_PPI_FUNC_BLOCKED             (2 << 0)
> >> +#define TPM_PPI_FUNC_ALLOWED_USR_REQ     (3 << 0)
> >> +#define TPM_PPI_FUNC_ALLOWED_USR_NOT_REQ (4 << 0)
> >> +#define TPM_PPI_FUNC_MASK                (7 << 0)
> >> +
> >>   #endif /* HW_ACPI_TPM_H */
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index d9320845ed..d815af4eef 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -43,6 +43,7 @@
> >>   #include "hw/acpi/memory_hotplug.h"
> >>   #include "sysemu/tpm.h"
> >>   #include "hw/acpi/tpm.h"
> >> +#include "hw/tpm/tpm_ppi.h"
> >>   #include "hw/acpi/vmgenid.h"
> >>   #include "sysemu/tpm_backend.h"
> >>   #include "hw/timer/mc146818rtc_regs.h"
> >> @@ -1789,6 +1790,421 @@ static Aml *build_q35_osc_method(void)
> >>       return method;
> >>   }
> >>  =20
> >> +static void
> >> +build_tpm_ppi(Aml *dev)
> >> +{
> >> +    Aml *method, *name, *field, *ifctx, *ifctx2, *ifctx3, *pak;
> >> +    int i;
> >> +
> >> +    if (!object_property_get_bool(OBJECT(tpm_find()), "ppi", &error_a=
bort)) { =20
> > if tpm_find() =3D=3D NULL -> BAAM??? =20
>=20
> This function wouldn't be called if there's no TPM.
it happens not to be called now,
I'd suggest do look up once (QOM tree walk expensive)
and pass found value as an argument down call chain.
