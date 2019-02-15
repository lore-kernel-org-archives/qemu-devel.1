Received: from eggs.gnu.org ([209.51.188.92]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gueW4-0007e4-UQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gueW3-0008Kv-PW
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:31:00 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:43953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gueW1-00085d-U1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:30:59 -0500
Received: from player771.ha.ovh.net (unknown [10.109.159.123])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id AE0191170D0
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 15:30:39 +0100 (CET)
Date: Fri, 15 Feb 2019 15:30:18 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190215153018.1185a72a@bahia.lan>
In-Reply-To: <20190215133005.15955-3-david@redhat.com>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215133005.15955-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] spapr: support memory unplug for
 qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 15 Feb 2019 14:30:01 +0100
David Hildenbrand <david@redhat.com> wrote:

> Fake availability of OV5_HP_EVT, so we can test memory unplug in qtest.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_ovec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> index 318bf33de4..12510b236a 100644
> --- a/hw/ppc/spapr_ovec.c
> +++ b/hw/ppc/spapr_ovec.c
> @@ -16,6 +16,7 @@
>  #include "qemu/bitmap.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> +#include "sysemu/qtest.h"
>  #include "trace.h"
>  #include <libfdt.h>
>  
> @@ -131,6 +132,11 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long bitnr)
>      g_assert(ov);
>      g_assert(bitnr < OV_MAXBITS);
>  
> +    /* support memory unplug for qtest */
> +    if (qtest_enabled() && bitnr == OV5_HP_EVT) {
> +        return true;
> +    }
> +
>      return test_bit(bitnr, ov->bitmap) ? true : false;
>  }
>  
