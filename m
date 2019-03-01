Received: from eggs.gnu.org ([209.51.188.92]:59237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzqjC-0006cO-Py
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 17:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gzqjB-0006mV-F0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 17:34:02 -0500
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <155146875704.147873.10563808578795890265.stgit@bahia.lan>
References: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
	<155146875704.147873.10563808578795890265.stgit@bahia.lan>
Message-ID: <155147961832.30057.4167728683124961502@sif>
Date: Fri, 01 Mar 2019 16:33:38 -0600
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: Simulate CAS for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Quoting Greg Kurz (2019-03-01 13:32:37)
> The RTAS event hotplug code for machine types 2.8 and newer depends on
> the CAS negotiated ov5 in order to work properly. However, there's no
> CAS when running under qtest. There has been a tentative to trick the
> code by faking the OV5_HP_EVT bit, but it turned out to break other
> assumptions in the code and the change got reverted.
> =

> Go for a more general approach and simulate a CAS when running under
> qtest. For simplicity, this pseudo CAS simple simulates the case where
> the guest supports the same features as the machine. It is done at
> reset time, just before we reset the DRCs, which could potentially
> exercise the unplug code.
> =

> This allows to test unplug on spapr with both older and newer machine
> types.
> =

> Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks for sending this!

Just now realizing we should probably apply the revert after this patch
however, since the commit we're reverting fixes a `make check` test that
is run by default, whereas this patch fixes one that only gets run if we
run the tests with -m=3Dslow specified.

Maybe David can do that on his end?

> ---
>  hw/ppc/spapr.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b6a571b6f184..6da64ef7ee2b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -29,6 +29,7 @@
>  #include "qapi/visitor.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/qtest.h"
>  #include "hw/hw.h"
>  #include "qemu/log.h"
>  #include "hw/fw-path-provider.h"
> @@ -1711,6 +1712,16 @@ static void spapr_machine_reset(void)
>       */
>      spapr_irq_reset(spapr, &error_fatal);
> =

> +    /*
> +     * There is no CAS under qtest. Simulate one to please the code that
> +     * depends on spapr->ov5_cas. This is especially needed to test devi=
ce
> +     * unplug, so we do that before resetting the DRCs.
> +     */
> +    if (qtest_enabled()) {
> +        spapr_ovec_cleanup(spapr->ov5_cas);
> +        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
> +    }
> +
>      /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
>       * if this device is used by another device (eg, a running vhost bac=
kend
>       * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
>=20
