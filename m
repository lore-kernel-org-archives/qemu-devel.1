Received: from eggs.gnu.org ([2001:4830:134:3::10]:59506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cEWzB-0007IG-Cp
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 02:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cEWz8-00064Y-C4
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 02:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cEWz8-00062o-6V
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 02:49:50 -0500
References: <20161130101017.13382-1-maxime.coquelin@redhat.com>
	<20161130101017.13382-3-maxime.coquelin@redhat.com>
	<f7t37i0x61w.fsf@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <506e3923-6354-03fa-b622-01d23233f42a@redhat.com>
Date: Wed, 7 Dec 2016 08:49:42 +0100
MIME-Version: 1.0
In-Reply-To: <f7t37i0x61w.fsf@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 2/3] vhost-net: Notify the backend about
 the host MTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Conole <aconole@redhat.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, fbl@redhat.com, berrange@redhat.com, mlureau@redhat.com, ktraynor@redhat.com, jasowang@redhat.com, yuanhan.liu@linux.intel.com



On 12/06/2016 07:31 PM, Aaron Conole wrote:
> Maxime Coquelin <maxime.coquelin@redhat.com> writes:
>
>> This patch provides a way for virtio-net to notify the
>> backend about the host MTU set by the user.
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Aaron Conole <aconole@redhat.com>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>> ---
>>  hw/net/vhost_net.c      | 22 ++++++++++++++++++++++
>>  include/net/vhost_net.h |  2 ++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>> index f2d49ad..d7c13d4 100644
>> --- a/hw/net/vhost_net.c
>> +++ b/hw/net/vhost_net.c
>> @@ -51,6 +51,7 @@ static const int kernel_feature_bits[] = {
>>      VIRTIO_RING_F_EVENT_IDX,
>>      VIRTIO_NET_F_MRG_RXBUF,
>>      VIRTIO_F_VERSION_1,
>> +    VIRTIO_NET_F_MTU,
>>      VHOST_INVALID_FEATURE_BIT
>>  };
>>
>> @@ -74,6 +75,7 @@ static const int user_feature_bits[] = {
>>      VIRTIO_NET_F_HOST_ECN,
>>      VIRTIO_NET_F_HOST_UFO,
>>      VIRTIO_NET_F_MRG_RXBUF,
>> +    VIRTIO_NET_F_MTU,
>>
>>      /* This bit implies RARP isn't sent by QEMU out of band */
>>      VIRTIO_NET_F_GUEST_ANNOUNCE,
>> @@ -435,6 +437,22 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
>>      return 0;
>>  }
>>
>> +int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
>> +{
>> +    const VhostOps *vhost_ops = net->dev.vhost_ops;
>> +    int ret;
>> +
>> +    if (!vhost_ops->vhost_net_set_mtu) {
>> +        return -ENOSYS;
>> +    }
>> +
>> +    ret = vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
>> +    if (ret < 0) {
>> +        return -errno;
>> +    }
>> +    return 0;
>> +}
>> +
>>  #else
>>  uint64_t vhost_net_get_max_queues(VHostNetState *net)
>>  {
>> @@ -501,4 +519,8 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
>>  {
>>      return 0;
>>  }
>> +
>> +int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
>> +{
>> +}
>>  #endif
>
> I think this should return something - I don't know what value will come
> through if it doesn't :).

Good catch, of course something should be returned...

Thanks!
Maxime
