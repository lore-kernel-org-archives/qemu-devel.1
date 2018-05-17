Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fJKIt-0007DB-Qw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fJKIp-00016u-Ur
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:54:51 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com
	([104.47.33.56]:10555
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fJKIp-00015o-Mn
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:54:47 -0400
References: <20180406185125.12536-1-brijesh.singh@amd.com>
	<20180408065347-mutt-send-email-mst@kernel.org>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e5a2ff57-a049-42ab-de44-522ec4195406@amd.com>
Date: Thu, 17 May 2018 09:54:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180408065347-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12] tap: set vhostfd passed from
 qemu cli to non-blocking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Thomas.Lendacky@amd.com, Jason Wang <jasowang@redhat.com>

Hi Michael and Jason,

Looks like this patch was not included in any of your pull request hence 
it didn't made into 2.12. Can you please include this patch in your next 
pull request?

~ Brijesh

On 04/07/2018 10:53 PM, Michael S. Tsirkin wrote:
> On Fri, Apr 06, 2018 at 01:51:25PM -0500, Brijesh Singh wrote:
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
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
>> ---
>>
>> Changes since v1:
>>   - use qemu_set_nonblock() instead of fcntl(..)
>>
>>   net/tap.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 2b3a36f9b50d..89c4e19162a2 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -40,6 +40,7 @@
>>   #include "qemu-common.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/sockets.h"
>>   
>>   #include "net/tap.h"
>>   
>> @@ -693,6 +694,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>>                   }
>>                   return;
>>               }
>> +            qemu_set_nonblock(vhostfd);
>>           } else {
>>               vhostfd = open("/dev/vhost-net", O_RDWR);
>>               if (vhostfd < 0) {
>> -- 
>> 2.14.3
