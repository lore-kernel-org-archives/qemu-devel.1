Received: from eggs.gnu.org ([2001:4830:134:3::10]:39370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwoKn-0004Dg-RK
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fwoKi-0007rK-Oj
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:52:01 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:35307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fwoKi-0007qL-Bk
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:51:56 -0400
Received: by mail-ed1-x543.google.com with SMTP id y20-v6so725879edq.2
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 05:51:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1f65d6b1-9599-4cfd-2062-0241602b9d62@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-5-sameeh@daynix.com>
	<1f65d6b1-9599-4cfd-2062-0241602b9d62@redhat.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 3 Sep 2018 15:51:54 +0300
Message-ID: <CAKPgXcG5qDtre_zg9woL=KSV64i7209dK4nAYBg4wxZ9qps9_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 4/6] virtio-net: implement steering mode
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>

On Mon, Sep 3, 2018 at 6:34 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
>>
>> From: Sameeh Jubran <sjubran@redhat.com>
>>
>> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
>> ---
>>   hw/net/virtio-net.c                         | 65
>> +++++++++++++++++++++++++----
>>   include/hw/virtio/virtio-net.h              |  3 ++
>>   include/standard-headers/linux/virtio_net.h | 55
>> ++++++++++++++++++++++++
>>   3 files changed, 116 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 90502fca7c..e7c4ce6f66 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -972,13 +972,53 @@ static int virtio_net_handle_mq(VirtIONet *n,
>> uint8_t cmd,
>>       return VIRTIO_NET_OK;
>>   }
>>   +static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
>> +                                struct iovec *iov, unsigned int iov_cnt=
,
>> +                                struct iovec *iov_in, unsigned int
>> iov_cnt_in,
>> +        size_t *size_in)
>> +{
>> +    size_t s;
>> +    struct virtio_net_steering_mode sm;
>> +
>> +    switch (cmd) {
>> +    case VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES:
>> +        if (!size_in) {
>> +            return VIRTIO_NET_ERR;
>> +        }
>> +                  s =3D iov_from_buf(iov_in, iov_cnt_in, 0,
>> +          &n->supported_modes, sizeof(n->supported_modes));
>> +        if (s !=3D sizeof(n->supported_modes) ||
>> +          !size_in) {
>
>
> size_in has been checked in the above I think?
true
>
>
>> +            return VIRTIO_NET_ERR;
>> +        }
>> +                  *size_in =3D s;
>> +      break;
>> +    case VIRTIO_NET_CTRL_SM_CONTROL:
>> +        s =3D iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm) -
>> +                sizeof(union command_data));
>> +        if (s !=3D sizeof(sm) - sizeof(union command_data)) {
>> +            return VIRTIO_NET_ERR;
>> +        }
>> +        /* switch (cmd)
>> +             {
>> +                dafault:
>> +                return VIRTIO_NET_ERR;
>> +         } */
>> +      break;
>> +    default:
>> +                return VIRTIO_NET_ERR;
>> +    }
>> +
>> +    return VIRTIO_NET_OK;
>> +}
>> +
>>   static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
>>   {
>>       VirtIONet *n =3D VIRTIO_NET(vdev);
>>       struct virtio_net_ctrl_hdr ctrl;
>>       virtio_net_ctrl_ack status =3D VIRTIO_NET_ERR;
>>       VirtQueueElement *elem;
>> -    size_t s;
>> +    size_t s, elem_in_size =3D 0;
>>       struct iovec *iov, *iov2;
>>       unsigned int iov_cnt;
>>   @@ -996,7 +1036,8 @@ static void virtio_net_handle_ctrl(VirtIODevice
>> *vdev, VirtQueue *vq)
>>           }
>>             iov_cnt =3D elem->out_num;
>> -        iov2 =3D iov =3D g_memdup(elem->out_sg, sizeof(struct iovec) *
>> elem->out_num);
>> +        iov2 =3D iov =3D g_memdup(elem->out_sg, sizeof(struct iovec) *
>> +                elem->out_num);
>
>
> Still looks unnecessary.
true
>
>
>>           s =3D iov_to_buf(iov, iov_cnt, 0, &ctrl, sizeof(ctrl));
>>           iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
>>           if (s !=3D sizeof(ctrl)) {
>> @@ -1013,12 +1054,20 @@ static void virtio_net_handle_ctrl(VirtIODevice
>> *vdev, VirtQueue *vq)
>>               status =3D virtio_net_handle_mq(n, ctrl.cmd, iov, iov_cnt)=
;
>>           } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_GUEST_OFFLOADS) {
>>               status =3D virtio_net_handle_offloads(n, ctrl.cmd, iov,
>> iov_cnt);
>> +        } else if (ctrl.class =3D=3D VIRTIO_NET_CTRL_STEERING_MODE) {
>> +            size_t size_in =3D 0;
>> +            status =3D virtio_net_ctrl_steering_mode(n, ctrl.cmd, iov,
>> iov_cnt,
>> +                   elem->in_sg, elem->in_num, &size_in);
>> +            if (status =3D=3D VIRTIO_NET_OK  && size_in > 0) {
>> +                elem_in_size +=3D size_in;
>> +        }
>>           }
>>   -        s =3D iov_from_buf(elem->in_sg, elem->in_num, 0, &status,
>> sizeof(status));
>> +        s =3D iov_from_buf(elem->in_sg, elem->in_num, elem_in_size,
>> &status,
>> +                sizeof(status));
>>           assert(s =3D=3D sizeof(status));
>> -
>> -        virtqueue_push(vq, elem, sizeof(status));
>> +        elem_in_size +=3D s;
>> +        virtqueue_push(vq, elem, elem_in_size);
>>           virtio_notify(vdev, vq);
>>           g_free(iov2);
>>           g_free(elem);
>> @@ -1375,10 +1424,10 @@ static int32_t virtio_net_flush_tx(VirtIONetQueu=
e
>> *q)
>>                                      n->guest_hdr_len, -1);
>>                   if (out_num =3D=3D VIRTQUEUE_MAX_SIZE) {
>>                       goto drop;
>> -               }
>> +    }
>>                   out_num +=3D 1;
>>                   out_sg =3D sg2;
>> -           }
>> +      }
>
>
> Let's avoid mixing such possible style fixes.
no problem
>
>>           }
>>           /*
>>            * If host wants to see the guest header as is, we can
>> @@ -1957,6 +2006,8 @@ static void virtio_net_device_realize(DeviceState
>> *dev, Error **errp)
>>           n->host_features |=3D (1ULL << VIRTIO_NET_F_MTU);
>>       }
>>   +        n->host_features |=3D (1ULL << VIRTIO_NET_F_CTRL_STEERING_MOD=
E);
>
>
> I think we need a property for virtio-net and compat this for old machine
> types.
yup
>
>
>> +
>>       if (n->net_conf.duplex_str) {
>>           if (strncmp(n->net_conf.duplex_str, "half", 5) =3D=3D 0) {
>>               n->net_conf.duplex =3D DUPLEX_HALF;
>> diff --git a/include/hw/virtio/virtio-net.h
>> b/include/hw/virtio/virtio-net.h
>> index a7b53edc96..809e85481c 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -102,6 +102,9 @@ typedef struct VirtIONet {
>>       int announce_counter;
>>       bool needs_vnet_hdr_swap;
>>       bool mtu_bypass_backend;
>> +    struct virtio_net_steering_modes supported_modes;
>> +    struct virtio_net_steering_modes current_mode;
>> +    struct virtio_net_rss_conf *rss_conf;
>>   } VirtIONet;
>>     void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>> diff --git a/include/standard-headers/linux/virtio_net.h
>> b/include/standard-headers/linux/virtio_net.h
>> index e9f255ea3f..fa399b97ab 100644
>> --- a/include/standard-headers/linux/virtio_net.h
>> +++ b/include/standard-headers/linux/virtio_net.h
>> @@ -258,4 +258,59 @@ struct virtio_net_ctrl_mq {
>>   #define VIRTIO_NET_CTRL_GUEST_OFFLOADS   5
>>   #define VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET        0
>>   +
>> +#define RSS_HASH_FUNCTION_TOEPLITZ       0x1
>> +#define RSS_HASH_FUNCTION_SYMMETRIC      0x2
>> +
>> +// Hash function fields
>> +#define RSS_HASH_FIELDS_IPV4             0x00000100
>> +#define RSS_HASH_FIELDS_TCP_IPV4         0x00000200
>> +#define RSS_HASH_FIELDS_IPV6             0x00000400
>> +#define RSS_HASH_FIELDS_IPV6_EX          0x00000800
>> +#define RSS_HASH_FIELDS_TCP_IPV6         0x00001000
>> +#define RSS_HASH_FIELDS_TCP_IPV6_EX      0x00002000
>> +
>> +struct virtio_net_rss_supported_hash{
>> +uint32_t hash_function;
>> +};
>> +
>> +struct virtio_net_rss_conf_ptrs {
>> +    uint8_t *hash_key;
>> +    uint32_t  *indirection_table;
>> +};
>> +
>> +struct virtio_net_rss_conf {
>> +    uint32_t hash_function;
>> +    uint32_t hash_function_flags;
>> +    uint32_t hash_key_length;
>> +    uint32_t indirection_table_length;
>> +    struct virtio_net_rss_conf_ptrs ptrs;
>> +};
>
>
> I think the RSS stuffs should go with an independent patch?
You are right
>
>> +
>> +#define VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS   0
>> +#define VIRTIO_NET_SM_CTRL_RSS_SET                       1
>> +
>> +
>> +struct virtio_net_steering_modes {
>> +    uint32_t steering_modes;
>> +};
>> +
>> +union command_data {
>> +    struct virtio_net_rss_conf rss;
>> +};
>> +
>> +struct virtio_net_steering_mode {
>> +    uint32_t steering_mode;
>> +    uint32_t command;
>> +};
>> +
>> +#define VIRTIO_NET_F_CTRL_STEERING_MODE  60
>> +
>> +#define VIRTIO_NET_CTRL_STEERING_MODE             7
>> +#define VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES    0
>> +#define VIRTIO_NET_CTRL_SM_CONTROL                1
>
>
> SM_CONTROL sounds pretty generic, maybe just SET_SUPPORTED_MODES?
It is generic, it is used to send control commands for the sub modes
of the steering mode. such as setting the RSS parameters for the RSS
steering mode. (checkout the usage in patch 5)
>
> Thanks
>
>
>> +
>> +#define STEERING_MODE_AUTO          0x1
>> +#define STEERING_MODE_RSS           0x2
>> +
>>   #endif /* _LINUX_VIRTIO_NET_H */
>
>



--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
