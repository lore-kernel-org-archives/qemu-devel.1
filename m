Received: from eggs.gnu.org ([209.51.188.92]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz304-0006kN-Hz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gz302-0004Qn-SX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gz302-0003hf-H5
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:28:06 -0500
Date: Wed, 27 Feb 2019 18:27:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190227182749.2fbbca15@redhat.com>
In-Reply-To: <20190227135920.ly6pzlbx5a4vubak@master>
References: <20190220005124.24224-1-richardw.yang@linux.intel.com>
	<20190221155004.010f7b7a@redhat.com>
	<20190223000249.e56gmq6su7vqor6k@master>
	<20190225090537.60f7aedf@Igors-MacBook-Pro.local>
	<20190225124714.2567npif32iqt5bx@master>
	<20190227141242.71081f37@redhat.com>
	<20190227135920.ly6pzlbx5a4vubak@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] PCDIMM cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, xiaoguangrong.eric@gmail.com, philmd@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On Wed, 27 Feb 2019 13:59:20 +0000
Wei Yang <richard.weiyang@gmail.com> wrote:

> On Wed, Feb 27, 2019 at 02:12:42PM +0100, Igor Mammedov wrote:
> >On Mon, 25 Feb 2019 12:47:14 +0000
> >Wei Yang <richard.weiyang@gmail.com> wrote:
> >  
> >> On Mon, Feb 25, 2019 at 09:05:37AM +0100, Igor Mammedov wrote:  
> >> >On Sat, 23 Feb 2019 00:02:49 +0000
> >> >Wei Yang <richard.weiyang@gmail.com> wrote:
> >> >    
> >> >> On Thu, Feb 21, 2019 at 03:50:04PM +0100, Igor Mammedov wrote:    
> >> >> >On Wed, 20 Feb 2019 08:51:21 +0800
> >> >> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> >> >    
> >> >> >> Three trivial cleanup for pc-dimm.
> >> >> >> 
> >> >> >> Patch [1] remove the check on class->hotpluggable since pc-dimm is always
> >> >> >> hotpluggable.
> >> >> >> Patch [2] remove nvdimm_realize
> >> >> >> Patch [2] remove pcdimm realize-callback    
> >> >> >even though this series doesn't break anything, I disagree with it
> >> >> >conceptually as it makes device less abstracted and make it more
> >> >> >dependent on how existing machine code uses it.
> >> >> >I'd drop whole series.
> >> >> >    
> >> >> 
> >> >> Is Patch [1] also make device more dependent on existing implementation?    
> >> >yes, it's implementation detail that PCDIMM&Co are hotpluggable now.
> >> >    
> >> >> For example, when we look at the counterpart of acpi_memory_plug_cb():
> >> >> 
> >> >>     acpi_pcihp_device_plug_cb
> >> >> 
> >> >> which handle the pci device hotplug. We don't check the hotpluggable
> >> >> property for pci devices.
> >> >> 
> >> >> To me, this is a general rule for PCDIMM, they are hotpluggable.    
> >> >yes, PCDIMMs are hotpluggable but apci device (piix4pm/ich9/...) handling hotplug
> >> >should ignore any non-hotpluggable one. If you remove check and then later
> >> >someone else would add non-hotpluggable memory device or make PC-DIMMs or its
> >> >variant of non-hotpluggable one, acpi device handling will break.
> >> >Hence I'd prefer to keep the check.  
> >> >     
> >> 
> >> Ok, if we'd support un-hotpluggable mem device, we could retain this
> >> check. But this maybe not a proper place.
> >> 
> >> Based on my understanding, at this point, every thing has been done
> >> properly. If this check pass, we will send an acpi interrupt to notify
> >> the guest. In case this is an un-hotpluggable device, every thing looks
> >> good but no effect in guest. Because we skip the notification.
> >> 
> >> Maybe we need to move the check in pre-plug?  
> >And what would happen then and afterwards?
> >
> >Point is to make one of the handlers in chain to ignore plug event
> >(i.e. do not generate SCI event) while the rest of handlers complete
> >successfully mapping device in address space and whatever else.
> >  
> 
> This will have a well prepared device in system but guest is not
> notified, right?
yes, it's theoretically possible to move check up the call stack
to machine level and not call secondary hotplug handler on non hotplugged
device but that again depends on what secondary hotplug handler does.
I'd rather keep logic independent here unless there is good reason not
to do so.


> My idea to move the check in pre-plug will result the qemu return when
> it see no SCI event will be generated, so there is no device created.
> 
> I guess current behavior is a designed decision?
I'd say so.
PS:
QEMU's hotplug_hadler API is misnamed at this point as it handles both
cold (basic device wiring) and hotplug (processing hotplug).
Maybe we should rename it but I'm not irritated enough by it to do so.

> >> >> For Patch[2][3], I agree with you.
> >> >>     
> >>   
> 
