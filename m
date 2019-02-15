Received: from eggs.gnu.org ([209.51.188.92]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubSQ-0001ND-9J
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gubSO-0002p2-9x
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gubSN-0002YX-T7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:15:00 -0500
Date: Fri, 15 Feb 2019 12:14:32 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190215121432.6823da96@Igors-MacBook-Pro.local>
In-Reply-To: <20190214205331.pvht6oqynndc2k7u@master>
References: <20190214005225.24048-1-richardw.yang@linux.intel.com>
	<20190214122527.5d2fcab8@redhat.com>
	<20190214205331.pvht6oqynndc2k7u@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com

On Thu, 14 Feb 2019 20:53:31 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Thu, Feb 14, 2019 at 12:25:27PM +0100, Igor Mammedov wrote:
> >On Thu, 14 Feb 2019 08:52:25 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >
> >> Currently we do device realization like below:
> >> 
> >>    hotplug_handler_pre_plug()
> >>    dc->realize()
> >>    hotplug_handler_plug()
> >> 
> >> Before we do device realization and plug, we would allocate necessary
> >> resources and check the capacity.
> >'capacity' probably is not right word to use here
> >maybe s/the capacity/if 'memory-hotplug-support' property is enabled/
> >
> >> 
> >> While we leave acpi_memory_hotplug capacity check in the last step. This
> >wouldn't use 'leave' and 'capacity' here either, pls rephrase.
> >
> >> looks not comply with current architecture and does some unnecessary
> >s/looks not/doesn't/
> >> work.
> >add more explanation about 'unnecessary work'.
> >problem as I see it, is that after successful pc_dimm_plug()
> >we get into piix4_device_plug_cb() and since
> > s->acpi_memory_hotplug.is_enabled == false
> >and all other 'if' conditions also false we would endup
> >at g_assert_not_reached() causing QEMU crash in piix4 case
> >and with error_abort up the call chain in case of ich9.
> >
> 
> Thanks Igor, I rephrase above change log like this. Does this look
> better to you now?
> 
>     Before we do device realization and plug, we would allocate
s/would/should/

>     necessary resources and check if memory-hotplug-support property is
>     enabled.
>     
>     In piix4 and ich9, the acpi_memory_hotplug property is checked in
s/in/at the/
>     plug stage, this doesn't comply with current architecture. This
drop              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     means we have prepared everything and even do pc_dimm_plug()
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
that device has been realized and mapped into guest address space
'pc_dimm_plug()' by the time acpi plug handler is called, where it might
fail and crash QEMU due to reaching  g_assert_not_reached() (piix4) or
error_abort (ich9).

or something like this, I'm not native speaker either so CC Eric Blake
on next respin so he could check commit message.

>     successfuly, but failed at last because
>     acpi_memory_hotplug.is_enabled == false. Which is worse is in piix4,
>     this endup at g_assert_not_reached() and cause QEMU crash.
> 
> 
> >> This patch abstract the check on acpi_memory_hotplug capacity in
> >> pre_plug stage.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  hw/acpi/piix4.c | 14 ++++++++++++--
> >>  hw/i386/pc.c    |  8 ++++++++
> >doesn't look complete, why did you skip on similar code in ich9
> >(Q35 machine)?
> >
> 
> You are right, I missed this part.
> 
> >>  2 files changed, 20 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >> index e330f24c71..c97b747496 100644
> >> --- a/hw/acpi/piix4.c
> >> +++ b/hw/acpi/piix4.c
> >> @@ -370,13 +370,22 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> >>      acpi_pm1_evt_power_down(&s->ar);
> >>  }
> >>  
> >> +static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >> +                                 DeviceState *dev, Error **errp)
> >> +{
> >> +    PIIX4PMState *s = PIIX4_PM(hotplug_dev);
> >> +
> >> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> >> +        !s->acpi_memory_hotplug.is_enabled)
> >> +        error_setg(errp,
> >> +            "memory hotplug is not enabled: PIIX4 memory hotplug disabled");
> >> +}
> >>  static void piix4_device_plug_cb(HotplugHandler *hotplug_dev,
> >>                                   DeviceState *dev, Error **errp)
> >>  {
> >>      PIIX4PMState *s = PIIX4_PM(hotplug_dev);
> >>  
> >> -    if (s->acpi_memory_hotplug.is_enabled &&
> >> -        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >>          if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> >>              nvdimm_acpi_plug_cb(hotplug_dev, dev);
> >>          } else {
> >> @@ -702,6 +711,7 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
> >>       */
> >>      dc->user_creatable = false;
> >>      dc->hotpluggable = false;
> >> +    hc->pre_plug = piix4_device_pre_plug_cb;
> >>      hc->plug = piix4_device_plug_cb;
> >>      hc->unplug_request = piix4_device_unplug_request_cb;
> >>      hc->unplug = piix4_device_unplug_cb;
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index 734d3268fa..3c6eed0cd3 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1662,6 +1662,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>      const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> >>      const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> >>      const uint64_t legacy_align = TARGET_PAGE_SIZE;
> >> +    HotplugHandlerClass *hhc;
> >>  
> >>      /*
> >>       * When -no-acpi is used with Q35 machine type, no ACPI is built,
> >> @@ -1674,6 +1675,13 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>          return;
> >>      }
> >>  
> >> +    /*
> >> +     * Check acpi_dev memory hotplug capacity
> >> +     */
> >> +    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >> +    if (hcc->pre_plug)
> >> +        hhc->pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, errp);
> >use hotplug_handler_pre_plug() instead of open-coding check
> >
> 
> Thanks, will fix this.
> 
> >>      if (is_nvdimm && !pcms->acpi_nvdimm_state.is_enabled) {
> >>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
> >>          return;
> >
> 
