Received: from eggs.gnu.org ([209.51.188.92]:45497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2Frf-0007hn-JY
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h2Frd-0006YS-8Z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:48:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h2Frb-0006QE-Fx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:48:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id d16so3091829qtn.10
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:48:39 -0800 (PST)
Date: Fri, 8 Mar 2019 08:48:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190308084438-mutt-send-email-mst@kernel.org>
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-11-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190308013222.12524-11-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/18] hw/nvram/fw_cfg: Add
 reboot_timeout to FWCfgState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Fri, Mar 08, 2019 at 02:32:14AM +0100, Philippe Mathieu-Daudé wrote:
> Due to the contract interface of fw_cfg_add_file(), the
> 'reboot_timeout' data has to be valid for the lifetime of the
> FwCfg object. For this reason it is copied on the heap with
> memdup().
> 
> The object state, 'FWCfgState', is also meant to be valid during the
> lifetime of the object.
> Move the 'reboot_timeout' in FWCfgState to achieve the same purpose.
> Doing so we avoid a memory leak.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I don't like adding random per-file state to fw cfg at all.

I don't see a leak. Please add more explanation about this.
And maybe split from this series.

> ---
>  hw/nvram/fw_cfg.c         | 4 +++-
>  include/hw/nvram/fw_cfg.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index b73a591eff..182d27f59a 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -250,7 +250,9 @@ static void fw_cfg_reboot(FWCfgState *s)
>          }
>      }
>  
> -    fw_cfg_add_file(s, "etc/boot-fail-wait", g_memdup(&rt_val, 4), 4);
> +    s->reboot_timeout = rt_val;
> +    fw_cfg_add_file(s, "etc/boot-fail-wait",
> +                    &s->reboot_timeout, sizeof(s->reboot_timeout));
>  }
>  
>  static void fw_cfg_write(FWCfgState *s, uint8_t value)
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 828ad9dedc..99f6fafcaa 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -53,6 +53,8 @@ struct FWCfgState {
>      dma_addr_t dma_addr;
>      AddressSpace *dma_as;
>      MemoryRegion dma_iomem;
> +
> +    uint32_t reboot_timeout;
>  };
>  
>  struct FWCfgIoState {
> -- 
> 2.20.1
