Received: from eggs.gnu.org ([2001:4830:134:3::10]:33341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj5lw-0001Xx-Ua
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj5lv-0006yc-Te
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:39:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
	<2b92ae960dfc47149945c9e47f90b4433d8eee35.1532701430.git.damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <155529c9-2847-0f30-9277-6b2c8bb31b78@amsat.org>
Date: Fri, 27 Jul 2018 13:39:06 -0300
MIME-Version: 1.0
In-Reply-To: <2b92ae960dfc47149945c9e47f90b4433d8eee35.1532701430.git.damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC PATCH 2/6] qdev: add power/clock
 gating control on bus tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, luc.michel@greensocs.com

Hi Damien,

On 07/27/2018 11:37 AM, Damien Hedde wrote:
> Add functions [qdev|qbus]_set_[power|clock]_all(_fn).
> Theses allow to control power and clock gating along a bus hierarchy.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  include/hw/qdev-core.h | 20 +++++++++++++++++
>  hw/core/qdev.c         | 51 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 659287e185..607c367738 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -464,4 +464,24 @@ void device_set_power(DeviceState *dev, bool en);
>   */
>  void device_set_clock(DeviceState *dev, bool en);
>  
> +/**
> + * qdev/qbus_set_power_all(_fn)
> + * Enable/Disable the power of a tree starting
> + * at given device or bus
> + */
> +void qdev_set_power_all(DeviceState *dev, bool en);
> +void qdev_set_power_all_fn(void *opaque, bool en);
> +void qbus_set_power_all(BusState *bus, bool en);
> +void qbus_set_power_all_fn(void *opaque, bool en);

I think we don't need the _fn() functions, most of the current codebase
directly use DEVICE(x) or BUS(x) to casts.

> +
> +/**
> + * qdev/qbus_set_clock_all(_fn)
> + * Enable/Disable the clock of a tree starting
> + * at given device or bus
> + */
> +void qdev_set_clock_all(DeviceState *dev, bool en);
> +void qdev_set_clock_all_fn(void *opaque, bool en);
> +void qbus_set_clock_all(BusState *bus, bool en);
> +void qbus_set_clock_all_fn(void *opaque, bool en);
> +
>  #endif
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index bb6d36eab9..24b90bd45f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -1138,6 +1138,57 @@ void device_set_clock(DeviceState *dev, bool en)
>      }
>  }
>  
> +static int qdev_set_power_one(DeviceState *dev, void *opaque)
> +{
> +    device_set_power(dev, *((bool *)opaque));
> +    return 0;
> +}
> +
> +void qdev_set_power_all(DeviceState *dev, bool en)
> +{
> +    qdev_walk_children(dev, NULL, NULL, qdev_set_power_one, NULL, &en);
> +}
> +
> +void qdev_set_power_all_fn(void *opaque, bool en)
> +{
> +    qdev_set_power_all(DEVICE(opaque), en);
> +}
> +
> +void qbus_set_power_all(BusState *bus, bool en)
> +{
> +    qbus_walk_children(bus, NULL, NULL, qdev_set_power_one, NULL, &en);
> +}
> +
> +void qbus_set_power_all_fn(void *opaque, bool en)
> +{
> +    qbus_set_power_all(BUS(opaque), en);
> +}
> +
> +static int qdev_set_clock_one(DeviceState *dev, void *opaque)
> +{
> +    device_set_clock(dev, *((bool *)opaque));
> +    return 0;
> +}
> +
> +void qdev_set_clock_all(DeviceState *dev, bool en)
> +{
> +    qdev_walk_children(dev, NULL, NULL, qdev_set_clock_one, NULL, &en);
> +}
> +
> +void qdev_set_clock_all_fn(void *opaque, bool en)
> +{
> +    qdev_set_clock_all(DEVICE(opaque), en);
> +}
> +
> +void qbus_set_clock_all(BusState *bus, bool en)
> +{
> +    qbus_walk_children(bus, NULL, NULL, qdev_set_clock_one, NULL, &en);
> +}
> +
> +void qbus_set_clock_all_fn(void *opaque, bool en)
> +{
> +    qbus_set_clock_all(BUS(opaque), en);
> +}
>  
>  Object *qdev_get_machine(void)
>  {
> 
