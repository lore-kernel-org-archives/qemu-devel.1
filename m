Received: from eggs.gnu.org ([2001:4830:134:3::10]:37153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSPOU-00050b-C1
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:37:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eSPOT-0002f1-9R
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:37:54 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1513790494.git.alistair.francis@xilinx.com>
	<6bad4084f4cbc290e2e9f1a72fcfcda7223383ec.1513790495.git.alistair.francis@xilinx.com>
Date: Fri, 22 Dec 2017 16:37:47 +0100
In-Reply-To: <6bad4084f4cbc290e2e9f1a72fcfcda7223383ec.1513790495.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Wed, 20 Dec 2017 09:23:01 -0800")
Message-ID: <87lghulqno.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 04/29] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair23@gmail.com, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Second thoughts...

Alistair Francis <alistair.francis@xilinx.com> writes:

> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
>
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|erro=
r_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_=
report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_repo=
rt("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report=
("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("=
\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1=
"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\=
2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2)=
;|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|=
Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig=
}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}'=
 \
>     {} +
>
> Some lines where then manually tweaked to pass checkpatch.
>
> The 'qemu: ' prefix was manually removed from the hw/arm/boot.c file.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: qemu-arm@nongnu.org
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> V6:
>  - Fix indendation
> V3:
>  - Remoave 'qemu: ' prefix
> V2:
>  - Split hw patch into individual directories
>
>  hw/arm/armv7m.c      |  2 +-
>  hw/arm/boot.c        | 37 ++++++++++++++++++-------------------
>  hw/arm/gumstix.c     | 13 +++++++------
>  hw/arm/mainstone.c   |  7 ++++---
>  hw/arm/musicpal.c    |  2 +-
>  hw/arm/omap1.c       |  5 +++--
>  hw/arm/omap2.c       | 23 ++++++++++++-----------
>  hw/arm/omap_sx1.c    |  8 +++-----
>  hw/arm/palm.c        | 10 +++++-----
>  hw/arm/pxa2xx.c      |  7 ++++---
>  hw/arm/stellaris.c   |  3 ++-
>  hw/arm/tosa.c        | 18 +++++++++---------
>  hw/arm/versatilepb.c |  2 +-
>  hw/arm/vexpress.c    |  8 ++++----
>  hw/arm/z2.c          |  6 +++---
>  15 files changed, 77 insertions(+), 74 deletions(-)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index bb2dfc942b..56770a7048 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -278,7 +278,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kern=
el_filename, int mem_size)
>  #endif
>=20=20
>      if (!kernel_filename && !qtest_enabled()) {
> -        fprintf(stderr, "Guest image must be specified (using -kernel)\n=
");
> +        error_report("Guest image must be specified (using -kernel)");
>          exit(1);
>      }
>=20=20

This is obviously a genuine (fatal) error.

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c2720c8046..6e6b8c0c6a 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -8,6 +8,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include <libfdt.h>
>  #include "hw/hw.h"
> @@ -418,13 +419,13 @@ static int load_dtb(hwaddr addr, const struct arm_b=
oot_info *binfo,
>          char *filename;
>          filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, binfo->dtb_file=
name);
>          if (!filename) {
> -            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_fi=
lename);
> +            error_report("Couldn't open dtb file %s", binfo->dtb_filenam=
e);
>              goto fail;
>          }

These is obviously a genuine (recoverable) error..

[More of the same...]
> diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
> index b53878b8b9..3a1d995d6a 100644
> --- a/hw/arm/omap2.c
> +++ b/hw/arm/omap2.c
> @@ -19,6 +19,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -1311,8 +1312,8 @@ static void omap_prcm_apll_update(struct omap_prcm_=
s *s)
>      /* TODO: update clocks */
>=20=20
>      if (mode[0] =3D=3D 1 || mode[0] =3D=3D 2 || mode[1] =3D=3D 1 || mode=
[1] =3D=3D 2)
> -        fprintf(stderr, "%s: bad EN_54M_PLL or bad EN_96M_PLL\n",
> -                        __func__);
> +        error_report("%s: bad EN_54M_PLL or bad EN_96M_PLL",
> +                     __func__);
>  }

This one's different: we neither exit() nor return a "failed" status to
the caller.

We get here when the guest writes something funny to a certain
memory-mapped I/O register.  In other words, it's guest misbehavior, not
a user error.  I doubt it should be reported with error_report().
Peter, do we have a canonical way to report or log  guest misbehavior?

[...]
