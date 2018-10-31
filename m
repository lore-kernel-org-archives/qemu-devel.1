Received: from eggs.gnu.org ([2001:4830:134:3::10]:59108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHvNF-0000gP-JG
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHvNC-0003Cv-Bp
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:37:49 -0400
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<75690654-196d-f863-c58e-d23e2b33317a@redhat.com>
	<20181031180604.GN3902@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <4566c66e-0795-32b3-d812-0ec735e06eee@redhat.com>
Date: Wed, 31 Oct 2018 14:37:36 -0400
MIME-Version: 1.0
In-Reply-To: <20181031180604.GN3902@habkost.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>



On 10/31/2018 02:06 PM, Eduardo Habkost wrote:
> On Wed, Oct 31, 2018 at 12:04:16PM -0400, John Snow wrote:
>>
>>
>> On 10/30/2018 09:32 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Gerd,
>>>
>>> On 30/10/18 12:13, Gerd Hoffmann wrote:
>>>> Indicates support state for somerhing (device, backend, subsystem, .=
..)
>>>
>>> "something"
>>>
>>>> in qemu.=C2=A0 Modeled roughly after the "S:" states we have in MAIN=
TANERS.
>>>>
>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>> =C2=A0 include/qemu/support-state.h | 17 +++++++++++++++++
>>>> =C2=A0 util/support-state.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 23 +++++++++++++++++++++++
>>>> =C2=A0 qapi/common.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 ++++++++++++++++
>>>> =C2=A0 util/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>> =C2=A0 4 files changed, 57 insertions(+)
>>>> =C2=A0 create mode 100644 include/qemu/support-state.h
>>>> =C2=A0 create mode 100644 util/support-state.c
>>>>
>>>> diff --git a/include/qemu/support-state.h b/include/qemu/support-sta=
te.h
>>>> new file mode 100644
>>>> index 0000000000..5fd3c83eee
>>>> --- /dev/null
>>>> +++ b/include/qemu/support-state.h
>>>> @@ -0,0 +1,17 @@
>>>> +#ifndef QEMU_SUPPORT_STATE_H
>>>> +#define QEMU_SUPPORT_STATE_H
>>>> +
>>>> +#include "qapi/qapi-types-common.h"
>>>> +
>>>> +typedef struct QemuSupportState {
>>>> +=C2=A0=C2=A0=C2=A0 SupportState state;
>>>> +=C2=A0=C2=A0=C2=A0 const char *reason;
>>>> +} QemuSupportState;
>>>> +
>>>> +void qemu_warn_support_state(const char *type, const char *name,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 QemuSupportState *state);
>>>> +
>>>> +bool qemu_is_deprecated(QemuSupportState *state);
>>>> +bool qemu_is_obsolete(QemuSupportState *state);
>>>> +
>>>> +#endif /* QEMU_SUPPORT_STATE_H */
>>>> diff --git a/util/support-state.c b/util/support-state.c
>>>> new file mode 100644
>>>> index 0000000000..7966fa0fc7
>>>> --- /dev/null
>>>> +++ b/util/support-state.c
>>>> @@ -0,0 +1,23 @@
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/error-report.h"
>>>> +#include "qemu/support-state.h"
>>>> +
>>>> +void qemu_warn_support_state(const char *type, const char *name,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 QemuSupportState *state)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 warn_report("%s %s is %s%s%s%s", type, name,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 SupportState_str(state->state),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? " ("=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 : "",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? state->reason : "",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 state->reason ? ")"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 : "");
>>>> +}
>>>> +
>>>> +bool qemu_is_deprecated(QemuSupportState *state)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return state->state =3D=3D SUPPORT_STATE_DEPRECA=
TED;
>>>> +}
>>>> +
>>>> +bool qemu_is_obsolete(QemuSupportState *state)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 return state->state =3D=3D SUPPORT_STATE_OBSOLET=
E;
>>>> +}
>>>> diff --git a/qapi/common.json b/qapi/common.json
>>>> index 021174f04e..78176151af 100644
>>>> --- a/qapi/common.json
>>>> +++ b/qapi/common.json
>>>> @@ -151,3 +151,19 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'x86_64', 'xtensa', 'xtensaeb' ] }
>>>> +
>>>> +##
>>>> +# @SupportState:
>>>> +#
>>>> +# Indicate Support level of qemu devices, backends, subsystems, ...
>>>> +#
>>>> +# Since: 3.2
>>>> +##
>>>> +{ 'enum': 'SupportState',
>>>> +=C2=A0 'data': [ 'unknown',
>>>
>>> 'unknown' is scary and should be fixed.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'supported',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'maintained',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'odd-fixes',
>>>
>>> All those fit in 'supported'
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'orphan',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'obsolete',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
'deprecated' ] }
>>>
>>> And all those should appear as 'deprecated' IMHO.
>>>
>>
>> You've covered it a bit below, but I think we need more than "supporte=
d"
>> and "deprecated" -- at *least* a third state "unsupported" is required=
, IMO:
>>
>> - Supported: We expect this to work. We test this component. We will
>> ship CVE fixes in a timely manner for this component. You are, as a
>> user, using something that is cared for and you may rely on us to care
>> for it.
>>
>> - Unsupported: We expect this to work, but nobody is tending to it
>> actively. It might be perfectly OK, but the tests and support may be
>> lacking. Try not to rely on this in an enterprise environment unless y=
ou
>> have resources to devote to caring for it personally. I'd count things
>> like Raspberry Pi boards in this category: they work, usually, but not
>> fully. Some people are working on them, but they're not ready for prim=
e
>> time usage.
>=20
> I wonder: do we need a distinction between code that's
> unsupported and expected to be removed in the next versions of
> QEMU, and code that's unsupported but not planned to be removed
> yet?
>=20

I maybe should not have used the word deprecated, which I think
obfuscates the code quality metric we might be trying to convey: even
top-notch, first-tier support code can be deprecated in favor of some
newer, better model.

So let's not use it for these purposes: as you suggest, even deprecated
code should be compiled because it hasn't been removed *yet*, and it
serves explicitly as a transitional stage.


I just really want to paint a difference between... say,

"stuff that maybe works, but isn't tier 1" and
"stuff that probably doesn't work without some elbow grease."

I'm just having a hard time coming up with a hard metric to
differentiate the two, but I can't shake the feeling that "SUPPORTED" vs
"UNSUPPORTED" is just simply too strict of a binary.

In my mental model, it's three tiers:

A: First-class support.
B: Proceed with caution.
C: Experimental/Development ONLY.

As a stoplight, it'd be:

GREEN: Expected to work. Well cared for and tested.

YELLOW: Some problems, but expected either to transition to green
(maintainer willing), OR be deprecated/removed. At a code quality level
where non-developers should try using it and report bugs. These devices
might work well for certain use cases but aren't fully implemented yet
and could break.

RED: Broken. Kept in the code base for development reasons; e.g. new
ARM/SoC models that are in development, but are known to not work yet.
People who are not developers should not waste their time trying to use
them to accomplish real work yet.


That's kind of the granularity I have in mind, but I don't know if it's
practical to grade everything on so fuzzy a scale to begin with. I'd
suggest as a first pass marking everything either as YELLOW or RED to
suggest "SUPPORTED" vs "UNSUPPORTED", and then individually making the
case for specific components to be promoted to GREEN.

--js

>>
>> - Deprecated: This used to work, or used to be maintained, but has bee=
n
>> superseded or is otherwise scheduled to be removed -- the expectation =
is
>> that this device will get worse, not better. The device model may be
>> known to be incorrect, there may be major bugs, and it receives little
>> to no care or maintenance. Actively avoid using in an enterprise conte=
xt.
>>
>> The idea being that there is definitely a difference between obviously
>> and wholly broken components that we're working on replacing or gettin=
g
>> rid of, and components that are "in beta" or partially functional, and
>> those that are full, "tier 1" supported subsystems.
>=20
> I agree there's a difference between unsupported and supported
> code.
>=20
> But I'd say that making this a build time option is a must (as
> many distributions would wish to disable unsupported code at
> build time).  Making the information available at runtime is just
> nice to have.
>=20

Oh, yes, it must absolutely be build-time. In my three-tier example, I
would expect downstream distributions like Fedora to compile out the
RED/C-TIER immediately. For something like RHEL, they might compile out
the YELLOW/B-TIER as well.

Some use cases might want to compile out RED but leave YELLOW as some
run-time warning or run-time error ("please use --use-shoddy-parts if
you wish to use %%ramshackle_device%% ...")

I think what this buys us is confidence that despite QEMU's very wide
scope, we can quickly see both in code and at run-time that we're not
using something we shouldn't be, or misunderstanding the relative
quality of the parts we're building our virtual machine from.

Having conservative green/yellow lists might help reduce the "search
space" for documentation and help more users arrive at "good"
configurations by default.

> Deprecated code, on the other hand, is expected to be enabled at
> build time even on enterprise distributions, and will definitely
> require a mechanism to generate a warning at runtime.
>=20
>=20
>>
>> Adding any more nuanced states than this, though, risks making it too
>> difficult to make any informed decisions as a user, I think. This patc=
h
>> as-is maybe adds too many?
>=20
> Agreed.
>=20
>>
>> --js
>>
>>>> diff --git a/util/Makefile.objs b/util/Makefile.objs
>>>> index 0820923c18..6e5f8faf82 100644
>>>> --- a/util/Makefile.objs
>>>> +++ b/util/Makefile.objs
>>>> @@ -50,5 +50,6 @@ util-obj-y +=3D range.o
>>>> =C2=A0 util-obj-y +=3D stats64.o
>>>> =C2=A0 util-obj-y +=3D systemd.o
>>>> =C2=A0 util-obj-y +=3D iova-tree.o
>>>> +util-obj-y +=3D support-state.o
>>>> =C2=A0 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
>>>> =C2=A0 util-obj-$(CONFIG_OPENGL) +=3D drm.o
>>>>
>>>
>=20
