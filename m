Received: from eggs.gnu.org ([2001:4830:134:3::10]:55360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcx5-0004bq-4W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmcx1-0000sE-UX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:36:55 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmcx1-0000rL-O9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:36:51 -0400
Received: by mail-wm0-x241.google.com with SMTP id e204so380088wma.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:36:51 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:36:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829093648.GH25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-9-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-9-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 08/14] apic: add function to apic that will
 be used by hvf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:48PM -0500, Sergio Andres Gomez Del Real wrote:
> This commit moves (hides) the function apic_get_highest_priority_irr to
> apic.c and exports it through the interface in apic.h for use by hvf.

I don't see a move.  This patch only adds a new function.  Did you
forget to delete the old function?

> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  hw/intc/apic.c         | 11 +++++++++++
>  include/hw/i386/apic.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index fe15fb6024..3de59d07fd 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -305,6 +305,17 @@ static void apic_set_tpr(APICCommonState *s, uint8_t val)
>      }
>  }
>  
> +int apic_get_highest_priority_irr(DeviceState *dev)
> +{
> +    APICCommonState *s;
> +
> +    if (!dev) {
> +        return -1;
> +    }
> +    s = APIC_COMMON(dev);
> +    return get_highest_priority_int(s->irr);
> +}
> +
>  static uint8_t apic_get_tpr(APICCommonState *s)
>  {
>      apic_sync_vapic(s, SYNC_FROM_VAPIC);
> diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
> index ea48ea9389..a9f6c0aa33 100644
> --- a/include/hw/i386/apic.h
> +++ b/include/hw/i386/apic.h
> @@ -20,6 +20,7 @@ void apic_init_reset(DeviceState *s);
>  void apic_sipi(DeviceState *s);
>  void apic_poll_irq(DeviceState *d);
>  void apic_designate_bsp(DeviceState *d, bool bsp);
> +int apic_get_highest_priority_irr(DeviceState *dev);
>  
>  /* pc.c */
>  DeviceState *cpu_get_current_apic(void);
> -- 
> 2.14.1
> 
> 
