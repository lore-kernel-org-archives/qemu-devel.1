Received: from eggs.gnu.org ([2001:4830:134:3::10]:50235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3rG5-0004WZ-H6
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f3rG4-00073V-Jf
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 18:52:01 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1522869306-17292-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba4e459e-5b7f-aa25-180c-9e7e9dd8a51a@amsat.org>
Date: Wed, 4 Apr 2018 19:51:51 -0300
MIME-Version: 1.0
In-Reply-To: <1522869306-17292-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12] hw/arm/integratorcp:
 Don't do things that could be fatal in the instance_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Hi Thomas,

On 04/04/2018 04:15 PM, Thomas Huth wrote:
> An instance_init function must not fail - and might be called multiple times,
> e.g. during device introspection with the 'device-list-properties' QMP
> command. Since the integratorcm device ignores this rule, QEMU currently
> aborts in this case (though it really should not):
> 
> echo "{'execute':'qmp_capabilities'}"\
>      "{'execute':'device-list-properties',"\
>      "'arguments':{'typename':'integrator_core'}}" \
>      | arm-softmmu/qemu-system-arm -M integratorcp,accel=qtest -qmp stdio
> {"QMP": {"version": {"qemu": {"micro": 91, "minor": 11, "major": 2},
>  "package": "build-all"}, "capabilities": []}}
> {"return": {}}
> RAMBlock "integrator.flash" already registered, abort!
> Aborted (core dumped)
> 
> Move the problematic code to the realize() function instead to fix this
> problem.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/integratorcp.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index e8303b8..9e2df34 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -266,7 +266,6 @@ static const MemoryRegionOps integratorcm_ops = {
>  static void integratorcm_init(Object *obj)
>  {
>      IntegratorCMState *s = INTEGRATOR_CM(obj);
> -    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>  
>      s->cm_osc = 0x01000048;
>      /* ??? What should the high bits of this value be?  */
> @@ -276,20 +275,28 @@ static void integratorcm_init(Object *obj)
>      s->cm_init = 0x00000112;
>      s->cm_refcnt_offset = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), 24,
>                                     1000);
> -    memory_region_init_ram(&s->flash, obj, "integrator.flash", 0x100000,
> -                           &error_fatal);
>  
> -    memory_region_init_io(&s->iomem, obj, &integratorcm_ops, s,
> -                          "integratorcm", 0x00800000);
> -    sysbus_init_mmio(dev, &s->iomem);
> -
> -    integratorcm_do_remap(s);
>      /* ??? Save/restore.  */
>  }
>  
>  static void integratorcm_realize(DeviceState *d, Error **errp)
>  {
>      IntegratorCMState *s = INTEGRATOR_CM(d);
> +    SysBusDevice *dev = SYS_BUS_DEVICE(d);
> +    Error *local_err = NULL;
> +
> +    memory_region_init_ram(&s->flash, (Object *)d, "integrator.flash", 0x100000,

To keep consistency:

    memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash", ...

> +                           &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->iomem, (Object *)d, &integratorcm_ops, s,

    memory_region_init_io(&s->iomem, OBJECT(d), &integratorcm_ops, s,

> +                          "integratorcm", 0x00800000);
> +    sysbus_init_mmio(dev, &s->iomem);
> +
> +    integratorcm_do_remap(s);
>  
>      if (s->memsz >= 256) {
>          integrator_spd[31] = 64;
> 

With the macro instead of the cast:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.
