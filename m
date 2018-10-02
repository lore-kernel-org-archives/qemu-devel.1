Received: from eggs.gnu.org ([2001:4830:134:3::10]:33050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7TNG-0000n4-Bm
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 18:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7TNC-00022f-8c
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 18:42:38 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7TNC-00022D-0I
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 18:42:34 -0400
Received: by mail-wr1-f48.google.com with SMTP id y8-v6so3969307wrh.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 15:42:33 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-4-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2478a2c0-7f5f-556c-09c3-1fa503984f38@redhat.com>
Date: Wed, 3 Oct 2018 00:42:31 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-4-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/9] qdev-monitor: print the device's
 clock with info qtree
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

Hi Damien,

On 10/2/18 4:24 PM, Damien Hedde wrote:
> This prints the clocks attached to a DeviceState when using "info qtree" monitor
> command. For every clock, it displays the direction, the name and if the
> clock is forwarded. For input clock, it displays also the frequency.

What would also be really useful (during development mostly)
is a "info clktree" monitor command.

> 
> This is based on the original work of Frederic Konrad.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  qdev-monitor.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 61e0300991..8c39a3a65b 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -682,6 +682,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>      ObjectClass *class;
>      BusState *child;
>      NamedGPIOList *ngl;
> +    NamedClockList *clk;
>  
>      qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
>                  dev->id ? dev->id : "");
> @@ -696,6 +697,17 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
>                          ngl->num_out);
>          }
>      }
> +    QLIST_FOREACH(clk, &dev->clocks, node) {
> +        if (clk->out) {
> +            qdev_printf("clock-out%s \"%s\"\n",
> +                        clk->forward ? " (fw)" : "",
> +                        clk->name);
> +        } else {
> +            qdev_printf("clock-in%s \"%s\" freq=%" PRIu64 "Hz\n",

IMHO 'freq_hz=%" PRIu64 "\n"' is easier to read.

However if we plan to add/use a qemu_strtohz() similar to
qemu_strtosz_metric(), that would be fine.

> +                        clk->forward ? " (fw)" : "",
> +                        clk->name, clock_get_frequency(clk->in));
> +        }
> +    }
>      class = object_get_class(OBJECT(dev));
>      do {
>          qdev_print_props(mon, dev, DEVICE_CLASS(class)->props, indent);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
