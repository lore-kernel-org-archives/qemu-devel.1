Received: from eggs.gnu.org ([2001:4830:134:3::10]:44887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dKO4Q-0003Tq-3I
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dKO4N-0005hu-0g
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dKO4M-0005hX-RS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:03:42 -0400
Date: Mon, 12 Jun 2017 14:03:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170612140335.6f1a9310@nial.brq.redhat.com>
In-Reply-To: <1497097821-32754-5-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-5-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] fw_cfg: move fw_cfg_init1() into the
 fw_cfg_*_realize() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On Sat, 10 Jun 2017 13:30:19 +0100
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> And rename to fw_cfg_common_realize() which better describes its role.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index f7b78a9..87b4392 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -910,7 +910,7 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>  
>  
>  
> -static void fw_cfg_init1(DeviceState *dev)
> +static void fw_cfg_common_realize(DeviceState *dev)
>  {
>      FWCfgState *s = FW_CFG(dev);
>      MachineState *machine = MACHINE(qdev_get_machine());
> @@ -951,7 +951,6 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
>          qdev_prop_set_bit(dev, "dma_enabled", false);
>      }
>  
> -    fw_cfg_init1(dev);
>      qdev_init_nofail(dev);
>  
>      s = FW_CFG(dev);
> @@ -985,7 +984,6 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
>          qdev_prop_set_bit(dev, "dma_enabled", false);
>      }
>  
> -    fw_cfg_init1(dev);
>      qdev_init_nofail(dev);
>  
>      sbd = SYS_BUS_DEVICE(dev);
> @@ -1085,6 +1083,8 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    fw_cfg_common_realize(dev);
For QOM objects it's done with inheritance, see 9f318f8f7e6 for example.

i.e. define in parent TYPE_FW_CFG.realize and call it from children.
You also can dedup fw_cfg_mem_realize/fw_cfg_mem_realize and
move common code into new fw_cfg_realize()
