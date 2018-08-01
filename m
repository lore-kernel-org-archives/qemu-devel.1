Received: from eggs.gnu.org ([2001:4830:134:3::10]:45374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkrI0-0006nK-Tx
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fkrHw-0008P8-0Q
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:44 -0400
Received: from 8.mo1.mail-out.ovh.net ([178.33.110.239]:59687)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fkrHv-0008On-QR
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:35:39 -0400
Received: from player737.ha.ovh.net (unknown [10.109.160.93])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id E8C601173BC
	for <qemu-devel@nongnu.org>; Wed,  1 Aug 2018 15:35:37 +0200 (CEST)
Date: Wed, 1 Aug 2018 15:35:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180801153531.0585b914@bahia.lan>
In-Reply-To: <20180731032715.GI2708@umbus.fritz.box>
References: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
	<20180727052724.GJ3694@umbus.fritz.box>
	<20180727095452.45edee8b@bahia>
	<20180730055715.GD2708@umbus.fritz.box>
	<20180730104145.109ef196@bahia.lan>
	<20180730115900.0ba16809@bahia.lan>
	<20180731032715.GI2708@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/dq+4NIq51aEDA3DO45XOVuj";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU
 hotplug on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?Q8Op?= =?UTF-8?B?ZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/dq+4NIq51aEDA3DO45XOVuj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 31 Jul 2018 13:27:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 30, 2018 at 11:59:00AM +0200, Greg Kurz wrote:
> > On Mon, 30 Jul 2018 10:41:45 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > On Mon, 30 Jul 2018 15:57:15 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote: =20
> > [...] =20
> > > > > > I'm pretty sure trying to change the accelerator on a qtest tes=
t just
> > > > > > doesn't make sense.  We'd need a different approach for testing=
 cpu
> > > > > > hotplug against kvm & tcg backends.
> > > > > >      =20
> > > > >=20
> > > > > The test starts QEMU, triggers the CPU hotplug code with a QMP co=
mmand
> > > > > and checks the command didn't fail (or QEMU didn't crash, as it w=
ould
> > > > > have before commit b585395b655a)... I really don't understand what
> > > > > is wrong with that... Please elaborate.     =20
> > > >=20
> > > > Well, ok, let me turn that around.  A test that doesn't rely on
> > > > controlling the guest side behaviour at all probably shouldn't be a
> > > > qtest based test, since that's what qtest is all about.
> > > >    =20
> > >=20
> > > The CPU hotplug test doesn't seem to do anything on the guest side: it
> > > just checks that 'device_add' returns a response that isn't an error.
> > > I'm not aware that the guest is expected to have a specific behavior
> > > during 'device_add', apart from not crashing or hanging. That was the
> > > initial idea behind passing '-S' to ensure the guest doesn't run.
> > >=20
> > > Your remark seems to be more general though... are you meaning that
> > > doing something like qtest_start("-machine accel=3Dkvm:tcg") is just
> > > wrong ? =20
> >=20
> > The purpose of this test is simply to exercise a path in QEMU that
> > is only used with KVM, but it can also be achieved the other way
> > around:
> >=20
> > @@ -189,7 +190,7 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> >      Error *local_err =3D NULL;
> > =20
> > -    if (kvm_enabled()) {
> > +    if (kvm_enabled() || qtest_enabled()) {
> >          if (machine_kernel_irqchip_allowed(machine) &&
> >              !xics_kvm_init(spapr, &local_err)) {
> >=20
> > This will test the setup of the in-kernel XICS when run on a book3s hos=
t,
> > and fallback to emulated XICS otherwise (eg, travis).
> >=20
> > Would this be more acceptable ? =20
>=20
> No, I don't think that will work.  With this we call into kvm related
> code via machine_kernel_irqchip_allowed() and xics_kvm_init() even in
> the qtest case.  If they work on a host which doesn't have KVM (say
> x86) it will only be by sheer accident.
>=20

It's the other way around actually. The expected behaviour would be
for machine_kernel_irqchip_allowed(machine) and/or xics_kvm_init()
to fail and to fallback to emulated XICS if run without a proper KVM.
This means no behavior change for this test when run on a x86 host.

The issue is when we run this with KVM actually, because the XICS KVM
code obviously needs... KVM to be initialized, which won't happen
with qtest :)

--Sig_/dq+4NIq51aEDA3DO45XOVuj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlthtyMACgkQcdTV5YIv
c9Z4+BAAvJ2CXoufv6lIq0OCFtDH047+wVeFSwwO02EbHWDEpXuiEocHrV49GSNc
zpjyBqKAGUJjM8HVOS36X4R2WwWK4siukuW5ayQcmpbd7R2HsMXvDR0ccmcCLJWO
r+OXXXTE2V96edfta2G1mAH5ulBV3kZNj3Jum2xBjzg8nxQfAzOnAqaVZTjZJPFq
J9+jppQj1GR47kyUKX856ZP9FeCFn7KpfVelbwzy0F/vVUrIibZWxWnrFsla7xLR
G+wkbAuRN+vISk8PDMSiWqU12yMZ0A+K5iQ9ktbwJZ5JM7AQPnd1WkNaBowjmKDL
NTYNVxdUskedt7djdAadj5eqJ8lZMS56inOi4XZMm64+nq/xwUvYonuGAh2HmYGa
AIWqj7GV6SqhxeHIlhsP8RNKZcQo4mdgupi2MW+X/jq55R3nRYG/zgVwfBvUf4RI
f2PxWe5aQX1jhMGeDa3ZM7Hk9B9gPu0w1UqE1CRgQBY87y+JzT3Ai3JN+LGIifZo
psO+mbJSQTfEWY2QmqAKtAwmOVc34he5FAUEFvmlbrWt35l/V/rK2qGUHVrnX1fl
b5nA5/06cxa/gYF1VqwLTeeNmkngodMXeIb3wIYL7YPTPht6zQdYl/WxBtFMdX9z
lpKI7tLJaOS5KM+b7II3sYbtKpf+lMY4dxrknGaXmRHR1FvfXpM=
=kygU
-----END PGP SIGNATURE-----

--Sig_/dq+4NIq51aEDA3DO45XOVuj--
