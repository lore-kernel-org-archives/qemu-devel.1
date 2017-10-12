Received: from eggs.gnu.org ([2001:4830:134:3::10]:32772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e2UYT-0006tx-A4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1e2UYQ-0003XC-6Z
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:53:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:58485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1e2UYP-0003WE-S5
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 23:53:02 -0400
Message-ID: <59DEE790.5040809@intel.com>
Date: Thu, 12 Oct 2017 11:54:56 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1506744354-20979-1-git-send-email-wei.w.wang@intel.com>
	<1506744354-20979-6-git-send-email-wei.w.wang@intel.com>
	<20171001060305-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F73932025A@shsmsx102.ccr.corp.intel.com>
	<20171010180636-mutt-send-email-mst@kernel.org>
	<59DDB428.4020208@intel.com>
	<20171011161912-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171011161912-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v16 5/5] virtio-balloon:
 VIRTIO_BALLOON_F_CTRL_VQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "willy@infradead.org" <willy@infradead.org>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On 10/11/2017 09:49 PM, Michael S. Tsirkin wrote:
> On Wed, Oct 11, 2017 at 02:03:20PM +0800, Wei Wang wrote:
>> On 10/10/2017 11:15 PM, Michael S. Tsirkin wrote:
>>> On Mon, Oct 02, 2017 at 04:38:01PM +0000, Wang, Wei W wrote:
>>>> On Sunday, October 1, 2017 11:19 AM, Michael S. Tsirkin wrote:
>>>>> On Sat, Sep 30, 2017 at 12:05:54PM +0800, Wei Wang wrote:
>>>>>> +static void ctrlq_send_cmd(struct virtio_balloon *vb,
>>>>>> +			  struct virtio_balloon_ctrlq_cmd *cmd,
>>>>>> +			  bool inbuf)
>>>>>> +{
>>>>>> +	struct virtqueue *vq = vb->ctrl_vq;
>>>>>> +
>>>>>> +	ctrlq_add_cmd(vq, cmd, inbuf);
>>>>>> +	if (!inbuf) {
>>>>>> +		/*
>>>>>> +		 * All the input cmd buffers are replenished here.
>>>>>> +		 * This is necessary because the input cmd buffers are lost
>>>>>> +		 * after live migration. The device needs to rewind all of
>>>>>> +		 * them from the ctrl_vq.
>>>>> Confused. Live migration somehow loses state? Why is that and why is it a good
>>>>> idea? And how do you know this is migration even?
>>>>> Looks like all you know is you got free page end. Could be any reason for this.
>>>> I think this would be something that the current live migration lacks - what the
>>>> device read from the vq is not transferred during live migration, an example is the
>>>> stat_vq_elem:
>>>> Line 476 at https://github.com/qemu/qemu/blob/master/hw/virtio/virtio-balloon.c
>>> This does not touch guest memory though it just manipulates
>>> internal state to make it easier to migrate.
>>> It's transparent to guest as migration should be.
>>>
>>>> For all the things that are added to the vq and need to be held by the device
>>>> to use later need to consider the situation that live migration might happen at any
>>>> time and they need to be re-taken from the vq by the device on the destination
>>>> machine.
>>>>
>>>> So, even without this live migration optimization feature, I think all the things that are
>>>> added to the vq for the device to hold, need a way for the device to rewind back from
>>>> the vq - re-adding all the elements to the vq is a trick to keep a record of all of them
>>>> on the vq so that the device side rewinding can work.
>>>>
>>>> Please let me know if anything is missed or if you have other suggestions.
>>> IMO migration should pass enough data source to destination for
>>> destination to continue where source left off without guest help.
>>>
>> I'm afraid it would be difficult to pass the entire VirtQueueElement to the
>> destination. I think
>> that would also be the reason that stats_vq_elem chose to rewind from the
>> guest vq, which re-do the
>> virtqueue_pop() --> virtqueue_map_desc() steps (the QEMU virtual address to
>> the guest physical
>> address relationship may be changed on the destination).
> Yes but note how that rewind does not involve modifying the ring.
> It just rolls back some indices.

Yes, it rolls back the indices, then the following 
virtio_balloon_receive_stats()
can re-pop out the previous entry given by the guest.

Recall how stats_vq_elem works: there is only one stats buffer, which is 
used by the
guest to report stats, and also used by the host to ask the guest for 
stats report.

So the host can roll back one previous entry and what it gets will 
always be stat_vq_elem.


Our case is a little more complex than that - we have both free_page_cmd_in
(for host to guest command) and free_page_cmd_out (for guest to host 
command) buffer
passed via ctrl_vq. When the host rolls back one entry, it may get the 
free_page_cmd_out
buffer which can't be used as the host to guest buffer (i.e. 
free_page_elem held by the device).

So a trick in the driver is to refill the free_page_cmd_in buffer every 
time after the free_page_cmd_out
was sent to the host, so that when the host rewind one previous entry, 
it can always get the
free_page_cmd_in buffer (may be not a very nice method).



>
>> How about another direction which would be easier - using two 32-bit device
>> specific configuration registers,
>> Host2Guest and Guest2Host command registers, to replace the ctrlq for
>> command exchange:
>>
>> The flow can be as follows:
>>
>> 1) Before Host sending a StartCMD, it flushes the free_page_vq in case any
>> old free page hint is left there;
>> 2) Host writes StartCMD to the Host2Guest register, and notifies the guest;
>>
>> 3) Upon receiving a configuration notification, Guest reads the Host2Guest
>> register, and detaches all the used buffers from free_page_vq;
>> (then for each StartCMD, the free_page_vq will always have no obsolete free
>> page hints, right? )
>>
>> 4) Guest start report free pages:
>>      4.1) Host may actively write StopCMD to the Host2Guest register before
>> the guest finishes; or
>>      4.2) Guest finishes reporting, write StopCMD  the Guest2HOST register,
>> which traps to QEMU, to stop.
>>
>>
>> Best,
>> Wei
> I am not sure it matters whether a VQ or the config are used to start/stop.


Not matters, in terms of the flushing issue. The config method could 
avoid the above rewind issue.


> But I think flushing is very fragile. You will easily run into races
> if one of the actors gets out of sync and keeps adding data.
> I think adding an ID in the free vq stream is a more robust
> approach.
>

Adding ID to the free vq would need the device to distinguish whether it 
receives an ID or a free page hint,
so an extra protocol is needed for the two sides to talk. Currently, we 
directly assign the free page
address to desc->addr. With ID support, we would need to first allocate 
buffer for the protocol header,
and add the free page address to the header, then desc->addr = &header.

How about putting the ID to the command path? This would avoid the above 
trouble.

For example, using the 32-bit config registers:
first 16-bit: Command field
send 16-bit: ID field

Then, the working flow would look like this:

1) Host writes "Start, 1" to the Host2Guest register and notify;

2) Guest reads Host2Guest register, and ACKs by writing "Start, 1" to 
Guest2Host register;

3) Guest starts report free pages;

4) Each time when the host receives a free page hint from the 
free_page_vq, it compares the ID fields of
the Host2Guest and Guest2Host register. If matching, then filter out the 
free page from the migration dirty bitmap,
otherwise, simply push back without doing the filtering.


Best,
Wei
