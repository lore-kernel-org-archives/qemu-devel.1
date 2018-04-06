Received: from eggs.gnu.org ([2001:4830:134:3::10]:58196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1f4Tuz-0001NN-Tw
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1f4Tuw-0007r1-N4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:08:49 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com
	([104.47.33.67]:38358
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1f4Tuw-0007qX-7L
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 12:08:46 -0400
References: <20180406120356.24757-1-brijesh.singh@amd.com>
	<18da2a0b-bb37-a3bf-d9ca-220835df7ae2@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <05b0dea5-7dd1-b695-de96-82db2c76441c@amd.com>
Date: Fri, 6 Apr 2018 11:08:38 -0500
MIME-Version: 1.0
In-Reply-To: <18da2a0b-bb37-a3bf-d9ca-220835df7ae2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] tap: set vhostfd passed from qemu
 cli to non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Thomas.Lendacky@amd.com, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>



On 04/06/2018 10:44 AM, Eric Blake wrote:
> On 04/06/2018 07:03 AM, Brijesh Singh wrote:
>> A guest boot hangs while probing the network interface when
>> iommu_platform=on is used.
>>
>> The following qemu cli hangs without this patch:
>>
>> # $QEMU \
>>    -netdev tap,fd=3,id=hostnet0,vhost=on,vhostfd=4 3<>/dev/tap67 4<>/dev/host-net \
>>    -device virtio-net-pci,netdev=hostnet0,id=net0,iommu_platform=on,disable-legacy=on \
>>    ...
>>
>> Commit: c471ad0e9bd46 (vhost_net: device IOTLB support) took care of
>> setting vhostfd to non-blocking when QEMU opens /dev/host-net but if
>> the fd is passed from qemu cli then we need to ensure that fd is set
>> to non-blocking.
>>
>> Fixes: c471ad0e9bd46 "vhost_net: device IOTLB support"
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>   net/tap.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 2b3a36f9b50d..8c026fbf95cd 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -693,6 +693,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>>                   }
>>                   return;
>>               }
>> +            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> 
> Please use qemu_set_nonblock() instead.
> 


Sure will do.
