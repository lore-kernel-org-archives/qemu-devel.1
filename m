Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1edfr7-0006TW-DU
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1edfr4-00043J-8R
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:26:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1edfr3-00042a-Uv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:25:58 -0500
Date: Mon, 22 Jan 2018 15:25:46 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180122172546.GI5292@localhost.localdomain>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-5-marcandre.lureau@redhat.com>
	<f2ecf612-8538-f8d1-ffd8-f875aa453c42@amsat.org>
	<3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
	<CAMxuvaxyBmEEnk_dtFR4qbk_-95ROnR6o-3gR7U=HNJAhV5DdA@mail.gmail.com>
	<6cb2b88f-0c8b-4bab-c8fc-018dd0cbc662@linux.vnet.ibm.com>
	<CAMxuvazYZZwzSBPvbmKLPv_YG2uYPkPA1meiYoMkizegEozC_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazYZZwzSBPvbmKLPv_YG2uYPkPA1meiYoMkizegEozC_g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 22, 2018 at 04:08:30PM +0100, Marc-Andre Lureau wrote:
> Hi
>=20
> On Sun, Jan 21, 2018 at 11:01 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
> > On 01/21/2018 02:24 PM, Marc-Andre Lureau wrote:
> >>
> >> Hi
> >>
> >> On Sun, Jan 21, 2018 at 6:46 AM, Stefan Berger
> >> <stefanb@linux.vnet.ibm.com> wrote:
> >>>
> >>> On 01/20/2018 07:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>
> >>>> On 01/19/2018 11:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> >>>>>
> >>>>> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
> >>>>> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
> >>>>> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.0=
3 v22.
> >>>>>
> >>>>> The PTP allows device implementation to switch between TIS and CR=
B
> >>>>> model at run time, but given that CRB is a simpler device to
> >>>>> implement, I chose to implement it as a different device.
> >>>>>
> >>>>> The device doesn't implement other locality than 0 for now (my la=
ptop
> >>>>> TPM doesn't either, so I assume this isn't so bad)
> >>>>>
> >>>>> The command/reply memory region is statically allocated after the=
 CRB
> >>>>> registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
> >>>>> wonder if the BIOS could or should allocate it instead, or what s=
ize
> >>>>> to use, again this seems to fit well expectations)
> >>>>>
> >>>>> The PTP doesn't specify a particular bus to put the device. So I =
added
> >>>>> it on the system bus directly, so it could hopefully be used easi=
ly on
> >>>>> a different platform than x86. Currently, it fails to init on pii=
x,
> >>>>> because error_on_sysbus_device() check. The check may be changed =
in a
> >>>>> near future, see discussion on the qemu-devel ML.
> >>>>>
> >>>>> Tested with some success with Linux upstream and Windows 10, seab=
ios &
> >>>>> modified ovmf. The device is recognized and correctly transmit
> >>>>> command/response with passthrough & emu. However, we are missing =
PPI
> >>>>> ACPI part atm.
> >>>>>
> >>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m>
> >>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >>>>> ---
> >>>>>    qapi/tpm.json                      |   5 +-
> >>>>>    include/hw/acpi/tpm.h              |  72 ++++++++
> >>>>>    include/sysemu/tpm.h               |   3 +
> >>>>>    hw/i386/acpi-build.c               |  34 +++-
> >>>>>    hw/tpm/tpm_crb.c                   | 327
> >>>>> +++++++++++++++++++++++++++++++++++++
> >>>>>    default-configs/i386-softmmu.mak   |   1 +
> >>>>>    default-configs/x86_64-softmmu.mak |   1 +
> >>>>>    hw/tpm/Makefile.objs               |   1 +
> >>>>>    8 files changed, 434 insertions(+), 10 deletions(-)
> >>>>>    create mode 100644 hw/tpm/tpm_crb.c
> >>>>>
> >>>>> diff --git a/qapi/tpm.json b/qapi/tpm.json
> >>>>> index 7093f268fb..d50deef5e9 100644
> >>>>> --- a/qapi/tpm.json
> >>>>> +++ b/qapi/tpm.json
> >>>>> @@ -11,10 +11,11 @@
> >>>>>    # An enumeration of TPM models
> >>>>>    #
> >>>>>    # @tpm-tis: TPM TIS model
> >>>>> +# @tpm-crb: TPM CRB model (since 2.12)
> >>>>>    #
> >>>>>    # Since: 1.5
> >>>>>    ##
> >>>>> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
> >>>>> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
> >>>>>      ##
> >>>>>    # @query-tpm-models:
> >>>>> @@ -28,7 +29,7 @@
> >>>>>    # Example:
> >>>>>    #
> >>>>>    # -> { "execute": "query-tpm-models" }
> >>>>> -# <- { "return": [ "tpm-tis" ] }
> >>>>> +# <- { "return": [ "tpm-tis", "tpm-crb" ] }
> >>>>>    #
> >>>>>    ##
> >>>>>    { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
> >>>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> >>>>> index 6d516c6a7f..b0048515fa 100644
> >>>>> --- a/include/hw/acpi/tpm.h
> >>>>> +++ b/include/hw/acpi/tpm.h
> >>>>> @@ -16,11 +16,82 @@
> >>>>>    #ifndef HW_ACPI_TPM_H
> >>>>>    #define HW_ACPI_TPM_H
> >>>>>    +#include "qemu/osdep.h"
> >>>>> +
> >>>>>    #define TPM_TIS_ADDR_BASE           0xFED40000
> >>>>>    #define TPM_TIS_ADDR_SIZE           0x5000
> >>>>>      #define TPM_TIS_IRQ                 5
> >>>>>    +struct crb_regs {
> >>>>> +    union {
> >>>>> +        uint32_t reg;
> >>>>> +        struct {
> >>>>> +            unsigned tpm_established:1;
> >>>>> +            unsigned loc_assigned:1;
> >>>>> +            unsigned active_locality:3;
> >>>>> +            unsigned reserved:2;
> >>>>> +            unsigned tpm_reg_valid_sts:1;
> >>>>> +        } bits;
> >>>>
> >>>> I suppose this is little-endian layout, so this won't work on big-=
endian
> >>>> hosts.
> >>>>
> >>>> Can you add a qtest?
> >>>>
> >>>>> +    } loc_state;
> >>>>> +    uint32_t reserved1;
> >>>>> +    uint32_t loc_ctrl;
> >>>>> +    union {
> >>>>> +        uint32_t reg;
> >>>>> +        struct {
> >>>>> +            unsigned granted:1;
> >>>>> +            unsigned been_seized:1;
> >>>>> +        } bits;
> >>>>
> >>>>
> >>>> This is unclear where you expect those bits (right/left aligned).
> >>>>
> >>>> Can you add an unnamed field to be more explicit?
> >>>>
> >>>> i.e. without using struct if left alignment expected:
> >>>>
> >>>>              unsigned granted:1, been_seized:1, :30;
> >>>
> >>>
> >>>
> >>> I got rid of all the bitfields and this patch here makes it work on=
 a
> >>> ppc64
> >>> big endian and also x86_64 host:
> >>>
> >>>
> >>> https://github.com/stefanberger/qemu-tpm/commit/28fc07f0d9314168986=
190effd6d72d9fd3972dd
> >>>
> >> Thank you Stefan! I am all for squashing this fix to the patch. You
> >> should then add your signed-off to the commit.
> >
> >
> > I'll do that.
> >
> > The TIS is an ISA Device and the CRB is similar. Considering the
>=20
> How much similarity is there between TIS and CRB is there? The two
> devices look quite different to me, CRB is way simpler it seems. Or is
> the CRB implementation just lacking many bells and whistles that TIS
> has? Should we consider merging CRB in TIS?
>=20
> > complications with the sysbus devices where one has to explicitly all=
ow it
> > for a certain machine type, I would advocate to convert the CRB to an=
 ISA
> > device. A patch that does that is this one:
>=20
> If it's only for that reason (an explicit enable), I would rather keep
> it on the system bus. Or should it be on an LPC bus?
>=20
> Eduardo, what do you think?

Everything about sysbus is exceptional and confusing, so I would
prefer to avoid using sysbus every time we have an alternative.
If tpm-tis is already an ISA device, what are the reasons to not
use ISA for tpm-crb too?

--=20
Eduardo
