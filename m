Received: from eggs.gnu.org ([2001:4830:134:3::10]:47646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edlmX-0005na-PJ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 18:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edlmU-0006T5-Lw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 18:45:41 -0500
Date: Tue, 23 Jan 2018 00:53:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180122135311.GD11419@umbus>
References: <1516571878-13321-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <1516571878-13321-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] ppc: Deprecate qemu-system-ppcemb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2018 at 10:57:58PM +0100, Thomas Huth wrote:
> qemu-system-ppcemb has been once split of qemu-system-ppc to support
> CPU page sizes < 4096 for some of the embedded 4xx PowerPC CPUs.
> However, there was hardly any OS available in the wild that really
> used such small page sizes (Linux uses 4096 on PPC), so there is
> no known recent use case for this separate build anymore. It's
> rather cumbersome to maintain a separate set of config switches for
> this, and it's wasting compile and test time of all the developers
> who have to build all QEMU targets to verify that their changes did
> not break anything.
>=20
> Except for the small CPU page sizes, qemu-system-ppc can be used as
> a full replacement for qemu-system-ppcemb since it contains all the
> embedded 4xx PPC boards and CPUs, too. Thus let's start the deprecation
> process for qemu-system-ppcemb to see whether somebody still needs
> the small page sizes or whether we could finally remove this unloved
> separate build.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  v3: Use qtest_enabled() and emit the deprecation message in the
>      machine init functions (I unfortunately haven't found a better
>      common spot for all 4xx machines where qtest_enabled() works).
>=20
>  hw/ppc/ppc405_boards.c | 14 ++++++++++++++
>  hw/ppc/ppc440_bamboo.c |  9 +++++++++
>  hw/ppc/virtex_ml507.c  |  8 ++++++++
>  qemu-doc.texi          |  6 ++++++
>  4 files changed, 37 insertions(+)
>=20
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index e92db2c..6f7f2ee 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -202,6 +202,13 @@ static void ref405ep_init(MachineState *machine)
>      DriveInfo *dinfo;
>      MemoryRegion *sysmem =3D get_system_memory();
> =20
> +#ifdef TARGET_PPCEMB
> +    if (!qtest_enabled()) {
> +        warn_report("qemu-system-ppcemb is deprecated, "
> +                    "please use qemu-system-ppc instead.");
> +    }
> +#endif
> +
>      /* XXX: fix this */
>      memory_region_allocate_system_memory(&ram_memories[0], NULL, "ef405e=
p.ram",
>                                           0x08000000);
> @@ -497,6 +504,13 @@ static void taihu_405ep_init(MachineState *machine)
>      int fl_idx, fl_sectors;
>      DriveInfo *dinfo;
> =20
> +#ifdef TARGET_PPCEMB
> +    if (!qtest_enabled()) {
> +        warn_report("qemu-system-ppcemb is deprecated, "
> +                    "please use qemu-system-ppc instead.");
> +    }
> +#endif
> +
>      /* RAM is soldered to the board so the size cannot be changed */
>      ram_size =3D 0x08000000;
>      memory_region_allocate_system_memory(ram, NULL, "taihu_405ep.ram",
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 693c215..a299206 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -13,6 +13,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/error-report.h"
>  #include "net/net.h"
>  #include "hw/hw.h"
>  #include "hw/pci/pci.h"
> @@ -27,6 +28,7 @@
>  #include "hw/ppc/ppc.h"
>  #include "ppc405.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
>  #include "hw/sysbus.h"
> =20
>  #define BINARY_DEVICE_TREE_FILE "bamboo.dtb"
> @@ -191,6 +193,13 @@ static void bamboo_init(MachineState *machine)
>          exit(1);
>      }
> =20
> +#ifdef TARGET_PPCEMB
> +    if (!qtest_enabled()) {
> +        warn_report("qemu-system-ppcemb is deprecated, "
> +                    "please use qemu-system-ppc instead.");
> +    }
> +#endif
> +
>      qemu_register_reset(main_cpu_reset, cpu);
>      ppc_booke_timers_init(cpu, 400000000, 0);
>      ppc_dcr_init(env, NULL, NULL);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 5ac4f76..9fe7655 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -29,6 +29,7 @@
>  #include "hw/char/serial.h"
>  #include "hw/block/flash.h"
>  #include "sysemu/sysemu.h"
> +#include "sysemu/qtest.h"
>  #include "hw/devices.h"
>  #include "hw/boards.h"
>  #include "sysemu/device_tree.h"
> @@ -210,6 +211,13 @@ static void virtex_init(MachineState *machine)
>      int kernel_size;
>      int i;
> =20
> +#ifdef TARGET_PPCEMB
> +    if (!qtest_enabled()) {
> +        warn_report("qemu-system-ppcemb is deprecated, "
> +                    "please use qemu-system-ppc instead.");
> +    }
> +#endif
> +
>      /* init CPUs */
>      cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_type, 40000000=
0);
>      env =3D &cpu->env;
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 3e9eb81..b13c633 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2766,6 +2766,12 @@ The ``host_net_remove'' command is replaced by the=
 ``netdev_del'' command.
>  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
>  or ``ivshmem-doorbell`` device types.
> =20
> +@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12=
=2E0)
> +
> +qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc6=
4)
> +should be used instead. That means that embedded 4xx PowerPC CPUs will n=
ot
> +support page sizes < 4096 any longer.
> +
>  @section System emulator machines
> =20
>  @subsection Xilinx EP108 (since 2.11.0)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpl7MEACgkQbDjKyiDZ
s5LuTA/+N/Bnhb6lkDSpRqkOl/7mXXBCwu0YPIVdrqtP4NZ48XYmd+yoSGIvloXO
zNbbjHjNDulbuvwtMhyeZRJRvhaKxQlt0yq7CxpL2vwO0uC8huRMtrCJTvU9wMoE
17TNLHPoxvG+6x5upUlcIqnnQISRLjOOC0c9viV8PZyrtg1/iRyUV/sNlUQy78Zo
PvxBysl9bKOX/6gVmbaysPDZCCD6K7LQcGVq3lG/wwTWIqO7QMi8Yd6m83sUWreP
9/COCWVuvTFG12QOc+VTMH0ptkzvrQmnz1SEh2B8mNuE83su/CYAmzItnsfw9ExB
h2L2iKVqVfWBjezp4XUVb93t27gb9VCkgbxwL75AAXTK9Wft2daDK1DeDXgNz6L/
krOAYvavoza23/gSH2v7+MhpEBG2gz2mY7aowWF0OWUIx9sUUBkL35q5QFmDYNin
G9DmPFY2+rELbkQT1Vv8+tzjGYYNka0Z75j+aCdeM7M7aL6YqE8n63VDdPGTsgEX
l7yDc3gjSMVBOTnTKJ2oAp+PC5NR90J7s57QFNORXPhftU2lPY+mPhFhvBrS8nnN
bCtYI5RhYPSWDp04XC8eFc3Mvg5VlAGuPmXGQY0Jg3yMLBCdNLxdCfbnPgErecUn
7Py90BvNh1vzTEIeRSa1YuDSphEPqul7HgHS/Ivl9VGkdyJoJeI=
=5iCk
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
