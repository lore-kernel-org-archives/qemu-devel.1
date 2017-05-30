Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFi7f-0002oS-Ok
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFi7e-0007m6-SR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dFi7e-0007kp-Kj
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:27:46 -0400
Date: Tue, 30 May 2017 11:27:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530142732.GK32274@thinpad.lan.raisama.net>
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
	<1496140501.4100.5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1496140501.4100.5.camel@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, May 30, 2017 at 12:35:01PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > >=A0v2:
> > > =A0- Deprecate machines up to pc-1.2
> > >=20
> > > =A0hw/i386/pc_piix.c | 9 +++++++++
> > > =A01 file changed, 9 insertions(+)
> > >=20
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index 9f102aa..aace378 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -38,6 +38,7 @@
> > > =A0#include "sysemu/kvm.h"
> > > =A0#include "hw/kvm/clock.h"
> > > =A0#include "sysemu/sysemu.h"
> > > +#include "sysemu/qtest.h"
> > > =A0#include "hw/sysbus.h"
> > > =A0#include "sysemu/arch_init.h"
> > > =A0#include "sysemu/block-backend.h"
> > > @@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
> > > =A0=A0=A0=A0=A0MemoryRegion *pci_memory;
> > > =A0=A0=A0=A0=A0MemoryRegion *rom_memory;
> > > =A0=A0=A0=A0=A0ram_addr_t lowmem;
> > > +=A0=A0=A0=A0char *mc_name =3D MACHINE_CLASS(pcmc)->name;
> > > +
> > > +=A0=A0=A0=A0/* Machines pc-0.10 up to pc-1.2 are considered as dep=
recated
> > > */
> > > +=A0=A0=A0=A0if (!qtest_enabled() && (!strncmp(mc_name, "pc-0.", 5)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0|| (!strncmp(mc_name, "pc-1.", 5) && mc_na=
me[5] < '3'))) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0error_report("Machine type '%s' is depreca=
ted, "
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"pl=
ease use a newer type instead", mc_name);
> > > +=A0=A0=A0=A0}
> > > =A0
> > > =A0=A0=A0=A0=A0/*
> > > =A0=A0=A0=A0=A0=A0* Calculate ram split, for memory below and above=
 4G.=A0=A0It's a
> > > bit
> > >=20
> >=20
> > Ping! Any comments on this version of the patch?
>=20
> Does it make sense to build some infrastructure=A0for this, so we don't
> have ad-hoc code to print deprecation warnings everywhere?
>=20
> Something like adding a "bool deprecated" or "char *deprecated_msg"
> field to MachineClass (and possibly elsewhere too, for example
> DeviceClass).

I would prefer that.  And as our class_init
(pc_*_machine_options()) functions already call their successors,
we would need only one deprecated=3Dtrue line in the code (at
pc_i440fx_1_3_machine_options()).

It's probably a good idea to report the deprecated flag on the
'query-machines' QMP command too.

--=20
Eduardo
