Received: from eggs.gnu.org ([2001:4830:134:3::10]:40464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cak9k-0008IC-9e
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:20:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cak9e-0003FA-3L
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:20:36 -0500
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cak9d-0003DZ-SO
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:20:30 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 65E2B370E9
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 15:20:23 +0100 (CET)
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-3-git-send-email-fred.konrad@greensocs.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6b974238-ab18-8bd5-ffe7-6f07627f59f3@kaod.org>
Date: Mon, 6 Feb 2017 15:20:14 +0100
MIME-Version: 1.0
In-Reply-To: <1485424060-12217-3-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 02/10] qemu-clk: allow to add a clock to
 a device
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
> This allows to add a clock to a DeviceState.
> Contrary to gpios, the clock pins are not contained in the DeviceState but
> with the child property so they can appears in the qom-tree.
> 
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> 
> V1 -> V2:
>   * Rename the function use 'add' instead of 'attach'
> ---
>  include/qemu/qemu-clock.h | 24 +++++++++++++++++++++++-
>  qemu-clock.c              | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/qemu-clock.h b/include/qemu/qemu-clock.h
> index e7acd68..3e692d3 100644
> --- a/include/qemu/qemu-clock.h
> +++ b/include/qemu/qemu-clock.h
> @@ -33,8 +33,30 @@
>  typedef struct qemu_clk {
>      /*< private >*/
>      Object parent_obj;
> +    char *name;            /* name of this clock in the device. */
>  } *qemu_clk;
>  
> -#endif /* QEMU_CLOCK_H */
> +/**
> + * qemu_clk_device_add_clock:
> + * @dev: the device on which the clock needs to be added.
> + * @clk: the clock which needs to be added.
> + * @name: the name of the clock can't be NULL.
> + *
> + * Add @clk to device @dev as a clock named @name.
> + *
> + */
> +void qemu_clk_device_add_clock(DeviceState *dev, qemu_clk clk,
> +                               const char *name);
>  
> +/**
> + * qemu_clk_device_get_clock:
> + * @dev: the device which contains the clock.
> + * @name: the name of the clock.
> + *
> + * Get the clock named @name contained in the device @dev, or NULL if not found.
> + *
> + * Returns the clock named @name contained in @dev.
> + */
> +qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name);
>  
> +#endif /* QEMU_CLOCK_H */
> diff --git a/qemu-clock.c b/qemu-clock.c
> index ceea98d..803deb3 100644
> --- a/qemu-clock.c
> +++ b/qemu-clock.c
> @@ -25,6 +25,7 @@
>  #include "qemu/qemu-clock.h"
>  #include "hw/hw.h"
>  #include "qemu/log.h"
> +#include "qapi/error.h"
>  
>  #ifndef DEBUG_QEMU_CLOCK
>  #define DEBUG_QEMU_CLOCK 0
> @@ -36,6 +37,28 @@
>      }                                                                        \
>  } while (0);
>  
> +void qemu_clk_device_add_clock(DeviceState *dev, qemu_clk clk,
> +                               const char *name)
> +{
> +    assert(name);
> +    assert(!clk->name);
> +    object_property_add_child(OBJECT(dev), name, OBJECT(clk), &error_abort);
> +    clk->name = g_strdup(name);
> +}
> +
> +qemu_clk qemu_clk_device_get_clock(DeviceState *dev, const char *name)
> +{
> +    gchar *path = NULL;
> +    Object *clk;
> +    bool ambiguous;
> +
> +    path = g_strdup_printf("%s/%s", object_get_canonical_path(OBJECT(dev)),
> +                           name);
> +    clk = object_resolve_path(path, &ambiguous);
> +    g_free(path);
> +    return QEMU_CLOCK(clk);
> +}


I see how these routines are used in patch 10/10. But if we were
open coding device CRF_APB, I don't think we would need them at
all and it would make the code a little simple IMHO.

Thanks,

C.  

>  static const TypeInfo qemu_clk_info = {
>      .name          = TYPE_CLOCK,
>      .parent        = TYPE_OBJECT,
> 
