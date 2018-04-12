Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6RFM-0007UF-Ie
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 21:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1f6RFJ-0002wQ-DZ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 21:41:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:41850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1f6RFJ-0002vl-0B
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 21:41:53 -0400
Date: Thu, 12 Apr 2018 09:39:43 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180412013942.egucc4isxkokta7z@debian>
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180411161926-mutt-send-email-mst@kernel.org>
	<20180412011059.yywn73znjdip2cyv@debian>
	<20180412042724-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180412042724-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, peterx@redhat.com, qemu-devel@nongnu.org, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com

On Thu, Apr 12, 2018 at 04:29:29AM +0300, Michael S. Tsirkin wrote:
> On Thu, Apr 12, 2018 at 09:10:59AM +0800, Tiwei Bie wrote:
> > On Wed, Apr 11, 2018 at 04:22:21PM +0300, Michael S. Tsirkin wrote:
> > > On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
> > > > This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > feature for vhost-user. By default, vhost-user backend needs
> > > > to query the IOTLBs from QEMU after meeting unknown IOVAs.
> > > > With this protocol feature negotiated, QEMU will provide all
> > > > the IOTLBs to vhost-user backend without waiting for the
> > > > queries from backend. This is helpful when using a hardware
> > > > accelerator which is not able to handle unknown IOVAs at the
> > > > vhost-user backend.
> > > > 
> > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > 
> > > This is potentially a large amount of data to be sent
> > > on a socket.
> > 
> > If we take the hardware accelerator out of this picture, we
> > will find that it's actually a question of "pre-loading" vs
> > "lazy-loading". I think neither of them is perfect.
> > 
> > For "pre-loading", as you said, we may have a tough starting.
> > But for "lazy-loading", we can't have a predictable performance.
> > A sudden, unexpected performance drop may happen at any time,
> > because we may meet an unknown IOVA at any time in this case.
> 
> That's how hardware behaves too though. So we can expect guests
> to try to optimize locality.

The difference is that, the software implementation needs to
query the mappings via socket. And it's much slower..

> 
> > Once we meet an unknown IOVA, the backend's data path will need
> > to stop and query the mapping of the IOVA via the socket and
> > wait for the reply. And the latency is not negligible (sometimes
> > it's even unacceptable), especially in high performance network
> > case. So maybe it's better to make both of them available to
> > the vhost backend.
> > 
> > > 
> > > I had an impression that a hardware accelerator was using
> > > VFIO anyway. Given this, can't we have QEMU program
> > > the shadow IOMMU tables into VFIO directly?
> > 
> > I think it's a good idea! Currently, my concern about it is
> > that, the hardware device may not use IOMMU and it may have
> > its builtin address translation unit. And it will be a pain
> > for device vendors to teach VFIO to be able to work with the
> > builtin address translation unit.
> 
> I think such drivers would have to interate with VFIO somehow.
> Otherwise, what is the plan for assigning such devices then?

Such devices are just for vhost data path acceleration.
They have many available queue pairs, the switch logic
will be done among those queue pairs. And different queue
pairs will serve different VMs directly.

Best regards,
Tiwei Bie

> 
> 
> > Best regards,
> > Tiwei Bie
> > 
> > > 
> > > 
> > > > ---
> > > > The idea of this patch is to let QEMU push all the IOTLBs
> > > > to vhost-user backend without waiting for the queries from
> > > > the backend. Because hardware accelerator at the vhost-user
> > > > backend may not be able to handle unknown IOVAs.
> > > > 
> > > > This is just a RFC for now. It seems that, it doesn't work
> > > > as expected when guest is using kernel driver (To handle
> > > > this case, it seems that some RAM regions' events also need
> > > > to be listened). Any comments would be appreciated! Thanks!
> > > > 
> > > >  docs/interop/vhost-user.txt       |  9 ++++++++
> > > >  hw/virtio/vhost-backend.c         |  7 ++++++
> > > >  hw/virtio/vhost-user.c            |  8 +++++++
> > > >  hw/virtio/vhost.c                 | 47 ++++++++++++++++++++++++++++++++++++---
> > > >  include/hw/virtio/vhost-backend.h |  3 +++
> > > >  5 files changed, 71 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > > index 534caab18a..73e07f9dad 100644
> > > > --- a/docs/interop/vhost-user.txt
> > > > +++ b/docs/interop/vhost-user.txt
> > > > @@ -380,6 +380,7 @@ Protocol features
> > > >  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
> > > >  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
> > > >  #define VHOST_USER_PROTOCOL_F_CONFIG         9
> > > > +#define VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB 10
> > > >  
> > > >  Master message types
> > > >  --------------------
> > > > @@ -797,3 +798,11 @@ resilient for selective requests.
> > > >  For the message types that already solicit a reply from the client, the
> > > >  presence of VHOST_USER_PROTOCOL_F_REPLY_ACK or need_reply bit being set brings
> > > >  no behavioural change. (See the 'Communication' section for details.)
> > > > +
> > > > +VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> > > > +------------------------------------
> > > > +By default, vhost-user backend needs to query the IOTLBs from QEMU after
> > > > +meeting unknown IOVAs. With this protocol feature negotiated, QEMU will
> > > > +provide all the IOTLBs to vhost backend without waiting for the queries
> > > > +from backend. This is helpful when using a hardware accelerator which is
> > > > +not able to handle unknown IOVAs at the vhost-user backend.
> > > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > > index 7f09efab8b..d72994e9a5 100644
> > > > --- a/hw/virtio/vhost-backend.c
> > > > +++ b/hw/virtio/vhost-backend.c
> > > > @@ -233,6 +233,11 @@ static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> > > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
> > > >  }
> > > >  
> > > > +static bool vhost_kernel_need_all_device_iotlb(struct vhost_dev *dev)
> > > > +{
> > > > +    return false;
> > > > +}
> > > > +
> > > >  static const VhostOps kernel_ops = {
> > > >          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
> > > >          .vhost_backend_init = vhost_kernel_init,
> > > > @@ -264,6 +269,8 @@ static const VhostOps kernel_ops = {
> > > >  #endif /* CONFIG_VHOST_VSOCK */
> > > >          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
> > > >          .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
> > > > +        .vhost_backend_need_all_device_iotlb =
> > > > +                                vhost_kernel_need_all_device_iotlb,
> > > >  };
> > > >  
> > > >  int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
> > > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > index 38da8692bb..30e0b1c13b 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -47,6 +47,7 @@ enum VhostUserProtocolFeature {
> > > >      VHOST_USER_PROTOCOL_F_CRYPTO_SESSION = 7,
> > > >      VHOST_USER_PROTOCOL_F_PAGEFAULT = 8,
> > > >      VHOST_USER_PROTOCOL_F_CONFIG = 9,
> > > > +    VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB = 10,
> > > >      VHOST_USER_PROTOCOL_F_MAX
> > > >  };
> > > >  
> > > > @@ -1581,6 +1582,12 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
> > > >      return 0;
> > > >  }
> > > >  
> > > > +static bool vhost_user_need_all_device_iotlb(struct vhost_dev *dev)
> > > > +{
> > > > +    return virtio_has_feature(dev->protocol_features,
> > > > +                              VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB);
> > > > +}
> > > > +
> > > >  const VhostOps user_ops = {
> > > >          .backend_type = VHOST_BACKEND_TYPE_USER,
> > > >          .vhost_backend_init = vhost_user_init,
> > > > @@ -1611,4 +1618,5 @@ const VhostOps user_ops = {
> > > >          .vhost_set_config = vhost_user_set_config,
> > > >          .vhost_crypto_create_session = vhost_user_crypto_create_session,
> > > >          .vhost_crypto_close_session = vhost_user_crypto_close_session,
> > > > +        .vhost_backend_need_all_device_iotlb = vhost_user_need_all_device_iotlb,
> > > >  };
> > > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > > index f51bf573d5..70922ee998 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -48,6 +48,9 @@ static unsigned int used_memslots;
> > > >  static QLIST_HEAD(, vhost_dev) vhost_devices =
> > > >      QLIST_HEAD_INITIALIZER(vhost_devices);
> > > >  
> > > > +static int vhost_memory_region_lookup(struct vhost_dev *hdev, uint64_t gpa,
> > > > +                                      uint64_t *uaddr, uint64_t *len);
> > > > +
> > > >  bool vhost_has_free_slot(void)
> > > >  {
> > > >      unsigned int slots_limit = ~0U;
> > > > @@ -634,12 +637,39 @@ static void vhost_region_addnop(MemoryListener *listener,
> > > >      vhost_region_add_section(dev, section);
> > > >  }
> > > >  
> > > > -static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > > > +static void vhost_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
> > > >  {
> > > >      struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
> > > >      struct vhost_dev *hdev = iommu->hdev;
> > > >      hwaddr iova = iotlb->iova + iommu->iommu_offset;
> > > >  
> > > > +    if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
> > > > +        uint64_t uaddr, len;
> > > > +
> > > > +        rcu_read_lock();
> > > > +
> > > > +        if (iotlb->target_as != NULL) {
> > > > +            if (vhost_memory_region_lookup(hdev, iotlb->translated_addr,
> > > > +                        &uaddr, &len)) {
> > > > +                error_report("Fail to lookup the translated address "
> > > > +                        "%"PRIx64, iotlb->translated_addr);
> > > > +                goto out;
> > > > +            }
> > > > +
> > > > +            len = MIN(iotlb->addr_mask + 1, len);
> > > > +            iova = iova & ~iotlb->addr_mask;
> > > > +
> > > > +            if (vhost_backend_update_device_iotlb(hdev, iova, uaddr,
> > > > +                                                  len, iotlb->perm)) {
> > > > +                error_report("Fail to update device iotlb");
> > > > +                goto out;
> > > > +            }
> > > > +        }
> > > > +out:
> > > > +        rcu_read_unlock();
> > > > +        return;
> > > > +    }
> > > > +
> > > >      if (vhost_backend_invalidate_device_iotlb(hdev, iova,
> > > >                                                iotlb->addr_mask + 1)) {
> > > >          error_report("Fail to invalidate device iotlb");
> > > > @@ -652,6 +682,7 @@ static void vhost_iommu_region_add(MemoryListener *listener,
> > > >      struct vhost_dev *dev = container_of(listener, struct vhost_dev,
> > > >                                           iommu_listener);
> > > >      struct vhost_iommu *iommu;
> > > > +    IOMMUNotifierFlag flags;
> > > >      Int128 end;
> > > >  
> > > >      if (!memory_region_is_iommu(section->mr)) {
> > > > @@ -662,8 +693,15 @@ static void vhost_iommu_region_add(MemoryListener *listener,
> > > >      end = int128_add(int128_make64(section->offset_within_region),
> > > >                       section->size);
> > > >      end = int128_sub(end, int128_one());
> > > > -    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > > > -                        IOMMU_NOTIFIER_UNMAP,
> > > > +
> > > > +    if (dev->vhost_ops->vhost_backend_need_all_device_iotlb(dev)) {
> > > > +        flags = IOMMU_NOTIFIER_ALL;
> > > > +    } else {
> > > > +        flags = IOMMU_NOTIFIER_UNMAP;
> > > > +    }
> > > > +
> > > > +    iommu_notifier_init(&iommu->n, vhost_iommu_map_notify,
> > > > +                        flags,
> > > >                          section->offset_within_region,
> > > >                          int128_get64(end));
> > > >      iommu->mr = section->mr;
> > > > @@ -673,6 +711,9 @@ static void vhost_iommu_region_add(MemoryListener *listener,
> > > >      memory_region_register_iommu_notifier(section->mr, &iommu->n);
> > > >      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
> > > >      /* TODO: can replay help performance here? */
> > > > +    if (flags == IOMMU_NOTIFIER_ALL) {
> > > > +        memory_region_iommu_replay(IOMMU_MEMORY_REGION(iommu->mr), &iommu->n);
> > > > +    }
> > > >  }
> > > >  
> > > >  static void vhost_iommu_region_del(MemoryListener *listener,
> > > > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
> > > > index 5dac61f9ea..602fd987a4 100644
> > > > --- a/include/hw/virtio/vhost-backend.h
> > > > +++ b/include/hw/virtio/vhost-backend.h
> > > > @@ -101,6 +101,8 @@ typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *dev,
> > > >  typedef int (*vhost_crypto_close_session_op)(struct vhost_dev *dev,
> > > >                                               uint64_t session_id);
> > > >  
> > > > +typedef bool (*vhost_backend_need_all_device_iotlb_op)(struct vhost_dev *dev);
> > > > +
> > > >  typedef struct VhostOps {
> > > >      VhostBackendType backend_type;
> > > >      vhost_backend_init vhost_backend_init;
> > > > @@ -138,6 +140,7 @@ typedef struct VhostOps {
> > > >      vhost_set_config_op vhost_set_config;
> > > >      vhost_crypto_create_session_op vhost_crypto_create_session;
> > > >      vhost_crypto_close_session_op vhost_crypto_close_session;
> > > > +    vhost_backend_need_all_device_iotlb_op vhost_backend_need_all_device_iotlb;
> > > >  } VhostOps;
> > > >  
> > > >  extern const VhostOps user_ops;
> > > > -- 
> > > > 2.11.0
