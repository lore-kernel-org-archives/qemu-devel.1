Received: from eggs.gnu.org ([2001:4830:134:3::10]:36719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHszA-0003Ti-TH
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHsz6-0006fW-UJ
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:04:48 -0400
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <75690654-196d-f863-c58e-d23e2b33317a@redhat.com>
Date: Wed, 31 Oct 2018 12:04:16 -0400
MIME-Version: 1.0
In-Reply-To: <8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] add QemuSupportState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>



On 10/30/2018 09:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Gerd,
>=20
> On 30/10/18 12:13, Gerd Hoffmann wrote:
>> Indicates support state for somerhing (device, backend, subsystem, ...=
)
>=20
> "something"
>=20
>> in qemu.=C2=A0 Modeled roughly after the "S:" states we have in MAINTA=
NERS.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>> =C2=A0 include/qemu/support-state.h | 17 +++++++++++++++++
>> =C2=A0 util/support-state.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 +++++++++++++++++++++++
>> =C2=A0 qapi/common.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
>> =C2=A0 util/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 4 files changed, 57 insertions(+)
>> =C2=A0 create mode 100644 include/qemu/support-state.h
>> =C2=A0 create mode 100644 util/support-state.c
>>
>> diff --git a/include/qemu/support-state.h b/include/qemu/support-state=
.h
>> new file mode 100644
>> index 0000000000..5fd3c83eee
>> --- /dev/null
>> +++ b/include/qemu/support-state.h
>> @@ -0,0 +1,17 @@
>> +#ifndef QEMU_SUPPORT_STATE_H
>> +#define QEMU_SUPPORT_STATE_H
>> +
>> +#include "qapi/qapi-types-common.h"
>> +
>> +typedef struct QemuSupportState {
>> +=C2=A0=C2=A0=C2=A0 SupportState state;
>> +=C2=A0=C2=A0=C2=A0 const char *reason;
>> +} QemuSupportState;
>> +
>> +void qemu_warn_support_state(const char *type, const char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 QemuSupportState *state);
>> +
>> +bool qemu_is_deprecated(QemuSupportState *state);
>> +bool qemu_is_obsolete(QemuSupportState *state);
>> +
>> +#endif /* QEMU_SUPPORT_STATE_H */
>> diff --git a/util/support-state.c b/util/support-state.c
>> new file mode 100644
>> index 0000000000..7966fa0fc7
>> --- /dev/null
>> +++ b/util/support-state.c
>> @@ -0,0 +1,23 @@
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/support-state.h"
>> +
>> +void qemu_warn_support_state(const char *type, const char *name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 QemuSupportState *state)
>> +{
>> +=C2=A0=C2=A0=C2=A0 warn_report("%s %s is %s%s%s%s", type, name,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SupportState_str(state->state),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? " ("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? state->reason : "",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? ")"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "");
>> +}
>> +
>> +bool qemu_is_deprecated(QemuSupportState *state)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return state->state =3D=3D SUPPORT_STATE_DEPRECATE=
D;
>> +}
>> +
>> +bool qemu_is_obsolete(QemuSupportState *state)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return state->state =3D=3D SUPPORT_STATE_OBSOLETE;
>> +}
>> diff --git a/qapi/common.json b/qapi/common.json
>> index 021174f04e..78176151af 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -151,3 +151,19 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 'x86_64', 'xtensa', 'xtensaeb' ] }
>> +
>> +##
>> +# @SupportState:
>> +#
>> +# Indicate Support level of qemu devices, backends, subsystems, ...
>> +#
>> +# Since: 3.2
>> +##
>> +{ 'enum': 'SupportState',
>> +=C2=A0 'data': [ 'unknown',
>=20
> 'unknown' is scary and should be fixed.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 's=
upported',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'm=
aintained',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'o=
dd-fixes',
>=20
> All those fit in 'supported'
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'o=
rphan',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'o=
bsolete',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'd=
eprecated' ] }
>=20
> And all those should appear as 'deprecated' IMHO.
>=20

You've covered it a bit below, but I think we need more than "supported"
and "deprecated" -- at *least* a third state "unsupported" is required, I=
MO:

- Supported: We expect this to work. We test this component. We will
ship CVE fixes in a timely manner for this component. You are, as a
user, using something that is cared for and you may rely on us to care
for it.

- Unsupported: We expect this to work, but nobody is tending to it
actively. It might be perfectly OK, but the tests and support may be
lacking. Try not to rely on this in an enterprise environment unless you
have resources to devote to caring for it personally. I'd count things
like Raspberry Pi boards in this category: they work, usually, but not
fully. Some people are working on them, but they're not ready for prime
time usage.

- Deprecated: This used to work, or used to be maintained, but has been
superseded or is otherwise scheduled to be removed -- the expectation is
that this device will get worse, not better. The device model may be
known to be incorrect, there may be major bugs, and it receives little
to no care or maintenance. Actively avoid using in an enterprise context.

The idea being that there is definitely a difference between obviously
and wholly broken components that we're working on replacing or getting
rid of, and components that are "in beta" or partially functional, and
those that are full, "tier 1" supported subsystems.

Adding any more nuanced states than this, though, risks making it too
difficult to make any informed decisions as a user, I think. This patch
as-is maybe adds too many?

--js

>> diff --git a/util/Makefile.objs b/util/Makefile.objs
>> index 0820923c18..6e5f8faf82 100644
>> --- a/util/Makefile.objs
>> +++ b/util/Makefile.objs
>> @@ -50,5 +50,6 @@ util-obj-y +=3D range.o
>> =C2=A0 util-obj-y +=3D stats64.o
>> =C2=A0 util-obj-y +=3D systemd.o
>> =C2=A0 util-obj-y +=3D iova-tree.o
>> +util-obj-y +=3D support-state.o
>> =C2=A0 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
>> =C2=A0 util-obj-$(CONFIG_OPENGL) +=3D drm.o
>>
>=20
