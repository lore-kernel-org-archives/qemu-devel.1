Received: from eggs.gnu.org ([2001:4830:134:3::10]:47769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ebQSy-0004ZC-Es
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ebQSs-000462-NE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ebQSs-000427-EB
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:35:42 -0500
References: <20180112145658.17121-1-maxime.coquelin@redhat.com>
	<20180112145658.17121-2-maxime.coquelin@redhat.com>
	<20180116045637-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <481b4c1f-c0da-0614-e553-50dca87d7b4c@redhat.com>
Date: Tue, 16 Jan 2018 13:35:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180116045637-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] vhost-user: fix multiple queue
 specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, mlureau@redhat.com, zhengxiang9@huawei.com, lersek@redhat.com, pbonzini@redhat.com



On 01/16/2018 04:00 AM, Michael S. Tsirkin wrote:
> On Fri, Jan 12, 2018 at 03:56:55PM +0100, Maxime Coquelin wrote:
>> The number of queues supported by the slave is queried with
>> message VHOST_USER_GET_QUEUE_NUM, not with message
>> VHOST_USER_GET_PROTOCOL_FEATURES.
>>
>> Also, looking at master and slave implemntations, the payload
>> returned by the slave is the number of queue pairs supported
>> by the slave, not the number of queues.
> 
> virtio doesn't have a concept of queue pairs. virtio net does
> have a concept of a tx/rx pair for purposes of steering.

Ok, thanks for the clarification. I will have a look at how vhost-user
SCSI implements it.

> Would this be a slave bug then?

If I'm not mistaken, the bug is in QEMU:

VHOST_USER_GET_QUEUE_NUM is stored in (struct vhost_dev).max_queues.
vhost_net_get_max_queues() returns (struct vhost_dev).max_queues.
And vhost_user_start() from net/vhost-user.c calls
vhost_net_get_max_queues() to get the max number of tx/rx pairs.

If we want to fix QEMU, I think we will need a new flag for
compatibility with older/current backends that assume it represent a
queue pair.

> I've applied the 1st chunk for now.

Thanks.

>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>   docs/interop/vhost-user.txt | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
>> index d49444e037..8a14191a1e 100644
>> --- a/docs/interop/vhost-user.txt
>> +++ b/docs/interop/vhost-user.txt
>> @@ -214,8 +214,8 @@ Multiple queue is treated as a protocol extension, hence the slave has to
>>   implement protocol features first. The multiple queues feature is supported
>>   only when the protocol feature VHOST_USER_PROTOCOL_F_MQ (bit 0) is set.
>>   
>> -The max number of queues the slave supports can be queried with message
>> -VHOST_USER_GET_PROTOCOL_FEATURES. Master should stop when the number of
>> +The max number of queue pairs the slave supports can be queried with message
>> +VHOST_USER_GET_QUEUE_NUM. Master should stop when the number of
>>   requested queues is bigger than that.
>>   
>>   As all queues share one connection, the master uses a unique index for each
>> @@ -537,7 +537,7 @@ Master message types
>>         Master payload: N/A
>>         Slave payload: u64
>>   
>> -      Query how many queues the backend supports. This request should be
>> +      Query how many queue pairs the backend supports. This request should be
>>         sent only when VHOST_USER_PROTOCOL_F_MQ is set in queried protocol
>>         features by VHOST_USER_GET_PROTOCOL_FEATURES.
>>   
>> -- 
>> 2.14.3
