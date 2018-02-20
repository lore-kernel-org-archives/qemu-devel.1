Received: from eggs.gnu.org ([2001:4830:134:3::10]:60383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCcD-00035Y-ES
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCcA-0007wS-6v
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:26:09 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-12-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b673b8c2-9eed-9d2c-196b-8782bfa8edb0@amsat.org>
Date: Tue, 20 Feb 2018 15:26:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 11/19] qdev: Add new
 qdev_init_gpio_in_named_with_opaque()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/20/2018 03:03 PM, Peter Maydell wrote:
> The function qdev_init_gpio_in_named() passes the DeviceState pointer
> as the opaque data pointor for the irq handler function.  Usually
> this is what you want, but in some cases it would be helpful to use
> some other data pointer.
> 
> Add a new function qdev_init_gpio_in_named_with_opaque() which allows
> the caller to specify the data pointer they want.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/qdev-core.h | 30 ++++++++++++++++++++++++++++--
>  hw/core/qdev.c         |  8 +++++---
>  2 files changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index fc9d617a76..9453588160 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -311,10 +311,36 @@ BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
>  /* GPIO inputs also double as IRQ sinks.  */
>  void qdev_init_gpio_in(DeviceState *dev, qemu_irq_handler handler, int n);
>  void qdev_init_gpio_out(DeviceState *dev, qemu_irq *pins, int n);
> -void qdev_init_gpio_in_named(DeviceState *dev, qemu_irq_handler handler,
> -                             const char *name, int n);
>  void qdev_init_gpio_out_named(DeviceState *dev, qemu_irq *pins,
>                                const char *name, int n);
> +/**
> + * qdev_init_gpio_in_named_with_opaque: create an array of input GPIO lines
> + *   for the specified device
> + *
> + * @dev: Device to create input GPIOs for
> + * @handler: Function to call when GPIO line value is set
> + * @opaque: Opaque data pointer to pass to @handler
> + * @name: Name of the GPIO input (must be unique for this device)
> + * @n: Number of GPIO lines in this input set
> + */
> +void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
> +                                         qemu_irq_handler handler,
> +                                         void *opaque,
> +                                         const char *name, int n);
> +
> +/**
> + * qdev_init_gpio_in_named: create an array of input GPIO lines
> + *   for the specified device
> + *
> + * Like qdev_init_gpio_in_named_with_opaque(), but the opaque pointer
> + * passed to the handler is @dev (which is the most commonly desired behaviour).
> + */
> +static inline void qdev_init_gpio_in_named(DeviceState *dev,
> +                                           qemu_irq_handler handler,
> +                                           const char *name, int n)
> +{
> +    qdev_init_gpio_in_named_with_opaque(dev, handler, dev, name, n);
> +}
>  
>  void qdev_pass_gpios(DeviceState *dev, DeviceState *container,
>                       const char *name);
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 7ed1f431f0..f3754ee606 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -385,15 +385,17 @@ static NamedGPIOList *qdev_get_named_gpio_list(DeviceState *dev,
>      return ngl;
>  }
>  
> -void qdev_init_gpio_in_named(DeviceState *dev, qemu_irq_handler handler,
> -                             const char *name, int n)
> +void qdev_init_gpio_in_named_with_opaque(DeviceState *dev,
> +                                         qemu_irq_handler handler,
> +                                         void *opaque,
> +                                         const char *name, int n)
>  {
>      int i;
>      NamedGPIOList *gpio_list = qdev_get_named_gpio_list(dev, name);
>  
>      assert(gpio_list->num_out == 0 || !name);
>      gpio_list->in = qemu_extend_irqs(gpio_list->in, gpio_list->num_in, handler,
> -                                     dev, n);
> +                                     opaque, n);
>  
>      if (!name) {
>          name = "unnamed-gpio-in";
> 
