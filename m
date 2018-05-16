Received: from eggs.gnu.org ([2001:4830:134:3::10]:34526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fIpvW-0005Io-A7
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:28:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fIpvS-0002Im-52
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:28:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:4802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fIpvR-0002HS-PV
	for qemu-devel@nongnu.org; Wed, 16 May 2018 02:28:38 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Wed, 16 May 2018 06:28:32 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D3526A2004@SHSMSX103.ccr.corp.intel.com>
References: <1525854869-13975-1-git-send-email-jingqi.liu@intel.com>
	<20180515163549.2389fc70@redhat.com>
In-Reply-To: <20180515163549.2389fc70@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/7] hmat acpi: Build Memory Subsystem
 Address Range Structre(s) in ACPI HMAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>

On Tue, May 15, 2018 10:36 PM, Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed,  9 May 2018 16:34:29 +0800
> Liu Jingqi <jingqi.liu@intel.com> wrote:
>=20
> > HMAT is defined in ACPI 6.2: 5.2.27 Heterogeneous Memory Attribute Tabl=
e
> (HMAT).
> > The specification references below link:
> > http://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
> >
> > It describes the memory attributes, such as memory side cache
> > attributes and bandwidth and latency details, related to the System
> > Physical Address (SPA) Memory Ranges. The software is expected to use
> > this information as hint for optimization.
> >
> > This structure describes the System Physical Address(SPA) range
> > occupied by memory subsystem and its associativity with processor
> > proximity domain as well as hint for memory usage.
> >
> > Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> > ---
> >  default-configs/x86_64-softmmu.mak |   1 +
> >  hw/acpi/Makefile.objs              |   1 +
> >  hw/acpi/hmat.c                     | 174
> +++++++++++++++++++++++++++++++++++++
> >  hw/acpi/hmat.h                     |  75 ++++++++++++++++
> >  hw/i386/acpi-build.c               |   3 +
> >  5 files changed, 254 insertions(+)
> >  create mode 100644 hw/acpi/hmat.c
> >  create mode 100644 hw/acpi/hmat.h
> >
> > diff --git a/default-configs/x86_64-softmmu.mak
> > b/default-configs/x86_64-softmmu.mak
> > index 0390b43..3b4a37d 100644
> > --- a/default-configs/x86_64-softmmu.mak
> > +++ b/default-configs/x86_64-softmmu.mak
> > @@ -66,3 +66,4 @@ CONFIG_I2C=3Dy
> >  CONFIG_SEV=3D$(CONFIG_KVM)
> >  CONFIG_VTD=3Dy
> >  CONFIG_AMD_IOMMU=3Dy
> > +CONFIG_ACPI_HMAT=3Dy
> > diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs index
> > 11c35bc..21889fd 100644
> > --- a/hw/acpi/Makefile.objs
> > +++ b/hw/acpi/Makefile.objs
> > @@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D
> > memory_hotplug.o
> >  common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
> >  common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
> >  common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
> > +common-obj-$(CONFIG_ACPI_HMAT) +=3D hmat.o
> >  common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
> >
> >  common-obj-y +=3D acpi_interface.o
> > diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c new file mode 100644
> > index 0000000..bca1fbb
> > --- /dev/null
> > +++ b/hw/acpi/hmat.c
> > @@ -0,0 +1,174 @@
> > +/*
> > + * HMAT ACPI Implementation
> > + *
> > + * Copyright(C) 2018 Intel Corporation.
> > + *
> > + * Author:
> > + *  Liu jingqi <jingqi.liu@linux.intel.com>
> > + *
> > + * HMAT is defined in ACPI 6.2.
> > + *
> > + * This library is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU Lesser General Public
> > + * License as published by the Free Software Foundation; either
> > + * version 2 of the License, or (at your option) any later version.
> > + *
> > + * This library is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + * Lesser General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU Lesser General Public
> > + * License along with this library; if not, see
> > +<http://www.gnu.org/licenses/>  */
> > +
> > +#include "unistd.h"
> > +#include "fcntl.h"
> > +#include "qemu/osdep.h"
> > +#include "sysemu/numa.h"
> > +#include "hw/i386/pc.h"
> > +#include "hw/acpi/acpi.h"
> > +#include "hw/acpi/hmat.h"
> > +#include "hw/acpi/aml-build.h"
> > +#include "hw/nvram/fw_cfg.h"
> > +#include "hw/acpi/bios-linker-loader.h"
> > +
> > +#define HOLE_640K_START  (640 * 1024)
> > +#define HOLE_640K_END    (1024 * 1024)
> > +
> > +uint32_t initiator_pxm[MAX_NODES], target_pxm[MAX_NODES]; uint32_t
> > +num_initiator =3D 0, num_target =3D 0;
> > +
> > +static void hmat_build_spa_info(AcpiHmatSpaRange *spa,
> > +                                uint64_t base, uint64_t length, int
> > +node) {
> > +    int i;
> > +
> > +    spa->type       =3D ACPI_HMAT_SPA;
> > +    spa->length     =3D sizeof(*spa);
> > +    spa->spa_base   =3D base;
> > +    spa->spa_length =3D length;
> all of above will break on big-endian host, that's one of the reasons we =
prefer
> new code/tables to use build_append_foo() API.
>=20
> Pls rewrite it using preferred build_append_int_noprefix() API,
> build_amd_iommu() can serve as an example.
>=20
> As comments above fields use exact field names from spec tables so one co=
uld
> easily match spec vs code.
>=20
Thanks for your reviewing.
I will use preferred build_append_int_noprefix() API in next version.
Jingqi Liu
