Received: from eggs.gnu.org ([2001:4830:134:3::10]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmt8-0001Ly-8S
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmt4-0003xR-Aq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:26:18 -0400
Date: Fri, 15 Sep 2017 11:26:07 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170915092607.GA6835@vader>
References: <20170915090643.6043-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915090643.6043-1-otubo@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] dma/i82374: avoid double
 creation of i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com

(oups, forgot the v2 on Subject)

On Fri, Sep 15, 2017 at 11:06:43AM +0200, Eduardo Otubo wrote:
> QEMU fails when used with the following command line:
> 
>   ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
>   qemu-system-ppc64: hw/isa/isa-bus.c:110: isa_bus_dma: Assertion `!bus->dma[0] && !bus->dma[1]' failed.
>   Aborted (core dumped)
> 
> The 40p machine type already creates the device i82374. If specified in the
> command line, it will try to create it again, hence generating the error. The
> function isa_bus_dma() isn't supposed to be called twice for the same bus. One
> way to avoid this problem is to set user_creatable=false.
> 
> A possible fix in a near future would be making
> isa_bus_dma()/DMA_init()/i82374_realize() return an error instead of asserting
> as well.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  hw/dma/i82374.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 6c0f975df0..e76dea8dc7 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -139,6 +139,11 @@ static void i82374_class_init(ObjectClass *klass, void *data)
>      dc->realize = i82374_realize;
>      dc->vmsd = &vmstate_i82374;
>      dc->props = i82374_properties;
> +    dc->user_creatable = false;
> +    /*
> +     * Reason: i82374_realize() crashes (assertion failure inside isa_bus_dma()
> +     *         if the device is instantiated twice.
> +     */
>  }
>  
>  static const TypeInfo i82374_info = {
> -- 
> 2.13.5
> 
> 

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
