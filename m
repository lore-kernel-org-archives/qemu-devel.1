Received: from eggs.gnu.org ([2001:4830:134:3::10]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyE9M-0006WN-6R
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cyE9J-0004Pl-0h
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40156)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cyE9I-0004Ot-PJ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 05:01:12 -0400
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-3-maxime.coquelin@redhat.com>
	<20170411132046.GA16464@pxdev.xzpeter.org>
	<ed46bbd8-222b-3cda-e524-f9dfda8e3770@redhat.com>
	<20170412071708.GE16464@pxdev.xzpeter.org>
	<0f3cde33-98f0-c7b0-2f3b-372a26b83384@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <96684f23-04f2-dd49-b43b-8e71b049288c@redhat.com>
Date: Wed, 12 Apr 2017 17:00:43 +0800
MIME-Version: 1.0
In-Reply-To: <0f3cde33-98f0-c7b0-2f3b-372a26b83384@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 2/2] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: yuanhan.liu@linux.intel.com, mst@redhat.com, qemu-devel@nongnu.org, wexu@redhat.com, virtio-comment@lists.oasis-open.org, vkaplans@redhat.com



On 2017=E5=B9=B404=E6=9C=8812=E6=97=A5 15:24, Maxime Coquelin wrote:
>
>
> On 04/12/2017 09:17 AM, Peter Xu wrote:
>> On Tue, Apr 11, 2017 at 05:16:19PM +0200, Maxime Coquelin wrote:
>>> On 04/11/2017 03:20 PM, Peter Xu wrote:
>>>> On Tue, Apr 11, 2017 at 12:10:02PM +0200, Maxime Coquelin wrote:
>>
>> [...]
>>
>>>>
>>>>> +slave is expected to reply with a zero payload, non-zero otherwise=
.
>>>>
>>>> Is this ack mechanism really necessary? If not, not sure it'll be ni=
ce
>>>> to keep vhost-user/vhost-kernel aligned on this behavior. At least
>>>> that'll simplify vhost-user implementation on QEMU side (iiuc even
>>>> without introducing new functions for update/invalidate operations).
>>>
>>> I think this is necessary, and it won't complexify the vhost-user
>>> implementation on QEMU side, since already widely used (see reply-ack
>>> feature).
>>
>> Could you provide file/function/link pointer to the "reply-ack"
>> feature? I failed to find it myself.
>>
>>>
>>> This reply-ack mechanism is used to obtain a behaviour closer to kern=
el
>>> backend. Indeed, when QEMU sends a vhost_msg to the kernel backend, i=
t
>>> is blocked in the write() while the message is being processed in the
>>> Kernel. With user backend, QEMU is unblocked from the write() when th=
e
>>> backend has read the message, before it is being processed.
>>>
>>
>> I see. Then I agree with you that we may need a synchronized way to do
>> it. One thing I think of is IOMMU page invalidation - it should be a
>> sync operation to make sure that all the related caches were destroyed
>> when the invalidation command returns in QEMU vIOMMU emulation path.
>>
>>>
>>>>> +
>>>>> +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the=20
>>>>> slave, and the
>>>>> +master initiated the slave to master communication channel using t=
he
>>>>> +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB=20
>>>>> miss and access
>>>>> +failure events by sending VHOST_USER_IOTLB_MSG requests to the=20
>>>>> master with a
>>>>> +struct vhost_iotlb_msg payload. For miss events, the iotlb=20
>>>>> payload has to be
>>>>> +filled with the miss message type (1), the I/O virtual address=20
>>>>> and the
>>>>> +permissions flags. For access failure event, the iotlb payload=20
>>>>> has to be
>>>>> +filled with the access failure message type (4), the I/O virtual=20
>>>>> address and
>>>>> +the permissions flags. On success, the master is expected to=20
>>>>> reply  when the
>>>>> +request has been handled (for example, on miss requests, once the=20
>>>>> device IOTLB
>>>>> +has been updated) with a zero payload, non-zero otherwise.
>>>>
>>>> Failed to understand the last sentence clearly. IIUC vhost-net will
>>>> reply with an UPDATE message when a MISS message is received. Here f=
or
>>>> vhost-user are we going to send one extra zero payload after that?
>>>
>>> Not exactly. There are two channels, one for QEMU to backend requests
>>> (channel A), one for backend to QEMU requests (channel B).
>>>
>>> The backend may be multi-threaded (like DPDK), one thread for handlin=
g
>>> QEMU initiated requests (channel A), the others to handle packet
>>> processing (i.e. one for Rx, one for Tx).
>>>
>>> The processing threads will need to translate iova adresses by
>>> searching in the IOTLB cache. In case of miss, it will send an IOTLB
>>> miss request on channel B, and then wait for the ack/nack. In case of
>>> ack, it can search again the IOTLB cache and find the translation.
>>>
>>> On QEMU side, when the thread handling channel B requests receives th=
e
>>> IOTLB miss message, it gets the translation and send an IOTLB update
>>> message on channel A. Then it waits for the ack from the backend,
>>> meaning that the IOTLB cache has been updated, and replies ack on
>>> channel B.
>>
>> If the ack on channel B is used to notify the processing thread that
>> "cache is ready", then... would it be faster that we just let the
>> processing thread poll the cache until it finds it, or let the other
>> thread notify it when it receives ack on channel A? Not sure whether
>> it'll be faster.
>
> Not sure either.
> Not requiring a ack can indeed make sense in some cases, for example
> with single-threaded backends.
>
> What we can do is to remove the mandatory ack reply for
> VHOST_USER_IOTLB_MSG slave requests (miss, access fail).

I don't see any requirement for ack reply unless slave want to do any=20
post processing when guest want to access the forbidden area. It looks=20
to me that this should be done by userspace, if it's a valid map, master=20
will send the IOTLB update message. If not, it will just report to=20
guest. What needs to be guaranteed is that slave can still handle other=20
request e.g set_owner or other in this case.

Thanks

> The backend then can just rely on the REPLY_ACK feature, and set the
> VHOST_USER_NEED_REPLY flag if it want to receive such ack.
>
> Would it be fine for you?
>
> Thanks,
> Maxime
>
