Received: from eggs.gnu.org ([2001:4830:134:3::10]:45941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmTG-0001Us-1O
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsmTD-0000q7-0f
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dsmTC-0000ph-Qn
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:59:30 -0400
References: <20170915084030.40988-1-aik@ozlabs.ru>
	<20170915084030.40988-4-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23a47b4e-2260-e711-15e9-07027a2f9529@redhat.com>
Date: Fri, 15 Sep 2017 10:59:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170915084030.40988-4-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2 03/13] memory: Open code FlatView
 rendering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

On 15/09/2017 10:40, Alexey Kardashevskiy wrote:
> +    /*
> +     * FIXME: this is cut-n-paste from address_space_update_topology_pass,
> +     * simplify it
> +     */
> +    iold = inew = 0;
> +    while (iold < old_view->nr || inew < new_view->nr) {
> +        if (iold < old_view->nr) {
> +            frold = &old_view->ranges[iold];
> +        } else {
> +            frold = NULL;
> +        }
> +        if (inew < new_view->nr) {
> +            frnew = &new_view->ranges[inew];
> +        } else {
> +            frnew = NULL;
> +        }
> +
> +        if (frold
> +            && (!frnew
> +                || int128_lt(frold->addr.start, frnew->addr.start)
> +                || (int128_eq(frold->addr.start, frnew->addr.start)
> +                    && !flatrange_equal(frold, frnew)))) {
> +            ++iold;
> +        } else if (frold && frnew && flatrange_equal(frold, frnew)) {
> +            /* In both and unchanged (except logging may have changed) */
> +            MemoryRegionSection mrs = section_from_flat_range(frnew, as);
> +
> +            mem_add(as, &mrs);
> +
> +            ++iold;
> +            ++inew;
> +        } else {
> +            /* In new */
> +            MemoryRegionSection mrs = section_from_flat_range(frnew, as);
> +
> +            mem_add(as, &mrs);
> +
> +            ++inew;
> +        }
> +    }

This indeed is just

    for (i = 0; i < new_view->nr; i++) {
        MemoryRegionSection mrs =
           section_from_flat_range(&new_view->ranges[i], as);
        mem_add(as, &mrs);
    }

:)

Paolo
