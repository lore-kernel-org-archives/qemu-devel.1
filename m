Received: from eggs.gnu.org ([2001:4830:134:3::10]:37865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0VZx-0000LI-UM
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f0VZu-0003wo-ME
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:06:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40196 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f0VZu-0003wM-GH
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:06:38 -0400
References: <1522071403-52486-1-git-send-email-pbonzini@redhat.com>
	<1522071403-52486-7-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da663860-2815-362c-045b-71624ef0b14f@redhat.com>
Date: Mon, 26 Mar 2018 19:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <1522071403-52486-7-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 06/16] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Eduardo Habkost <ehabkost@redhat.com>

On 26.03.2018 15:36, Paolo Bonzini wrote:
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> A "powernv" machine type defines an ISA bus but it does not add any DMA
> controller to it so it is possible to hit assert(fdctrl->dma) by
> adding "-machine powernv -device isa-fdc".
> 
> This replaces assert() with an error message.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [thuth: Slightly adjusted error message and updated scripts/device-crash-test]

That's strange, the hunk with the update to device-crash-test seems to be missing ... ?

device-crash-test now reports some "Didn't fail as expected" warnings :-(

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <1521193892-15552-3-git-send-email-thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/block/fdc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 7b7dd41..cd29e27 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2695,7 +2695,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
>      fdctrl->dma_chann = isa->dma;
>      if (fdctrl->dma_chann != -1) {
>          fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
> -        assert(fdctrl->dma);
> +        if (!fdctrl->dma) {
> +            error_setg(errp, "ISA controller does not support DMA");
> +            return;
> +        }
>      }
>  
>      qdev_set_legacy_instance_id(dev, isa->iobase, 2);
> 

FWIW, this is the hunk that was part of the version that I sent to the list:

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7ff351d..99d20cb 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -217,7 +217,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},

 Thomas
