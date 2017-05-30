Received: from eggs.gnu.org ([2001:4830:134:3::10]:36197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFeup-00014g-N9
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dFeum-0000ZZ-JP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:02:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dFeum-0000ZA-B5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:02:16 -0400
Date: Tue, 30 May 2017 13:02:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170530130207.249299e7@nial.brq.redhat.com>
In-Reply-To: <1496140501.4100.5.camel@redhat.com>
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
	<1496140501.4100.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On Tue, 30 May 2017 12:35:01 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > >=C2=A0v2:
> > > =C2=A0- Deprecate machines up to pc-1.2
> > >=20
> > > =C2=A0hw/i386/pc_piix.c | 9 +++++++++
> > > =C2=A01 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index 9f102aa..aace378 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -38,6 +38,7 @@
> > > =C2=A0#include "sysemu/kvm.h"
> > > =C2=A0#include "hw/kvm/clock.h"
> > > =C2=A0#include "sysemu/sysemu.h"
> > > +#include "sysemu/qtest.h"
> > > =C2=A0#include "hw/sysbus.h"
> > > =C2=A0#include "sysemu/arch_init.h"
> > > =C2=A0#include "sysemu/block-backend.h"
> > > @@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *pci_memory;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *rom_memory;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_addr_t lowmem;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0char *mc_name =3D MACHINE_CLASS(pcmc)->name;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0/* Machines pc-0.10 up to pc-1.2 are conside=
red as deprecated
> > > */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (!qtest_enabled() && (!strncmp(mc_name, "=
pc-0.", 5)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (!strncmp(mc_name=
, "pc-1.", 5) && mc_name[5] < '3'))) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("Machin=
e type '%s' is deprecated, "
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"please use a n=
ewer type instead", mc_name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calculate ram split, for memory=
 below and above 4G.=C2=A0=C2=A0It's a
> > > bit
> > >  =20
> >=20
> > Ping! Any comments on this version of the patch? =20
>=20
> Does it make sense to build some infrastructure=C2=A0for this, so we don't
> have ad-hoc code to print deprecation warnings everywhere?
we are deprecating incomplete numa mapping but it uses 'obsoleted' word
somewhere in warning message (in machine_numa_finish_init).

it could be better if if we had error_report_depricated()
which would add prefix deprecated prefix consistently
something like: "DEPRECATED: "
=20
> Something like adding a "bool deprecated" or "char *deprecated_msg"
> field to MachineClass (and possibly elsewhere too, for example
> DeviceClass).
>=20
> cheers,
>   Gerd
>=20
