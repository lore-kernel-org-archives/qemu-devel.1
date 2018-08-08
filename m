Received: from eggs.gnu.org ([2001:4830:134:3::10]:56105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fnUJI-0000j2-7m
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fnUJE-0000u1-9c
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fnUJE-0000sy-3k
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:39:52 -0400
References: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8de65abc-7623-b3ce-f1c6-a0efaec1fac4@redhat.com>
Date: Wed, 8 Aug 2018 21:39:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180808191951.23193-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: add bootdevice-ignore-suffixes
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On 08/08/18 21:19, Mark Cave-Ayland wrote:
> For the older machines (such as Mac and SPARC) the DT nodes representing
> bootdevices for disk nodes are irregular for mainly historical reasons.
> 
> Since the majority of bootdevice nodes for these machines either do not have a
> separate disk node or require different (custom) names then it is much easier
> to disable all suffixes for a particular machine by setting the ignore_suffixes
> parameter to get_boot_devices_list() to true, and customise the disk nodes as
> required.
> 
> Here we add a new bootdevice-ignore-suffixes property to the FW_CFG device to
> allow the generation of disk suffixes to be controlled on a per-machine basis.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c         | 9 ++++++++-
>  include/hw/nvram/fw_cfg.h | 1 +
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index b23e7f64a8..52488b999f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -861,7 +861,8 @@ static void fw_cfg_machine_reset(void *opaque)
>      void *ptr;
>      size_t len;
>      FWCfgState *s = opaque;
> -    char *bootindex = get_boot_devices_list(&len, false);
> +    char *bootindex = get_boot_devices_list(&len,
> +                                            s->bootdevice_ignore_suffixes);
>  
>      ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)bootindex, len);
>      g_free(ptr);
> @@ -990,12 +991,18 @@ FWCfgState *fw_cfg_find(void)
>      return FW_CFG(object_resolve_path_type("", TYPE_FW_CFG, NULL));
>  }
>  
> +static Property fw_cfg_properties[] = {
> +    DEFINE_PROP_BOOL("bootdevice-ignore-suffixes", FWCfgState,
> +                     bootdevice_ignore_suffixes, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

I've got two questions which are not "loaded" -- I honestly have no clue:

- Do we intend to expose this to users and higher-level tools? If not,
should it be called "x-..." (experimental)? I can't remember the rules
about "x-" properties.

- I vaguely recall that earlier we tried to add properties to the fw_cfg
base class, but ultimately added them to the derived classes (see
"fw_cfg_mem_properties" and "fw_cfg_io_properties"). Despite the fact
that the referenced fields themselves (dma_enabled, file_slots) belong
to the base class; IOW, the properties refer to "parent_obj.xxx". I
don't really remember why we did this. I seem to recall issues
otherwise, with setting the property from the command line due to object
construction / realization order, or whatever.

Mark, can you verify whether you can control
"bootdevice-ignore-suffixes" from the command line, e.g. via "-global"?

The object model keeps scaring me. :(

Laszlo

>  
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->reset = fw_cfg_reset;
> +    dc->props = fw_cfg_properties;
>      dc->vmsd = &vmstate_fw_cfg;
>  }
>  
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index b2259cc4a3..848c83aef4 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -58,6 +58,7 @@ struct FWCfgState {
>      uint16_t cur_entry;
>      uint32_t cur_offset;
>      Notifier machine_ready;
> +    bool bootdevice_ignore_suffixes;
>  
>      int fw_cfg_order_override;
>  
> 
