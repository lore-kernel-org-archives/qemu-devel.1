Received: from eggs.gnu.org ([209.51.188.92]:58119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ghHQY-0002yR-MB
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1ghHQW-0006nG-Ns
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 12:14:02 -0500
References: <20190103094211.28473-1-geert+renesas@glider.be>
	<acd10959-a781-d3bf-dc67-bda878740ec9@redhat.com>
	<CAMuHMdXgoAL7B0F4pL51uLcQZWM0BLisDSAXMhW5O3s0yGVGMg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a3727fb9-bee7-8a2e-d444-6fbd5a53e486@redhat.com>
Date: Wed, 9 Jan 2019 18:13:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXgoAL7B0F4pL51uLcQZWM0BLisDSAXMhW5O3s0yGVGMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH QEMU v5] hw/arm/sysbus-fdt: Add support for
 instantiating generic devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Geert,

On 1/9/19 5:15 PM, Geert Uytterhoeven wrote:
> Hi Eric,
> 
> Thanks for your comments!
> 
> On Wed, Jan 9, 2019 at 4:56 PM Auger Eric <eric.auger@redhat.com> wrote:
>> On 1/3/19 10:42 AM, Geert Uytterhoeven wrote:
>>> Add a fallback for instantiating generic devices without a type-specific
>>> or compatible-specific instantiation method.  This will be used when no
>>> other match is found.
>>>
>>> Generic device instantiation avoids having to write device-specific
>>> instantiation methods for each and every "simple" device using only a
>>> set of generic properties.  Devices that need more specialized handling
>>> can still provide their own instantiation methods.
>>>
>>> The generic instantiation method creates a device node with remapped
>>> "reg" and (optional) "interrupts" properties, and copies properties from
>>> the host, if deemed appropriate:
>>>   - In general, properties without phandles are safe to be copied.
>>>     Unfortunately, the FDT does not carry type information, hence an
>>>     explicit whitelist is used, which can be extended when needed.
>>>   - Properties related to power management (power and/or clock domain),
>>>     isolation, and pin control, are handled by the host, and must not to
>>>     be copied.
>>>
>>> Devices nodes with subnodes are rejected, as subnodes cannot easily be
>>> handled in a generic way.
>>>
>>> This has been tested on a Renesas Salvator-XS board (R-Car H3 ES2.0)
>>> with SATA, using:
>>>
>>>     -device vfio-platform,host=ee300000.sata
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>> Note: Also tested with GPIO, which needs "vfio: No-IOMMU mode support":
>>>
>>>     -device vfio-platform,host=e6055400.gpio
>>>
>>> v5:
>>>   - Replace copying of a fixed list of properties (and ignoring all
>>>     others), by scanning all properties on the host, and deciding if
>>>     they need to be ignored, copied, or rejected,
>>>   - Reject device nodes with subnodes,
>>>   - Handle edge interrupts,
>>>
>>> v3:
>>>   - New.
> 
>>> --- a/hw/arm/sysbus-fdt.c
>>> +++ b/hw/arm/sysbus-fdt.c
> 
>>> +static struct {
>>> +    const char *name;
>>> +    enum GenericPropertyAction action;
>>> +} generic_properties[] = {
>>> +    { "name",            PROP_IGNORE }, /* handled automatically */
>>> +    { "phandle",         PROP_IGNORE }, /* not needed for the generic case */
>>> +
>>> +    /* The following are copied and remapped by dedicated code */
>>> +    { "reg",             PROP_IGNORE },
>>> +    { "interrupts",      PROP_IGNORE },
>> Shouldn't interrupt-parent be safely ignored as remapped?
> 
> Probably. Typically interrupt-parent is present at a higher level.
> And interrupts-extended should be ignored, too.
> 
>>> +
>>> +    /* The following are handled by the host */
>>> +    { "power-domains",   PROP_IGNORE }, /* power management (+ opt. clocks) */
>>> +    { "iommus",          PROP_IGNORE }, /* isolation */
>>> +    { "resets",          PROP_IGNORE }, /* isolation */
>>> +    { "pinctrl-*",       PROP_IGNORE }, /* pin control */
>>> +
>>> +    /* Ignoring the following may or may not work, hence the warning */
>>> +    { "gpio-ranges",     PROP_WARN },   /* no support for pinctrl yet */
>>> +    { "dmas",            PROP_WARN },   /* no support for external DMACs yet */
>> I would be tempted to simply reject things that may not work.
> 
> I kept gpio-ranges, as it works with my rcar-gpio proof of concept
> (depends on with no-iommu support).
> Without dmas, drivers are supposed to fall back to PIO.  If a driver
> doesn't support that, it will complain.
In general I am concerned about allowing things we are not 100% sure
they will work. I would rather say either the node is sufficiently
simple and we can afford relying on a very simple and generic node
creation function or we may request a specific node creation function.
> 
>>> +
>>> +    /* The following are irrelevant, as corresponding specifiers are ignored */
>>> +    { "clock-names",     PROP_IGNORE },
>>> +    { "reset-names",     PROP_IGNORE },
>>> +    { "dma-names",       PROP_IGNORE },
>>> +
>>> +    /* Whitelist of properties not taking phandles, and thus safe to copy */
>>> +    { "compatible",      PROP_COPY },
>>> +    { "status",          PROP_COPY },
>>> +    { "reg-names",       PROP_COPY },
>>> +    { "interrupt-names", PROP_COPY },
>>> +    { "#*-cells",        PROP_COPY },
>>> +};
>>> +
>>> +#ifndef CONFIG_FNMATCH
>>> +/* Fall back to exact string matching instead of allowing wildcards */
>>> +static inline int fnmatch(const char *pattern, const char *string, int flags)
>>> +{
>>> +        return strcmp(pattern, string);
>>> +}
>>> +#endif
> 
>>> +/**
>>> + * copy_generic_node
>>> + *
>>> + * Copy the generic part of a DT node from the host
>>> + */
>>> +static void copy_generic_node(void *host_fdt, void *guest_fdt, char *host_path,
>>> +                              char *guest_path)
>>> +{
>>> +    int node, prop, len;
>>> +    const void *data;
>>> +    const char *name;
>>> +    enum GenericPropertyAction action;
>>> +
>>> +    node = fdt_path_offset(host_fdt, host_path);
>>> +    if (node < 0) {
>>> +        error_report("Cannot find node %s: %s", host_path, fdt_strerror(node));
>>> +        exit(1);
>>> +    }
>>> +
>>> +    /* Submodes are not yet supported */
>>> +    if (fdt_first_subnode(host_fdt, node) >= 0) {
>>> +        error_report("%s has unsupported subnodes", host_path);
>>> +        goto unsupported;
>>> +    }
>>> +
>>> +    /* Copy generic properties */
>>> +    fdt_for_each_property_offset(prop, host_fdt, node) {
>>> +        data = fdt_getprop_by_offset(host_fdt, prop, &name, &len);
>>> +        if (!data) {
>>> +            error_report("Cannot get property of %s: %s", host_path,
>>> +                         fdt_strerror(len));
>>> +            exit(1);
>>> +        }
>>> +
>>> +        if (!len) {
>>> +            /* Zero-sized properties are safe to copy */
>>> +            action = PROP_COPY;
>>> +        } else if (!strcmp(name, "clocks")) {
>>> +            /* Reject "clocks" if "power-domains" is not present */
>> Could you elaborate on clock management with and without power-domain.
>> If clock handles can be found on host side, don't we need to generate
>> clock nodes on guest side (as what was done with the amd xgmac). And in
>> that case don't you need clock-names prop too?
>>
>> Please can you explain how the fact power-domain is not present
>> simplifies the problem. It is not obvious to me.
> 
> In the presence of a power-domains property, it's possible the clocks are
> used for power management only (if the device is part of a clock domain).
> In that case, the guest doesn't need to manage the clock.
> Qemu will still print a warning, as it cannot be 100% sure that the clocks
> are not needed.
Thank you for the explanation. possible but 100% sure. Is it acceptable?
But I now understand this would kill your SATA use case.
> 
> In the absence of a power-domains property, it is assumed the clocks are
> needed, and the device node is rejected.
> Qemu could be enhanced to inspect all clocks and copy fixed-rate clocks,
> like is done for xgmac, but that can be added later, if someone has a need
> for it.
> 
> For an initial version, I try to keep it generic, but not too complicated ;-)
> 
> For complex cases, you can always write a device-specific instantiation
> method.
sure
> 
>>> +            action = fdt_getprop(host_fdt, node, "power-domains", NULL)
>>> +                     ? PROP_WARN : PROP_REJECT;
>>> +        } else {
>>> +            action = get_generic_property_action(name);
>>> +        }
>>> +
>>> +        switch (action) {
>>> +        case PROP_WARN:
>>> +            warn_report("%s: Ignoring %s property", host_path, name);
>>> +        case PROP_IGNORE:
>>> +            break;
>>> +
>>> +        case PROP_COPY:
>>> +            qemu_fdt_setprop(guest_fdt, guest_path, name, data, len);
>>> +            break;
>>> +
>>> +        case PROP_REJECT:
>>> +            error_report("%s has unsupported %s property", host_path, name);
>>> +            goto unsupported;
>>> +        }
>>> +    }
>>> +    return;
>>> +
>>> +unsupported:
>>> +    error_report("You can ask a wizard to enhance me");
>> maybe report which property causes the assignment abort
> 
> That's already done above.
oups sorry


> 
>>> +    exit(1);
>>> +}
>>> +
>>> +/**
>>> + * add_generic_fdt_node
>>> + *
>>> + * Generates a generic DT node by copying properties from the host
>>> + */
>>> +static int add_generic_fdt_node(SysBusDevice *sbdev, void *opaque)
>>> +{
>>> +    PlatformBusFDTData *data = opaque;
>>> +    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
>>> +    const char *parent_node = data->pbus_node_name;
>>> +    void *guest_fdt = data->fdt, *host_fdt;
>>> +    VFIODevice *vbasedev = &vdev->vbasedev;
>>> +    char **node_path, *node_name, *dt_name;
>>> +    PlatformBusDevice *pbus = data->pbus;
>>> +    uint32_t *reg_attr, *irq_attr;
>>> +    uint64_t mmio_base;
>>> +    int i, irq_number;
>>> +    VFIOINTp *intp;
>>> +
>>> +    host_fdt = load_device_tree_from_sysfs();
>>> +
>>> +    dt_name = sysfs_to_dt_name(vbasedev->name);
>>> +    if (!dt_name) {
>>> +        error_report("%s incorrect sysfs device name %s", __func__,
>>> +                     vbasedev->name);
>>> +        exit(1);
>>> +    }
>>> +    node_path = qemu_fdt_node_path(host_fdt, dt_name, vdev->compat,
>>> +                                   &error_fatal);
>>> +    if (!node_path || !node_path[0]) {
>>> +        error_report("%s unable to retrieve node path for %s/%s", __func__,
>>> +                     dt_name, vdev->compat);
>>> +        exit(1);
>>> +    }
>>> +
>>> +    if (node_path[1]) {
>>> +        error_report("%s more than one node matching %s/%s!", __func__,
>>> +                     dt_name, vdev->compat);
>>> +        exit(1);
>>> +    }
>> The above part now is duplicated with code in add_amd_xgbe_fdt_node().
>> couldn't we factorize this into an helper such like
>> char [*]*get_host_node_path(VFIODevice *vbasedev).
> 
> Sure.
> 
>> Could you share the SATA node that was generated with the generic function.
> 
> Sure. The original one on the host is
> (from arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts):
> 
>         sata@ee300000 {
>                 compatible = "renesas,sata-r8a7795", "renesas,rcar-gen3-sata";
>                 reg = <0 0xee300000 0 0x200000>;
>                 interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&cpg CPG_MOD 815>;
>                 power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
thanks for sharing

Eric
>                 resets = <&cpg 815>;
>                 status = "okay";
>                 iommus = <&ipmmu_hc 2>;
>         };
> 
> The one on the guest is (wrapped in the platform subnode):
> 
>         platform@c000000 {
>                 interrupt-parent = <0x8001>;
>                 #address-cells = <0x1>;
>                 #size-cells = <0x1>;
>                 compatible = "qemu,platform", "simple-bus";
>                 ranges = <0x0 0x0 0xc000000 0x2000000>;
> 
>                 ee300000.sata@0 {
>                         status = "okay";
>                         reg = <0x0 0x200000>;
>                         interrupts = <0x0 0x70 0x4>;
>                         compatible = "renesas,sata-r8a7795",

> "renesas,rcar-gen3-sata";
>                 };
>         };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
