Received: from eggs.gnu.org ([209.51.188.92]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1sO0-0002xJ-3F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h1sNz-0000In-8P
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:44:32 -0500
Date: Thu, 7 Mar 2019 09:44:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190307124419.GA8899@habkost.net>
References: <20190307090639.8261-1-eric.auger@redhat.com>
	<20190307104859.248a7608@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307104859.248a7608@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] machine: Move acpi_nvdimm_state into
 struct MachineState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, david@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org, sbhat@linux.ibm.com, Markus Armbruster <armbru@redhat.com>

On Thu, Mar 07, 2019 at 10:48:59AM +0100, Igor Mammedov wrote:
[...]
> > +static void machine_set_nvdimm_persistence(Object *obj, const char *value,
> > +                                               Error **errp)
> > +{
> > +    MachineState *ms = MACHINE(obj);
> > +    AcpiNVDIMMState *nvdimms_state = &ms->nvdimms_state;
> > +
> > +    if (strcmp(value, "cpu") == 0)
> > +        nvdimms_state->persistence = 3;
> we probably should use QAPI enum magic to handle description to value conversion
> but I don't know how to (CCed Markus).

QEMU is not very consistent in this.  I have found at least 3
different methods for registering enum properties:

1) qdev PropertyInfo using set_enum/get_enum.  Examples:
   DEFINE_PROP_ON_OFF_AUTO, DEFINE_PROP_LOSTTICKPOLICY.
2) object_property_add() + visit_type_...().  Examples:
   machine_set_kernel_irqchip(), pc_machine_set_vmport(),
   pc_machine_set_smm().
3) object_property_add_add_enum() and object_class_property_add_enum().  Examples:
   qauthz_list_prop_set_policy(), host_memory_backend_set_policy(),
   qcrypto_secret_prop_set_format(), netfilter_set_direction().

> But since it's just moving existing code, it do not insist and it could be
> done on top later on.

Agreed, but I think we should at least add a TODO comment
indicating the code is not a good example to be followed.

-- 
Eduardo
