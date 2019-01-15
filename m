Received: from eggs.gnu.org ([209.51.188.92]:45176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gjJWc-0001Hp-3u
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gjJWa-0002Hj-Jg
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:52:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gjJWa-0002H3-Au
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:52:40 -0500
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
	<ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
	<CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6e0c0b2-bd0b-454c-8280-12e0ec964240@redhat.com>
Date: Tue, 15 Jan 2019 15:52:21 +0800
MIME-Version: 1.0
In-Reply-To: <CAONzpcY6pdSz65Tzj_Ws0M4vskUOXMuaxQ-uYz6NnCvdMgkFOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 4/7] libvhost-user: Support
 tracking inflight I/O in shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>


On 2019/1/11 =E4=B8=8B=E5=8D=882:10, Yongji Xie wrote:
> On Fri, 11 Jan 2019 at 11:56, Jason Wang <jasowang@redhat.com> wrote:
>>
>> On 2019/1/9 =E4=B8=8B=E5=8D=887:27, elohimes@gmail.com wrote:
>>> From: Xie Yongji <xieyongji@baidu.com>
>>>
>>> This patch adds support for VHOST_USER_GET_INFLIGHT_FD and
>>> VHOST_USER_SET_INFLIGHT_FD message to set/get shared memory
>>> to/from qemu. Then we maintain a "bitmap" of all descriptors in
>>> the shared memory for each queue to track inflight I/O.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
>>> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
>>> ---
>>>    Makefile                              |   2 +-
>>>    contrib/libvhost-user/libvhost-user.c | 258 ++++++++++++++++++++++=
++--
>>>    contrib/libvhost-user/libvhost-user.h |  29 +++
>>>    3 files changed, 268 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index dd53965f77..b5c9092605 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -473,7 +473,7 @@ Makefile: $(version-obj-y)
>>>    # Build libraries
>>>
>>>    libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>>> -libvhost-user.a: $(libvhost-user-obj-y)
>>> +libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>>>
>>>    ##################################################################=
####
>>>
>>> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost=
-user/libvhost-user.c
>>> index 23bd52264c..e73ce04619 100644
>>> --- a/contrib/libvhost-user/libvhost-user.c
>>> +++ b/contrib/libvhost-user/libvhost-user.c
>>> @@ -41,6 +41,8 @@
>>>    #endif
>>>
>>>    #include "qemu/atomic.h"
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/memfd.h"
>>>
>>>    #include "libvhost-user.h"
>>>
>>> @@ -53,6 +55,18 @@
>>>                _min1 < _min2 ? _min1 : _min2; })
>>>    #endif
>>>
>>> +/* Round number down to multiple */
>>> +#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
>>> +
>>> +/* Round number up to multiple */
>>> +#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
>>> +
>>> +/* Align each region to cache line size in inflight buffer */
>>> +#define INFLIGHT_ALIGNMENT 64
>>> +
>>> +/* The version of inflight buffer */
>>> +#define INFLIGHT_VERSION 1
>>> +
>>>    #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
>>>
>>>    /* The version of the protocol we support */
>>> @@ -66,6 +80,20 @@
>>>            }                                       \
>>>        } while (0)
>>>
>>> +static inline
>>> +bool has_feature(uint64_t features, unsigned int fbit)
>>> +{
>>> +    assert(fbit < 64);
>>> +    return !!(features & (1ULL << fbit));
>>> +}
>>> +
>>> +static inline
>>> +bool vu_has_feature(VuDev *dev,
>>> +                    unsigned int fbit)
>>> +{
>>> +    return has_feature(dev->features, fbit);
>>> +}
>>> +
>>>    static const char *
>>>    vu_request_to_string(unsigned int req)
>>>    {
>>> @@ -100,6 +128,8 @@ vu_request_to_string(unsigned int req)
>>>            REQ(VHOST_USER_POSTCOPY_ADVISE),
>>>            REQ(VHOST_USER_POSTCOPY_LISTEN),
>>>            REQ(VHOST_USER_POSTCOPY_END),
>>> +        REQ(VHOST_USER_GET_INFLIGHT_FD),
>>> +        REQ(VHOST_USER_SET_INFLIGHT_FD),
>>>            REQ(VHOST_USER_MAX),
>>>        };
>>>    #undef REQ
>>> @@ -890,6 +920,41 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg=
 *vmsg)
>>>        return true;
>>>    }
>>>
>>> +static int
>>> +vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
>>> +{
>>> +    int i =3D 0;
>>> +
>>> +    if (!has_feature(dev->protocol_features,
>>> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (unlikely(!vq->inflight)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    vq->used_idx =3D vq->vring.used->idx;
>>> +    vq->inflight_num =3D 0;
>>> +    for (i =3D 0; i < vq->vring.num; i++) {
>>> +        if (vq->inflight->desc[i] =3D=3D 0) {
>>> +            continue;
>>> +        }
>>> +
>>> +        vq->inflight_desc[vq->inflight_num++] =3D i;
>>> +        vq->inuse++;
>>> +    }
>>> +    vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->=
used_idx;
>>> +
>>> +    /* in case of I/O hang after reconnecting */
>>> +    if (eventfd_write(vq->kick_fd, 1) ||
>>> +        eventfd_write(vq->call_fd, 1)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static bool
>>>    vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>>>    {
>>> @@ -925,6 +990,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg =
*vmsg)
>>>                   dev->vq[index].kick_fd, index);
>>>        }
>>>
>>> +    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
>>> +        vu_panic(dev, "Failed to check inflights for vq: %d\n", inde=
x);
>>> +    }
>>> +
>>>        return false;
>>>    }
>>>
>>> @@ -1215,6 +1284,117 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg =
*vmsg)
>>>        return true;
>>>    }
>>>
>>> +static bool
>>> +vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
>>> +{
>>> +    int fd;
>>> +    void *addr;
>>> +    uint64_t mmap_size;
>>> +
>>> +    if (vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
>>> +        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->si=
ze);
>>> +        vmsg->payload.inflight.mmap_size =3D 0;
>>> +        return true;
>>> +    }
>>> +
>>> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n",
>>> +           vmsg->payload.inflight.num_queues);
>>> +
>>> +    mmap_size =3D vmsg->payload.inflight.num_queues *
>>> +                ALIGN_UP(sizeof(VuVirtqInflight), INFLIGHT_ALIGNMENT=
);
>>> +
>>> +    addr =3D qemu_memfd_alloc("vhost-inflight", mmap_size,
>>> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEA=
L,
>>> +                            &fd, NULL);
>>> +
>>> +    if (!addr) {
>>> +        vu_panic(dev, "Failed to alloc vhost inflight area");
>>> +        vmsg->payload.inflight.mmap_size =3D 0;
>>> +        return true;
>>> +    }
>>> +
>>> +    dev->inflight_info.addr =3D addr;
>>> +    dev->inflight_info.size =3D vmsg->payload.inflight.mmap_size =3D=
 mmap_size;
>>> +    vmsg->payload.inflight.mmap_offset =3D 0;
>>> +    vmsg->payload.inflight.align =3D INFLIGHT_ALIGNMENT;
>>> +    vmsg->payload.inflight.version =3D INFLIGHT_VERSION;
>>> +    vmsg->fd_num =3D 1;
>>> +    dev->inflight_info.fd =3D vmsg->fds[0] =3D fd;
>>> +
>>> +    DPRINT("send inflight mmap_size: %"PRId64"\n",
>>> +           vmsg->payload.inflight.mmap_size);
>>> +    DPRINT("send inflight mmap offset: %"PRId64"\n",
>>> +           vmsg->payload.inflight.mmap_offset);
>>> +    DPRINT("send inflight align: %"PRId32"\n",
>>> +           vmsg->payload.inflight.align);
>>> +    DPRINT("send inflight version: %"PRId16"\n",
>>> +           vmsg->payload.inflight.version);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static bool
>>> +vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
>>> +{
>>> +    int fd, i;
>>> +    uint64_t mmap_size, mmap_offset;
>>> +    uint32_t align;
>>> +    uint16_t num_queues, version;
>>> +    void *rc;
>>> +
>>> +    if (vmsg->fd_num !=3D 1 ||
>>> +        vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
>>> +        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%=
d",
>>> +                 vmsg->size, vmsg->fd_num);
>>> +        return false;
>>> +    }
>>> +
>>> +    fd =3D vmsg->fds[0];
>>> +    mmap_size =3D vmsg->payload.inflight.mmap_size;
>>> +    mmap_offset =3D vmsg->payload.inflight.mmap_offset;
>>> +    align =3D vmsg->payload.inflight.align;
>>> +    num_queues =3D vmsg->payload.inflight.num_queues;
>>> +    version =3D vmsg->payload.inflight.version;
>>> +
>>> +    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
>>> +    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
>>> +    DPRINT("set_inflight_fd align: %"PRId32"\n", align);
>>> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
>>> +    DPRINT("set_inflight_fd version: %"PRId16"\n", version);
>>> +
>>> +    rc =3D mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
>>> +              fd, mmap_offset);
>>> +
>>> +    if (rc =3D=3D MAP_FAILED) {
>>> +        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(err=
no));
>>> +        return false;
>>> +    }
>>> +
>>> +    if (version !=3D INFLIGHT_VERSION) {
>>> +        vu_panic(dev, "Invalid set_inflight_fd version: %d", version=
);
>>> +        return false;
>>> +    }
>>> +
>>> +    if (dev->inflight_info.fd) {
>>> +        close(dev->inflight_info.fd);
>>> +    }
>>> +
>>> +    if (dev->inflight_info.addr) {
>>> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
>>> +    }
>>> +
>>> +    dev->inflight_info.fd =3D fd;
>>> +    dev->inflight_info.addr =3D rc;
>>> +    dev->inflight_info.size =3D mmap_size;
>>> +
>>> +    for (i =3D 0; i < num_queues; i++) {
>>> +        dev->vq[i].inflight =3D (VuVirtqInflight *)rc;
>>> +        rc =3D (void *)((char *)rc + ALIGN_UP(sizeof(VuVirtqInflight=
), align));
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>>    static bool
>>>    vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>>>    {
>>> @@ -1292,6 +1472,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *v=
msg)
>>>            return vu_set_postcopy_listen(dev, vmsg);
>>>        case VHOST_USER_POSTCOPY_END:
>>>            return vu_set_postcopy_end(dev, vmsg);
>>> +    case VHOST_USER_GET_INFLIGHT_FD:
>>> +        return vu_get_inflight_fd(dev, vmsg);
>>> +    case VHOST_USER_SET_INFLIGHT_FD:
>>> +        return vu_set_inflight_fd(dev, vmsg);
>>>        default:
>>>            vmsg_close_fds(vmsg);
>>>            vu_panic(dev, "Unhandled request: %d", vmsg->request);
>>> @@ -1359,8 +1543,18 @@ vu_deinit(VuDev *dev)
>>>                close(vq->err_fd);
>>>                vq->err_fd =3D -1;
>>>            }
>>> +        vq->inflight =3D NULL;
>>>        }
>>>
>>> +    if (dev->inflight_info.addr) {
>>> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
>>> +        dev->inflight_info.addr =3D NULL;
>>> +    }
>>> +
>>> +    if (dev->inflight_info.fd > 0) {
>>> +        close(dev->inflight_info.fd);
>>> +        dev->inflight_info.fd =3D -1;
>>> +    }
>>>
>>>        vu_close_log(dev);
>>>        if (dev->slave_fd !=3D -1) {
>>> @@ -1687,20 +1881,6 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
>>>        return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>>>    }
>>>
>>> -static inline
>>> -bool has_feature(uint64_t features, unsigned int fbit)
>>> -{
>>> -    assert(fbit < 64);
>>> -    return !!(features & (1ULL << fbit));
>>> -}
>>> -
>>> -static inline
>>> -bool vu_has_feature(VuDev *dev,
>>> -                    unsigned int fbit)
>>> -{
>>> -    return has_feature(dev->features, fbit);
>>> -}
>>> -
>>>    static bool
>>>    vring_notify(VuDev *dev, VuVirtq *vq)
>>>    {
>>> @@ -1829,12 +2009,6 @@ virtqueue_map_desc(VuDev *dev,
>>>        *p_num_sg =3D num_sg;
>>>    }
>>>
>>> -/* Round number down to multiple */
>>> -#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
>>> -
>>> -/* Round number up to multiple */
>>> -#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
>>> -
>>>    static void *
>>>    virtqueue_alloc_element(size_t sz,
>>>                                         unsigned out_num, unsigned in=
_num)
>>> @@ -1935,9 +2109,44 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, uns=
igned int idx, size_t sz)
>>>        return elem;
>>>    }
>>>
>>> +static int
>>> +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
>>> +{
>>> +    if (!has_feature(dev->protocol_features,
>>> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (unlikely(!vq->inflight)) {
>>> +        return -1;
>>> +    }
>>> +
>>
>> Just wonder what happens if backend get killed at this point?
>>
> We will re-caculate last_avail_idx like: last_avail_idx =3D inuse + use=
d_idx


I'm not sure I get you here, but it looks to me at least one pending=20
descriptor is missed since you don't set vq->inflight->desc[desc_idx] to =
1?


>
> At this point, backend could consume this entry correctly after reconne=
ct.
>
>> You want to survive from the backend crash but you still depend on
>> backend to get and put inflight descriptors which seems somehow confli=
ct.
>>
> But if backend get killed in vu_queue_inflight_put(), I think you are
> right, there is something conflict. One descriptor is consumed by
> guest but still marked as inused in inflight buffer. Then we will
> re-send this old descriptor after restart.
>
> Maybe we can add something like that to fix this issue:
>
> void vu_queue_push()
> {
>      vq->inflight->elem_idx =3D elem->idx;
>      vu_queue_fill();
>      vu_queue_flush();
>      vq->inflight->desc[elem->idx] =3D 0;


Does this safe to be killed here?


>      vq->inflight->used_idx =3D vq->vring.used->idx;
> }
>
> static int vu_check_queue_inflights()
> {
>      ....
>      if (vq->inflight->used_idx !=3D vq->vring.used->idx) {
>          /* Crash in vu_queue_push() */
>          vq->inflight->desc[vq->inflight->elem_idx] =3D 0;
>      }
>      ....
> }
>
> Thanks,
> Yongji


Well, this may work but here're my points:

1) The code want to recover from backed crash by introducing extra space=20
to store inflight data, but it still depends on the backend to set/get=20
the inflight state

2) Since the backend could be killed at any time, the backend must have=20
the ability to recover from the partial inflight state

So it looks to me 1) tends to be self-contradictory and 2) tends to be=20
recursive. The above lines show how tricky could the code looks like.

Solving this at vhost-user level through at backend is probably wrong.=20
It's time to consider the support from virtio itself.

Thanks
