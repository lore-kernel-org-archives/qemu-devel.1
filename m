Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsnhS-0001JO-Vf
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dsnhR-0005BT-N1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:18:18 -0400
References: <20170915090643.6043-1-otubo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d4bdcbb-3153-0064-d280-d9ca4f0671e4@redhat.com>
Date: Fri, 15 Sep 2017 12:18:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170915090643.6043-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, ehabkost@redhat.com, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>

On 15/09/2017 11:06, Eduardo Otubo wrote:
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
> 

This breaks "make check", doesn't it?

v2 should be the one that returns an error instead of asserting.

Paolo
