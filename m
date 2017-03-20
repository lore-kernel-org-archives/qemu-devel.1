Received: from eggs.gnu.org ([2001:4830:134:3::10]:40606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cpwdq-00051V-5A
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cpwdl-0006GH-Jj
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:42:30 -0400
Received: from [59.151.112.132] (port=6526 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cpwdj-00069v-Us
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:42:25 -0400
References: <1488180523-18137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170313160619.28622002@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58CFD01F.1060508@cn.fujitsu.com>
Date: Mon, 20 Mar 2017 20:50:39 +0800
MIME-Version: 1.0
In-Reply-To: <20170313160619.28622002@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio pci: kernel support of error recovery
 only for non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com

Sorry for late.

On 03/14/2017 06:06 AM, Alex Williamson wrote:
> On Mon, 27 Feb 2017 15:28:43 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> 0. What happens now (PCIE AER only)
>>    Fatal errors cause a link reset.
>>    Non fatal errors don't.
>>    All errors stop the VM eventually, but not immediately
>>    because it's detected and reported asynchronously.
>>    Interrupts are forwarded as usual.
>>    Correctable errors are not reported to guest at all.
>>    Note: PPC EEH is different. This focuses on AER.
> 
> Perhaps you're only focusing on AER, but don't the error handlers we're
> using support both AER and EEH generically?  I don't think we can
> completely disregard how this affects EEH behavior, if at all.
> 

After taking a rough look at the EEH,  find that EEH always feed
error_detected with pci_channel_io_frozen, from perspective of
error_detected, EEH is not affected.  

I am not sure about a question: when assign devices in spapr host,
should all functions/devices in a PE be bound to vfio? I am kind of
confused about the relationship between a PE & a tce iommu group

>>
>> 1. Correctable errors
>>    There is no need to report these to guest. So let's not.
> 
> What does this patch change to make this happen?  I don't see
> anything.  Was this always the case?  No change?
> 

yes, no change on correctable error.

>>
>> 2. Fatal errors
>>    It's not easy to handle them gracefully since link reset
>>    is needed. As a first step, let's use the existing mechanism
>>    in that case.
> 
> Ok, so no change here either.
> 
>> 2. Non-fatal errors
>>    Here we could make progress by reporting them to guest
>>    and have guest handle them.
> 
> In practice, what actual errors do we expect userspace to see as
> non-fatal errors? It would be useful for the commit log to describe
> the actual benefit we're going to see by splitting out non-fatal errors
> for the user (not always a guest) to see separately.  Justify that this
> is actually useful.
> 
>>
>>    Issues:
>>    a. this behaviour should only be enabled with new userspace,
>>       old userspace should work without changes.
>>
>>       Suggestion: One way to address this would be to add a new eventfd
>>       non_fatal_err_trigger. If not set, invoke err_trigger.
> 
> This outline format was really more useful for Michael to try to
> generate discussion, for a commit log, I'd much rather see a definitive
> statement such as:
> 
>  "To maintain backwards compatibility with userspace, non-fatal errors
>  will continue to trigger via the existing error interrupt index if a
>  non-fatal signaling mechanism has not been registered."
> 
>>    b. drivers are supposed to stop MMIO when error is reported,
>>       if vm keeps going, we will keep doing MMIO/config.
>>
>>       Suggestion 1: ignore this. vm stop happens much later when
>>       userspace runs anyway, so we are not making things much worse.
>>
>>       Suggestion 2: try to stop MMIO/config, resume on resume call
>>
>>       Patch below implements Suggestion 1.
>>
>>       Note that although this is really against the documentation, which
>>       states error_detected() is the point at which the driver should quiesce
>>       the device and not touch it further (until diagnostic poking at
>>       mmio_enabled or full access at resume callback).
>>
>>       Fixing this won't be easy. However, this is not a regression.
>>
>>       Also note this does nothing about interrupts, documentation
>>       suggests returning IRQ_NONE until reset.
>>       Again, not a regression.
> 
> So again, no change here.  I'm not sure what this adds to the commit
> log, perhaps we can reference this as a link to Michael's original
> proposal.
>  
>>    c. PF driver might detect that function is completely broken,
>>       if vm keeps going, we will keep doing MMIO/config.
>>
>>       Suggestion 1: ignore this. vm stop happens much later when
>>       userspace runs anyway, so we are not making things much worse.
>>
>>       Suggestion 2: detect this and invoke err_trigger to stop VM.
>>
>>       Patch below implements Suggestion 2.
> 
> This needs more description and seems a bit misleading.  This patch
> adds a slot_reset handler, such that if the slot is reset, we notify
> the user, essentially promoting the non-fatal error to fatal.  But what
> condition gets us to this point?  AIUI, AER is a voting scheme and if
> any driver affected says they need a reset, everyone gets a reset.  So
> the PF driver we're talking about here is not vfio-pci and it's not the
> user, the user has no way to signal that the device is completely
> broken, this only handles the case of other collateral devices with
> native host drivers that might signal this, right?
> 

Yes, same understanding as you, if I don't miss something from michael.

> It seems like this is where this patch has the greatest exposure to
> regressions.  If we take the VM use case, previously we could have a
> non-AER aware guest and the hypervisor could stop the VM on all
> errors.  Now the hypervisor might support the distinction between fatal
> and non-fatal, but the guest may still not have AER support.  That
> doesn't imply a problem with this approach, the user (hypervisor) would
> be at fault for any difference in handling in that case.
> 

>>  
>> +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct vfio_pci_device *vdev;
>> +	struct vfio_device *device;
>> +	static pci_ers_result_t err = PCI_ERS_RESULT_NONE;
>> +
>> +	device = vfio_device_get_from_dev(&pdev->dev);
>> +	if (!device)
>> +		goto err_dev;
>> +
>> +	vdev = vfio_device_data(device);
>> +	if (!vdev)
>> +		goto err_data;
>> +
>> +	mutex_lock(&vdev->igate);
>> +
>> +	if (vdev->err_trigger)
>> +		eventfd_signal(vdev->err_trigger, 1);
> 
> What about the case where the user has not registered for receiving
> non-fatal errors, now we send an error signal on both error_detected
> and slot_reset.  Is that useful/desirable?
> 

Not desirable, but seems not harmful, guest user will stop anyway. How
to avoid this case gracefully seems not easy.

-- 
Sincerely,
Cao jin
