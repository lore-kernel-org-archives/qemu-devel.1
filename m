Received: from eggs.gnu.org ([2001:4830:134:3::10]:58497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFeUZ-0004tP-8G
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFeUU-0000zu-D5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:35:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFeUU-0000zW-7g
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:35:06 -0400
Message-ID: <1496140501.4100.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 May 2017 12:35:01 +0200
In-Reply-To: <40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

  Hi,

> >=C2=A0v2:
> > =C2=A0- Deprecate machines up to pc-1.2
> >=20
> > =C2=A0hw/i386/pc_piix.c | 9 +++++++++
> > =C2=A01 file changed, 9 insertions(+)
> >=20
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 9f102aa..aace378 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -38,6 +38,7 @@
> > =C2=A0#include "sysemu/kvm.h"
> > =C2=A0#include "hw/kvm/clock.h"
> > =C2=A0#include "sysemu/sysemu.h"
> > +#include "sysemu/qtest.h"
> > =C2=A0#include "hw/sysbus.h"
> > =C2=A0#include "sysemu/arch_init.h"
> > =C2=A0#include "sysemu/block-backend.h"
> > @@ -84,6 +85,14 @@ static void pc_init1(MachineState *machine,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *pci_memory;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MemoryRegion *rom_memory;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ram_addr_t lowmem;
> > +=C2=A0=C2=A0=C2=A0=C2=A0char *mc_name =3D MACHINE_CLASS(pcmc)->name;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0/* Machines pc-0.10 up to pc-1.2 are considere=
d as deprecated
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0if (!qtest_enabled() && (!strncmp(mc_name, "pc=
-0.", 5)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (!strncmp(mc_name, =
"pc-1.", 5) && mc_name[5] < '3'))) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_report("Machine =
type '%s' is deprecated, "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"please use a newe=
r type instead", mc_name);
> > +=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Calculate ram split, for memory b=
elow and above 4G.=C2=A0=C2=A0It's a
> > bit
> >=20
>=20
> Ping! Any comments on this version of the patch?

Does it make sense to build some infrastructure=C2=A0for this, so we don't
have ad-hoc code to print deprecation warnings everywhere?

Something like adding a "bool deprecated" or "char *deprecated_msg"
field to MachineClass (and possibly elsewhere too, for example
DeviceClass).

cheers,
  Gerd
