Received: from eggs.gnu.org ([2001:4830:134:3::10]:40479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEVIt-0006zV-Cx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEVIs-00040c-0K
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:38:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fEVIr-000408-Ql
	for qemu-devel@nongnu.org; Fri, 04 May 2018 03:38:53 -0400
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164346.28940.93328.stgit@gimli.home>
	<20180503045603.GG8239@xz-mi> <20180503102942.7fcc1211@w520.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <9e5a58a1-8e91-3791-1efd-434831092d75@redhat.com>
Date: Fri, 4 May 2018 09:38:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180503102942.7fcc1211@w520.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vfio/quirks: Enable ioeventfd
 quirks to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

Hi Alex,

On 05/03/2018 06:29 PM, Alex Williamson wrote:
> On Thu, 3 May 2018 12:56:03 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
>> On Tue, May 01, 2018 at 10:43:46AM -0600, Alex Williamson wrote:
>>
>> [...]
>>
>>> -static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
>>> +static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
>>>  {
>>>      QLIST_REMOVE(ioeventfd, next);
>>> +
>>>      memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
>>>                                ioeventfd->match_data, ioeventfd->data,
>>>                                &ioeventfd->e);
>>> -    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
>>> +
>>> +    if (ioeventfd->vfio) {
>>> +        struct vfio_device_ioeventfd vfio_ioeventfd;
>>> +
>>> +        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
>>> +        vfio_ioeventfd.flags = ioeventfd->size;
>>> +        vfio_ioeventfd.data = ioeventfd->data;
>>> +        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
>>> +                                ioeventfd->region_addr;
>>> +        vfio_ioeventfd.fd = -1;
>>> +
>>> +        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);  
>>
>> (If the series is going to respin, I am thinking whether it would
>>  worth it to capture this error to dump something.  But it's for sure
>>  optional since even error happened we should have something in dmesg
>>  so it only matters on whether we also want something to be dumped
>>  from QEMU side too... After all there aren't much we can do)
> 
> I'm torn whether to use QEMU standard error handling here, ie.
> abort().  If we failed to remove the KVM ioeventfd, we'd abort before
> we get here, so there's no chance that the vfio ioeventfd will continue
> to be triggered.  Obviously leaving a vfio ioeventfd that we can't
> trigger and might interfere with future ioeventfds is not good, but do
> we really want to kill the VM because we possibly can't add an
> accelerator here later?  I'm inclined to say no, so I think I'll just
> error_report() unless there are objections.
> 
>>> +
>>> +    } else {
>>> +        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
>>> +                            NULL, NULL, NULL);
>>> +    }
>>> +
>>>      event_notifier_cleanup(&ioeventfd->e);
>>>      trace_vfio_ioeventfd_exit(memory_region_name(ioeventfd->mr),
>>>                                (uint64_t)ioeventfd->addr, ioeventfd->size,  
>>
>> [...]
>>
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index ba1239551115..84e27c7bb2d1 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3177,6 +3177,8 @@ static Property vfio_pci_dev_properties[] = {
>>>                       no_geforce_quirks, false),
>>>      DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
>>>                       false),
>>> +    DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
>>> +                     false),  
>>
>> Here it looks more like a tri-state for me, so we can either:
>>
>> - disable the acceleration in general, or
>> - enable QEMU-side acceleration only, or
>> - enable kernel-side acceleration
> 
> So you're looking for a Auto/Off/KVM-only option?  Do you really think
> it's worth defining a new tristate property for this sort of debugging
> option...
> 
>> In other words, IIUC x-no-vfio-ioeventfd won't matter much if
>> x-no-kvm-ioeventfd is already set.  So not sure whether a single
>> parameter would be nicer.
> 
> That's correct, but who do we expect to be using this option and why?
> I added enum OffAutoPCIBAR and the property to enable it for MSI-x
> relocation because it is an option that a normal user might reasonably
> need to use, given the right hardware on the right host, but it's an
> unsupported option because we cannot programatically validate it.
> Support rests with the individual user, if it doesn't work, don't use
> it, if it helps, great.  Here we have options that are really only for
> debugging, to test whether something has gone wrong in this code,
> disable this bypass to make all device interactions visible through
> QEMU, or specifically to evaluate the performance of this path.  Is it
> reasonable to impose yet another property type on the common code for
> this use case when a couple bools work just fine, if perhaps not
> absolutely ideal?  Am I overlooking an existing tri-state that might be
> a reasonable match?
> 
> Tying Eric's thread so we can discuss this in one place:
> 
> On Thu, 3 May 2018 17:20:18 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
>> I tend to agree with Peter about the 2 options. Only the KVM
>> acceleration brings benefit here?
> 
> Not at all, KVM acceleration does half the job (perhaps more than
> half), but if we want to completely bypass the userspace exit then we
> need both KVM triggering the ioeventfd and vfio consuming it.  It's
> useful for me at least to be able to compare completely disabled vs
> just KVM vs also adding vfio.  As above, I don't expect these to be
> used for anything other than debugging and performance evaluation, so I
> don't think it's worth making non-trivial code changes to enable the
> vfio-only path, nor do I think it's worthwhile to define a new
> tri-state property to resolve the slight mismatch we have vs two
> bools.  Again, let me know if you think I'm missing an existing
> property or if there are trivial changes we could make to make this map
> to an existing property.  Thanks,

Yes sorry I was not clear enough. I understood actual acceleration was
due to the fact the ioeventfd is handled on kernel side and not on user
side. So I thought we generally wanted both or nothing, hence a single
option. Nevertheless I am fine as well to leave the 2 debug options.

Thanks

Eric
> 
> Alex
> 
