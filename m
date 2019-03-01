Received: from eggs.gnu.org ([209.51.188.92]:60504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzkuZ-00075I-Mf
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzkuR-0005XC-Ux
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:17 -0500
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
References: <155144987334.126105.2493613675615671242.stgit@bahia.lan>
Message-ID: <155145721677.30057.3700488922747499209@sif>
Date: Fri, 01 Mar 2019 10:20:16 -0600
Subject: Re: [Qemu-devel] [PATCH] spapr: Explicitly check machine support
 before using EVENT_CLASS_HOT_PLUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2019-03-01 08:17:53)
> Recent commit b8165118f52c "spapr: support memory unplug for qtest" broke
> CPU hotplug tests for old machine types:
> =

> $ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-te=
st -m=3Dslow
> /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=3D6: OK
> /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=3D6: **
> ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_=
source: assertion failed: (source->enabled)
> Broken pipe
> /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU de=
ath from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
> =

> The rtas_event_log_to_source() function is supposed to return the event
> source to be used for a given event type. In the case of hotplug, it first
> tries EVENT_CLASS_HOT_PLUG and, if the guest doesn't support it, it falls
> back to EVENT_CLASS_EPOW.
> =

> This works well for machine types that enable EVENT_CLASS_HOT_PLUG. For
> older machine types, this happened to work because they don't set the
> OV5_HP_EVT bit in spapr->ov5. CAS hence logically keeps the bit cleared
> in spapr->ov5_cas and we avoid the assert.
> =

> As shown by commit b8165118f52c, the logic is fragile and we need a
> bigger hammer to ensure that rtas_event_log_to_source() doesn't go
> down the EVENT_CLASS_HOT_PLUG path with older machine types.

I think that fact that we set spapr->ov5 based on relevant machine
options/support being there, and the fact that this means they won't
show up in ov5_cas, is a nice thing to assert and rely on, since being
able to rely on that keeps keeps the logic throughout the code tied to
ov5/ov5_cas and avoids the need to keep re-checking things like
spapr->use_hotplug_event_source (and various other options tied to an
OV5 capability) after init time.

I think this particular case is purely the result of us violating (via
b8165118f52c) the condition that bits that aren't ever set in spapr->ov5
should never end up in spapr->ov5_cas, and losing that precondition might
make the code harder to reason about since now we have to check both
ov5_cas and the related options (rather than 1 necessarilly following
from the other).

Another approach might be to revert b8165118f52c, and then add a hook for
qtest_enabled() that does a fake CAS negotiation (which I guess would
essentially involve copying spapr->ov5 into spapr->ov5_cas). This would
maintain the flow of machine options -> spapr->ov5 -> spapr->ov5_cas and
still let qtest do it's thing (AFAICT).

> =

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr_events.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index ab9a1f0063d5..1a09dab6857d 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -307,11 +307,13 @@ rtas_event_log_to_source(sPAPRMachineState *spapr, =
int log_type)
> =

>      switch (log_type) {
>      case RTAS_LOG_TYPE_HOTPLUG:
> -        source =3D spapr_event_sources_get_source(spapr->event_sources,
> -                                                EVENT_CLASS_HOT_PLUG);
> -        if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
> -            g_assert(source->enabled);
> -            break;
> +        if (spapr->use_hotplug_event_source) {
> +            source =3D spapr_event_sources_get_source(spapr->event_sourc=
es,
> +                                                    EVENT_CLASS_HOT_PLUG=
);
> +            if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
> +                g_assert(source->enabled);
> +                break;
> +            }
>          }
>          /* fall back to epow for legacy hotplug interrupt source */
>      case RTAS_LOG_TYPE_EPOW:
> =

>=20
