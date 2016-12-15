Received: from eggs.gnu.org ([2001:4830:134:3::10]:35437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHSSg-0002v5-E7
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cHSSd-00034R-9e
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:36:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cHSSd-00033q-1E
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:36:23 -0500
Date: Thu, 15 Dec 2016 10:36:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20161215103617.071b418d@nial.brq.redhat.com>
In-Reply-To: <1481744348-8868-1-git-send-email-ehabkost@redhat.com>
References: <1481744348-8868-1-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2] qmp: query-device-slots command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Laine Stump <laine@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Jason J. Herne" <jjherne@us.ibm.com>

On Wed, 14 Dec 2016 17:39:08 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> This adds a new command to QMP: query-device-slots. It will allow
> management software to query possible slots where devices can be
> plugged.
> 
> This implementation of the command will return:
> 
> * Multiple PCI slots per bus, in the case of PCI buses;
> * One slot per bus for the other buses (that don't
>   implement slot enumeration yet);
> * One slot for each entry from query-hotpluggable-cpus.
Perhaps command should handle slots enumeration for DIMM/NV-DIMM
devices as well which are also bus-less as cpus but don't have
dedicated command for possible slots enumeration.

[...]
> +##
> +# @DeviceSlotInfo:
> +#
> +# Information on a slot where devices can be plugged.
> +#
> +# @type: type of device slot.
> +#
> +# @accepted-device-types: List of device types accepted by the slot.
> +#                         Any device plugged to the slot should implement
> +#                         one of the accepted device types.
> +#
> +# @available: If false, the slot is not available for plugging any device.
> +#             This value can change at runtime if condition changes
> +#             (e.g. if the slot becomes full, or if the machine
> +#             was already initialized and the slot doesn't support
> +#             hotplug).
or slot has been freed as result of unplug action


> +# @hotpluggable: If true, the slot accepts hotplugged devices.
> +#
> +# @props: The arguments that should be given to @device_add if plugging
> +#         a device to this slot.
Could it be a list of arbitrary properties?
What do we gain making it a union of fixed types which are in the end just property lists?

[...]
> +{
> +    SlotListState s = { };
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    s.machine = ms;
> +    s.next = &s.result;
> +
> +    /* We build the device slot list from two sources:
> +     * 1) Calling the BusClass::enumerate_slots() method on all buses;
> +     * 2) The return value of MachineClass::query_hotpluggable_cpus()
> +     */
> +
> +
> +    object_child_foreach_recursive(qdev_get_machine(), walk_bus, &s);
> +    if (s.err) {
> +        goto out;
> +    }
> +
> +    if (mc->query_hotpluggable_cpus) {
> +        HotpluggableCPUList *hcl = mc->query_hotpluggable_cpus(ms);
> +        HotpluggableCPUList *i;
> +
> +        for (i = hcl; i; i = i->next) {
> +            DeviceSlotInfoList *r = g_new0(DeviceSlotInfoList, 1);
> +            HotpluggableCPU *hc = i->value;
> +            r->value = g_new0(DeviceSlotInfo, 1);
> +            r->value->type = DEVICE_SLOT_TYPE_CPU;
> +            r->value->accepted_device_types = g_new0(strList, 1);
> +            r->value->accepted_device_types->value = g_strdup(hc->type);
> +            r->value->available = !hc->has_qom_path;
> +            /*TODO: should it be always true? */
> +            r->value->hotpluggable = true;
it shouldn't be true for BSP, and for the rest of x86 cpus it's true
provided machine versions supports cpu hotplug.

But it might be another story for SPAPR or s390,
CCing maintainers.

> +
> +            r->value->u.cpu.props = QAPI_CLONE(CpuInstanceProperties,
> +                                               hc->props);
> +            *s.next = r;
> +            s.next = & r->next;
> +        }
> +
> +        qapi_free_HotpluggableCPUList(hcl);
> +    }
> +
> +out:
> +    error_propagate(errp, s.err);
> +    return s.result;
> +}
> +
>  
>  #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
>  static void qbus_print(Monitor *mon, BusState *bus, int indent);
