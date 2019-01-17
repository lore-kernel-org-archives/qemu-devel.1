Received: from eggs.gnu.org ([209.51.188.92]:35692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gk9Ti-0004wU-E7
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gk9Tf-0001XA-Ee
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:21:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gk9Te-0001ER-FD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:21:07 -0500
Date: Thu, 17 Jan 2019 08:21:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190117082102.236fd268@x1.home>
In-Reply-To: <a317f715-e146-d63e-5da8-0f6beb85d93a@huawei.com>
References: <648fabd1-b598-02a9-14f6-02ed2c767b2a@huawei.com>
	<20190114090757.68bfa839@x1.home>
	<aeda1442-6fe9-c86a-dfae-8d46f47a9555@huawei.com>
	<20190115091817.07d9916c@x1.home>
	<a317f715-e146-d63e-5da8-0f6beb85d93a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions about VFIO enabling MSIX vector
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Wanghaibin (D)" <wanghaibin.wang@huawei.com>

On Thu, 17 Jan 2019 20:55:05 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> On 2019/1/16 0:18, Alex Williamson wrote:
> > On Tue, 15 Jan 2019 11:21:51 +0800
> > Heyi Guo <guoheyi@huawei.com> wrote:
> >  
> >> Hi Alex,
> >>
> >> Really appreciate your comments. I have some more questions below.
> >>
> >>
> >> On 2019/1/15 0:07, Alex Williamson wrote:  
> >>> On Sat, 12 Jan 2019 10:30:40 +0800
> >>> Heyi Guo <guoheyi@huawei.com> wrote:
> >>>     
> >>>> Hi folks,
> >>>>
> >>>> I have some questions about vfio_msix_vector_do_use() in
> >>>> hw/vfio/pci.c, could you help to explain?
> >>>>
> >>>> We can see that when guest tries to enable one specific MSIX vector
> >>>> by unmasking MSIX Vector Control, the access will be trapped and then
> >>>> into function vfio_msix_vector_do_use(). And we may go to the below
> >>>> branch in line 525:
> >>>>
> >>>>
> >>>> 520 /*
> >>>> 521  * We don't want to have the host allocate all possible MSI vectors
> >>>> 522  * for a device if they're not in use, so we shutdown and incrementally
> >>>> 523  * increase them as needed.
> >>>> 524  */
> >>>> 525  if (vdev->nr_vectors < nr + 1) {
> >>>> 526      vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
> >>>> 527      vdev->nr_vectors = nr + 1;
> >>>> 528      ret = vfio_enable_vectors(vdev, true);
> >>>> 529      if (ret) {
> >>>> 530          error_report("vfio: failed to enable vectors, %d", ret);
> >>>> 531      }
> >>>>
> >>>> Here all MSIX vectors will be disabled first and then enabled, with
> >>>> one more MSIX. The comment is there but I still don't quite
> >>>> understand. It makes sense for not allocating all possible MSI
> >>>> vectors, but why shall we shutdown the whole MSI when being requested
> >>>> to enable one specific vector? Can't we just enable the user
> >>>> specified vector indexed by "nr"?  
> >>> What internal kernel API would vfio-pci make use of to achieve that?
> >>> We can't know the intentions of the guest and we have a limited set of
> >>> tools to manage the MSI-X state in the host kernel.  It's generally the
> >>> case that MSI-X vectors are only manipulated during driver setup and
> >>> shutdown, so while the current behavior isn't necessarily efficient, it
> >>> works within the constraints and generally doesn't have a runtime impact
> >>> on performance.  We also recognize that this behavior may change in the
> >>> future depending on more dynamic internal host kernel interfaces, thus
> >>> we export the VFIO_IRQ_INFO_NORESIZE flag to indicate to userspace
> >>> whether this procedure is required.  
> >> I tried to enable the specified MSIX vector only, and finally
> >> understood the original QEMU code after always getting EINVAL from
> >> ioctl->VFIO_DEVICE_SET_IRQS. Then I tried to allocate all MSIX
> >> vectors in vfio_msix_enable(), not only MSIX vector 0. The change
> >> works, but it definitely doesn't follow the comment in the code "We
> >> don't want to have the host allocate all possible MSI vectors for a
> >> device if they're not in use". May I ask what the side effect is if
> >> we really allocate all possible vectors at the beginning?  
> > Host IRQ vector exhaustion.  Very few devices seem to make use of the
> > their full compliment of available vectors and some devices support a
> > very, very large number of vectors.  The current approach only consumes
> > the host resources that the guest is actually making use of.
> >  
> >>>> What's more, on ARM64 systems with GIC ITS, the kernel will issue
> >>>> an ITS discard command when disabling a MSI vector, which will drop
> >>>> currently pending MSI interrupt. If device driver in guest system
> >>>> enables some MSIs first and interrupts may come at any time, and
> >>>> then it tries to enable other MSIs, is it possible for the above
> >>>> code to cause interrupts missing?  
> >>> Interrupt reconfiguration is generally during driver setup or
> >>> teardown when the device is considered idle or lost interrupts are
> >>> not a concern.  If you have a device which manipulates interrupt
> >>> configuration runtime, you can expect that lost interrupts won't be
> >>> the only problem,  
> >> On physical machine, if the driver enables vector 0 first, and then
> >> vector 1 later, will the vector 0 interrupt be lost for some
> >> possibility? In my opinion the manipulation of vector 1 should not
> >> affect the interrupt of vector 0, isn't it? But if this is possible
> >> in virtual world, what do we consider it as? A bug to be fixed in
> >> future, or a known limitation of virtualization that won't be fixed
> >> and all driver developers should pay attention to it?  
> > Are you experiencing an actual problem with lost interrupts or is this
> > a theoretical question?  There is a difference in programming of MSI-X
> > for an assigned device because we cannot know the intentions of the
> > guest with respect to how many vectors they intend to use.  We can only
> > know as individual vectors are unmasked that a vector is now used.
> > Allocating the maximum compliment of interrupts supported on the device
> > is wasteful of host resources.  Given this, combined with the fact that
> > drivers generally configure vectors only at device setup time, the
> > existing code generally works well.  Ideally drivers should not be
> > required to modify their behavior to support device assignment, but
> > certain actions, like high frequency masking/unmasking of interrupts
> > through the vector table impose unavoidable virtualization overhead
> > and should be avoided.  I believe older Linux guests (RHEL5 time frame)
> > had such behavior.  
>
> Yes we are experiencing occasional interrupts missing for Huawei
> Hi1822 NIC VF used on Guest. Once I suspected the workflow in qemu
> could cause this issue, but after more investigation these two days,
> we found it should only be the trigger of the issue. The root cause
> may be on kernel or ARM GICR in the chip, for kernel always maps vPE
> to the first CPU (normally CPU 0), and then moves the map to the
> scheduled CPU. But there is a time window between these two actions,
> and interrupts may get lost when triggered in this short time window.
> However we have not come to a final conclusion yet.
> 
> >
> > It's possible that current IRQ domains alleviate some of the concern
> > for host IRQ exhaustion and that vfio-pci could be made to allocate
> > the maximum supported vectors per device, removing the use of the
> > NORESIZE flag for the index.  Userspace would need to continue to
> > support both modes of operation and the kernel would need to
> > continue to be compatible with that.  Thanks,  
>
> How about we set a threshold (maybe 16, 32) that only allocating
> vectors of number = min (maximum supported vectors, threshold), and
> go thru the original work flow if the specified vector is larger than
> the initially allocated?

I would not support such a solution, it's not only still wasteful of
interrupt vectors but it introduces an inflection point in the behavior
which means that "high-end" configurations exercise code paths that
"low-end" configurations do not.  Besides, it seems you haven't yet
even proven that this is an issue.  If we wanted to remove the NORESIZE
flag for this vector index, I think the host would need to allocate all
vectors supported by the MSI-X capability in advance, which means we
need to verify that vector exhaustion is no longer a concern on the
host.  Thanks,

Alex
