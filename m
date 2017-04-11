Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cxxWw-0002Vj-V9
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cxxWt-00023k-Of
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cxxWt-00023R-FK
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:16:27 -0400
References: <20170411101002.28451-1-maxime.coquelin@redhat.com>
	<20170411101002.28451-3-maxime.coquelin@redhat.com>
	<20170411132046.GA16464@pxdev.xzpeter.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <ed46bbd8-222b-3cda-e524-f9dfda8e3770@redhat.com>
Date: Tue, 11 Apr 2017 17:16:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170411132046.GA16464@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/2] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: mst@redhat.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, virtio-comment@lists.oasis-open.org, qemu-devel@nongnu.org



On 04/11/2017 03:20 PM, Peter Xu wrote:
> On Tue, Apr 11, 2017 at 12:10:02PM +0200, Maxime Coquelin wrote:
>> This patch specifies the master/slave communication to support
>> device IOTLB implementation in slave.
>>
>> The vhost_iotlb_msg structure introduced for kernel backends is
>> re-used, making the design close between the two backends.
>>
>> An exception is the use of the secondary channel to enable the
>> slave to send IOTLB miss requests to the master.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>  docs/specs/vhost-user.txt | 56 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
>> index b365047..048a4d6 100644
>> --- a/docs/specs/vhost-user.txt
>> +++ b/docs/specs/vhost-user.txt
>> @@ -97,6 +97,23 @@ Depending on the request type, payload can be:
>>     log offset: offset from start of supplied file descriptor
>>         where logging starts (i.e. where guest address 0 would be logged)
>>
>> + * An IOTLB message
>> +   ---------------------------------------------------------
>> +   | iova | size | user address | permissions flags | type |
>> +   ---------------------------------------------------------
>> +
>> +   IOVA: a 64-bit guest I/O virtual address
>> +   Size: a 64-bit size
>> +   User address: a 64-bit user address
>> +   Permissions flags: a 8-bit bit field:
>> +    - Bit 0: Read access
>> +    - Bit 1: Write access
>> +   Type: a 8-bit IOTLB message type:
>> +    - 1: IOTLB miss
>> +    - 2: IOTLB update
>> +    - 3: IOTLB invalidate
>> +    - 4: IOTLB access fail
>> +
>>  In QEMU the vhost-user message is implemented with the following struct:
>>
>>  typedef struct VhostUserMsg {
>> @@ -109,6 +126,7 @@ typedef struct VhostUserMsg {
>>          struct vhost_vring_addr addr;
>>          VhostUserMemory memory;
>>          VhostUserLog log;
>> +        struct vhost_iotlb_msg iotlb;
>>      };
>>  } QEMU_PACKED VhostUserMsg;
>>
>> @@ -258,6 +276,30 @@ Once the source has finished migration, rings will be stopped by
>>  the source. No further update must be done before rings are
>>  restarted.
>>
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
> s/update/invalidate/?

Indeed.

>
>> +slave is expected to reply with a zero payload, non-zero otherwise.
>
> Is this ack mechanism really necessary? If not, not sure it'll be nice
> to keep vhost-user/vhost-kernel aligned on this behavior. At least
> that'll simplify vhost-user implementation on QEMU side (iiuc even
> without introducing new functions for update/invalidate operations).

I think this is necessary, and it won't complexify the vhost-user
implementation on QEMU side, since already widely used (see reply-ack
feature).

This reply-ack mechanism is used to obtain a behaviour closer to kernel
backend. Indeed, when QEMU sends a vhost_msg to the kernel backend, it
is blocked in the write() while the message is being processed in the
Kernel. With user backend, QEMU is unblocked from the write() when the
backend has read the message, before it is being processed.


>> +
>> +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave, and the
>> +master initiated the slave to master communication channel using the
>> +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss and access
>> +failure events by sending VHOST_USER_IOTLB_MSG requests to the master with a
>> +struct vhost_iotlb_msg payload. For miss events, the iotlb payload has to be
>> +filled with the miss message type (1), the I/O virtual address and the
>> +permissions flags. For access failure event, the iotlb payload has to be
>> +filled with the access failure message type (4), the I/O virtual address and
>> +the permissions flags. On success, the master is expected to reply  when the
>> +request has been handled (for example, on miss requests, once the device IOTLB
>> +has been updated) with a zero payload, non-zero otherwise.
>
> Failed to understand the last sentence clearly. IIUC vhost-net will
> reply with an UPDATE message when a MISS message is received. Here for
> vhost-user are we going to send one extra zero payload after that?

Not exactly. There are two channels, one for QEMU to backend requests
(channel A), one for backend to QEMU requests (channel B).

The backend may be multi-threaded (like DPDK), one thread for handling
QEMU initiated requests (channel A), the others to handle packet
processing (i.e. one for Rx, one for Tx).

The processing threads will need to translate iova adresses by
searching in the IOTLB cache. In case of miss, it will send an IOTLB
miss request on channel B, and then wait for the ack/nack. In case of
ack, it can search again the IOTLB cache and find the translation.

On QEMU side, when the thread handling channel B requests receives the
IOTLB miss message, it gets the translation and send an IOTLB update
message on channel A. Then it waits for the ack from the backend,
meaning that the IOTLB cache has been updated, and replies ack on
channel B.

Doing this, in backend, we have only one writer in the IOTLB cache, and
multiple readers.

>> +
>>  Protocol features
>>  -----------------
>>
>> @@ -524,6 +566,20 @@ Message types
>>        has been negotiated, and protocol feature bit VHOST_USER_PROTOCOL_F_SLAVE_REQ
>>        bit is present in VHOST_USER_GET_PROTOCOL_FEATURES.
>>
>> + * VHOST_USER_IOTLB_MSG
>> +
>> +      Id: 22
>> +      Equivalent ioctl: N/A (equivalent to VHOST_IOTLB_MSG message type)
>> +      Initiator: Master or slave
>> +
>> +      Send IOTLB messages with struct vhost_iotlb_msg as payload.
>> +      Master sends such requests to update and invalidate entries in the device
>> +      IOTLB. Slave sends such requests to notify of an IOTLB miss, or an IOTLB
>
> s/of//?

Yes.

>
>> +      access failure. The recipient has to acknowledge the request with
>> +      sending zero as u64 payload for success, non-zero otherwise.
>
> Same question here...

Thanks,
Maxime

> Thanks,
>
>> +      This request should be send only when VIRTIO_F_IOMMU_PLATFORM feature
>> +      has been successfully negotiated.
>> +
>>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>>  -------------------------------
>>  The original vhost-user specification only demands replies for certain
>> --
>> 2.9.3
>>
>
