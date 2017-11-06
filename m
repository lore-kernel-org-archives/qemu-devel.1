Received: from eggs.gnu.org ([2001:4830:134:3::10]:49886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBf2x-0006UE-Oa
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eBf2s-0005Yx-SB
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:54:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eBf2s-0005YE-Ll
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:54:22 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171026080041.8280-1-aik@ozlabs.ru>
Date: Mon, 06 Nov 2017 11:54:19 +0100
In-Reply-To: <20171026080041.8280-1-aik@ozlabs.ru> (Alexey Kardashevskiy's
	message of "Thu, 26 Oct 2017 19:00:41 +1100")
Message-ID: <878tfjhe3o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

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

Quote include/qapi/error.h:

 * Please don't error_setg(&error_fatal, ...), use error_report() and
 * exit(), because that's more obvious.
