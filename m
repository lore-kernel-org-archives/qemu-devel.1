Received: from eggs.gnu.org ([2001:4830:134:3::10]:59593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZpzV-0001jS-1H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dZpzQ-0005yE-DA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:54:33 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dZpzQ-0005xQ-7J
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:54:28 -0400
Received: by mail-pg0-x244.google.com with SMTP id v190so13312091pgv.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:54:28 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-20-git-send-email-clg@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6e9f8817-2ecc-4ea3-8f22-17496b520bb4@ozlabs.ru>
Date: Tue, 25 Jul 2017 12:54:20 +1000
MIME-Version: 1.0
In-Reply-To: <1499274819-15607-20-git-send-email-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 19/26] ppc/xive: introduce a
 helper to map the XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 06/07/17 03:13, Cédric Le Goater wrote:
> It will be used when the guest chooses the XIVE exploitation mode in
> CAS.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c        | 11 +++++++++++
>  include/hw/ppc/xive.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index cda1fa18e44d..895dd2b2f61b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -915,3 +915,14 @@ bool xive_eq_for_target(XIVE *x, uint32_t target, uint8_t priority,
>  
>      return true;
>  }
> +
> +void xive_mmio_map(XIVE *x)
> +{
> +    /* ESBs */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 0, x->vc_base);
> +
> +    /* Thread Management Interrupt Areas */
> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
> +     * region needs some rework in the handlers */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 1, x->tm_base + (1 << x->tm_shift));
> +}


imho it makes more sense to squash such small patches (this one and 20/26,
21/26) into those which actually make use of the new helpers - easier to
review, better for bisectability.


> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 288116aeb8f4..560f6ab66f73 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -68,4 +68,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>  void xive_spapr_init(sPAPRMachineState *spapr);
>  void xive_spapr_populate(XIVE *x, void *fdt);
>  
> +void xive_mmio_map(XIVE *x);
> +
>  #endif /* PPC_XIVE_H */
> 


-- 
Alexey
