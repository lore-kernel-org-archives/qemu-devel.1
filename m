Received: from eggs.gnu.org ([209.51.188.92]:37851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goy4S-0008Gz-7v
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1goy4M-0002XX-V7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:10:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1goy4K-0002OI-OM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:10:52 -0500
Date: Wed, 30 Jan 2019 17:10:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190130170943-mutt-send-email-mst@kernel.org>
References: <20181212095707.19358-1-david@redhat.com>
	<a26a687a-5098-1715-9fee-8374bdd30268@redhat.com>
	<c646ce74-7ecd-325f-3cb9-421af6d8a9b8@redhat.com>
	<a0441fd2-cfbc-83ef-2543-7d34530875cf@redhat.com>
	<0fb48298-a01b-0f0b-dc89-73e14f09f6f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb48298-a01b-0f0b-dc89-73e14f09f6f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] pc: Use
 hotplug_handler_(plug|unplug|unplug_request)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jan 30, 2019 at 04:07:06PM +0100, David Hildenbrand wrote:
> On 30.01.19 14:09, Paolo Bonzini wrote:
> > On 30/01/19 13:35, David Hildenbrand wrote:
> >> On 14.12.18 10:58, Paolo Bonzini wrote:
> >>> On 12/12/18 10:57, David Hildenbrand wrote:
> >>>> Let's avoid manually looking up the hotplug handler class. Use the
> >>>> existing wrappers instead.
> >>>>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  hw/i386/pc.c | 30 ++++++++----------------------
> >>>>  1 file changed, 8 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >>>> index 4cd2fbca4d..c8857138f9 100644
> >>>> --- a/hw/i386/pc.c
> >>>> +++ b/hw/i386/pc.c
> >>>> @@ -1711,7 +1711,6 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >>>>  static void pc_memory_plug(HotplugHandler *hotplug_dev,
> >>>>                             DeviceState *dev, Error **errp)
> >>>>  {
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>>      bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
> >>>> @@ -1725,8 +1724,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
> >>>>          nvdimm_plug(&pcms->acpi_nvdimm_state);
> >>>>      }
> >>>>  
> >>>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -    hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
> >>>> +    hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
> >>>>  out:
> >>>>      error_propagate(errp, local_err);
> >>>>  }
> >>>> @@ -1734,7 +1732,6 @@ out:
> >>>>  static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> >>>>                                       DeviceState *dev, Error **errp)
> >>>>  {
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>>  
> >>>> @@ -1755,9 +1752,8 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> >>>>          goto out;
> >>>>      }
> >>>>  
> >>>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>> -
> >>>> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> >>>> +                                   &local_err);
> >>>>  out:
> >>>>      error_propagate(errp, local_err);
> >>>>  }
> >>>> @@ -1766,12 +1762,9 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
> >>>>                               DeviceState *dev, Error **errp)
> >>>>  {
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>  
> >>>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>> -
> >>>> +    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>>      if (local_err) {
> >>>>          goto out;
> >>>>      }
> >>>> @@ -1813,14 +1806,12 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
> >>>>                          DeviceState *dev, Error **errp)
> >>>>  {
> >>>>      CPUArchId *found_cpu;
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>      X86CPU *cpu = X86_CPU(dev);
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>>  
> >>>>      if (pcms->acpi_dev) {
> >>>> -        hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -        hhc->plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>> +        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>>          if (local_err) {
> >>>>              goto out;
> >>>>          }
> >>>> @@ -1844,7 +1835,6 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> >>>>                                       DeviceState *dev, Error **errp)
> >>>>  {
> >>>>      int idx = -1;
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>      X86CPU *cpu = X86_CPU(dev);
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>> @@ -1861,9 +1851,8 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> >>>>          goto out;
> >>>>      }
> >>>>  
> >>>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -    hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>> -
> >>>> +    hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
> >>>> +                                   &local_err);
> >>>>      if (local_err) {
> >>>>          goto out;
> >>>>      }
> >>>> @@ -1877,14 +1866,11 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> >>>>                               DeviceState *dev, Error **errp)
> >>>>  {
> >>>>      CPUArchId *found_cpu;
> >>>> -    HotplugHandlerClass *hhc;
> >>>>      Error *local_err = NULL;
> >>>>      X86CPU *cpu = X86_CPU(dev);
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>>  
> >>>> -    hhc = HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
> >>>> -    hhc->unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>> -
> >>>> +    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
> >>>>      if (local_err) {
> >>>>          goto out;
> >>>>      }
> >>>>
> >>>
> >>> Queued, thanks.
> >>
> >> Paolo, just wondering, is this still on your queue or fell of the wagon?
> > 
> > I had some issues with the previous pull request and also have to really
> > spend some time on KVM.  But it's still queued.
> > 
> 
> No worries, I have some qdev patches based on this, but will simply send
> this patch along with that series. Whatever hits upstream first :)

Yes I was going to offer to put it on my queue but if there
are dependencies for another queue that's fine too.
You can also add

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

if you like.

> > Paolo
> > 
> 
> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
