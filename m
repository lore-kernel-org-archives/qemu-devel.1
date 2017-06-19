Received: from eggs.gnu.org ([2001:4830:134:3::10]:41628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxfo-0006sc-0W
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dMxfk-0004PC-Rt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dMxfk-0004Ot-I9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 10:28:56 -0400
Date: Mon, 19 Jun 2017 11:28:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170619142852.GS5016@thinpad.lan.raisama.net>
References: <1497877149-19253-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497877149-19253-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv6 3/5] fw_cfg: move assert() and linking of
 fw_cfg device to the machine into instance_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Mon, Jun 19, 2017 at 01:59:07PM +0100, Mark Cave-Ayland wrote:
> In preparation for calling fw_cfg_init1() during realize rather than during
> init, move the assert() checking for existing fw_cfg devices and the linking
> of the device to the machine with object_property_add_child() to a new
> fw_cfg instance_init() function.
> 
> This guarantees that we will still assert() correctly if more than one fw_cfg
> device is instantiated by accident.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 99bdbc2..af45012 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -915,10 +915,6 @@ static void fw_cfg_init1(DeviceState *dev)
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
> @@ -1020,6 +1016,15 @@ FWCfgState *fw_cfg_find(void)
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

I don't think this belongs to instance_init.  We must always be
able to instantiate objects without crashing QEMU or affecting
QEMU global state.  This patch makes device-list-properties
crash:

  $ qemu-system-x86_64 -display none -qmp unix:/tmp/qmp,server,nowait &
  [1] 2848
  $ echo 'device-list-properties typename=fw_cfg_mem' | ./scripts/qmp/qmp-shell /tmp/qmp
  Welcome to the QMP low-level shell!
  Connected to QEMU 2.9.50
  
  qemu-system-x86_64: qemu/hw/nvram/fw_cfg.c:974: fw_cfg_init: Assertion `!object_resolve_path(FW_CFG_PATH, NULL)' failed.
  (QEMU) Disconnected
  [1]+  Aborted                 (core dumped) qemu-system-x86_64 -display none -qmp unix:/tmp/qmp,server,nowait
  $ 


I suggest moving this check to realize, like the rest of
fw_cfg_init1(), but change it to do proper error reporting
instead of asserting.

> +}
> +
>  static void fw_cfg_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1033,6 +1038,7 @@ static const TypeInfo fw_cfg_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .abstract      = true,
>      .instance_size = sizeof(FWCfgState),
> +    .instance_init = fw_cfg_init,
>      .class_init    = fw_cfg_class_init,
>  };
>  
> -- 
> 1.7.10.4
> 

-- 
Eduardo
