Received: from eggs.gnu.org ([2001:4830:134:3::10]:51760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct11a-0000sL-Dc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ct11X-0000lg-Ab
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:59:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ct11X-0000lH-1L
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 19:59:39 -0400
Date: Wed, 29 Mar 2017 02:59:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170329025512-mutt-send-email-mst@kernel.org>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161224.270f334e@t450s.home>
	<58DA69DD.2060203@cn.fujitsu.com>
	<20170328101225.5772b33a@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170328101225.5772b33a@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio-pci: process non fatal error
 of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Tue, Mar 28, 2017 at 10:12:25AM -0600, Alex Williamson wrote:
> On Tue, 28 Mar 2017 21:49:17 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
> > On 03/25/2017 06:12 AM, Alex Williamson wrote:
> > > On Thu, 23 Mar 2017 17:09:23 +0800
> > > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> > >   
> > >> Make use of the non fatal error eventfd that the kernel module provide
> > >> to process the AER non fatal error. Fatal error still goes into the
> > >> legacy way which results in VM stop.
> > >>
> > >> Register the handler, wait for notification. Construct aer message and
> > >> pass it to root port on notification. Root port will trigger an interrupt
> > >> to signal guest, then guest driver will do the recovery.  
> > > 
> > > Can we guarantee this is the better solution in all cases or could
> > > there be guests without AER support where the VM stop is the better
> > > solution?
> > >   
> > 
> > Currently, we only have VM stop on errors, that looks the same as a
> > sudden power down to me.  With this solution, we have about
> > 50%(non-fatal) chance to reduce the sudden power-down risk.
> 
> If half of all faults are expected to be non-fatal, then you must have
> some real examples of devices triggering non-fatal errors which can be
> corrected in the guest driver that you can share to justify why it's a
> good thing to enable this behavior.
> 
> > What if a guest doesn't support AER?  It looks the same as a host
> > without AER support. Now I only can speculate the worst condition: guest
> > crash, would that be quite different from a sudden power-down?
> 
> Yes, it's very different.  In one case we contain the fault by stopping
> the guest, in the other case we allow the guest to continue operating
> with a known fault in the device which may allow the fault to propagate
> and perhaps go unnoticed.  We have established with the current
> behavior that QEMU will prevent further propagation of a fault by
> halting the VM.  To change QEMU's behavior here risks that a VM relying
> on that behavior no longer has that protection.  So it seems we either
> need to detect whether the VM is handling AER or we need to require the
> VM administrator to opt-in to this new feature.

An opt-in flag sounds very reasonable. It can also specify whether
to log the errors. We have a similar flag for disk errors.

>  Real hardware has
> these same issues and I believe there are handshakes that can be done
> through ACPI to allow the guest to take over error handling from the
> system.

No, that's only for error reporting IIUC. Driver needs to be
aware of a chance for errors to trigger and be able to
handle them.

So yes, some guests might have benefitted from VM stop
on AER but
1. the stop happens asynchronously so if guest can't handle
   errors there's a chance it is already crashed by the time we
   try to do vm stop
2. it's more of a chance by-product - we never promised
   guests that VMs would be more robust than bare metal



> > >> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> > >> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> > >> ---
> > >>  hw/vfio/pci.c              | 202 +++++++++++++++++++++++++++++++++++++++++++++
> > >>  hw/vfio/pci.h              |   2 +
> > >>  linux-headers/linux/vfio.h |   2 +
> > >>  3 files changed, 206 insertions(+)
> > >>
> > >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > >> index 3d0d005..c6786d5 100644
> > >> --- a/hw/vfio/pci.c
> > >> +++ b/hw/vfio/pci.c
> > >> @@ -2432,6 +2432,200 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
> > >>      vfio_put_base_device(&vdev->vbasedev);
> > >>  }
> > >>  
> > >> +static void vfio_non_fatal_err_notifier_handler(void *opaque)
> > >> +{
> > >> +    VFIOPCIDevice *vdev = opaque;
> > >> +    PCIDevice *dev = &vdev->pdev;
> > >> +    PCIEAERMsg msg = {
> > >> +        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
> > >> +        .source_id = pci_requester_id(dev),
> > >> +    };
> > >> +
> > >> +    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
> > >> +        return;
> > >> +    }
> > >> +
> > >> +    /* Populate the aer msg and send it to root port */
> > >> +    if (dev->exp.aer_cap) {  
> > > 
> > > Why would we have registered this notifier otherwise?
> > >   
> > >> +        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
> > >> +        uint32_t uncor_status;
> > >> +        bool isfatal;
> > >> +
> > >> +        uncor_status = vfio_pci_read_config(dev,
> > >> +                            dev->exp.aer_cap + PCI_ERR_UNCOR_STATUS, 4);
> > >> +        if (!uncor_status) {
> > >> +            return;
> > >> +        }
> > >> +
> > >> +        isfatal = uncor_status & pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
> > >> +        if (isfatal) {
> > >> +            goto stop;
> > >> +        }  
> > > 
> > > Huh?  How can we get a non-fatal error notice for a fatal error?  (and
> > > why are we saving this to a variable rather than testing it within the
> > > 'if' condition?
> > >  
> > 
> > Both of these are for the unsure corner cases.
> > Is it possible that register reading shows a fatal error?
> > Saving it into a variable just is personal taste: more neat.
> 
> Why are there unsure corner cases?  Shouldn't the kernel have done this
> check if there was any doubt whether the error was fatal or not?
> Signaling the user with a non-fatal trigger for a fatal error certainly
> doesn't make me have much confidence in this code.
> 
> > >> +
> > >> +        error_report("%s sending non fatal event to root port. uncor status = "
> > >> +                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
> > >> +        pcie_aer_msg(dev, &msg);
> > >> +        return;
> > >> +    }
> > >> +
> > >> +stop:
> > >> +    /* Terminate the guest in case of fatal error */
> > >> +    error_report("%s: Device detected a fatal error. VM stopped",
> > >> +	    vdev->vbasedev.name);
> > >> +    vm_stop(RUN_STATE_INTERNAL_ERROR);  
> > > 
> > > Shouldn't we use the existing error index if we can't make use of
> > > correctable errors?
> > >   
> > 
> > Why? If register reading shows it is actually a fatal error, is it the
> > same as fatal error handler is notified?  what we use the existing error
> > index for?
> 
> See below.
> 
> > >> @@ -2860,6 +3054,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> > >>          }
> > >>      }
> > >>  
> > >> +    vfio_register_passive_reset_notifier(vdev);
> > >> +    vfio_register_non_fatal_err_notifier(vdev);  
> > > 
> > > I think it's wrong that we configure these unconditionally.  Why do we
> > > care about these unless we're configuring the guest to receive AER
> > > events?
> > >   
> > 
> > But do we have ways to know whether the guest has AER support? For now,
> > I don't think so.
> 
> By unconditionally here, I'm referring to not even testing whether the
> device is in a VM topology where it can receive AER events.  If we
> cannot signal the device, we don't need these additional triggers and
> therefore we don't need the aer_cap test in the non-fatal error
> handler, we can use the existing error index instead.  Enabling these
> triggers at the point where the guest takes over error handling from
> the system would be even better.
>  
> > If guest don't have AER support, for the worst condition: guest crash,
> > it is not worse than a sudden power-down.
> 
> Worst case is that a non-fatal error introduces a data corruption which
> was previously noted via a VM stop (even if asynchronous notification
> allowed some propagation) and now potentially goes unnoticed.  That's a
> very big difference.  Thanks,
> 
> Alex
