Received: from eggs.gnu.org ([2001:4830:134:3::10]:58014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6T7i-0008Ph-RP
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f6T7f-0000xA-Lp
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:42:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57000 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f6T7f-0000wp-EM
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:42:07 -0400
Date: Thu, 12 Apr 2018 06:41:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180412063824-mutt-send-email-mst@kernel.org>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
	<20180412011059.yywn73znjdip2cyv@debian>
	<20180412042724-mutt-send-email-mst@kernel.org>
	<20180412013942.egucc4isxkokta7z@debian>
	<20180412044404-mutt-send-email-mst@kernel.org>
	<1726abc8-92ff-420a-adbd-c08e9fa251d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1726abc8-92ff-420a-adbd-c08e9fa251d2@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com

On Thu, Apr 12, 2018 at 11:37:35AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 09:57, Michael S. Tsirkin wrote:
> > On Thu, Apr 12, 2018 at 09:39:43AM +0800, Tiwei Bie wrote:
> > > On Thu, Apr 12, 2018 at 04:29:29AM +0300, Michael S. Tsirkin wrote:
> > > > On Thu, Apr 12, 2018 at 09:10:59AM +0800, Tiwei Bie wrote:
> > > > > On Wed, Apr 11, 2018 at 04:22:21PM +0300, Michael S. Tsirkin wr=
ote:
> > > > > > On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
> > > > > > > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > > > > feature for vhost-user. By default, vhost-user backend need=
s
> > > > > > > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > > > > > > With this protocol feature negotiated, QEMU will provide al=
l
> > > > > > > the IOTLBs to vhost-user backend without waiting for the
> > > > > > > queries from backend. This is helpful when using a hardware
> > > > > > > accelerator which is not able to handle unknown IOVAs at th=
e
> > > > > > > vhost-user backend.
> > > > > > >=20
> > > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > This is potentially a large amount of data to be sent
> > > > > > on a socket.
> > > > > If we take the hardware accelerator out of this picture, we
> > > > > will find that it's actually a question of "pre-loading" vs
> > > > > "lazy-loading". I think neither of them is perfect.
> > > > >=20
> > > > > For "pre-loading", as you said, we may have a tough starting.
> > > > > But for "lazy-loading", we can't have a predictable performance=
.
> > > > > A sudden, unexpected performance drop may happen at any time,
> > > > > because we may meet an unknown IOVA at any time in this case.
> > > > That's how hardware behaves too though. So we can expect guests
> > > > to try to optimize locality.
> > > The difference is that, the software implementation needs to
> > > query the mappings via socket. And it's much slower..
> > If you are proposing this new feature as an optimization,
> > then I'd like to see numbers showing the performance gains.
> >=20
> > It's definitely possible to optimize things out.  Pre-loading isn't
> > where I would start optimizing though.  For example, DPDK could have =
its
> > own VTD emulation, then it could access guest memory directly.
>=20
> Have vtd emulation in dpdk have many disadvantages:
>=20
> - vendor locked, can only work for intel

I don't see what would prevent other vendors from doing the same.

> - duplication of codes and bugs
> - a huge number of new message types needs to be invented

Oh, just the flush I'd wager.

> So I tend to go to a reverse way, link dpdk to qemu.

Won't really help as people want to build software using dpdk.


> >=20
> >=20
> > > > > Once we meet an unknown IOVA, the backend's data path will need
> > > > > to stop and query the mapping of the IOVA via the socket and
> > > > > wait for the reply. And the latency is not negligible (sometime=
s
> > > > > it's even unacceptable), especially in high performance network
> > > > > case. So maybe it's better to make both of them available to
> > > > > the vhost backend.
> > > > >=20
> > > > > > I had an impression that a hardware accelerator was using
> > > > > > VFIO anyway. Given this, can't we have QEMU program
> > > > > > the shadow IOMMU tables into VFIO directly?
> > > > > I think it's a good idea! Currently, my concern about it is
> > > > > that, the hardware device may not use IOMMU and it may have
> > > > > its builtin address translation unit. And it will be a pain
> > > > > for device vendors to teach VFIO to be able to work with the
> > > > > builtin address translation unit.
> > > > I think such drivers would have to interate with VFIO somehow.
> > > > Otherwise, what is the plan for assigning such devices then?
> > > Such devices are just for vhost data path acceleration.
> > That's not true I think.  E.g. RDMA devices have an on-card MMU.
> >=20
> > > They have many available queue pairs, the switch logic
> > > will be done among those queue pairs. And different queue
> > > pairs will serve different VMs directly.
> > >=20
> > > Best regards,
> > > Tiwei Bie
> > The way I would do it is attach different PASID values to
> > different queues. This way you can use the standard IOMMU
> > to enforce protection.
>=20
> So that's just shared virtual memory on host which can share iova addre=
ss
> space between a specific queue pair and a process. I'm not sure how har=
d can
> exist vhost-user backend to support this.
>=20
> Thanks

That would be VFIO's job, nothing to do with vhost-user besides
sharing the VFIO descriptor.

> >=20
> >=20
> >=20
> > > >=20
> > > > > Best regards,
> > > > > Tiwei Bie
> > > > >=20
> > > > > >=20
> > > > > > > ---
> > > > > > > The idea of this patch is to let QEMU push all the IOTLBs
> > > > > > > to vhost-user backend without waiting for the queries from
> > > > > > > the backend. Because hardware accelerator at the vhost-user
> > > > > > > backend may not be able to handle unknown IOVAs.
> > > > > > >=20
> > > > > > > This is just a RFC for now. It seems that, it doesn't work
> > > > > > > as expected when guest is using kernel driver (To handle
> > > > > > > this case, it seems that some RAM regions' events also need
> > > > > > > to be listened). Any comments would be appreciated! Thanks!
> > > > > > >=20
> > > > > > >   docs/interop/vhost-user.txt       |  9 ++++++++
> > > > > > >   hw/virtio/vhost-backend.c         |  7 ++++++
> > > > > > >   hw/virtio/vhost-user.c            |  8 +++++++
> > > > > > >   hw/virtio/vhost.c                 | 47 ++++++++++++++++++=
++++++++++++++++++---
> > > > > > >   include/hw/virtio/vhost-backend.h |  3 +++
> > > > > > >   5 files changed, 71 insertions(+), 3 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vho=
st-user.txt
> > > > > > > index 534caab18a..73e07f9dad 100644
> > > > > > > --- a/docs/interop/vhost-user.txt
> > > > > > > +++ b/docs/interop/vhost-user.txt
> > > > > > > @@ -380,6 +380,7 @@ Protocol features
> > > > > > >   #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> > > > > > >   #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
> > > > > > >   #define VHOST_USER_PROTOCOL_F_CONFIG         9
> > > > > > > +#define VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB 10
> > > > > > >   Master message types
> > > > > > >   --------------------
> > > > > > > @@ -797,3 +798,11 @@ resilient for selective requests.
> > > > > > >   For the message types that already solicit a reply from t=
he client, the
> > > > > > >   presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply=
 bit being set brings
> > > > > > >   no behavioural change. (See the 'Communication' section f=
or details.)
> > > > > > > +
> > > > > > > +VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > > > > +------------------------------------
> > > > > > > +By default, vhost-user backend needs to query the IOTLBs f=
rom QEMU after
> > > > > > > +meeting unknown IOVAs. With this protocol feature negotiat=
ed, QEMU will
> > > > > > > +provide all the IOTLBs to vhost backend without waiting fo=
r the queries
> > > > > > > +from backend. This is helpful when using a hardware accele=
rator which is
> > > > > > > +not able to handle unknown IOVAs at the vhost-user backend=
.
> > > > > > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-ba=
ckend.c
> > > > > > > index 7f09efab8b..d72994e9a5 100644
> > > > > > > --- a/hw/virtio/vhost-backend.c
> > > > > > > +++ b/hw/virtio/vhost-backend.c
> > > > > > > @@ -233,6 +233,11 @@ static void vhost_kernel_set_iotlb_cal=
lback(struct vhost_dev *dev,
> > > > > > >           qemu_set_fd_handler((uintptr_t)dev->opaque, NULL,=
 NULL, NULL);
> > > > > > >   }
> > > > > > > +static bool vhost_kernel_need_all_device_iotlb(struct vhos=
t_dev *dev)
> > > > > > > +{
> > > > > > > +    return false;
> > > > > > > +}
> > > > > > > +
> > > > > > >   static const VhostOps kernel_ops =3D {
> > > > > > >           .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> > > > > > >           .vhost_backend_init =3D vhost_kernel_init,
> > > > > > > @@ -264,6 +269,8 @@ static const VhostOps kernel_ops =3D {
> > > > > > >   #endif /* CONFIG_VHOST_VSOCK */
> > > > > > >           .vhost_set_iotlb_callback =3D vhost_kernel_set_io=
tlb_callback,
> > > > > > >           .vhost_send_device_iotlb_msg =3D vhost_kernel_sen=
d_device_iotlb_msg,
> > > > > > > +        .vhost_backend_need_all_device_iotlb =3D
> > > > > > > +                                vhost_kernel_need_all_devi=
ce_iotlb,
> > > > > > >   };
> > > > > > >   int vhost_set_backend_type(struct vhost_dev *dev, VhostBa=
ckendType backend_type)
> > > > > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.=
c
> > > > > > > index 38da8692bb..30e0b1c13b 100644
> > > > > > > --- a/hw/virtio/vhost-user.c
> > > > > > > +++ b/hw/virtio/vhost-user.c
> > > > > > > @@ -47,6 +47,7 @@ enum VhostUserProtocolFeature {
> > > > > > >       VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
> > > > > > >       VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
> > > > > > >       VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
> > > > > > > +    VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB =3D 10,
> > > > > > >       VHOST_USER_PROTOCOL_F_MAX
> > > > > > >   };
> > > > > > > @@ -1581,6 +1582,12 @@ vhost_user_crypto_close_session(stru=
ct vhost_dev *dev, uint64_t session_id)
> > > > > > >       return 0;
> > > > > > >   }
> > > > > > > +static bool vhost_user_need_all_device_iotlb(struct vhost_=
dev *dev)
> > > > > > > +{
> > > > > > > +    return virtio_has_feature(dev->protocol_features,
> > > > > > > +                              VHOST_USER_PROTOCOL_F_NEED_A=
LL_IOTLB);
> > > > > > > +}
> > > > > > > +
> > > > > > >   const VhostOps user_ops =3D {
> > > > > > >           .backend_type =3D VHOST_BACKEND_TYPE_USER,
> > > > > > >           .vhost_backend_init =3D vhost_user_init,
> > > > > > > @@ -1611,4 +1618,5 @@ const VhostOps user_ops =3D {
> > > > > > >           .vhost_set_config =3D vhost_user_set_config,
> > > > > > >           .vhost_crypto_create_session =3D vhost_user_crypt=
o_create_session,
> > > > > > >           .vhost_crypto_close_session =3D vhost_user_crypto=
_close_session,
> > > > > > > +        .vhost_backend_need_all_device_iotlb =3D vhost_use=
r_need_all_device_iotlb,
> > > > > > >   };
> > > > > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > > > > index f51bf573d5..70922ee998 100644
> > > > > > > --- a/hw/virtio/vhost.c
> > > > > > > +++ b/hw/virtio/vhost.c
> > > > > > > @@ -48,6 +48,9 @@ static unsigned int used_memslots;
> > > > > > >   static QLIST_HEAD(, vhost_dev) vhost_devices =3D
> > > > > > >       QLIST_HEAD_INITIALIZER(vhost_devices);
> > > > > > > +static int vhost_memory_region_lookup(struct vhost_dev *hd=
ev, uint64_t gpa,
> > > > > > > +                                      uint64_t *uaddr, uin=
t64_t *len);
> > > > > > > +
> > > > > > >   bool vhost_has_free_slot(void)
> > > > > > >   {
> > > > > > >       unsigned int slots_limit =3D ~0U;
> > > > > > > @@ -634,12 +637,39 @@ static void vhost_region_addnop(Memor=
yListener *listener,
> > > > > > >       vhost_region_add_section(dev, section);
> > > > > > >   }
> > > > > > > -static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOM=
MUTLBEntry *iotlb)
> > > > > > > +static void vhost_iommu_map_notify(IOMMUNotifier *n, IOMMU=
TLBEntry *iotlb)
> > > > > > >   {
> > > > > > >       struct vhost_iommu *iommu =3D container_of(n, struct =
vhost_iommu, n);
> > > > > > >       struct vhost_dev *hdev =3D iommu->hdev;
> > > > > > >       hwaddr iova =3D iotlb->iova + iommu->iommu_offset;
> > > > > > > +    if ((iotlb->perm & IOMMU_RW) !=3D IOMMU_NONE) {
> > > > > > > +        uint64_t uaddr, len;
> > > > > > > +
> > > > > > > +        rcu_read_lock();
> > > > > > > +
> > > > > > > +        if (iotlb->target_as !=3D NULL) {
> > > > > > > +            if (vhost_memory_region_lookup(hdev, iotlb->tr=
anslated_addr,
> > > > > > > +                        &uaddr, &len)) {
> > > > > > > +                error_report("Fail to lookup the translate=
d address "
> > > > > > > +                        "%"PRIx64, iotlb->translated_addr)=
;
> > > > > > > +                goto out;
> > > > > > > +            }
> > > > > > > +
> > > > > > > +            len =3D MIN(iotlb->addr_mask + 1, len);
> > > > > > > +            iova =3D iova & ~iotlb->addr_mask;
> > > > > > > +
> > > > > > > +            if (vhost_backend_update_device_iotlb(hdev, io=
va, uaddr,
> > > > > > > +                                                  len, iot=
lb->perm)) {
> > > > > > > +                error_report("Fail to update device iotlb"=
);
> > > > > > > +                goto out;
> > > > > > > +            }
> > > > > > > +        }
> > > > > > > +out:
> > > > > > > +        rcu_read_unlock();
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > >       if (vhost_backend_invalidate_device_iotlb(hdev, iova,
> > > > > > >                                                 iotlb->addr=
_mask + 1)) {
> > > > > > >           error_report("Fail to invalidate device iotlb");
> > > > > > > @@ -652,6 +682,7 @@ static void vhost_iommu_region_add(Memo=
ryListener *listener,
> > > > > > >       struct vhost_dev *dev =3D container_of(listener, stru=
ct vhost_dev,
> > > > > > >                                            iommu_listener);
> > > > > > >       struct vhost_iommu *iommu;
> > > > > > > +    IOMMUNotifierFlag flags;
> > > > > > >       Int128 end;
> > > > > > >       if (!memory_region_is_iommu(section->mr)) {
> > > > > > > @@ -662,8 +693,15 @@ static void vhost_iommu_region_add(Mem=
oryListener *listener,
> > > > > > >       end =3D int128_add(int128_make64(section->offset_with=
in_region),
> > > > > > >                        section->size);
> > > > > > >       end =3D int128_sub(end, int128_one());
> > > > > > > -    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notif=
y,
> > > > > > > -                        IOMMU_NOTIFIER_UNMAP,
> > > > > > > +
> > > > > > > +    if (dev->vhost_ops->vhost_backend_need_all_device_iotl=
b(dev)) {
> > > > > > > +        flags =3D IOMMU_NOTIFIER_ALL;
> > > > > > > +    } else {
> > > > > > > +        flags =3D IOMMU_NOTIFIER_UNMAP;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    iommu_notifier_init(&iommu->n, vhost_iommu_map_notify,
> > > > > > > +                        flags,
> > > > > > >                           section->offset_within_region,
> > > > > > >                           int128_get64(end));
> > > > > > >       iommu->mr =3D section->mr;
> > > > > > > @@ -673,6 +711,9 @@ static void vhost_iommu_region_add(Memo=
ryListener *listener,
> > > > > > >       memory_region_register_iommu_notifier(section->mr, &i=
ommu->n);
> > > > > > >       QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next=
);
> > > > > > >       /* TODO: can replay help performance here? */
> > > > > > > +    if (flags =3D=3D IOMMU_NOTIFIER_ALL) {
> > > > > > > +        memory_region_iommu_replay(IOMMU_MEMORY_REGION(iom=
mu->mr), &iommu->n);
> > > > > > > +    }
> > > > > > >   }
> > > > > > >   static void vhost_iommu_region_del(MemoryListener *listen=
er,
> > > > > > > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw=
/virtio/vhost-backend.h
> > > > > > > index 5dac61f9ea..602fd987a4 100644
> > > > > > > --- a/include/hw/virtio/vhost-backend.h
> > > > > > > +++ b/include/hw/virtio/vhost-backend.h
> > > > > > > @@ -101,6 +101,8 @@ typedef int (*vhost_crypto_create_sessi=
on_op)(struct vhost_dev *dev,
> > > > > > >   typedef int (*vhost_crypto_close_session_op)(struct vhost=
_dev *dev,
> > > > > > >                                                uint64_t ses=
sion_id);
> > > > > > > +typedef bool (*vhost_backend_need_all_device_iotlb_op)(str=
uct vhost_dev *dev);
> > > > > > > +
> > > > > > >   typedef struct VhostOps {
> > > > > > >       VhostBackendType backend_type;
> > > > > > >       vhost_backend_init vhost_backend_init;
> > > > > > > @@ -138,6 +140,7 @@ typedef struct VhostOps {
> > > > > > >       vhost_set_config_op vhost_set_config;
> > > > > > >       vhost_crypto_create_session_op vhost_crypto_create_se=
ssion;
> > > > > > >       vhost_crypto_close_session_op vhost_crypto_close_sess=
ion;
> > > > > > > +    vhost_backend_need_all_device_iotlb_op vhost_backend_n=
eed_all_device_iotlb;
> > > > > > >   } VhostOps;
> > > > > > >   extern const VhostOps user_ops;
> > > > > > > --=20
> > > > > > > 2.11.0
