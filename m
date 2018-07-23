Received: from eggs.gnu.org ([2001:4830:134:3::10]:37261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fhf03-0004aM-1q
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fhezz-0001rQ-U7
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:51:59 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:47802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fhezz-0001pK-LG
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:51:55 -0400
Received: from player772.ha.ovh.net (unknown [10.109.146.211])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3251BD8212
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 19:51:45 +0200 (CEST)
Date: Mon, 23 Jul 2018 19:51:38 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180723195138.00672525@bahia>
In-Reply-To: <821367d0-c3ef-43bd-071c-b2ff50dae7bd@kaod.org>
References: <153138970964.331720.14349788349972574256.stgit@bahia>
	<821367d0-c3ef-43bd-071c-b2ff50dae7bd@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: fix ICP reset path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

On Mon, 23 Jul 2018 13:36:36 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 07/12/2018 12:01 PM, Greg Kurz wrote:
> > Recent cleanup in commit a028dd423ee6 dropped the ICPStateClass::reset
> > handler. It is now up to child ICP classes to call the DeviceClass::res=
et
> > handler of the parent class, thanks to device_class_set_parent_reset().
> > This is a better object programming pattern, =20
>=20
> I think that the device_class_set_parent* routines just obfuscate a little
> more the object programming approach of QEMU.=20
>=20

Really ?

> > but unfortunately it causes QEMU to crash during CPU hotplug: =20
>=20
> I guess I did not try that :/ Would it be complex to add a spapr unit tes=
t=20
> for CPU hotplug ? It would be useful.
>=20

Actually, there's one in tests/cpu-plug-test.c but it runs with
accel=3Dqtest, and thus it doesn't exercise the KVM ICP code.

I've patched it to use accel=3Dkvm:tcg on pseries: it would have caught
the SEGV indeed. There's another problem though: QEMU sometimes stays=20
stuck in kvm_vcpu_ioctl() in 'disk sleep' state, causing the test
to hang until someone kills QEMU with SIGKILL.

Not sure yet what's happening...

> > (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> > Segmentation fault (core dumped)
> >=20
> > When the hotplug path tries to reset the ICP device, we end up calling:
> >=20
> > static void icp_kvm_reset(DeviceState *dev)
> > {
> >     ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> >=20
> >     icpc->parent_reset(dev);
> >=20
> > but icpc->parent_reset is NULL... This happens because icp_kvm_class_in=
it()
> > calls:
> >=20
> >     device_class_set_parent_reset(dc, icp_kvm_reset,
> >                                   &icpc->parent_reset);
> >=20
> > but dc->reset, ie, DeviceClass::reset for the TYPE_ICP type, is
> > itself NULL.>
> > This patch hence sets DeviceClass::reset for the TYPE_ICP type to
> > point to icp_reset(). It then registers a reset handler that calls
> > DeviceClass::reset. If the ICP subtype has configured its own reset
> > handler with device_class_set_parent_reset(), this ensures it will
> > be called first and it can then call ICPStateClass::parent_reset
> > safely. This fixes the reset path for the TYPE_KVM_ICP type, which
> > is the only subtype that defines its own reset function. =20
>=20
> So, now, isn't ICP reset called twice on KVM ?=20
>=20

No. We have one path for cold plugged CPUS:

#0  icp_reset (dev=3D0x113db100) at /home/greg/Work/qemu/qemu-spapr/hw/intc=
/xics.c:296
#1  0x0000000010146d0c in icp_kvm_reset (dev=3D0x113db100) at /home/greg/Wo=
rk/qemu/qemu-spapr/hw/intc/xics_kvm.c:121
#2  0x00000000101434b0 in icp_reset_handler (dev=3D0x113db100) at /home/gre=
g/Work/qemu/qemu-spapr/hw/intc/xics.c:310
#3  0x00000000104c3744 in qemu_devices_reset () at /home/greg/Work/qemu/qem=
u-spapr/hw/core/reset.c:69
#4  0x00000000101d61c8 in spapr_machine_reset () at /home/greg/Work/qemu/qe=
mu-spapr/hw/ppc/spapr.c:1639
#5  0x00000000103de654 in qemu_system_reset (reason=3DSHUTDOWN_CAUSE_NONE) =
at /home/greg/Work/qemu/qemu-spapr/vl.c:1645
...

and one path for hot plugged CPUs:

#0  icp_reset (dev=3D0x11268e40) at /home/greg/Work/qemu/qemu-spapr/hw/intc=
/xics.c:296
#1  0x0000000010146d0c in icp_kvm_reset (dev=3D0x11268e40) at /home/greg/Wo=
rk/qemu/qemu-spapr/hw/intc/xics_kvm.c:121
#2  0x00000000104be300 in device_reset (dev=3D0x11268e40) at /home/greg/Wor=
k/qemu/qemu-spapr/hw/core/qdev.c:1082
#3  0x00000000104bd62c in device_set_realized (obj=3D0x11268e40, value=3Dtr=
ue, errp=3D0x7fffffffcfa8) at /home/greg/Work/qemu/qemu-spapr/hw/core/qdev.=
c:867
...

> Anyway, we can sort that out if necessary.
>=20
> Thanks,
>=20
> C.
> =20
> > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > Fixes: a028dd423ee6dfd091a8c63028240832bf10f671
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/intc/xics.c |   14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > index b9f1a3c97214..c90c893228dc 100644
> > --- a/hw/intc/xics.c
> > +++ b/hw/intc/xics.c
> > @@ -291,7 +291,7 @@ static const VMStateDescription vmstate_icp_server =
=3D {
> >      },
> >  };
> > =20
> > -static void icp_reset(void *dev)
> > +static void icp_reset(DeviceState *dev)
> >  {
> >      ICPState *icp =3D ICP(dev);
> > =20
> > @@ -303,6 +303,13 @@ static void icp_reset(void *dev)
> >      qemu_set_irq(icp->output, 0);
> >  }
> > =20
> > +static void icp_reset_handler(void *dev)
> > +{
> > +    DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
> > +
> > +    dc->reset(dev);
> > +}
> > +
> >  static void icp_realize(DeviceState *dev, Error **errp)
> >  {
> >      ICPState *icp =3D ICP(dev);
> > @@ -345,7 +352,7 @@ static void icp_realize(DeviceState *dev, Error **e=
rrp)
> >          return;
> >      }
> > =20
> > -    qemu_register_reset(icp_reset, dev);
> > +    qemu_register_reset(icp_reset_handler, dev);
> >      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, ic=
p);
> >  }
> > =20
> > @@ -354,7 +361,7 @@ static void icp_unrealize(DeviceState *dev, Error *=
*errp)
> >      ICPState *icp =3D ICP(dev);
> > =20
> >      vmstate_unregister(NULL, &vmstate_icp_server, icp);
> > -    qemu_unregister_reset(icp_reset, dev);
> > +    qemu_unregister_reset(icp_reset_handler, dev);
> >  }
> > =20
> >  static void icp_class_init(ObjectClass *klass, void *data)
> > @@ -363,6 +370,7 @@ static void icp_class_init(ObjectClass *klass, void=
 *data)
> > =20
> >      dc->realize =3D icp_realize;
> >      dc->unrealize =3D icp_unrealize;
> > +    dc->reset =3D icp_reset;
> >  }
> > =20
> >  static const TypeInfo icp_info =3D {
> >  =20
>=20
