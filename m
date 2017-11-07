Received: from eggs.gnu.org ([2001:4830:134:3::10]:52056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBs5C-0002gl-B8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBs58-0005Rn-Bq
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:49:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1eBs58-0005RJ-4z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:49:34 -0500
References: <20171026080041.8280-1-aik@ozlabs.ru>
From: John Snow <jsnow@redhat.com>
Message-ID: <1cfd3d4f-616d-c9fc-fd82-8d6c2573c0d8@redhat.com>
Date: Mon, 6 Nov 2017 19:49:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171026080041.8280-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] isa-bus: Replace assert() about DMA
 with error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 10/26/2017 04:00 AM, Alexey Kardashevskiy wrote:
> Running "qemu-system-ppc64 -machine prep -device i82374" creates an ISA
> bus with two i82374 DMA controllers - one is implicit from ppc_prep_init(),
> the other one is from "-device i82374". QEMU asserts but it is not
> immediately clear why.
> 
> This adds an error message to explain the failure.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> 
> Better phase suggestions are welcome. Thanks!
> 
> 
> ---
>  hw/isa/isa-bus.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 348e0eab9d..553707b18d 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -107,7 +107,10 @@ void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq)
>  void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
>  {
>      assert(bus && dma8 && dma16);
> -    assert(!bus->dma[0] && !bus->dma[1]);
> +    if (bus->dma[0] || bus->dma[1]) {
> +        error_setg(&error_fatal,
> +                   "DMA is already set to ISA bus, duplicated DMA controller?");
> +    }
>      bus->dma[0] = dma8;
>      bus->dma[1] = dma16;
>  }
> 

I suppose it's an improvement strictly, but really we're just naming a
runtime assertion here. We should be avoiding the assertion -- and then
how valuable is the error message?

Is this something we anticipate can never be fixed? (I.e. exclusively
the cause of asking for impossible configurations?)
