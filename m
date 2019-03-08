Received: from eggs.gnu.org ([209.51.188.92]:42219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2JVw-0003gX-Q7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h2JVw-0004Co-2Y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:42:32 -0500
Date: Fri, 8 Mar 2019 14:42:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190308174214.GD8899@habkost.net>
References: <20190308152511.10882-1-eric.auger@redhat.com>
	<20190308152511.10882-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308152511.10882-3-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] machine: Move nvdimms state into
 struct MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com, philmd@redhat.com

On Fri, Mar 08, 2019 at 04:25:11PM +0100, Eric Auger wrote:
[...]
> @@ -791,6 +833,28 @@ static void machine_initfn(Object *obj)
>      ms->mem_merge = true;
>      ms->enable_graphics = true;
>  
> +    if (mc->nvdimm_supported) {
> +        ObjectClass *oc = OBJECT_CLASS(mc);
> +
> +        ms->nvdimms_state = g_new0(NVDIMMState, 1);

Initializing ms->nvdimms_state inside machine_initfn()
only if mc->nvdimm_support makes sense.

But:

> +        object_class_property_add_bool(oc, "nvdimm",
> +                                       machine_get_nvdimm, machine_set_nvdimm,
> +                                       &error_abort);
> +        object_class_property_set_description(oc, "nvdimm",
> +                                             "Set on/off to enable/disable "
> +                                             "NVDIMM instantiation", NULL);
> +
> +        object_class_property_add_str(oc, "nvdimm-persistence",
> +                                      machine_get_nvdimm_persistence,
> +                                      machine_set_nvdimm_persistence,
> +                                      &error_abort);
> +        object_class_property_set_description(oc, "nvdimm-persistence",
> +                                             "Set NVDIMM persistence"
> +                                             "Valid values are cpu, mem-ctrl",
> +                                              NULL);

Calling object_class_property_add_*() inside instance_init
defeats the purpose of class properties.  I suggest either using
object_property_add_*(), or registering these class properties in
machine_class_base_init().


> [...]

-- 
Eduardo
