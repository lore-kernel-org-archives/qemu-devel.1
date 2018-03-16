Received: from eggs.gnu.org ([2001:4830:134:3::10]:39473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewoXA-0001iE-TS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewoX8-0002we-AM
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:32:32 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ewoX8-0002wB-18
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:32:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id l8so11553948wrg.5
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 05:32:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
	<1521193892-15552-4-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6adba852-b494-e1bf-2008-897fb7d45188@amsat.org>
Date: Fri, 16 Mar 2018 13:32:25 +0100
MIME-Version: 1.0
In-Reply-To: <1521193892-15552-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/audio: Fix crashes when devices are
 used on ISA bus without DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

On 03/16/2018 10:51 AM, Thomas Huth wrote:
> The cs4231a, gus and sb16 sound cards crash QEMU when the user tries
> to instantiate them on a machine with DMA-less ISA bus (for example
> with "qemu-system-mips64el -M mips -device sb16"). Add proper checks
> to the realize functions to avoid the crashes.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/cs4231a.c        | 8 +++++++-
>  hw/audio/gus.c            | 7 ++++++-
>  hw/audio/sb16.c           | 9 +++++++--
>  scripts/device-crash-test | 3 ---
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
> index 096e8e9..aaebec1 100644
> --- a/hw/audio/cs4231a.c
> +++ b/hw/audio/cs4231a.c
> @@ -28,6 +28,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/qdev.h"
>  #include "qemu/timer.h"
> +#include "qapi/error.h"
>  
>  /*
>    Missing features:
> @@ -663,8 +664,13 @@ static void cs4231a_realizefn (DeviceState *dev, Error **errp)
>      CSState *s = CS4231A (dev);
>      IsaDmaClass *k;
>  
> -    isa_init_irq (d, &s->pic, s->irq);
>      s->isa_dma = isa_get_dma(isa_bus_from_device(d), s->dma);
> +    if (!s->isa_dma) {
> +        error_setg(errp, "ISA controller does not support DMA");
> +        return;
> +    }
> +
> +    isa_init_irq(d, &s->pic, s->irq);
>      k = ISADMA_GET_CLASS(s->isa_dma);
>      k->register_channel(s->isa_dma, s->dma, cs_dma_read, s);
>  
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index 3e864cd..8e0b27e 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -241,6 +241,12 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>      IsaDmaClass *k;
>      struct audsettings as;
>  
> +    s->isa_dma = isa_get_dma(isa_bus_from_device(d), s->emu.gusdma);
> +    if (!s->isa_dma) {
> +        error_setg(errp, "ISA controller does not support DMA");
> +        return;
> +    }
> +
>      AUD_register_card ("gus", &s->card);
>  
>      as.freq = s->freq;
> @@ -272,7 +278,6 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>      isa_register_portio_list(d, &s->portio_list2, (s->port + 0x100) & 0xf00,
>                               gus_portio_list2, s, "gus");
>  
> -    s->isa_dma = isa_get_dma(isa_bus_from_device(d), s->emu.gusdma);
>      k = ISADMA_GET_CLASS(s->isa_dma);
>      k->register_channel(s->isa_dma, s->emu.gusdma, GUS_read_DMA, s);
>      s->emu.himemaddr = s->himem;
> diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
> index 31de264..5a4d323 100644
> --- a/hw/audio/sb16.c
> +++ b/hw/audio/sb16.c
> @@ -1371,6 +1371,13 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
>      SB16State *s = SB16 (dev);
>      IsaDmaClass *k;
>  
> +    s->isa_hdma = isa_get_dma(isa_bus_from_device(isadev), s->hdma);
> +    s->isa_dma = isa_get_dma(isa_bus_from_device(isadev), s->dma);
> +    if (!s->isa_dma || !s->isa_hdma) {
> +        error_setg(errp, "ISA controller does not support DMA");
> +        return;
> +    }
> +
>      isa_init_irq (isadev, &s->pic, s->irq);
>  
>      s->mixer_regs[0x80] = magic_of_irq (s->irq);
> @@ -1389,11 +1396,9 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
>      isa_register_portio_list(isadev, &s->portio_list, s->port,
>                               sb16_ioport_list, s, "sb16");
>  
> -    s->isa_hdma = isa_get_dma(isa_bus_from_device(isadev), s->hdma);
>      k = ISADMA_GET_CLASS(s->isa_hdma);
>      k->register_channel(s->isa_hdma, s->hdma, SB_read_DMA, s);
>  
> -    s->isa_dma = isa_get_dma(isa_bus_from_device(isadev), s->dma);
>      k = ISADMA_GET_CLASS(s->isa_dma);
>      k->register_channel(s->isa_dma, s->dma, SB_read_DMA, s);
>  
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 99d20cb..8ad3f44 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -217,10 +217,7 @@ ERROR_WHITELIST = [
>      {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
>      {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
>      {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
> -    {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
>      {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
> -    {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
> -    {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
>      {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
>  
>      # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
> 
