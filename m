Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87tH-0003G3-KS
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:26:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87tG-0008LV-FQ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:26:07 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f87tG-0008KZ-6a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:26:06 -0400
Received: by mail-ot0-x231.google.com with SMTP id p2-v6so1454246otf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 10:26:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523551221-11612-3-git-send-email-imammedo@redhat.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-3-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 18:25:45 +0100
Message-ID: <CAFEAcA8zH6OyELbYGScXBjDTZZYgV5D-WQBeZOy4iUu0MwSr+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13 2/4] platform-bus-device: use
 device plug callback instead of machine_done notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>

On 12 April 2018 at 17:40, Igor Mammedov <imammedo@redhat.com> wrote:
> platform-bus were using machine_done notifier to get and map
> (assign irq/mmio resources) dynamically added sysbus devices
> after all '-device' options had been processed.
> That however creates non obvious dependencies on ordering of
> machine_done notifiers and requires carefull line juggling
> to keep it working. For example see comment above
> create_platform_bus() and 'straitforward' arm_load_kernel()
> had to converted to machine_done notifier and that lead to
> yet another machine_done notifier to keep it working
> arm_register_platform_bus_fdt_creator().
>
> Instead of hiding resource assignment in platform-bus-device
> to magically initialize sysbus devices, use device plug
> callback and assign resources explicitly at board level
> at the moment each -device option is being processed.
>
> That adds a bunch of machine declaration boiler plate to
> e500plat board, similar to ARM/x86 but gets rid of hidden
> machine_done notifier and would allow to remove the dependent
> notifiers in ARM code simplifying it and making code flow
> easier to follow.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

> +static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_SYS_BUS_DEVICE)) {
> +        if (vms->platform_bus_dev) {
> +            platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
> +                                     SYS_BUS_DEVICE(dev));
> +        }
> +    }
> +}
> +
> +static HotplugHandler *virt_machine_get_hotpug_handler(MachineState *machine,
> +                                                       DeviceState *dev)

Nit: typo in function name, should be "hotplug".

Will let others review the meat of the patch.

thanks
-- PMM
