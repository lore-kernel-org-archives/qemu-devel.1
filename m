Received: from eggs.gnu.org ([2001:4830:134:3::10]:35928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHvhR-0004mR-1Q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHvhM-0004EO-0C
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:58:40 -0400
Date: Wed, 31 Oct 2018 15:58:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031185811.GU3902@habkost.net>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<75690654-196d-f863-c58e-d23e2b33317a@redhat.com>
	<20181031180604.GN3902@habkost.net>
	<4566c66e-0795-32b3-d812-0ec735e06eee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4566c66e-0795-32b3-d812-0ec735e06eee@redhat.com>
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
To: John Snow <jsnow@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, Oct 31, 2018 at 02:37:36PM -0400, John Snow wrote:
>=20
>=20
> On 10/31/2018 02:06 PM, Eduardo Habkost wrote:
> > On Wed, Oct 31, 2018 at 12:04:16PM -0400, John Snow wrote:
> >>
> >>
> >> On 10/30/2018 09:32 AM, Philippe Mathieu-Daud=E9 wrote:
> >>> Hi Gerd,
> >>>
> >>> On 30/10/18 12:13, Gerd Hoffmann wrote:
> >>>> Indicates support state for somerhing (device, backend, subsystem,=
 ...)
> >>>
> >>> "something"
> >>>
> >>>> in qemu.=A0 Modeled roughly after the "S:" states we have in MAINT=
ANERS.
> >>>>
> >>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >>>> ---
> >>>> =A0 include/qemu/support-state.h | 17 +++++++++++++++++
> >>>> =A0 util/support-state.c=A0=A0=A0=A0=A0=A0=A0=A0 | 23 ++++++++++++=
+++++++++++
> >>>> =A0 qapi/common.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 16 ++++=
++++++++++++
> >>>> =A0 util/Makefile.objs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> >>>> =A0 4 files changed, 57 insertions(+)
> >>>> =A0 create mode 100644 include/qemu/support-state.h
> >>>> =A0 create mode 100644 util/support-state.c
> >>>>
> >>>> diff --git a/include/qemu/support-state.h b/include/qemu/support-s=
tate.h
> >>>> new file mode 100644
> >>>> index 0000000000..5fd3c83eee
> >>>> --- /dev/null
> >>>> +++ b/include/qemu/support-state.h
> >>>> @@ -0,0 +1,17 @@
> >>>> +#ifndef QEMU_SUPPORT_STATE_H
> >>>> +#define QEMU_SUPPORT_STATE_H
> >>>> +
> >>>> +#include "qapi/qapi-types-common.h"
> >>>> +
> >>>> +typedef struct QemuSupportState {
> >>>> +=A0=A0=A0 SupportState state;
> >>>> +=A0=A0=A0 const char *reason;
> >>>> +} QemuSupportState;
> >>>> +
> >>>> +void qemu_warn_support_state(const char *type, const char *name,
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QemuSupportState *state);
> >>>> +
> >>>> +bool qemu_is_deprecated(QemuSupportState *state);
> >>>> +bool qemu_is_obsolete(QemuSupportState *state);
> >>>> +
> >>>> +#endif /* QEMU_SUPPORT_STATE_H */
> >>>> diff --git a/util/support-state.c b/util/support-state.c
> >>>> new file mode 100644
> >>>> index 0000000000..7966fa0fc7
> >>>> --- /dev/null
> >>>> +++ b/util/support-state.c
> >>>> @@ -0,0 +1,23 @@
> >>>> +#include "qemu/osdep.h"
> >>>> +#include "qemu/error-report.h"
> >>>> +#include "qemu/support-state.h"
> >>>> +
> >>>> +void qemu_warn_support_state(const char *type, const char *name,
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QemuSupportState *state)
> >>>> +{
> >>>> +=A0=A0=A0 warn_report("%s %s is %s%s%s%s", type, name,
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SupportState_str(st=
ate->state),
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? " (=
"=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "",
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? sta=
te->reason : "",
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? ")"=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "");
> >>>> +}
> >>>> +
> >>>> +bool qemu_is_deprecated(QemuSupportState *state)
> >>>> +{
> >>>> +=A0=A0=A0 return state->state =3D=3D SUPPORT_STATE_DEPRECATED;
> >>>> +}
> >>>> +
> >>>> +bool qemu_is_obsolete(QemuSupportState *state)
> >>>> +{
> >>>> +=A0=A0=A0 return state->state =3D=3D SUPPORT_STATE_OBSOLETE;
> >>>> +}
> >>>> diff --git a/qapi/common.json b/qapi/common.json
> >>>> index 021174f04e..78176151af 100644
> >>>> --- a/qapi/common.json
> >>>> +++ b/qapi/common.json
> >>>> @@ -151,3 +151,19 @@
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'ppc64', 'riscv32', 'ri=
scv64', 's390x', 'sh4',
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'sh4eb', 'sparc', 'spar=
c64', 'tricore', 'unicore32',
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'x86_64', 'xtensa', 'xt=
ensaeb' ] }
> >>>> +
> >>>> +##
> >>>> +# @SupportState:
> >>>> +#
> >>>> +# Indicate Support level of qemu devices, backends, subsystems, .=
..
> >>>> +#
> >>>> +# Since: 3.2
> >>>> +##
> >>>> +{ 'enum': 'SupportState',
> >>>> +=A0 'data': [ 'unknown',
> >>>
> >>> 'unknown' is scary and should be fixed.
> >>>
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'supported',
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'maintained',
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'odd-fixes',
> >>>
> >>> All those fit in 'supported'
> >>>
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'orphan',
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'obsolete',
> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'deprecated' ] }
> >>>
> >>> And all those should appear as 'deprecated' IMHO.
> >>>
> >>
> >> You've covered it a bit below, but I think we need more than "suppor=
ted"
> >> and "deprecated" -- at *least* a third state "unsupported" is requir=
ed, IMO:
> >>
> >> - Supported: We expect this to work. We test this component. We will
> >> ship CVE fixes in a timely manner for this component. You are, as a
> >> user, using something that is cared for and you may rely on us to ca=
re
> >> for it.
> >>
> >> - Unsupported: We expect this to work, but nobody is tending to it
> >> actively. It might be perfectly OK, but the tests and support may be
> >> lacking. Try not to rely on this in an enterprise environment unless=
 you
> >> have resources to devote to caring for it personally. I'd count thin=
gs
> >> like Raspberry Pi boards in this category: they work, usually, but n=
ot
> >> fully. Some people are working on them, but they're not ready for pr=
ime
> >> time usage.
> >=20
> > I wonder: do we need a distinction between code that's
> > unsupported and expected to be removed in the next versions of
> > QEMU, and code that's unsupported but not planned to be removed
> > yet?
> >=20
>=20
> I maybe should not have used the word deprecated, which I think
> obfuscates the code quality metric we might be trying to convey: even
> top-notch, first-tier support code can be deprecated in favor of some
> newer, better model.
>=20
> So let's not use it for these purposes: as you suggest, even deprecated
> code should be compiled because it hasn't been removed *yet*, and it
> serves explicitly as a transitional stage.
>=20
>=20
> I just really want to paint a difference between... say,
>=20
> "stuff that maybe works, but isn't tier 1" and
> "stuff that probably doesn't work without some elbow grease."
>=20
> I'm just having a hard time coming up with a hard metric to
> differentiate the two, but I can't shake the feeling that "SUPPORTED" v=
s
> "UNSUPPORTED" is just simply too strict of a binary.
>=20
> In my mental model, it's three tiers:
>=20
> A: First-class support.
> B: Proceed with caution.
> C: Experimental/Development ONLY.
>=20
> As a stoplight, it'd be:
>=20
> GREEN: Expected to work. Well cared for and tested.
>=20
> YELLOW: Some problems, but expected either to transition to green
> (maintainer willing), OR be deprecated/removed. At a code quality level
> where non-developers should try using it and report bugs. These devices
> might work well for certain use cases but aren't fully implemented yet
> and could break.
>=20
> RED: Broken. Kept in the code base for development reasons; e.g. new
> ARM/SoC models that are in development, but are known to not work yet.
> People who are not developers should not waste their time trying to use
> them to accomplish real work yet.
>=20
>=20
> That's kind of the granularity I have in mind, but I don't know if it's
> practical to grade everything on so fuzzy a scale to begin with. I'd
> suggest as a first pass marking everything either as YELLOW or RED to
> suggest "SUPPORTED" vs "UNSUPPORTED", and then individually making the
> case for specific components to be promoted to GREEN.
>=20
> --js
>=20
> >>
> >> - Deprecated: This used to work, or used to be maintained, but has b=
een
> >> superseded or is otherwise scheduled to be removed -- the expectatio=
n is
> >> that this device will get worse, not better. The device model may be
> >> known to be incorrect, there may be major bugs, and it receives litt=
le
> >> to no care or maintenance. Actively avoid using in an enterprise con=
text.
> >>
> >> The idea being that there is definitely a difference between obvious=
ly
> >> and wholly broken components that we're working on replacing or gett=
ing
> >> rid of, and components that are "in beta" or partially functional, a=
nd
> >> those that are full, "tier 1" supported subsystems.
> >=20
> > I agree there's a difference between unsupported and supported
> > code.
> >=20
> > But I'd say that making this a build time option is a must (as
> > many distributions would wish to disable unsupported code at
> > build time).  Making the information available at runtime is just
> > nice to have.
> >=20
>=20
> Oh, yes, it must absolutely be build-time. In my three-tier example, I
> would expect downstream distributions like Fedora to compile out the
> RED/C-TIER immediately. For something like RHEL, they might compile out
> the YELLOW/B-TIER as well.
>=20
> Some use cases might want to compile out RED but leave YELLOW as some
> run-time warning or run-time error ("please use --use-shoddy-parts if
> you wish to use %%ramshackle_device%% ...")
>=20
> I think what this buys us is confidence that despite QEMU's very wide
> scope, we can quickly see both in code and at run-time that we're not
> using something we shouldn't be, or misunderstanding the relative
> quality of the parts we're building our virtual machine from.
>=20
> Having conservative green/yellow lists might help reduce the "search
> space" for documentation and help more users arrive at "good"
> configurations by default.

Right, I think we are on the same page here.

Now, support/stability status and deprecation/removal status seem
to be independent variables.  It's perfectly valid to say "this
device is expected to be removed in the future, you need to
update your configuration" and "this device is expected to be
stable and we support it" at the same time.  Let's not mix up
both.

This also means keeping in mind the different stories we want to
address.  The ones I would like to address are:

1) As a virtualization app user, I want to be warned at runtime
   in case my VM configuration relies on features that will be
   removed in future versions of the stack, so I have a chance to
   update my VM configuration before updating the software.

2) As a QEMU distributor, downstream vendor, or developer, I want
   to:
   * know which parts of the code are really supported and
     expected to work without bugs;
   * disable unsupported/unstable features at build time;
   * disable test cases for known-broken parts of QEMU;
   * know if an user is relying on an unsupported or known-broken
     feature of QEMU.

Are there any additional use cases I forgot, here?


>=20
> > Deprecated code, on the other hand, is expected to be enabled at
> > build time even on enterprise distributions, and will definitely
> > require a mechanism to generate a warning at runtime.
> >=20
> >=20
> >>
> >> Adding any more nuanced states than this, though, risks making it to=
o
> >> difficult to make any informed decisions as a user, I think. This pa=
tch
> >> as-is maybe adds too many?
> >=20
> > Agreed.
> >=20
> >>
> >> --js
> >>
> >>>> diff --git a/util/Makefile.objs b/util/Makefile.objs
> >>>> index 0820923c18..6e5f8faf82 100644
> >>>> --- a/util/Makefile.objs
> >>>> +++ b/util/Makefile.objs
> >>>> @@ -50,5 +50,6 @@ util-obj-y +=3D range.o
> >>>> =A0 util-obj-y +=3D stats64.o
> >>>> =A0 util-obj-y +=3D systemd.o
> >>>> =A0 util-obj-y +=3D iova-tree.o
> >>>> +util-obj-y +=3D support-state.o
> >>>> =A0 util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
> >>>> =A0 util-obj-$(CONFIG_OPENGL) +=3D drm.o
> >>>>
> >>>
> >=20

--=20
Eduardo
