Received: from eggs.gnu.org ([209.51.188.92]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho4j-0005LQ-EF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gho4h-0005pL-Fs
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:05:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gho4f-0005i5-DZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 23:05:39 -0500
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-5-xieyongji@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce11d062-1d64-3d35-b617-5c135f1506eb@redhat.com>
Date: Fri, 11 Jan 2019 11:56:11 +0800
MIME-Version: 1.0
In-Reply-To: <20190109112728.9214-5-xieyongji@baidu.com>
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
To: elohimes@gmail.com, mst@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>


On 2019/1/9 =E4=B8=8B=E5=8D=887:27, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patch adds support for VHOST_USER_GET_INFLIGHT_FD and
> VHOST_USER_SET_INFLIGHT_FD message to set/get shared memory
> to/from qemu. Then we maintain a "bitmap" of all descriptors in
> the shared memory for each queue to track inflight I/O.
>
> Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> ---
>   Makefile                              |   2 +-
>   contrib/libvhost-user/libvhost-user.c | 258 ++++++++++++++++++++++++-=
-
>   contrib/libvhost-user/libvhost-user.h |  29 +++
>   3 files changed, 268 insertions(+), 21 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index dd53965f77..b5c9092605 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -473,7 +473,7 @@ Makefile: $(version-obj-y)
>   # Build libraries
>  =20
>   libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
> -libvhost-user.a: $(libvhost-user-obj-y)
> +libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>  =20
>   #####################################################################=
#
>  =20
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> index 23bd52264c..e73ce04619 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -41,6 +41,8 @@
>   #endif
>  =20
>   #include "qemu/atomic.h"
> +#include "qemu/osdep.h"
> +#include "qemu/memfd.h"
>  =20
>   #include "libvhost-user.h"
>  =20
> @@ -53,6 +55,18 @@
>               _min1 < _min2 ? _min1 : _min2; })
>   #endif
>  =20
> +/* Round number down to multiple */
> +#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> +
> +/* Round number up to multiple */
> +#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> +
> +/* Align each region to cache line size in inflight buffer */
> +#define INFLIGHT_ALIGNMENT 64
> +
> +/* The version of inflight buffer */
> +#define INFLIGHT_VERSION 1
> +
>   #define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
>  =20
>   /* The version of the protocol we support */
> @@ -66,6 +80,20 @@
>           }                                       \
>       } while (0)
>  =20
> +static inline
> +bool has_feature(uint64_t features, unsigned int fbit)
> +{
> +    assert(fbit < 64);
> +    return !!(features & (1ULL << fbit));
> +}
> +
> +static inline
> +bool vu_has_feature(VuDev *dev,
> +                    unsigned int fbit)
> +{
> +    return has_feature(dev->features, fbit);
> +}
> +
>   static const char *
>   vu_request_to_string(unsigned int req)
>   {
> @@ -100,6 +128,8 @@ vu_request_to_string(unsigned int req)
>           REQ(VHOST_USER_POSTCOPY_ADVISE),
>           REQ(VHOST_USER_POSTCOPY_LISTEN),
>           REQ(VHOST_USER_POSTCOPY_END),
> +        REQ(VHOST_USER_GET_INFLIGHT_FD),
> +        REQ(VHOST_USER_SET_INFLIGHT_FD),
>           REQ(VHOST_USER_MAX),
>       };
>   #undef REQ
> @@ -890,6 +920,41 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *=
vmsg)
>       return true;
>   }
>  =20
> +static int
> +vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
> +{
> +    int i =3D 0;
> +
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    vq->used_idx =3D vq->vring.used->idx;
> +    vq->inflight_num =3D 0;
> +    for (i =3D 0; i < vq->vring.num; i++) {
> +        if (vq->inflight->desc[i] =3D=3D 0) {
> +            continue;
> +        }
> +
> +        vq->inflight_desc[vq->inflight_num++] =3D i;
> +        vq->inuse++;
> +    }
> +    vq->shadow_avail_idx =3D vq->last_avail_idx =3D vq->inuse + vq->us=
ed_idx;
> +
> +    /* in case of I/O hang after reconnecting */
> +    if (eventfd_write(vq->kick_fd, 1) ||
> +        eventfd_write(vq->call_fd, 1)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>   static bool
>   vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
>   {
> @@ -925,6 +990,10 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *v=
msg)
>                  dev->vq[index].kick_fd, index);
>       }
>  =20
> +    if (vu_check_queue_inflights(dev, &dev->vq[index])) {
> +        vu_panic(dev, "Failed to check inflights for vq: %d\n", index)=
;
> +    }
> +
>       return false;
>   }
>  =20
> @@ -1215,6 +1284,117 @@ vu_set_postcopy_end(VuDev *dev, VhostUserMsg *v=
msg)
>       return true;
>   }
>  =20
> +static bool
> +vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int fd;
> +    void *addr;
> +    uint64_t mmap_size;
> +
> +    if (vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> +        vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size=
);
> +        vmsg->payload.inflight.mmap_size =3D 0;
> +        return true;
> +    }
> +
> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n",
> +           vmsg->payload.inflight.num_queues);
> +
> +    mmap_size =3D vmsg->payload.inflight.num_queues *
> +                ALIGN_UP(sizeof(VuVirtqInflight), INFLIGHT_ALIGNMENT);
> +
> +    addr =3D qemu_memfd_alloc("vhost-inflight", mmap_size,
> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                            &fd, NULL);
> +
> +    if (!addr) {
> +        vu_panic(dev, "Failed to alloc vhost inflight area");
> +        vmsg->payload.inflight.mmap_size =3D 0;
> +        return true;
> +    }
> +
> +    dev->inflight_info.addr =3D addr;
> +    dev->inflight_info.size =3D vmsg->payload.inflight.mmap_size =3D m=
map_size;
> +    vmsg->payload.inflight.mmap_offset =3D 0;
> +    vmsg->payload.inflight.align =3D INFLIGHT_ALIGNMENT;
> +    vmsg->payload.inflight.version =3D INFLIGHT_VERSION;
> +    vmsg->fd_num =3D 1;
> +    dev->inflight_info.fd =3D vmsg->fds[0] =3D fd;
> +
> +    DPRINT("send inflight mmap_size: %"PRId64"\n",
> +           vmsg->payload.inflight.mmap_size);
> +    DPRINT("send inflight mmap offset: %"PRId64"\n",
> +           vmsg->payload.inflight.mmap_offset);
> +    DPRINT("send inflight align: %"PRId32"\n",
> +           vmsg->payload.inflight.align);
> +    DPRINT("send inflight version: %"PRId16"\n",
> +           vmsg->payload.inflight.version);
> +
> +    return true;
> +}
> +
> +static bool
> +vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
> +{
> +    int fd, i;
> +    uint64_t mmap_size, mmap_offset;
> +    uint32_t align;
> +    uint16_t num_queues, version;
> +    void *rc;
> +
> +    if (vmsg->fd_num !=3D 1 ||
> +        vmsg->size !=3D sizeof(vmsg->payload.inflight)) {
> +        vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d"=
,
> +                 vmsg->size, vmsg->fd_num);
> +        return false;
> +    }
> +
> +    fd =3D vmsg->fds[0];
> +    mmap_size =3D vmsg->payload.inflight.mmap_size;
> +    mmap_offset =3D vmsg->payload.inflight.mmap_offset;
> +    align =3D vmsg->payload.inflight.align;
> +    num_queues =3D vmsg->payload.inflight.num_queues;
> +    version =3D vmsg->payload.inflight.version;
> +
> +    DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
> +    DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
> +    DPRINT("set_inflight_fd align: %"PRId32"\n", align);
> +    DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
> +    DPRINT("set_inflight_fd version: %"PRId16"\n", version);
> +
> +    rc =3D mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +              fd, mmap_offset);
> +
> +    if (rc =3D=3D MAP_FAILED) {
> +        vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno=
));
> +        return false;
> +    }
> +
> +    if (version !=3D INFLIGHT_VERSION) {
> +        vu_panic(dev, "Invalid set_inflight_fd version: %d", version);
> +        return false;
> +    }
> +
> +    if (dev->inflight_info.fd) {
> +        close(dev->inflight_info.fd);
> +    }
> +
> +    if (dev->inflight_info.addr) {
> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> +    }
> +
> +    dev->inflight_info.fd =3D fd;
> +    dev->inflight_info.addr =3D rc;
> +    dev->inflight_info.size =3D mmap_size;
> +
> +    for (i =3D 0; i < num_queues; i++) {
> +        dev->vq[i].inflight =3D (VuVirtqInflight *)rc;
> +        rc =3D (void *)((char *)rc + ALIGN_UP(sizeof(VuVirtqInflight),=
 align));
> +    }
> +
> +    return false;
> +}
> +
>   static bool
>   vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
>   {
> @@ -1292,6 +1472,10 @@ vu_process_message(VuDev *dev, VhostUserMsg *vms=
g)
>           return vu_set_postcopy_listen(dev, vmsg);
>       case VHOST_USER_POSTCOPY_END:
>           return vu_set_postcopy_end(dev, vmsg);
> +    case VHOST_USER_GET_INFLIGHT_FD:
> +        return vu_get_inflight_fd(dev, vmsg);
> +    case VHOST_USER_SET_INFLIGHT_FD:
> +        return vu_set_inflight_fd(dev, vmsg);
>       default:
>           vmsg_close_fds(vmsg);
>           vu_panic(dev, "Unhandled request: %d", vmsg->request);
> @@ -1359,8 +1543,18 @@ vu_deinit(VuDev *dev)
>               close(vq->err_fd);
>               vq->err_fd =3D -1;
>           }
> +        vq->inflight =3D NULL;
>       }
>  =20
> +    if (dev->inflight_info.addr) {
> +        munmap(dev->inflight_info.addr, dev->inflight_info.size);
> +        dev->inflight_info.addr =3D NULL;
> +    }
> +
> +    if (dev->inflight_info.fd > 0) {
> +        close(dev->inflight_info.fd);
> +        dev->inflight_info.fd =3D -1;
> +    }
>  =20
>       vu_close_log(dev);
>       if (dev->slave_fd !=3D -1) {
> @@ -1687,20 +1881,6 @@ vu_queue_empty(VuDev *dev, VuVirtq *vq)
>       return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
>   }
>  =20
> -static inline
> -bool has_feature(uint64_t features, unsigned int fbit)
> -{
> -    assert(fbit < 64);
> -    return !!(features & (1ULL << fbit));
> -}
> -
> -static inline
> -bool vu_has_feature(VuDev *dev,
> -                    unsigned int fbit)
> -{
> -    return has_feature(dev->features, fbit);
> -}
> -
>   static bool
>   vring_notify(VuDev *dev, VuVirtq *vq)
>   {
> @@ -1829,12 +2009,6 @@ virtqueue_map_desc(VuDev *dev,
>       *p_num_sg =3D num_sg;
>   }
>  =20
> -/* Round number down to multiple */
> -#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
> -
> -/* Round number up to multiple */
> -#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
> -
>   static void *
>   virtqueue_alloc_element(size_t sz,
>                                        unsigned out_num, unsigned in_nu=
m)
> @@ -1935,9 +2109,44 @@ vu_queue_map_desc(VuDev *dev, VuVirtq *vq, unsig=
ned int idx, size_t sz)
>       return elem;
>   }
>  =20
> +static int
> +vu_queue_inflight_get(VuDev *dev, VuVirtq *vq, int desc_idx)
> +{
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +


Just wonder what happens if backend get killed at this point?

You want to survive from the backend crash but you still depend on=20
backend to get and put inflight descriptors which seems somehow conflict.

Thanks


> +    vq->inflight->desc[desc_idx] =3D 1;
> +
> +    return 0;
> +}
> +
> +static int
> +vu_queue_inflight_put(VuDev *dev, VuVirtq *vq, int desc_idx)
> +{
> +    if (!has_feature(dev->protocol_features,
> +        VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +        return 0;
> +    }
> +
> +    if (unlikely(!vq->inflight)) {
> +        return -1;
> +    }
> +
> +    vq->inflight->desc[desc_idx] =3D 0;
> +
> +    return 0;
> +}
> +
>   void *
>   vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>   {
> +    int i;
>       unsigned int head;
>       VuVirtqElement *elem;
>  =20
> @@ -1946,6 +2155,12 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>           return NULL;
>       }
>  =20
> +    if (unlikely(vq->inflight_num > 0)) {
> +        i =3D (--vq->inflight_num);
> +        elem =3D vu_queue_map_desc(dev, vq, vq->inflight_desc[i], sz);
> +        return elem;
> +    }
> +
>       if (vu_queue_empty(dev, vq)) {
>           return NULL;
>       }
> @@ -1976,6 +2191,8 @@ vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
>  =20
>       vq->inuse++;
>  =20
> +    vu_queue_inflight_get(dev, vq, head);
> +
>       return elem;
>   }
>  =20
> @@ -2121,4 +2338,5 @@ vu_queue_push(VuDev *dev, VuVirtq *vq,
>   {
>       vu_queue_fill(dev, vq, elem, len, 0);
>       vu_queue_flush(dev, vq, 1);
> +    vu_queue_inflight_put(dev, vq, elem->index);
>   }
> diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-u=
ser/libvhost-user.h
> index 4aa55b4d2d..5afb80ea5c 100644
> --- a/contrib/libvhost-user/libvhost-user.h
> +++ b/contrib/libvhost-user/libvhost-user.h
> @@ -53,6 +53,7 @@ enum VhostUserProtocolFeature {
>       VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
>       VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
>       VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
> +    VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
>  =20
>       VHOST_USER_PROTOCOL_F_MAX
>   };
> @@ -91,6 +92,8 @@ typedef enum VhostUserRequest {
>       VHOST_USER_POSTCOPY_ADVISE  =3D 28,
>       VHOST_USER_POSTCOPY_LISTEN  =3D 29,
>       VHOST_USER_POSTCOPY_END     =3D 30,
> +    VHOST_USER_GET_INFLIGHT_FD =3D 31,
> +    VHOST_USER_SET_INFLIGHT_FD =3D 32,
>       VHOST_USER_MAX
>   } VhostUserRequest;
>  =20
> @@ -138,6 +141,14 @@ typedef struct VhostUserVringArea {
>       uint64_t offset;
>   } VhostUserVringArea;
>  =20
> +typedef struct VhostUserInflight {
> +    uint64_t mmap_size;
> +    uint64_t mmap_offset;
> +    uint32_t align;
> +    uint16_t num_queues;
> +    uint16_t version;
> +} VhostUserInflight;
> +
>   #if defined(_WIN32)
>   # define VU_PACKED __attribute__((gcc_struct, packed))
>   #else
> @@ -163,6 +174,7 @@ typedef struct VhostUserMsg {
>           VhostUserLog log;
>           VhostUserConfig config;
>           VhostUserVringArea area;
> +        VhostUserInflight inflight;
>       } payload;
>  =20
>       int fds[VHOST_MEMORY_MAX_NREGIONS];
> @@ -234,9 +246,19 @@ typedef struct VuRing {
>       uint32_t flags;
>   } VuRing;
>  =20
> +typedef struct VuVirtqInflight {
> +    char desc[VIRTQUEUE_MAX_SIZE];
> +} VuVirtqInflight;
> +
>   typedef struct VuVirtq {
>       VuRing vring;
>  =20
> +    VuVirtqInflight *inflight;
> +
> +    uint16_t inflight_desc[VIRTQUEUE_MAX_SIZE];
> +
> +    uint16_t inflight_num;
> +
>       /* Next head to pop */
>       uint16_t last_avail_idx;
>  =20
> @@ -279,11 +301,18 @@ typedef void (*vu_set_watch_cb) (VuDev *dev, int =
fd, int condition,
>                                    vu_watch_cb cb, void *data);
>   typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
>  =20
> +typedef struct VuDevInflightInfo {
> +    int fd;
> +    void *addr;
> +    uint64_t size;
> +} VuDevInflightInfo;
> +
>   struct VuDev {
>       int sock;
>       uint32_t nregions;
>       VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
>       VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
> +    VuDevInflightInfo inflight_info;
>       int log_call_fd;
>       int slave_fd;
>       uint64_t log_size;
