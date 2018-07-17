Received: from eggs.gnu.org ([2001:4830:134:3::10]:39175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ffTuf-0007l5-NI
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ffTuc-0007Oy-Gf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:37:25 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1ffTuc-0007NX-7T
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 13:37:22 -0400
Received: by mail-lj1-x244.google.com with SMTP id 203-v6so1687769ljj.13
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 10:37:20 -0700 (PDT)
Date: Tue, 17 Jul 2018 19:37:16 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20180717173716.h2bhmmco7uoj2nvp@toto>
References: <1531839343-13828-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531839343-13828-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/microblaze/xlnx-zynqmp-pmu: Fix
 introspection problem in 'xlnx, zynqmp-pmu-soc'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>

On Tue, Jul 17, 2018 at 04:55:43PM +0200, Thomas Huth wrote:
> Valgrind complains:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'xlnx,zynqmp-pmu-soc'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q microblazeel-softmmu/qemu-system-microblazeel -M none,accel=qtest -qmp stdio
> [...]
> ==13605== Invalid read of size 8
> ==13605==    at 0x2AC69A: qdev_print (qdev-monitor.c:686)
> ==13605==    by 0x2AC69A: qbus_print (qdev-monitor.c:719)
> ==13605==    by 0x2591E8: handle_hmp_command (monitor.c:3446)
> 
> Use the new object_initialize_child() and sysbus_init_child_obj() to
> fix the issue.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Peter, could you pick this up for 3.0? Or do you want a pull request?

Cheers,
Edgar


> ---
>  hw/microblaze/xlnx-zynqmp-pmu.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
> index 999a565..57dc1cc 100644
> --- a/hw/microblaze/xlnx-zynqmp-pmu.c
> +++ b/hw/microblaze/xlnx-zynqmp-pmu.c
> @@ -62,13 +62,11 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
>  {
>      XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(obj);
>  
> -    object_initialize(&s->cpu, sizeof(s->cpu),
> -                      TYPE_MICROBLAZE_CPU);
> -    object_property_add_child(obj, "pmu-cpu", OBJECT(&s->cpu),
> -                              &error_abort);
> +    object_initialize_child(obj, "pmu-cpu", &s->cpu, sizeof(s->cpu),
> +                            TYPE_MICROBLAZE_CPU, &error_abort, NULL);
>  
> -    object_initialize(&s->intc, sizeof(s->intc), TYPE_XLNX_PMU_IO_INTC);
> -    qdev_set_parent_bus(DEVICE(&s->intc), sysbus_get_default());
> +    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
> +                          TYPE_XLNX_PMU_IO_INTC);
>  }
>  
>  static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
> -- 
> 1.8.3.1
> 
