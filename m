Received: from eggs.gnu.org ([2001:4830:134:3::10]:49634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBH2p-0004k7-7N
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dBH2k-0003SR-AS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:44:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dBH2k-0003SM-1h
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:44:22 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170517194401-mutt-send-email-mst@kernel.org>
Message-ID: <63eaa3cf-1114-0ab2-da05-9f2731464c83@redhat.com>
Date: Thu, 18 May 2017 10:43:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170517194401-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 05/17/2017 06:48 PM, Michael S. Tsirkin wrote:
> On Thu, May 11, 2017 at 02:32:46PM +0200, Maxime Coquelin wrote:
>> This patch specifies and implements the master/slave communication
>> to support device IOTLB in slave.
>>
>> The vhost_iotlb_msg structure introduced for kernel backends is
>> re-used, making the design close between the two backends.
>>
>> An exception is the use of the secondary channel to enable the
>> slave to send IOTLB miss requests to the master.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   docs/specs/vhost-user.txt | 75 +++++++++++++++++++++++++++++++++++++++++++++++
>>   hw/virtio/vhost-user.c    | 31 ++++++++++++++++++++
>>   2 files changed, 106 insertions(+)
>>
>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
>> index 5fa7016..4a1f0c3 100644
>> --- a/docs/specs/vhost-user.txt
>> +++ b/docs/specs/vhost-user.txt
>> @@ -97,6 +97,23 @@ Depending on the request type, payload can be:
>>      log offset: offset from start of supplied file descriptor
>>          where logging starts (i.e. where guest address 0 would be logged)
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
>>   In QEMU the vhost-user message is implemented with the following struct:
>>   
>>   typedef struct VhostUserMsg {
>> @@ -109,6 +126,7 @@ typedef struct VhostUserMsg {
>>           struct vhost_vring_addr addr;
>>           VhostUserMemory memory;
>>           VhostUserLog log;
>> +        struct vhost_iotlb_msg iotlb;
>>       };
>>   } QEMU_PACKED VhostUserMsg;
>>   
>> @@ -253,6 +271,31 @@ Once the source has finished migration, rings will be stopped by
>>   the source. No further update must be done before rings are
>>   restarted.
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
>> +invalidation message type (3), the I/O virtual address and the size. On
>> +success, the slave is expected to reply with a zero payload, non-zero
>> +otherwise.
>> +
>> +When the VHOST_USER_PROTOCOL_F_SLAVE_REQ is supported by the slave, and the
>> +master initiated the slave to master communication channel using the
>> +VHOST_USER_SET_SLAVE_REQ_FD request, the slave can send IOTLB miss and access
>> +failure events by sending VHOST_USER_SLAVE_IOTLB_MSG requests to the master
>> +with a struct vhost_iotlb_msg payload. For miss events, the iotlb payload has
>> +to be filled with the miss message type (1), the I/O virtual address and the
>> +permissions flags. For access failure event, the iotlb payload has to be
>> +filled with the access failure message type (4), the I/O virtual address and
>> +the permissions flags.
> 
> I don't think slave should cache invalid entries. If it does not,
> how can it detect access failure as opposed to a miss?

Of course, invalid cache entries should not be cached.
The VHOST_IOTLB_ACCESS_FAIL has been specified for the Kernel backend,
even if the latter does not implement it yet.

In the case of user backend, I think it could be used without caching
entries.

After the backend sends a miss requests, the master will send an update
requests.

If for some reasons, the update entry is invalid (e.g. is outside the
memory ranges shared by set_mem_table), it won't be inserted into the
cache. So, when looking again at the cache, the backend will still face
a miss, and so can notify the master of the failing access.

That said, I specified this message type to mimic the kernel backend, I
don't what the master could do of such information.

> 
>> For synchronization purpose, the slave may rely on the
>> +reply-ack feature, so the master may send a reply when operation is completed
> 
> What does completed mean in this context?

Completed means either the master has sent the IOTLB entry update to the
slave through the master->slave channel, or the IOVA is invalid (so
nothing sent).

> 
>> +if the reply-ack feature is negotiated and slaves requests a reply.
>> +
> 
> This is not very clear to me.
> So slave sends an access to master. Master finds a pte that
> overlaps. What does it send to guest? Initial PTE?
> All PTEs to cover the request? Part of the PTE that overlaps
> the request?

Actually, the slave only sends the IOVA and access permissions, not the
size. So the master will send the PTE overlapping this IOVA if
permissions match.
When received the slave will again lookup into its cache, and may send
another request with the next first missing IOVA if needed.

Maxime
