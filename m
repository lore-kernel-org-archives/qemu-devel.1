Received: from eggs.gnu.org ([2001:4830:134:3::10]:46546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1calkT-0006ZO-TJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1calkQ-00052Z-3X
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:02:37 -0500
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:38356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1calkP-00051y-Tb
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:02:34 -0500
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 57C38A19B9
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:02:32 +0100 (CET)
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-5-git-send-email-fred.konrad@greensocs.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6c6b722-a7e0-ce13-3a86-451c1ca0b5ec@kaod.org>
Date: Mon, 6 Feb 2017 17:02:25 +0100
MIME-Version: 1.0
In-Reply-To: <1485424060-12217-5-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 04/10] qemu-clk: introduce an init array
 to help the device construction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, alistair.francis@xilinx.com

On 01/26/2017 10:47 AM, fred.konrad@greensocs.com wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> This introduces a clock init array to ease the clock tree construction.

I think this belongs to the zynqmp-crf model.

Thanks,

C. 

 
> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> ---
>  include/qemu/qemu-clock.h | 23 +++++++++++++++++++++++
>  qemu-clock.c              | 17 +++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
> index 6d30299..45f8766 100644
> --- a/include/qemu/qemu-clock.h
> +++ b/include/qemu/qemu-clock.h
> @@ -49,6 +49,29 @@ struct ClkList {
>      QLIST_ENTRY(ClkList) node;
>  };
>  
> +typedef struct ClockInitElement {
> +    const char *name;      /* Name to give to the clock. */
> +    size_t offset;         /* Offset of the qemu_clk field in the object. */
> +    QEMUClkRateUpdateCallback *cb;
> +} ClockInitElement;
> +
> +#define DEVICE_CLOCK(_state, _field, _cb) {                                  \
> +    .name = #_field,                                                         \
> +    .offset = offsetof(_state, _field),                                      \
> +    .cb = _cb                                                                \
> +}
> +
> +#define DEVICE_CLOCK_END() {                                                 \
> +    .name = NULL                                                             \
> +}
> +
> +/**
> + * qemu_clk_init_device:
> + * @obj: the Object which need to be initialized.
> + * @array: the array of ClockInitElement to be used.
> + */
> +void qemu_clk_init_device(Object *obj, ClockInitElement *array);
> +
>  /**
>   * qemu_clk_device_add_clock:
>   * @dev: the device on which the clock needs to be added.
> diff --git a/qemu-clock.c b/qemu-clock.c
> index 8c12368..300e38f 100644
> --- a/qemu-clock.c
> +++ b/qemu-clock.c
> @@ -26,6 +26,7 @@
>  #include "hw/hw.h"
>  #include "qemu/log.h"
>  #include "qapi/error.h"
> +#include "hw/qdev-core.h"
>  
>  #ifndef DEBUG_QEMU_CLOCK
>  #define DEBUG_QEMU_CLOCK 0
> @@ -37,6 +38,22 @@
>      }                                                                        \
>  } while (0);
>  
> +void qemu_clk_init_device(Object *obj, ClockInitElement *array)
> +{
> +    qemu_clk *cur = NULL;
> +
> +    while (array->name != NULL) {
> +        DPRINTF("init clock named %s\n", array->name);
> +        cur = (((void *)obj) + array->offset);
> +        *cur = QEMU_CLOCK(object_new(TYPE_CLOCK));
> +        qemu_clk_device_add_clock(DEVICE(obj), *cur, array->name);
> +        if (array->cb) {
> +            qemu_clk_set_callback(*cur, array->cb, obj);
> +        }
> +        array++;
> +    }
> +}
> +
>  void qemu_clk_refresh(qemu_clk clk)
>  {
>      qemu_clk_update_rate(clk, clk->in_rate);
> 
