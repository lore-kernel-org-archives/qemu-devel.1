Received: from eggs.gnu.org ([2001:4830:134:3::10]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkm2-0000EK-Fe
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJklx-0006a6-Fa
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:06:10 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJklx-0006Zm-4Z
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:06:05 -0400
Received: by mail-qt0-x242.google.com with SMTP id w1so20042098qtg.0
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 11:06:05 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48bf4308-9e8a-f27e-7d21-ec4f3dca499c@amsat.org>
Date: Sat, 10 Jun 2017 15:05:59 -0300
MIME-Version: 1.0
In-Reply-To: <1497097821-32754-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] fw_cfg: move initialisation of
 FWCfgState into instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 06/10/2017 09:30 AM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 316fca9..144e0c6 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1017,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>  }
>
> +static void fw_cfg_init(Object *obj)
> +{
> +    FWCfgState *s = FW_CFG(obj);
> +
> +    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> +    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> +    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
> +}
> +
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1030,6 +1039,7 @@ static const TypeInfo fw_cfg_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .abstract      = true,
>      .instance_size = sizeof(FWCfgState),
> +    .instance_init = fw_cfg_init,
>      .class_init    = fw_cfg_class_init,
>  };
>
> @@ -1052,10 +1062,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
>                     file_slots_max);
>          return;
>      }
> -
> -    s->entries[0] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> -    s->entries[1] = g_new0(FWCfgEntry, fw_cfg_max_entry(s));
> -    s->entry_order = g_new0(int, fw_cfg_max_entry(s));
>  }
>
>  static Property fw_cfg_io_properties[] = {
>
