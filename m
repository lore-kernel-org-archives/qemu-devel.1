Received: from eggs.gnu.org ([2001:4830:134:3::10]:55396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJfrp-00027v-0y
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJfrl-0003KG-2B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:24:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eJfrk-0003JD-Rr
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:24:00 -0500
Date: Tue, 28 Nov 2017 14:23:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171128142354.42154129@redhat.com>
In-Reply-To: <93ccfc82-5089-fd1c-ee04-f80fef27d35b@redhat.com>
References: <1511188453-248734-1-git-send-email-imammedo@redhat.com>
	<20171120144454.GK3037@localhost.localdomain>
	<20171120155951.01623ed3@redhat.com>
	<20171120170539.GM3037@localhost.localdomain>
	<93ccfc82-5089-fd1c-ee04-f80fef27d35b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] pc: fix crash on attempted cpu
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, rth@twiddle.net

On Tue, 28 Nov 2017 12:28:43 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 20/11/2017 18:05, Eduardo Habkost wrote:
> > On Mon, Nov 20, 2017 at 03:59:51PM +0100, Igor Mammedov wrote:  
> >> On Mon, 20 Nov 2017 12:44:54 -0200
> >> Eduardo Habkost <ehabkost@redhat.com> wrote:
> >>  
> >>> On Mon, Nov 20, 2017 at 03:34:13PM +0100, Igor Mammedov wrote:  
> >>>> when qemu is started with '-no-acpi' CLI option, an attempt
> >>>> to unplug a CPU using device_del results in null pointer
> >>>> dereference at:
> >>>>
> >>>>   #0 object_get_class
> >>>>   #1 pc_machine_device_unplug_request_cb
> >>>>   #2 qmp_marshal_device_del
> >>>>
> >>>> which is caused by pcms->acpi_dev == NULL due to ACPI support
> >>>> being disabled.
> >>>>
> >>>> Considering that ACPI support is necessary for unplug to work,
> >>>> check that it's enabled and fail unplug request gracefully
> >>>> if no acpi device were found.
> >>>>
> >>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> >>>
> >>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >>>
> >>> But I have one small suggestion:
> >>>  
> >>>> ---
> >>>>  hw/i386/pc.c | 5 +++++
> >>>>  1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >>>> index c3afe5b..d80cec3 100644
> >>>> --- a/hw/i386/pc.c
> >>>> +++ b/hw/i386/pc.c
> >>>> @@ -1842,6 +1842,11 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> >>>>      X86CPU *cpu = X86_CPU(dev);
> >>>>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> >>>>  
> >>>> +    if (!pcms->acpi_dev) {
> >>>> +        error_setg(&local_err, "not supported without acpi");    
> >>>
> >>> I suggest "CPU hot unplug not supported without ACPI" instead.  
> >> I've thought about it but considering error is issued in context of
> >> device_del command, I've opted for more concise variant.
> >>
> >> Would you still like me to respin patch with your suggestion?  
> > 
> > I'd prefer to, so the error message would make sense even if out
> > of context.  But you still have my Reviewed-by in case Michael
> > wants to apply this version.  
> 
> I made the change and queued the patch.
I've thought Michael (CCed) queued v2
but he hasn't sent a pull req yet.

> Paolo
