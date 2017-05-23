Received: from eggs.gnu.org ([2001:4830:134:3::10]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dD6IC-0006Nx-6h
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dD6I6-0007aN-4Q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dD6I5-0007Yd-V8
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:39:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4824EC057FA7
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 09:39:44 +0000 (UTC)
References: <20170520080658.337-1-maxime.coquelin@redhat.com>
	<20170522202344-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <85b1fa8a-2014-c41e-099e-eaab69c73d5d@redhat.com>
Date: Tue, 23 May 2017 11:39:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170522202344-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost_net: do not expose MTU feature bit
 to kernel backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: aconole@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org



On 05/22/2017 07:24 PM, Michael S. Tsirkin wrote:
> On Sat, May 20, 2017 at 10:06:58AM +0200, Maxime Coquelin wrote:
>> This patch removes MTU from the list of features supported by
>> the kernel backend, so that vhost kernel backend does not have
>> to advertise it to be negotiated.
>>
>> Cc: Aaron Conole <aconole@redhat.com>
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> 
> This will break cross-version migration when the kernel
> does not advertise it though. I'm afraid we'll need
> a compat flag.

Ok, you are right.
The difficulty with a compat flag is that vhost-net is not a driver,
so we cannot add it a new property to make it kernel-backend only.

For consistency, maybe we can add a new internal property to virtio-net
driver, to bypass backend negotiation for this feature for all backends?

I will propose a new version shortly.

Thanks,
Maxime
>> ---
>>   hw/net/vhost_net.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index 22874a9..bdd8633 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -51,7 +51,6 @@ static const int kernel_feature_bits[] = {
>>       VIRTIO_RING_F_EVENT_IDX,
>>       VIRTIO_NET_F_MRG_RXBUF,
>>       VIRTIO_F_VERSION_1,
>> -    VIRTIO_NET_F_MTU,
>>       VIRTIO_F_IOMMU_PLATFORM,
>>       VHOST_INVALID_FEATURE_BIT
>>   };
>> -- 
>> 2.9.3
