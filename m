Received: from eggs.gnu.org ([209.51.188.92]:52870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzX4p-0004Yq-AN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzX31-0002MQ-OL
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 20:33:13 -0500
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <ec8e11d1-c966-b814-98da-a6ab56572834@redhat.com>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
	<20190226045304.25618-41-david@gibson.dropbear.id.au>
	<ec8e11d1-c966-b814-98da-a6ab56572834@redhat.com>
Message-ID: <155140389645.9499.14782774845761701651@sif>
Date: Thu, 28 Feb 2019 19:31:36 -0600
Subject: Re: [Qemu-devel] [PULL 40/50] spapr_events: add support for phb
 hotplug events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, clg@kaod.org

Quoting Thomas Huth (2019-02-28 12:40:52)
> On 26/02/2019 05.52, David Gibson wrote:
> > From: Michael Roth <mdroth@linux.vnet.ibm.com>
> > =

> > Extend the existing EPOW event format we use for PCI
> > devices to emit PHB plug/unplug events.
> > =

> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Message-Id: <155059671405.1466090.535964535260503283.stgit@bahia.lab.to=
ulouse-stg.fr.ibm.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_events.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > =

> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index b9c7ecb9e9..ab9a1f0063 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -526,6 +526,9 @@ static void spapr_hotplug_req_event(uint8_t hp_id, =
uint8_t hp_action,
> >      case SPAPR_DR_CONNECTOR_TYPE_CPU:
> >          hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_CPU;
> >          break;
> > +    case SPAPR_DR_CONNECTOR_TYPE_PHB:
> > +        hp->hotplug_type =3D RTAS_LOG_V6_HP_TYPE_PHB;
> > +        break;
> >      default:
> >          /* we shouldn't be signaling hotplug events for resources
> >           * that don't support them
> =

> I think this patch (or something else in this PULL request) broke CPU
> hot-plugging with older machine types:
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

> Could you please have a look?

Bisected to:

  commit b8165118f52ce5ee88565d3cec83d30374efdc96
  Author: David Hildenbrand <david@redhat.com>
  Date:   Mon Feb 18 10:21:58 2019 +0100
  =

      spapr: support memory unplug for qtest
      =

      Fake availability of OV5_HP_EVT, so we can test memory unplug in qtes=
t.

Which makes sense since OV5_HP_EVT assumes that
spapr->spapr->use_hotplug_event_source =3D=3D true, which isn't the default=
 for
2.7 and below.

If I revert that I think I hit the bug it was meant to fix:

  mdroth@sif:~/w/qemu-build3$ make V=3D1 check-qtest-ppc64
  ...
  PASS 1 device-plug-test /ppc64/device-plug/pci-unplug-request
  PASS 2 device-plug-test /ppc64/device-plug/spapr-cpu-unplug-request
  **
  ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c:28:device_del_fin=
ish: assertion failed: (qdict_haskey(resp, "return"))
  ERROR - Bail out! ERROR:/home/mdroth/w/qemu3.git/tests/device-plug-test.c=
:28:device_del_finish: assertion failed: (qdict_haskey(resp, "return"))
  Aborted (core dumped)
  /home/mdroth/w/qemu3.git/tests/Makefile.include:875: recipe for target 'c=
heck-qtest-ppc64' failed
  make: *** [check-qtest-ppc64] Error 1
  mdroth@sif:~/w/qemu-build3$

Which is probably due to this check in spapr_machine_device_unplug_request(=
):

    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
        if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
            spapr_memory_unplug_request(hotplug_dev, dev, errp);
        } else {
            /* NOTE: this means there is a window after guest reset, prior =
to
             * CAS negotiation, where unplug requests will fail due to the
             * capability not being detected yet. This is a bit different t=
han
             * the case with PCI unplug, where the events will be queued and
             * eventually handled by the guest after boot
             */
            error_setg(errp, "Memory hot unplug not supported for this gues=
t");
        }



This spapr-cpu-unplug-request test is failing because
spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT) relies on the CAS-negotiated OV5 =
bit,
which wouldn't have happened with qtest. If we want to make these tests run=
 in
this scenario we probably need a different approach than the original patch.

> =

>  Thomas
>=20
