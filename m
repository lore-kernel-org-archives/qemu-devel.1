Received: from eggs.gnu.org ([2001:4830:134:3::10]:59435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJZb8-0006Nt-It
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJZb3-0003ZL-Hg
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 02:46:58 -0500
Date: Mon, 5 Nov 2018 08:46:24 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105074624.lgywax74xgukp4mu@sirius.home.kraxel.org>
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-2-kraxel@redhat.com>
	<8c224534-c929-7c7f-a126-a9390bbdb77f@redhat.com>
	<75690654-196d-f863-c58e-d23e2b33317a@redhat.com>
	<20181031180604.GN3902@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181031180604.GN3902@habkost.net>
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
Cc: John Snow <jsnow@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, Oct 31, 2018 at 03:06:04PM -0300, Eduardo Habkost wrote:
> On Wed, Oct 31, 2018 at 12:04:16PM -0400, John Snow wrote:
> >=20
> >=20
> > On 10/30/2018 09:32 AM, Philippe Mathieu-Daud=E9 wrote:
> > > Hi Gerd,
> > >=20
> > > On 30/10/18 12:13, Gerd Hoffmann wrote:
> > >> Indicates support state for somerhing (device, backend, subsystem,=
 ...)
> > >=20
> > > "something"
> > >=20
> > >> in qemu.=A0 Modeled roughly after the "S:" states we have in MAINT=
ANERS.
> > >>
> > >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >> ---
> > >> =A0 include/qemu/support-state.h | 17 +++++++++++++++++
> > >> =A0 util/support-state.c=A0=A0=A0=A0=A0=A0=A0=A0 | 23 ++++++++++++=
+++++++++++
> > >> =A0 qapi/common.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 16 ++++=
++++++++++++
> > >> =A0 util/Makefile.objs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > >> =A0 4 files changed, 57 insertions(+)
> > >> =A0 create mode 100644 include/qemu/support-state.h
> > >> =A0 create mode 100644 util/support-state.c
> > >>
> > >> diff --git a/include/qemu/support-state.h b/include/qemu/support-s=
tate.h
> > >> new file mode 100644
> > >> index 0000000000..5fd3c83eee
> > >> --- /dev/null
> > >> +++ b/include/qemu/support-state.h
> > >> @@ -0,0 +1,17 @@
> > >> +#ifndef QEMU_SUPPORT_STATE_H
> > >> +#define QEMU_SUPPORT_STATE_H
> > >> +
> > >> +#include "qapi/qapi-types-common.h"
> > >> +
> > >> +typedef struct QemuSupportState {
> > >> +=A0=A0=A0 SupportState state;
> > >> +=A0=A0=A0 const char *reason;
> > >> +} QemuSupportState;
> > >> +
> > >> +void qemu_warn_support_state(const char *type, const char *name,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QemuSupportState *state);
> > >> +
> > >> +bool qemu_is_deprecated(QemuSupportState *state);
> > >> +bool qemu_is_obsolete(QemuSupportState *state);
> > >> +
> > >> +#endif /* QEMU_SUPPORT_STATE_H */
> > >> diff --git a/util/support-state.c b/util/support-state.c
> > >> new file mode 100644
> > >> index 0000000000..7966fa0fc7
> > >> --- /dev/null
> > >> +++ b/util/support-state.c
> > >> @@ -0,0 +1,23 @@
> > >> +#include "qemu/osdep.h"
> > >> +#include "qemu/error-report.h"
> > >> +#include "qemu/support-state.h"
> > >> +
> > >> +void qemu_warn_support_state(const char *type, const char *name,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 QemuSupportState *state)
> > >> +{
> > >> +=A0=A0=A0 warn_report("%s %s is %s%s%s%s", type, name,
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SupportState_str(st=
ate->state),
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? " (=
"=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "",
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? sta=
te->reason : "",
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->reason ? ")"=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : "");
> > >> +}
> > >> +
> > >> +bool qemu_is_deprecated(QemuSupportState *state)
> > >> +{
> > >> +=A0=A0=A0 return state->state =3D=3D SUPPORT_STATE_DEPRECATED;
> > >> +}
> > >> +
> > >> +bool qemu_is_obsolete(QemuSupportState *state)
> > >> +{
> > >> +=A0=A0=A0 return state->state =3D=3D SUPPORT_STATE_OBSOLETE;
> > >> +}
> > >> diff --git a/qapi/common.json b/qapi/common.json
> > >> index 021174f04e..78176151af 100644
> > >> --- a/qapi/common.json
> > >> +++ b/qapi/common.json
> > >> @@ -151,3 +151,19 @@
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'ppc64', 'riscv32', 'ri=
scv64', 's390x', 'sh4',
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'sh4eb', 'sparc', 'spar=
c64', 'tricore', 'unicore32',
> > >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'x86_64', 'xtensa', 'xt=
ensaeb' ] }
> > >> +
> > >> +##
> > >> +# @SupportState:
> > >> +#
> > >> +# Indicate Support level of qemu devices, backends, subsystems, .=
..
> > >> +#
> > >> +# Since: 3.2
> > >> +##
> > >> +{ 'enum': 'SupportState',
> > >> +=A0 'data': [ 'unknown',
> > >=20
> > > 'unknown' is scary and should be fixed.
> > >=20
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'supported',
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'maintained',
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'odd-fixes',
> > >=20
> > > All those fit in 'supported'
> > >=20
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'orphan',
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'obsolete',
> > >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'deprecated' ] }
> > >=20
> > > And all those should appear as 'deprecated' IMHO.
> > >=20
> >=20
> > You've covered it a bit below, but I think we need more than "support=
ed"
> > and "deprecated" -- at *least* a third state "unsupported" is require=
d, IMO:
> >=20
> > - Supported: We expect this to work. We test this component. We will
> > ship CVE fixes in a timely manner for this component. You are, as a
> > user, using something that is cared for and you may rely on us to car=
e
> > for it.

supported + maintained.  Yes, merging them makes sense probably.

> > - Unsupported: We expect this to work, but nobody is tending to it
> > actively. It might be perfectly OK, but the tests and support may be
> > lacking. Try not to rely on this in an enterprise environment unless =
you
> > have resources to devote to caring for it personally. I'd count thing=
s
> > like Raspberry Pi boards in this category: they work, usually, but no=
t
> > fully. Some people are working on them, but they're not ready for pri=
me
> > time usage.
>=20
> I wonder: do we need a distinction between code that's
> unsupported and expected to be removed in the next versions of
> QEMU, and code that's unsupported but not planned to be removed
> yet?

odd-fixes + orphan would be the "not planned to be removed" bucket.
Maybe merge those too, from a user point of view there isn't much of
a difference.

obsolete is "likely to be put on deprecation schedule" ...

> > - Deprecated: This used to work, or used to be maintained, but has be=
en
> > superseded or is otherwise scheduled to be removed -- the expectation=
 is
> > that this device will get worse, not better. The device model may be
> > known to be incorrect, there may be major bugs, and it receives littl=
e
> > to no care or maintenance. Actively avoid using in an enterprise cont=
ext.

... for one of these reasons.

> Deprecated code, on the other hand, is expected to be enabled at
> build time even on enterprise distributions, and will definitely
> require a mechanism to generate a warning at runtime.

That sounds more like "obsolete".  "deprecated" would be "is on
deprecation schedule already".

cheers,
  Gerd
