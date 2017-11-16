Received: from eggs.gnu.org ([2001:4830:134:3::10]:33434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eFNCn-0005N2-AG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eFNCi-0008Jd-CW
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:12922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eFNCg-0008AC-E4
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 11:39:52 -0500
Message-ID: <5A0D7D9A.1060509@intel.com>
Date: Thu, 16 Nov 2017 19:59:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-7-git-send-email-wei.w.wang@intel.com>
	<5A097548.8000608@intel.com>
	<20171113192309-mutt-send-email-mst@kernel.org>
	<5A0ADB3B.4070407@intel.com>
	<20171114230805-mutt-send-email-mst@kernel.org>
	<5A0BB8EE.4050402@intel.com>
	<20171115152307-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171115152307-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v17 6/6] virtio-balloon:
 VIRTIO_BALLOON_F_FREE_PAGE_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, Nitesh Narayan Lal <nilal@redhat.com>, Rik van Riel <riel@redhat.com>

On 11/15/2017 09:26 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 15, 2017 at 11:47:58AM +0800, Wei Wang wrote:
>> On 11/15/2017 05:21 AM, Michael S. Tsirkin wrote:
>>> On Tue, Nov 14, 2017 at 08:02:03PM +0800, Wei Wang wrote:
>>>> On 11/14/2017 01:32 AM, Michael S. Tsirkin wrote:
>>>>>> - guest2host_cmd: written by the guest to ACK to the host about the
>>>>>> commands that have been received. The host will clear the corresponding
>>>>>> bits on the host2guest_cmd register. The guest also uses this register
>>>>>> to send commands to the host (e.g. when finish free page reporting).
>>>>> I am not sure what is the role of guest2host_cmd. Reporting of
>>>>> the correct cmd id seems sufficient indication that guest
>>>>> received the start command. Not getting any more seems sufficient
>>>>> to detect stop.
>>>>>
>>>> I think the issue is when the host is waiting for the guest to report pages,
>>>> it does not know whether the guest is going to report more or the report is
>>>> done already. That's why we need a way to let the guest tell the host "the
>>>> report is done, don't wait for more", then the host continues to the next
>>>> step - sending the non-free pages to the destination. The following method
>>>> is a conclusion of other comments, with some new thought. Please have a
>>>> check if it is good.
>>> config won't work well for this IMHO.
>>> Writes to config register are hard to synchronize with the VQ.
>>> For example, guest sends free pages, host says stop, meanwhile
>>> guest sends stop for 1st set of pages.
>> I still don't see an issue with this. Please see below:
>> (before jumping into the discussion, just make sure I've well explained this
>> point: now host-to-guest commands are done via config, and guest-to-host
>> commands are done via the free page vq)
> This is fine by me actually. But right now you have guest to host
> not going through vq, going through command register instead -
> this is how sending stop to host seems to happen.
> If you make it go through vq then I think all will be well.
>
>> Case: Host starts to request the reporting with cmd_id=1. Some time later,
>> Host writes "stop" to config, meantime guest happens to finish the reporting
>> and plan to actively send a "stop" command from the free_page_vq().
>>            Essentially, this is like a sync between two threads - if we view
>> the config interrupt handler as one thread, another is the free page
>> reporting worker thread.
>>
>>          - what the config handler does is simply:
>>                1.1:  WRITE_ONCE(vb->reporting_stop, true);
>>
>>          - what the reporting thread will do is
>>                2.1:  WRITE_ONCE(vb->reporting_stop, true);
>>                2.2:  send_stop_to_host_via_vq();
>>
>>  From the guest point of view, no matter 1.1 is executed first or 2.1 first,
>> it doesn't make a difference to the end result - vb->reporting_stop is set.
>>
>>  From the host point of view, it knows that cmd_id=1 has truly stopped the
>> reporting when it receives a "stop" sign via the vq.
>>
>>
>>> How about adding a buffer with "stop" in the VQ instead?
>>> Wastes a VQ entry which you will need to reserve for this
>>> but is it a big deal?
>> The free page vq is guest-to-host direction.
> Yes, for guest to host stop sign.
>
>> Using it for host-to-guest
>> requests will make it bidirectional, which will result in the same issue
>> described before: https://lkml.org/lkml/2017/10/11/1009 (the first response)
>>
>> On the other hand, I think adding another new vq for host-to-guest
>> requesting doesn't make a difference in essence, compared to using config
>> (same 1.1, 2.1, 2.2 above), but will be more complicated.
> I agree with this. Host to guest can just incremenent the "free command id"
> register.


OK, thanks for the suggestions. I think one more issue left here:

Previously, when the guest receives a config interrupt, it blindly adds 
the balloon work item to the workqueue in virtballoon_changed(), because 
only ballooning uses the config.
Now, free page reporting is requested via config, too.

We have the following two options:

Option 1: add "diff = towards_target()" to virtballoon_changed(), and if 
diff = 0, it will not add the balloon work item to the wq.

Option 2: add "cmd" for the host-to-guest request, and add the item when 
"cmd | CMD_BALLOON" is true.

I'm inclined to take option 1 now. Which one would you prefer?

Best,
Wei
