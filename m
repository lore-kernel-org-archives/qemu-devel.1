Received: from eggs.gnu.org ([2001:4830:134:3::10]:49120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLyUo-0004xz-9d
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dLyUj-0003I2-A6
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dLyUj-0003HS-0T
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 17:09:29 -0400
References: <1497619387-11333-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497619387-11333-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <296a07cb-e692-241f-f4f2-7ab390164b0d@redhat.com>
Date: Fri, 16 Jun 2017 23:09:19 +0200
MIME-Version: 1.0
In-Reply-To: <1497619387-11333-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On 06/16/17 15:23, Mark Cave-Ayland wrote:
> In preparation for calling fw_cfg_init1() during realize rather than during
> init, move the assert() checking for existing fw_cfg devices and the linking
> of the device to the machine with object_property_add_child() to a new
> fw_cfg instance_init() function.
> 
> This guarantees that we will still assert() correctly if more than one fw_cfg
> device is instantiated by accident.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index e217239..39fcc04 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -916,10 +916,6 @@ static void fw_cfg_init1(DeviceState *dev)
>      MachineState *machine = MACHINE(qdev_get_machine());
>      uint32_t version = FW_CFG_VERSION;
>  
> -    assert(!object_resolve_path(FW_CFG_PATH, NULL));
> -
> -    object_property_add_child(OBJECT(machine), FW_CFG_NAME, OBJECT(s), NULL);
> -
>      qdev_init_nofail(dev);
>  
>      fw_cfg_add_bytes(s, FW_CFG_SIGNATURE, (char *)"QEMU", 4);
> @@ -1021,6 +1017,15 @@ FWCfgState *fw_cfg_find(void)
>      return FW_CFG(object_resolve_path(FW_CFG_PATH, NULL));
>  }
>  
> +static void fw_cfg_init(Object *obj)
> +{
> +    MachineState *machine = MACHINE(qdev_get_machine());
> +
> +    assert(!object_resolve_path(FW_CFG_PATH, NULL));
> +
> +    object_property_add_child(OBJECT(machine), FW_CFG_NAME, obj, NULL);
> +}
> +
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1034,6 +1039,7 @@ static const TypeInfo fw_cfg_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .abstract      = true,
>      .instance_size = sizeof(FWCfgState),
> +    .instance_init = fw_cfg_init,
>      .class_init    = fw_cfg_class_init,
>  };
>  
> 

Hopefully I'm not wrong :) , but this looks like a surprisingly
attractive solution to me. Basically it sinks the assertion and the link
creation into the qdev_create() calls of fw_cfg_init_io_dma() and
fw_cfg_init_mem_wide(), which is good, because the assert / linking
preserve their relative order to the realization (i.e., they keep
preceding it).

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
