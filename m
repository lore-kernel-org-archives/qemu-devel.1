Received: from eggs.gnu.org ([2001:4830:134:3::10]:35908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQtYE-0003Wz-As
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1fQtYA-0005cy-FW
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:57:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:57579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1fQtYA-0005cU-5j
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:57:54 -0400
Message-ID: <5B191EA6.3020004@intel.com>
Date: Thu, 07 Jun 2018 20:01:42 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<1524550428-27173-5-git-send-email-wei.w.wang@intel.com>
	<20180606064315.GB7815@xz-mi> <5B17B366.5030802@intel.com>
	<20180607031732.GG7815@xz-mi> <5B18C2B2.30709@intel.com>
	<20180607065808.GB750@xz-mi>
In-Reply-To: <20180607065808.GB750@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/5] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_HINT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On 06/07/2018 02:58 PM, Peter Xu wrote:
> On Thu, Jun 07, 2018 at 01:29:22PM +0800, Wei Wang wrote:
>>>>> [...]
>>>>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_report = {
>>>>>> +    .name = "virtio-balloon-device/free-page-report",
>>>>>> +    .version_id = 1,
>>>>>> +    .minimum_version_id = 1,
>>>>>> +    .needed = virtio_balloon_free_page_support,
>>>>>> +    .fields = (VMStateField[]) {
>>>>>> +        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>>>>> +        VMSTATE_UINT32(poison_val, VirtIOBalloon),
>>>>> (could we move all the poison-related lines into another patch or
>>>>>     postpone?  after all we don't support it yet, do we?)
>>>>>
>>>>    We don't support migrating poison value, but guest maybe use it, so we are
>>>> actually disabling this feature in that case. Probably good to leave the
>>>> code together to handle that case.
>>> Could we just avoid declaring that feature bit in emulation code
>>> completely?  I mean, we support VIRTIO_BALLOON_F_FREE_PAGE_HINT first
>>> as the first step (as you mentioned in commit message, the POISON is a
>>> TODO).  Then when you really want to completely support the POISON
>>> bit, you can put all that into a separate patch.  Would that work?
>>>
>> Not really. The F_PAGE_POISON isn't a feature configured via QEMU cmd line
>> like F_FREE_PAGE_HINT. We always set F_PAGE_POISON if F_FREE_PAGE_HINT is
>> enabled. It is used to detect if the guest is using page poison.
> Ok I think I kind of understand.  But it seems strange to me to have
> this as a feature bit.  I thought it suites more to be a config field
> so that guest could setup.  Like, we can have 1 byte to setup "whether
> PAGE_POISON is used in the guest", another 1 byte to setup "what is
> the PAGE_POISON value if it's enabled".

This is also suggested by Michael, which sounds good to me. Using config 
is doable, but that doesn't show advantages over using feature bits.



>
> Asked since I see this in virtio spec (v1.0, though I guess it won't
> change) in chapter "2.2.1 Driver Requirements: Feature Bits":
>
> "The driver MUST NOT accept a feature which the device did not offer"
>
> Then I'm curious what would happen if:
>
> - a emulator (not QEMU) only offered F_FREE_PAGE_HINT, not F_POISON
> - a guest that enabled PAGE_POISON
>
> Then how the driver could tell the host that PAGE_POISON is enabled
> considering that guest should never set that feature bit if the
> emulation code didn't provide it?
>

All the emulator implementations need to follow the virtio spec. We will 
finally have this feature written to the virtio-balloon device section, 
and state that the F_PAGE_POISON needs to be set on the device when 
F_FREE_PAGE_HINT is set on the device.


Best,
Wei
