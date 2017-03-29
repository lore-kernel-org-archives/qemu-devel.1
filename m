Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ct3lV-0001f6-Jg
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ct3lT-0006FO-Sj
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ct3lT-0006Ey-JE
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:55:15 -0400
Date: Tue, 28 Mar 2017 20:55:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170328205513.21b97381@t450s.home>
In-Reply-To: <20170329000148.GA18849@redhat.com>
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161238.366ce6a7@t450s.home>
	<58DA6954.2000601@cn.fujitsu.com>
	<20170328101233.74f50a92@t450s.home>
	<20170329000148.GA18849@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Wed, 29 Mar 2017 03:01:48 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 28, 2017 at 10:12:33AM -0600, Alex Williamson wrote:
> > On Tue, 28 Mar 2017 21:47:00 +0800
> > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> >   
> > > On 03/25/2017 06:12 AM, Alex Williamson wrote:  
> > > > On Thu, 23 Mar 2017 17:07:31 +0800
> > > > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> > > > 
> > > > A more appropriate patch subject would be:
> > > > 
> > > > vfio-pci: Report correctable errors and slot reset events to user
> > > >    
> > > 
> > > Correctable? It is confusing to me. Correctable error has its clear
> > > definition in PCIe spec, shouldn't it be "non-fatal"?  
> > 
> > My mistake, non-fatal.
> >    
> > > >> From: "Michael S. Tsirkin" <mst@redhat.com>    
> > > > 
> > > > This hardly seems accurate anymore.  You could say Suggested-by and let
> > > > Michael add a sign-off, but it's changed since he sent it.
> > > >     
> > > >>
> > > >> 0. What happens now (PCIE AER only)
> > > >>    Fatal errors cause a link reset. Non fatal errors don't.
> > > >>    All errors stop the QEMU guest eventually, but not immediately,
> > > >>    because it's detected and reported asynchronously.
> > > >>    Interrupts are forwarded as usual.
> > > >>    Correctable errors are not reported to user at all.
> > > >>
> > > >>    Note:
> > > >>    PPC EEH is different, but this approach won't affect EEH. EEH treat
> > > >>    all errors as fatal ones in AER, so they will still be signalled to user
> > > >>    via the legacy eventfd.  Besides, all devices/functions in a PE belongs
> > > >>    to the same IOMMU group, so the slot_reset handler in this approach
> > > >>    won't affect EEH either.
> > > >>
> > > >> 1. Correctable errors
> > > >>    Hardware can correct these errors without software intervention,
> > > >>    clear the error status is enough, this is what already done now.
> > > >>    No need to recover it, nothing changed, leave it as it is.
> > > >>
> > > >> 2. Fatal errors
> > > >>    They will induce a link reset. This is troublesome when user is
> > > >>    a QEMU guest. This approach doesn't touch the existing mechanism.
> > > >>
> > > >> 3. Non-fatal errors
> > > >>    Before this patch, they are signalled to user the same way as fatal ones.
> > > >>    With this patch, a new eventfd is introduced only for non-fatal error
> > > >>    notification. By splitting non-fatal ones out, it will benefit AER
> > > >>    recovery of a QEMU guest user.
> > > >>
> > > >>    To maintain backwards compatibility with userspace, non-fatal errors
> > > >>    will continue to trigger via the existing error interrupt index if a
> > > >>    non-fatal signaling mechanism has not been registered.
> > > >>
> > > >>    Note:
> > > >>    In case of PCI Express errors, kernel might request a slot reset
> > > >>    affecting our device (from our point of view this is a passive device
> > > >>    reset as opposed to an active one requested by vfio itself).
> > > >>    This might currently happen if a slot reset is requested by a driver
> > > >>    (other than vfio) bound to another device function in the same slot.
> > > >>    This will cause our device to lose its state so report this event to
> > > >>    userspace.    
> > > > 
> > > > I tried to convey this in my last comments, I don't think this is an
> > > > appropriate commit log.  Lead with what is the problem you're trying to
> > > > fix and why, what is the benefit to the user, and how is the change
> > > > accomplished.  If you want to provide a State of Error Handling in
> > > > VFIO, append it after the main points of the commit log.    
> > > 
> > > ok.
> > >   
> > > > 
> > > > I also asked in my previous comments to provide examples of errors that
> > > > might trigger correctable errors to the user, this comment seems to
> > > > have been missed.  In my experience, AERs generated during device
> > > > assignment are generally hardware faults or induced by bad guest
> > > > drivers.  These are cases where a single fatal error is an appropriate
> > > > and sufficient response.  We've scaled back this support to the point
> > > > where we're only improving the situation of correctable errors and I'm
> > > > not convinced this is worthwhile and we're not simply checking a box on
> > > > an ill-conceived marketing requirements document.    
> > > 
> > > Sorry. I noticed that question: "what actual errors do we expect
> > > userspace to see as non-fatal errors?", but I am confused about it.
> > > Correctable, non-fatal, fatal errors are clearly defined in PCIe spec,
> > > and Uncorrectable Error Severity Register will tell which is fatal, and
> > > which is non-fatal, this register is configurable, they are device
> > > specific as I guess. AER core driver distinguish them by
> > > pci_channel_io_normal/pci_channel_io_frozen,  So I don't understand your
> > > question. Or
> > > 
> > > Or, Do you mean we could list the default non-fatal error of
> > > Uncorrectable Error Severity Register which is provided by PCIe spec?  
> > 
> > I'm trying to ask why is this patch series useful.  It's clearly
> > possible for us to signal non-fatal errors for a device to a guest, but
> > why is it necessarily a good idea to do so?  What additional RAS
> > feature is gained by this?  Can we give a single example of a real
> > world scenario where a guest has been shutdown due to a non-fatal error
> > that the guest driver would have handled?  
> 
> We've been discussing AER for months if not years.
> Isn't it a bit too late to ask whether AER recovery
> by guests it useful at all?


Years, but I think that is more indicative of the persistence of the
developers rather than growing acceptance on my part.  For the majority
of that we were headed down the path of full AER support with the guest
able to invoke bus resets.  It was a complicated solution, but it was
more clear that it had some value.   Of course that's been derailed
due to various issues and we're now on this partial implementation that
only covers non-fatal errors that we assume the guest can recover from
without providing it mechanisms to do bus resets.  Is there actual
value to this or are we just trying to fill an AER checkbox on
someone's marketing sheet?  I don't think it's too much to ask for a
commit log to include evidence or discussion about how a feature is
actually a benefit to implement.


> > > > I had also commented asking how the hypervisor is expected to know
> > > > whether the guest supports AER.  With the existing support of a single
> > > > fatal error, the hypervisor halts the VM regardless of the error
> > > > severity or guest support.  Now we have the opportunity that the
> > > > hypervisor can forward a correctable error to the guest... and hope the
> > > > right thing occurs?  I never saw any response to this comment.
> > > >     
> > > 
> > > I noticed this question, you said: "That doesn't imply a problem with
> > > this approach, the user (hypervisor) would be at fault for any
> > > difference in handling in that case.". Maybe I understand you wrong.
> > > 
> > > From my limit understanding, QEMU doesn't has a way to know whether a
> > > guest has AER support, AER support need several kbuild configuration, I
> > > don't know how qemu is expected to know these.  
> > 
> > 
> > Isn't that a problem?  See my reply to QEMU patch 3/3.  
> 
> Yes but it's the same with bare metal IIUC.


I'll defer again to the thread on patch 3/3.  Thanks,

Alex

> > > >>
> > > >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > >> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> > > >> ---
> > > >> v6 changelog:
> > > >> Address all the comments from MST.
> > > >>
> > > >>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++++++++--
> > > >>  drivers/vfio/pci/vfio_pci_intrs.c   | 38 ++++++++++++++++++++++++++++
> > > >>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
> > > >>  include/uapi/linux/vfio.h           |  2 ++
> > > >>  4 files changed, 89 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > >> index 324c52e..71f9a8a 100644
> > > >> --- a/drivers/vfio/pci/vfio_pci.c
> > > >> +++ b/drivers/vfio/pci/vfio_pci.c
> > > >> @@ -441,7 +441,9 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
> > > >>  
> > > >>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
> > > >>  		}
> > > >> -	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> > > >> +	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX ||
> > > >> +		   irq_type == VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX ||
> > > >> +		   irq_type == VFIO_PCI_PASSIVE_RESET_IRQ_INDEX) {    
> > > > 
> > > > Should we add a typdef to alias VFIO_PCI_ERR_IRQ_INDEX to
> > > > VFIO_PCI_FATAL_ERR_IRQ?
> > > >     
> > > >>  		if (pci_is_pcie(vdev->pdev))
> > > >>  			return 1;
> > > >>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
> > > >> @@ -796,6 +798,8 @@ static long vfio_pci_ioctl(void *device_data,
> > > >>  		case VFIO_PCI_REQ_IRQ_INDEX:
> > > >>  			break;
> > > >>  		case VFIO_PCI_ERR_IRQ_INDEX:
> > > >> +		case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
> > > >> +		case VFIO_PCI_PASSIVE_RESET_IRQ_INDEX:
> > > >>  			if (pci_is_pcie(vdev->pdev))
> > > >>  				break;
> > > >>  		/* pass thru to return error */
> > > >> @@ -1282,7 +1286,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> > > >>  
> > > >>  	mutex_lock(&vdev->igate);
> > > >>  
> > > >> -	if (vdev->err_trigger)
> > > >> +	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
> > > >> +		eventfd_signal(vdev->non_fatal_err_trigger, 1);
> > > >> +	else if (vdev->err_trigger)
> > > >>  		eventfd_signal(vdev->err_trigger, 1);    
> > > > 
> > > > Should another patch rename err_trigger to fatal_err_trigger to better
> > > > describe its new function?
> > > >     
> > > >>  
> > > >>  	mutex_unlock(&vdev->igate);
> > > >> @@ -1292,8 +1298,47 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> > > >>  	return PCI_ERS_RESULT_CAN_RECOVER;
> > > >>  }
> > > >>  
> > > >> +/*
> > > >> + * In case of PCI Express errors, kernel might request a slot reset
> > > >> + * affecting our device (from our point of view, this is a passive device
> > > >> + * reset as opposed to an active one requested by vfio itself).
> > > >> + * This might currently happen if a slot reset is requested by a driver
> > > >> + * (other than vfio) bound to another device function in the same slot.
> > > >> + * This will cause our device to lose its state, so report this event to
> > > >> + * userspace.
> > > >> + */    
> > > > 
> > > > I really dislike "passive reset".  I expect you avoided "slot reset"
> > > > because we have other sources where vfio itself initiates a slot
> > > > reset.  Is "spurious" more appropriate?  "Collateral"?
> > > >     
> > > >> +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
> > > >> +{
> > > >> +	struct vfio_pci_device *vdev;
> > > >> +	struct vfio_device *device;
> > > >> +	static pci_ers_result_t err = PCI_ERS_RESULT_NONE;
> > > >> +
> > > >> +	device = vfio_device_get_from_dev(&pdev->dev);
> > > >> +	if (!device)
> > > >> +		goto err_dev;
> > > >> +
> > > >> +	vdev = vfio_device_data(device);
> > > >> +	if (!vdev)
> > > >> +		goto err_data;
> > > >> +
> > > >> +	mutex_lock(&vdev->igate);
> > > >> +
> > > >> +	if (vdev->passive_reset_trigger)
> > > >> +		eventfd_signal(vdev->passive_reset_trigger, 1);    
> > > > 
> > > > What are the exact user requirements here, we now have:
> > > > 
> > > > A) err_trigger
> > > > B) non_fatal_err_trigger
> > > > C) passive_reset_trigger
> > > > 
> > > > Currently we only have A, which makes things very simple, we notify on
> > > > errors and assume the user doesn't care otherwise.
> > > > 
> > > > The expectation here seems to be that A, B, and C are all registered,
> > > > but what if they're not?  What if in the above function, only A & B are
> > > > registered, do we trigger A here?  Are B & C really intrinsic to each
> > > > other and we should continue to issue only A unless both B & C are
> > > > registered?  In that case, should we be exposing a single IRQ INDEX to
> > > > the user with two sub-indexes, defined as sub-index 0 is correctable
> > > > error, sub-index 1 is slot reset, and promote any error to A if they
> > > > are not both registered?
> > > >     
> > > 
> > > I will see how to implement these.
> > >   
