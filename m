Received: from eggs.gnu.org ([2001:4830:134:3::10]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckw8s-0006jp-VM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:09:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1ckw8s-0000RA-3Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 12:09:50 -0500
Date: Mon, 6 Mar 2017 19:09:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170306170932.oj5fndc6rbbawzpr@kozik-lap>
References: <20170305214857.9510-1-krzk@kernel.org>
	<67b0d01e-219a-9df6-1e46-f763e879e767@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <67b0d01e-219a-9df6-1e46-f763e879e767@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/3] hw/arm/exynos: Convert
 fprintf to error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On Sun, Mar 05, 2017 at 06:56:09PM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Krzysztof,
>=20
> On 03/05/2017 06:48 PM, Krzysztof Kozlowski wrote:
> > error_report() is preferred over fprintf() for logging errors.  Also
> > remove square brackets [] and additional new line characters in printed
> > messages.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  hw/arm/exynos4_boards.c   |  6 +++---
> >  hw/timer/exynos4210_mct.c |  5 +++--
> >  hw/timer/exynos4210_pwm.c | 11 +++++------
> >  hw/timer/exynos4210_rtc.c | 16 +++++++---------
> >  4 files changed, 18 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> > index 0efa19405409..5cd94d402b52 100644
> > --- a/hw/arm/exynos4_boards.c
> > +++ b/hw/arm/exynos4_boards.c
> > @@ -22,6 +22,7 @@
> >   */
> >=20
> >  #include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> >  #include "qemu-common.h"
> >  #include "cpu.h"
> >  #include "sysemu/sysemu.h"
> > @@ -101,9 +102,8 @@ static Exynos4210State *exynos4_boards_init_common(=
MachineState *machine,
> >      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> >=20
> >      if (smp_cpus !=3D EXYNOS4210_NCPUS && !qtest_enabled()) {
> > -        fprintf(stderr, "%s board supports only %d CPU cores. Ignoring=
 smp_cpus"
> > -                " value.\n",
> > -                mc->name, EXYNOS4210_NCPUS);
> > +        error_report("%s board supports only %d CPU cores. Ignoring sm=
p_cpus value.",
> > +                     mc->name, EXYNOS4210_NCPUS);
>=20
> ok, to inform the user

By inform you mean error_report or some lower level?

>=20
> >      }
> >=20
> >      exynos4_board_binfo.ram_size =3D exynos4_board_ram_size[board_type=
];
> > diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> > index 6069116942a4..48041ab036a6 100644
> > --- a/hw/timer/exynos4210_mct.c
> > +++ b/hw/timer/exynos4210_mct.c
> > @@ -53,6 +53,7 @@
> >   */
> >=20
> >  #include "qemu/osdep.h"
> > +#include "qemu/error-report.h"
> >  #include "hw/sysbus.h"
> >  #include "qemu/timer.h"
> >  #include "qemu/main-loop.h"
> > @@ -1364,8 +1365,8 @@ static void exynos4210_mct_write(void *opaque, hw=
addr offset,
> >      case L0_TCNTO: case L1_TCNTO:
> >      case L0_ICNTO: case L1_ICNTO:
> >      case L0_FRCNTO: case L1_FRCNTO:
> > -        fprintf(stderr, "\n[exynos4210.mct: write to RO register "
> > -                TARGET_FMT_plx "]\n\n", offset);
> > +        error_report("exynos4210.mct: write to RO register " TARGET_FM=
T_plx,
> > +                     offset);
>=20
> no need to annoy the user here, it seems better to use
> qemu_log_mask(LOG_UNIMP, ...
>=20
> same for following diffs

Sure, I'll fix that as well.

Thanks for review.


Best regards,
Krzysztof
