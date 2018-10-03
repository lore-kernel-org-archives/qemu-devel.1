Received: from eggs.gnu.org ([2001:4830:134:3::10]:39930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7cRg-0000l8-Eg
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7cRb-000198-BN
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:23:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7cRa-00018g-Ty
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 04:23:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so5037813wrw.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 01:23:42 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-5-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37f8bd6e-d4fa-76bd-ae9f-dfd4f856cf3c@redhat.com>
Date: Wed, 3 Oct 2018 10:23:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-5-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 4/9] qdev-clock: introduce an init array
 to ease the device construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

On 02/10/2018 16:24, Damien Hedde wrote:
> Introduce a function and macro helpers to setup several clocks
> in a device from a static array description.
> 
> An element of the array describes the clock (name and direction) as
> well as the related callback and an optional offset to store the
> created object pointer in the device state structure.
> 
> The array must be terminated by a special element QDEV_CLOCK_END.
> 
> This is based on the original work of Frederic Konrad.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  include/hw/qdev-clock.h | 67 +++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev-clock.c    | 26 ++++++++++++++++
>  2 files changed, 93 insertions(+)
> 
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> index d76aa9f479..fba907dee2 100644
> --- a/include/hw/qdev-clock.h
> +++ b/include/hw/qdev-clock.h
> @@ -59,4 +59,71 @@ void qdev_connect_clock(DeviceState *dev, const char *name,
>                          DeviceState *driver, const char *driver_name,
>                          Error **errp);
>  
> +/**
> + * ClockInitElem:
> + * @name: name of the clock (can't be NULL)
> + * @output: indicates whether the clock is input or output
> + * @callback: for inputs, optional callback to be called on clock's update
> + * with device as opaque
> + * @offset: optional offset to store the clock pointer in device'state

... to store the the ClockIn or ClockOut pointer in device state

> + * structure (0 means unused)
> + */
> +struct ClockPortInitElem {
> +    const char *name;
> +    bool output;

Maybe name this 'is_output'

> +    ClockCallback *callback;
> +    size_t offset;
> +};
> +
> +#define clock_offset_value(_type, _devstate, _field) \
> +    (offsetof(_devstate, _field) + \
> +     type_check(_type *, typeof_field(_devstate, _field)))
> +
> +#define QDEV_CLOCK(_output, _type, _devstate, _field, _callback) { \

Ditto.

> +    .name = (stringify(_field)), \
> +    .output = _output, \
> +    .callback = _callback, \
> +    .offset = clock_offset_value(_type, _devstate, _field), \
> +}
> +
> +/**
> + * QDEV_CLOCK_(IN|OUT):
> + * @_devstate: structure type. @dev argument of qdev_init_clocks below must be
> + * a pointer to that same type.
> + * @_field: a field in @_devstate (must be ClockIn* or ClockOut*)
> + * @_callback: (for input only) callback (or NULL) to be called with the device
> + * state as argument
> + *
> + * The name of the clock will be derived from @_field
> + */
> +#define QDEV_CLOCK_IN(_devstate, _field, _callback) \
> +    QDEV_CLOCK(false, ClockIn, _devstate, _field, _callback)
> +
> +#define QDEV_CLOCK_OUT(_devstate, _field) \
> +    QDEV_CLOCK(true, ClockOut, _devstate, _field, NULL)
> +
> +/**
> + * QDEV_CLOCK_IN_NOFIELD:
> + * @_name: name of the clock
> + * @_callback: callback (or NULL) to be called with the device state as argument
> + */
> +#define QDEV_CLOCK_IN_NOFIELD(_name, _callback) { \
> +    .name = _name, \
> +    .output = false, \
> +    .callback = _callback, \
> +    .offset = 0, \
> +}
> +
> +#define QDEV_CLOCK_END { .name = NULL }
> +
> +typedef struct ClockPortInitElem ClockPortInitArray[];
> +
> +/**
> + * qdev_init_clocks:
> + * @dev: the device to add clocks
> + * @clocks: a QDEV_CLOCK_END-terminated array which contains the
> + * clocks information.
> + */
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks);
> +
>  #endif /* QDEV_CLOCK_H */
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index f0e4839aed..08afe3983d 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -138,3 +138,29 @@ void qdev_connect_clock(DeviceState *dev, const char *name,
>  
>      clock_connect(ncl->in , drv_ncl->out);
>  }
> +
> +void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
> +{
> +    const struct ClockPortInitElem *elem;
> +
> +    assert(dev);
> +    assert(clocks);
> +
> +    for (elem = &clocks[0]; elem->name != NULL; elem++) {
> +        /* offset cannot be inside the DeviceState part */
> +        assert(elem->offset == 0 || elem->offset > sizeof(DeviceState));
> +        if (elem->output) {
> +            ClockOut *clk;
> +            clk = qdev_init_clock_out(dev, elem->name);
> +            if (elem->offset) {
> +                *(ClockOut **)(((void *) dev) + elem->offset) = clk;
> +            }
> +        } else {
> +            ClockIn *clk;
> +            clk = qdev_init_clock_in(dev, elem->name, elem->callback, dev);
> +            if (elem->offset) {
> +                *(ClockIn **)(((void *) dev) + elem->offset) = clk;
> +            }
> +        }
> +    }
> +}
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
