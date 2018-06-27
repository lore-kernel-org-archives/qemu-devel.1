Received: from eggs.gnu.org ([2001:4830:134:3::10]:59909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYC63-0002Gb-8U
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYC60-00008A-J8
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:11:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYC60-00007W-D0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:11:00 -0400
Date: Wed, 27 Jun 2018 17:10:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627171057.3e030eca@redhat.com>
In-Reply-To: <CAJ+F1C+5nS6DbFO4a2==j4b2w__Uh3WySEDqCyoEcMcCqWdY+Q@mail.gmail.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-3-marcandre.lureau@redhat.com>
	<20180627134438.3016259b@redhat.com>
	<d5dd8b75-377a-4e68-59e6-49b1d3e2176e@linux.vnet.ibm.com>
	<20180627161914.024ddd2b@redhat.com>
	<CAJ+F1C+5nS6DbFO4a2==j4b2w__Uh3WySEDqCyoEcMcCqWdY+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/4] tpm: implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, 27 Jun 2018 16:29:51 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> On Wed, Jun 27, 2018 at 4:19 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
> > On Wed, 27 Jun 2018 08:53:28 -0400
> > Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> > =20
> >> On 06/27/2018 07:44 AM, Igor Mammedov wrote: =20
> >> > On Tue, 26 Jun 2018 14:23:41 +0200
> >> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >> > =20
> >> >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >>
> >> >> Implement a virtual memory device for the TPM Physical Presence int=
erface.
> >> >> The memory is located at 0xFED45000 and used by ACPI to send messag=
es to the
> >> >> firmware (BIOS) and by the firmware to provide parameters for each =
one of
> >> >> the supported codes.
> >> >>
> >> >> This device should be used by all TPM interfaces on x86 and can be =
added
> >> >> by calling tpm_ppi_init_io().
> >> >>
> >> >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> >>
> >> >> ---
> >> >>
> >> >> v4 (Marc-Andr=C3=A9):
> >> >>   - pass TPM_PPI_ADDR_BASE as argument to tpm_ppi_init_io()
> >> >>   - only enable PPI if property is set
> >> >>
> >> >> v3 (Marc-Andr=C3=A9):
> >> >>   - merge CRB support
> >> >>   - use trace events instead of DEBUG printf
> >> >>   - headers inclusion simplification
> >> >>
> >> >> v2:
> >> >>   - moved to byte access since an infrequently used device;
> >> >>     this simplifies code
> >> >>   - increase size of device to 0x400
> >> >>   - move device to 0xfffef000 since SeaBIOS has some code at 0xffff=
0000:
> >> >>     'On the emulators, the bios at 0xf0000 is also at 0xffff0000'
> >> >> ---
> >> >>   hw/tpm/tpm_ppi.h      | 27 ++++++++++++++++++++
> >> >>   include/hw/acpi/tpm.h |  6 +++++
> >> >>   hw/tpm/tpm_crb.c      |  7 ++++++
> >> >>   hw/tpm/tpm_ppi.c      | 57 ++++++++++++++++++++++++++++++++++++++=
+++++
> >> >>   hw/tpm/tpm_tis.c      |  7 ++++++
> >> >>   hw/tpm/Makefile.objs  |  2 +-
> >> >>   hw/tpm/trace-events   |  4 +++
> >> >>   7 files changed, 109 insertions(+), 1 deletion(-)
> >> >>   create mode 100644 hw/tpm/tpm_ppi.h
> >> >>   create mode 100644 hw/tpm/tpm_ppi.c
> >> >>
> >> >> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> >> >> new file mode 100644
> >> >> index 0000000000..ac7ad47238
> >> >> --- /dev/null
> >> >> +++ b/hw/tpm/tpm_ppi.h
> >> >> @@ -0,0 +1,27 @@
> >> >> +/*
> >> >> + * TPM Physical Presence Interface
> >> >> + *
> >> >> + * Copyright (C) 2018 IBM Corporation
> >> >> + *
> >> >> + * Authors:
> >> >> + *  Stefan Berger    <stefanb@us.ibm.com>
> >> >> + *
> >> >> + * This work is licensed under the terms of the GNU GPL, version 2=
 or later.
> >> >> + * See the COPYING file in the top-level directory.
> >> >> + */
> >> >> +#ifndef TPM_TPM_PPI_H
> >> >> +#define TPM_TPM_PPI_H
> >> >> +
> >> >> +#include "hw/acpi/tpm.h"
> >> >> +#include "exec/address-spaces.h"
> >> >> +
> >> >> +typedef struct TPMPPI {
> >> >> +    MemoryRegion mmio;
> >> >> +
> >> >> +    uint8_t ram[TPM_PPI_ADDR_SIZE];
> >> >> +} TPMPPI; =20
> >> > I probably miss something obvious here,
> >> > 1st:
> >> > commit message says that memory reion is supposed to be interface
> >> > between FW and OSPM (i.e. totally guest internal thingy).
> >> > So question is:
> >> >    why do we register memory region at all? =20
> >>
> >> One reason for the device itself was being able to debug the interacti=
on
> >> of the guest with ACPI though I had additional instrumentation for that
> >> showing register contents.
> >> We need it to have some memory in the region where we place it. I
> >> suppose a memory_region_init_ram() would provide migration support
> >> automatically but cannot be used on memory where we have
> >> MemoryRegionOps. So we could drop most parts of the device and only run
> >> memory_region_init_ram() ? =20
> > if QEMU doesn't need to touch it ever, you could do even better.
> > Use bios_linker to make FW allocate a reserved portion if guest RAM and
> > patch TPM aml code with allocated address. Then you won't have to worry
> > about migration as reserved area is already migrated as part of RAM. =20
>=20
> The location needs to be fixed across reboots (or content moved
> somehow..) And timing-wise, I am not sure the ACPI tables are
> installed and processed by firmware before the TPM PPI operation must
> be handled.
true,
maybe add a note/reason to commit message why bios_linker couldn't be used,
to prevent the same question being raised again or wasting cycles on
'optimizing' code later with bios_linker when nobody recalls why it can't b=
e used.

>=20
> >
> > Huge benefit here is that QEMU doesn't dictate address so no chance
> > of conflicts and related compat hacks in case we have to move it.
> >
> > To do it easily, I'd suggest to extract TPM from DSDT into a dedicated
> > SSDT table (see vmgenid_build_acpi() as example /you don't need
> > bios_linker_loader_write_pointer() part, later we can use it if
> > it would be necessary for QEMU to know address/)
> > =20
> >>     Stefan
> >> =20
> >
> > =20
>=20
>=20
>=20
