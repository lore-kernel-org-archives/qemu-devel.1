Received: from eggs.gnu.org ([209.51.188.92]:43839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzMQO-0008Sx-E3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzMQM-0002Kz-GN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:12:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gzMQJ-0002I1-Rw
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:12:32 -0500
Date: Thu, 28 Feb 2019 15:12:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190228151221.5909ff92@redhat.com>
In-Reply-To: <20190228011325.GA5515@richard>
References: <20190225010708.27385-1-richardw.yang@linux.intel.com>
	<20190225011534.GA27727@richard>
	<20190227190402.6c50c8ff@redhat.com>
	<20190228011325.GA5515@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

On Thu, 28 Feb 2019 09:13:25 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Wed, Feb 27, 2019 at 07:04:02PM +0100, Igor Mammedov wrote:
> >On Mon, 25 Feb 2019 09:15:34 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >  
> >> On Mon, Feb 25, 2019 at 09:07:08AM +0800, Wei Yang wrote:  
> >> >Currently we do device realization like below:
> >> >
> >> >   hotplug_handler_pre_plug()
> >> >   dc->realize()
> >> >   hotplug_handler_plug()
> >> >
> >> >Before we do device realization and plug, we should allocate necessary
> >> >resources and check if memory-hotplug-support property is enabled.
> >> >
> >> >At the piix4 and ich9, the memory-hotplug-support property is checked at
> >> >plug stage. This means that device has been realized and mapped into guest
> >> >address space 'pc_dimm_plug()' by the time acpi plug handler is called,
> >> >where it might fail and crash QEMU due to reaching g_assert_not_reached()
> >> >(piix4) or error_abort (ich9).
> >> >
> >> >Fix it by checking if memory hotplug is enabled at pre_plug stage
> >> >where we can gracefully abort hotplug request.
> >> >
> >> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> >CC: Igor Mammedov <imammedo@redhat.com>
> >> >CC: Eric Blake <eblake@redhat.com>
> >> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> >
> >> >---
> >> >v5:
> >> >   * rebase on latest upstream
> >> >   * remove a comment before hotplug_handler_pre_plug
> >> >   * fix alignment for ich9_pm_device_pre_plug_cb
> >> >v4:
> >> >   * fix code alignment of piix4_device_pre_plug_cb
> >> >v3:
> >> >   * replace acpi_memory_hotplug with memory-hotplug-support in changelog
> >> >   * fix code alignment of ich9_pm_device_pre_plug_cb
> >> >   * print which device type memory-hotplug-support is disabled in
> >> >     ich9_pm_device_pre_plug_cb and piix4_device_pre_plug_cb
> >> >v2:
> >> >   * (imammedo@redhat.com)
> >> >     - Almost the whole third paragraph
> >> >   * apply this change to ich9
> >> >   * use hotplug_handler_pre_plug() instead of open-coding check
> >> >---
> >> > hw/acpi/ich9.c         | 15 +++++++++++++--
> >> > hw/acpi/piix4.c        | 13 ++++++++++---
> >> > hw/i386/pc.c           |  2 ++
> >> > hw/isa/lpc_ich9.c      |  1 +
> >> > include/hw/acpi/ich9.h |  2 ++
> >> > 5 files changed, 28 insertions(+), 5 deletions(-)
> >> >
> >> >diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> >> >index c5d8646abc..e53dfe1ee3 100644
> >> >--- a/hw/acpi/ich9.c
> >> >+++ b/hw/acpi/ich9.c
> >> >@@ -483,13 +483,24 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm, Error **errp)
> >> >                              NULL);
> >> > }
> >> > 
> >> >+void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >> >+                                Error **errp)
> >> >+{
> >> >+    ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
> >> >+
> >> >+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> >> >+        !lpc->pm.acpi_memory_hotplug.is_enabled)
> >> >+        error_setg(errp,
> >> >+                   "memory hotplug is not enabled: %s.memory-hotplug-support "
> >> >+                   "is not set", object_get_typename(OBJECT(lpc)));
> >> >+}
> >> >+
> >> > void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
> >> >                             Error **errp)
> >> > {
> >> >     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
> >> > 
> >> >-    if (lpc->pm.acpi_memory_hotplug.is_enabled &&
> >> >-        object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >> >+    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> >> >         if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> >> >             nvdimm_acpi_plug_cb(hotplug_dev, dev);
> >> >         } else {
> >> >diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >> >index df8c0db909..8b9654e437 100644
> >> >--- a/hw/acpi/piix4.c
> >> >+++ b/hw/acpi/piix4.c
> >> >@@ -374,9 +374,16 @@ static void piix4_pm_powerdown_req(Notifier *n, void *opaque)
> >> > static void piix4_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >> >                                     DeviceState *dev, Error **errp)    
> >> 
> >> Hmm, I found one interesting thing.
> >> 
> >> This function is introduced in
> >> 
> >>     commit ec266f408882fd38475f72c4e864ed576228643b
> >>     pci/pcihp: perform check for bus capability in pre_plug handler
> >> 
> >> This is just implemented in piix4, but don't has the counterpart in ich9.
> >> 
> >> So I suggest to have a follow up patch to create the counterpart for ich9 and
> >> then apply this patch on top of that.  
> >not sure what do you mean, could you be more specific?
> >  
> 
> Let me reply here.
> 
> Everything starts from device_set_realized().
> 
>     device_set_realized()
>        hotplug_handler_pre_plug()
>        dc->realize()
>        hotplug_handler_plug()
> 
> There is two choice of HotplugHandler :
> 
>     * dev's bus hotplug_handler
>     * machine_hotplug_handler
> 
> Take PIIX as an example, machine_hotplug_handler and pci_bus hotplug_handler
> is:
> 
>     pc_machine_device_[pre_]plug_cb
>     piix4_device_[pre_]plug_cb
> 
> if I am correct.
> 
> Now back to your question.
> 
> Commit ec266f408882 introduced piix4_device_pre_plug_cb() to move the check in
> pre_plug handler for PIIX. Then I am wondering the counter part of ich9, But I
> don't see something for PCI_DEVICE in ich9_pm_device_plug_cb(). So on ich9,
> PCI_DEVICE is not pluggable? Maybe I am lost here.
> 
> Or in other words, in case other machine supports PCI_DEVICE hotplug, do we
> need to move similar check to pre_plug too?
it depends, in case of ICH9. I think acpi hotplug is not used (thankfully)
it uses native PCI-E hotplug path. Following pops out when looking for it.
 hw/pci/pcie.c:void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 hw/pci/pcie_port.c:    hc->pre_plug = pcie_cap_slot_pre_plug_cb;
