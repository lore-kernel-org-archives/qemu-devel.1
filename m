Received: from eggs.gnu.org ([2001:4830:134:3::10]:33874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d0k8f-0006CN-Cr
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1d0k8c-00060w-A7
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1d0k8c-00060f-01
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:34:54 -0400
References: <20170414174056.28946-1-maxime.coquelin@redhat.com>
	<20170414174056.28946-5-maxime.coquelin@redhat.com>
	<20170417035027.GB16703@pxdev.xzpeter.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <615dc39c-6db5-2062-d053-1324c1d1dcce@redhat.com>
Date: Wed, 19 Apr 2017 09:34:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170417035027.GB16703@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 4/4] spec/vhost-user spec: Add IOMMU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org



On 04/17/2017 05:50 AM, Peter Xu wrote:
> On Fri, Apr 14, 2017 at 07:40:56PM +0200, Maxime Coquelin wrote:
> 
> [...]
> 
>> +IOMMU support
>> +-------------
>> +
>> +When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master has
>> +to send IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
>> +requests to the slave with a struct vhost_iotlb_msg payload. For update events,
>> +the iotlb payload has to be filled with the update message type (2), the I/O
>> +virtual address, the size, the user virtual address, and the permissions
>> +flags. For invalidation events, the iotlb payload has to be filled with the
>> +update message type (3), the I/O virtual address and the size. On success, the
> 
> s/update/invalidate/ again?

Oh, sorry, I missed to fix it last time.

>> +slave is expected to reply with a zero payload, non-zero otherwise.
>> +
>> +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave, and the
>> +master initiated the slave to master communication channel using the
>> +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss and access
>> +failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests to the master
>> +with a struct vhost_iotlb_msg payload. For miss events, the iotlb payload has
>> +to be filled with the miss message type (1), the I/O virtual address and the
>> +permissions flags. For access failure event, the iotlb payload has to be
>> +filled with the access failure message type (4), the I/O virtual address and
>> +the permissions flags. For synchronization purpose, the slave may rely on the
>> +reply-ack feature, so the master may send a reply when operation is completed
>> +if the reply-ack feature is negotiated and slaves requests a reply.
>> +
>>   Slave communication
>>   -------------------
>>   
>> @@ -512,6 +554,38 @@ Master message types
>>         has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_F_SLAVE_REQ
>>         bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
>>   
>> + * VHOST_USER_IOTLB_MSG
>> +
>> +      Id: 22
>> +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
>> +      Master payload: struct vhost_iotlb_msg
>> +      Slave payload: u64
>> +
>> +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
>> +      Master sends such requests to update and invalidate entries in the device
>> +      IOTLB. The slave has to acknowledge the request with sending zero as u64
>> +      payload for success, non-zero otherwise.
>> +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
>> +      has been successfully negotiated.
>> +
>> +Slave message types
>> +-------------------
>> +
>> + * VHOST_USER_SLAVE_IOTLB_MSG
>> +
>> +      Id: 1
>> +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
>> +      Slave payload: struct vhost_iotlb_msg
>> +      Master payload: N/A
> 
> Master payload should be u64 due to REPLY_ACK?

Not sure it should be specified, as this is an optional reply in this
case. Or it should be "u64 if REPLY_ACK".

> A comment regarding to this whole patch - I see that there will be
> lots of things in common between vhost-kernel and vhost-user iotlb
> support at least in this patch. Would it be nice that we consider to
> leverage shared codes with vhost-kernel? I see the most difference is
> the channel (one using vhost fd, one using socket pair), but the
> protocol and logic should merely the same after all. Not sure whether
> we can just abstract the channel handling out of the logic (e.g., on
> how to read/write to the channel, and how to deal with reply_ack).

Right, I think we can go further in sharing code between backends.

Thanks for the review,
Maxime
