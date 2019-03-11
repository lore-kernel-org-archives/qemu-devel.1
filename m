Received: from eggs.gnu.org ([209.51.188.92]:42583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1h3Idg-00063m-82
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1h3IY0-0000fK-Gc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:52:45 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:57271)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1h3IY0-0000au-9v
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:52:44 -0400
Received: from player714.ha.ovh.net (unknown [10.109.143.72])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id A94C21D7715
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:52:36 +0100 (CET)
Date: Mon, 11 Mar 2019 11:52:28 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190311115228.30efc27b@bahia.lan>
In-Reply-To: <20190310082703.1245-5-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
	<20190310082703.1245-5-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 04/60] Revert "spapr: support memory unplug
 for qtest"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Sun, 10 Mar 2019 19:26:07 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Greg Kurz <groug@kaod.org>
> 
> Commit b8165118f52c broke CPU hotplug tests for old machine types:
> 
> $ QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-test -m=slow
> /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=6: OK
> /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=6: **
> ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_to_source: assertion failed: (source->enabled)
> Broken pipe
> /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> Aborted (core dumped)
> 
> The approach of faking the availability of OV5_HP_EVT causes the
> code to assume the hotplug event source is enabled, which is wrong
> for older machines.
> 
> This reverts commit b8165118f52ce5ee88565d3cec83d30374efdc96.
> 
> A subsequent patch will address the problem of CAS under qtest from
> a different angle.
> 

Since the patches got re-ordered, this sentence is wrong. In case
you re-send this pull request, maybe you can update the changelog
accordingly ?

> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Message-Id: <155146875097.147873.1732264036668112686.stgit@bahia.lan>
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_ovec.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 12510b236a..318bf33de4 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -16,7 +16,6 @@
>  #include "qemu/bitmap.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> -#include "sysemu/qtest.h"
>  #include "trace.h"
>  #include <libfdt.h>
>  
> @@ -132,11 +131,6 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
>      g_assert(ov);
>      g_assert(bitnr < OV_MAXBITS);
>  
> -    /* support memory unplug for qtest */
> -    if (qtest_enabled() && bitnr == OV5_HP_EVT) {
> -        return true;
> -    }
> -
>      return test_bit(bitnr, ov->bitmap) ? true : false;
>  }
>  
