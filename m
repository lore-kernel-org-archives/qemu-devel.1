Received: from eggs.gnu.org ([2001:4830:134:3::10]:56953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ey87a-0000Rr-RV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ey87X-0006E5-Gv
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:39:34 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2265 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ey87W-0006Bq-Jj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:39:31 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 20 Mar 2018 03:39:17 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473ABF2E24@DGGEMM505-MBS.china.huawei.com>
References: <1520241169-22892-1-git-send-email-jianjay.zhou@huawei.com>
	<20180320033051-mutt-send-email-mst@kernel.org>
	<B2D15215269B544CADD246097EACE7473ABF2941@DGGEMM505-MBS.china.huawei.com>
	<20180320044456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180320044456-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9] vhost: used_memslots refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Liuzhe (Ahriy, Euler)" <liuzhe13@huawei.com>



> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, March 20, 2018 10:51 AM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>; Gon=
glei
> (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler) <liuzhe13@huawei.=
com>
> Subject: Re: [PATCH v9] vhost: used_memslots refactoring
>=20
> On Tue, Mar 20, 2018 at 02:09:34AM +0000, Zhoujian (jay) wrote:
> > Hi Michael,
> >
> > > -----Original Message-----
> > > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > > Sent: Tuesday, March 20, 2018 9:34 AM
> > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > Cc: qemu-devel@nongnu.org; imammedo@redhat.com; Huangweidong (C)
> > > <weidong.huang@huawei.com>; wangxin (U)
> > > <wangxinxin.wang@huawei.com>; Gonglei
> > > (Arei) <arei.gonglei@huawei.com>; Liuzhe (Ahriy, Euler)
> > > <liuzhe13@huawei.com>
> > > Subject: Re: [PATCH v9] vhost: used_memslots refactoring
> > >
> > > On Mon, Mar 05, 2018 at 05:12:49PM +0800, Jay Zhou wrote:
> > > > Used_memslots is shared by vhost kernel and user, it is equal to
> > > > dev->mem->nregions, which is correct for vhost kernel, but not for
> > > > vhost user, the latter one uses memory regions that have file
> > > > descriptor. E.g. a VM has a vhost-user NIC and 8(vhost user
> > > > memslot upper limit) memory slots, it will be failed to hotplug a
> > > > new DIMM device since vhost_has_free_slot() finds no free slot
> > > > left. It should be successful if only part of memory slots have
> > > > file descriptor, so setting used memslots for vhost-user and vhost-
> kernel respectively.
> > >
> > >
> > > Below should go after ---
> >
> > Thanks for reminding.
> >
> > >
> > > > v7 ... v9:
> > > >  - rebased on the master
> > > > v2 ... v6:
> > > >  - delete the "used_memslots" global variable, and add it
> > > >    for vhost-user and vhost-kernel separately
> > > >  - refine the function, commit log
> > > >  - used_memslots refactoring
> > > >
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > > Signed-off-by: Liuzhe <liuzhe13@huawei.com>
> > >
> > > When built with clang this causes runtime warnings (during make
> > > check) about misaligned access to structures.
> > >
> > > The issue is that vhost_user_prepare_msg requests VhostUserMemory
> > > which compiler assumes but is then used with a pointer into a packed
> > > structure - where fields are not aligned.
> >
> > Sorry I missed the patch you have sent to fix the alignment, I have
> > replied to that thread.
> >
> > >
> > >
> > > > ---
> > > >  hw/virtio/vhost-backend.c         | 15 +++++++-
> > > >  hw/virtio/vhost-user.c            | 77 ++++++++++++++++++++++++++-=
----
> ----
> > > ----
> > > >  hw/virtio/vhost.c                 | 13 +++----
> > > >  include/hw/virtio/vhost-backend.h |  6 ++-
> > > >  4 files changed, 75 insertions(+), 36 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > > index 7f09efa..59def69 100644
> > > > --- a/hw/virtio/vhost-backend.c
> > > > +++ b/hw/virtio/vhost-backend.c
> > > > @@ -15,6 +15,8 @@
> > > >  #include "hw/virtio/vhost-backend.h"
> > > >  #include "qemu/error-report.h"
> > > >
> > > > +static unsigned int vhost_kernel_used_memslots;
> > > > +
> > > >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long
> > > > int
> > > request,
> > > >                               void *arg)  { @@ -62,6 +64,11 @@
> > > > static int vhost_kernel_memslots_limit(struct vhost_dev *dev)
> > > >      return limit;
> > > >  }
> > > >
> > > > +static bool vhost_kernel_has_free_memslots(struct vhost_dev *dev) =
{
> > > > +    return vhost_kernel_used_memslots <
> > > > +vhost_kernel_memslots_limit(dev); }
> > > > +
> > > >  static int vhost_kernel_net_set_backend(struct vhost_dev *dev,
> > > >                                          struct vhost_vring_file
> > > > *file)  { @@ -233,11 +240,16 @@ static void
> > > > vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> > > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > > > NULL);  }
> > > >
> > > > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) =
{
> > > > +    vhost_kernel_used_memslots =3D dev->mem->nregions; }
> > > > +
> > > >  static const VhostOps kernel_ops =3D {
> > > >          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> > > >          .vhost_backend_init =3D vhost_kernel_init,
> > > >          .vhost_backend_cleanup =3D vhost_kernel_cleanup,
> > > > -        .vhost_backend_memslots_limit =3D vhost_kernel_memslots_li=
mit,
> > > > +        .vhost_backend_has_free_memslots =3D
> > > > + vhost_kernel_has_free_memslots,
> > > >          .vhost_net_set_backend =3D vhost_kernel_net_set_backend,
> > > >          .vhost_scsi_set_endpoint =3D vhost_kernel_scsi_set_endpoin=
t,
> > > >          .vhost_scsi_clear_endpoint =3D
> > > > vhost_kernel_scsi_clear_endpoint, @@ -264,6 +276,7 @@ static const
> > > > VhostOps kernel_ops =3D {  #endif /* CONFIG_VHOST_VSOCK */
> > > >          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callb=
ack,
> > > >          .vhost_send_device_iotlb_msg =3D
> > > > vhost_kernel_send_device_iotlb_msg,
> > > > +        .vhost_set_used_memslots =3D
> > > > + vhost_kernel_set_used_memslots,
> > > >  };
> > > >
> > > >  int vhost_set_backend_type(struct vhost_dev *dev,
> > > > VhostBackendType
> > > > backend_type) diff --git a/hw/virtio/vhost-user.c
> > > > b/hw/virtio/vhost-user.c index 41ff5cf..ef14249 100644
> > > > --- a/hw/virtio/vhost-user.c
> > > > +++ b/hw/virtio/vhost-user.c
> > > > @@ -163,6 +163,8 @@ static VhostUserMsg m __attribute__
> > > > ((unused));
> > > >  /* The version of the protocol we support */
> > > >  #define VHOST_USER_VERSION    (0x1)
> > > >
> > > > +static bool vhost_user_free_memslots =3D true;
> > > > +
> > > >  struct vhost_user {
> > > >      CharBackend *chr;
> > > >      int slave_fd;
> > > > @@ -330,12 +332,43 @@ static int vhost_user_set_log_base(struct
> > > > vhost_dev
> > > *dev, uint64_t base,
> > > >      return 0;
> > > >  }
> > > >
> > > > +static int vhost_user_prepare_msg(struct vhost_dev *dev,
> > > > +VhostUserMemory
> > > *mem,
> > > > +                                  int *fds) {
> > > > +    int i, fd;
> > > > +
> > > > +    vhost_user_free_memslots =3D true;
> > > > +    for (i =3D 0, mem->nregions =3D 0; i < dev->mem->nregions; ++i=
) {
> > > > +        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> > > > +        ram_addr_t offset;
> > > > +        MemoryRegion *mr;
> > > > +
> > > > +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspac=
e_addr);
> > > > +        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> > > >userspace_addr,
> > > > +                                     &offset);
> > > > +        fd =3D memory_region_get_fd(mr);
> > > > +        if (fd > 0) {
> > > > +            if (mem->nregions =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > > > +                vhost_user_free_memslots =3D false;
> > > > +                return -1;
> > > > +            }
> > > > +
> > > > +            mem->regions[mem->nregions].userspace_addr =3D reg-
> > > >userspace_addr;
> > > > +            mem->regions[mem->nregions].memory_size =3D reg->memor=
y_size;
> > > > +            mem->regions[mem->nregions].guest_phys_addr =3D reg-
> > > >guest_phys_addr;
> > > > +            mem->regions[mem->nregions].mmap_offset =3D offset;
> > > > +            fds[mem->nregions++] =3D fd;
> > > > +        }
> > > > +    }
> > > > +
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  static int vhost_user_set_mem_table(struct vhost_dev *dev,
> > > >                                      struct vhost_memory *mem)  {
> > > >      int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > > -    int i, fd;
> > > > -    size_t fd_num =3D 0;
> > > > +    size_t fd_num;
> > > >      bool reply_supported =3D
> > > > virtio_has_feature(dev->protocol_features,
> > > >
> > > > VHOST_USER_PROTOCOL_F_REPLY_ACK);
> > > >
> > > > @@ -348,29 +381,12 @@ static int vhost_user_set_mem_table(struct
> > > > vhost_dev
> > > *dev,
> > > >          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> > > >      }
> > > >
> > > > -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> > > > -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> > > > -        ram_addr_t offset;
> > > > -        MemoryRegion *mr;
> > > > -
> > > > -        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspac=
e_addr);
> > > > -        mr =3D memory_region_from_host((void *)(uintptr_t)reg-
> > > >userspace_addr,
> > > > -                                     &offset);
> > > > -        fd =3D memory_region_get_fd(mr);
> > > > -        if (fd > 0) {
> > > > -            if (fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > > > -                error_report("Failed preparing vhost-user memory t=
able
> > > msg");
> > > > -                return -1;
> > > > -            }
> > > > -            msg.payload.memory.regions[fd_num].userspace_addr =3D =
reg-
> > > >userspace_addr;
> > > > -            msg.payload.memory.regions[fd_num].memory_size  =3D re=
g-
> > > >memory_size;
> > > > -            msg.payload.memory.regions[fd_num].guest_phys_addr =3D=
 reg-
> > > >guest_phys_addr;
> > > > -            msg.payload.memory.regions[fd_num].mmap_offset =3D off=
set;
> > > > -            fds[fd_num++] =3D fd;
> > > > -        }
> > > > +    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0)=
 {
> > > > +        error_report("Failed preparing vhost-user memory table msg=
");
> > > > +        return -1;
> > > >      }
> > > >
> > > > -    msg.payload.memory.nregions =3D fd_num;
> > > > +    fd_num =3D msg.payload.memory.nregions;
> > > >
> > > >      if (!fd_num) {
> > > >          error_report("Failed initializing vhost-user memory map, "
> > > > @@ -886,9 +902,9 @@ static int vhost_user_get_vq_index(struct
> > > > vhost_dev
> > > *dev, int idx)
> > > >      return idx;
> > > >  }
> > > >
> > > > -static int vhost_user_memslots_limit(struct vhost_dev *dev)
> > > > +static bool vhost_user_has_free_memslots(struct vhost_dev *dev)
> > > >  {
> > > > -    return VHOST_MEMORY_MAX_NREGIONS;
> > > > +    return vhost_user_free_memslots;
> > > >  }
> > > >
> > > >  static bool vhost_user_requires_shm_log(struct vhost_dev *dev) @@
> > > > -1156,11 +1172,19 @@ vhost_user_crypto_close_session(struct
> > > > vhost_dev *dev,
> > > uint64_t session_id)
> > > >      return 0;
> > > >  }
> > > >
> > > > +static void vhost_user_set_used_memslots(struct vhost_dev *dev) {
> > > > +    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > > > +    VhostUserMsg msg;
> > > > +
> > > > +    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
> > >
> > > Oops.  This is something I don't understand.
> > >
> > > Why is the message prepared here and then discarded?
> > >
> >
> > The purpose of vhost_user_set_used_memslots() is to set the boolean
> > value of vhost_user_free_memslots, which indicating whether there're
> > free memeslots for vhost user. Since there're code duplicating inside
> > vhost_user_set_used_memslots() and vhost_user_set_mem_table(), Igor
> > suggested that we could create a new function to avoid duplicating.
> > Here, the value of VhostUserMsg is not needed by the caller
> > vhost_user_set_used_memslots(), so we just discarded.
> >
> > Regards,
> > Jay
>=20
>=20
> I think I misunderstood the meaning of that variable.
> It seems to be set when there are more slots than supported.

Yes.

>=20
> What vhost_user_free_memslots implies is that it is set when there are no
> free slots, even if existing config fits.
>=20
> A better name would be vhost_user_out_of_memslots maybe?

vhost_user_free_memslots is set TRUE by default, if there are more slots
than supported it is set to FALSE.
vhost_user_out_of_memslots is another option, I think it should be set
FALSE by default, if there are more slots than supported it is set to TRUE.

Since two functions vhost_has_free_slot() and the callback
vhost_backend_has_free_memslots() are using this variable,
the name vhost_user_free_memslots seems a little matching to these
function names.

If you still prefer vhost_user_out_of_memslots, pls let me know.

>=20
>=20
> And I missed the fact that it (as well as the prepare call) can actually =
fail
> when out of slots.
> Shouldn't it return status too?

vhost_user_free_memslots is always set to false when prepare call failed, t=
his
is what vhost_user_set_used_memslots() wants to do, so e.g. when we hotplug=
 memory
DIMM devices, it will return false while calling vhost_has_free_slot().

So, I think vhost_user_set_used_memslots() doesn't need to handle or care a=
bout
the return status of vhost_user_prepare_msg(), the return value is only use=
ful to
another caller vhost_user_set_mem_table()

Regards,
Jay

>=20
> > >
> > > > +}
> > > > +
> > > >  const VhostOps user_ops =3D {
> > > >          .backend_type =3D VHOST_BACKEND_TYPE_USER,
> > > >          .vhost_backend_init =3D vhost_user_init,
> > > >          .vhost_backend_cleanup =3D vhost_user_cleanup,
> > > > -        .vhost_backend_memslots_limit =3D vhost_user_memslots_limi=
t,
> > > > +        .vhost_backend_has_free_memslots =3D
> > > > + vhost_user_has_free_memslots,
> > > >          .vhost_set_log_base =3D vhost_user_set_log_base,
> > > >          .vhost_set_mem_table =3D vhost_user_set_mem_table,
> > > >          .vhost_set_vring_addr =3D vhost_user_set_vring_addr, @@
> > > > -1184,6
> > > > +1208,7 @@ const VhostOps user_ops =3D {
> > > >          .vhost_send_device_iotlb_msg =3D
> vhost_user_send_device_iotlb_msg,
> > > >          .vhost_get_config =3D vhost_user_get_config,
> > > >          .vhost_set_config =3D vhost_user_set_config,
> > > > +        .vhost_set_used_memslots =3D vhost_user_set_used_memslots,
> > > >          .vhost_crypto_create_session =3D
> vhost_user_crypto_create_session,
> > > >          .vhost_crypto_close_session =3D
> > > > vhost_user_crypto_close_session,  }; diff --git
> > > > a/hw/virtio/vhost.c b/hw/virtio/vhost.c index d8d0ef9..17262d2
> > > > 100644
> > > > --- a/hw/virtio/vhost.c
> > > > +++ b/hw/virtio/vhost.c
> > > > @@ -44,20 +44,19 @@
> > > >  static struct vhost_log *vhost_log;  static struct vhost_log
> > > > *vhost_log_shm;
> > > >
> > > > -static unsigned int used_memslots;  static QLIST_HEAD(,
> > > > vhost_dev) vhost_devices =3D
> > > >      QLIST_HEAD_INITIALIZER(vhost_devices);
> > > >
> > > >  bool vhost_has_free_slot(void)
> > > >  {
> > > > -    unsigned int slots_limit =3D ~0U;
> > > >      struct vhost_dev *hdev;
> > > >
> > > >      QLIST_FOREACH(hdev, &vhost_devices, entry) {
> > > > -        unsigned int r =3D hdev->vhost_ops-
> > > >vhost_backend_memslots_limit(hdev);
> > > > -        slots_limit =3D MIN(slots_limit, r);
> > > > +        if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev=
)) {
> > > > +            return false;
> > > > +        }
> > > >      }
> > > > -    return slots_limit > used_memslots;
> > > > +    return true;
> > > >  }
> > > >
> > > >  static void vhost_dev_sync_region(struct vhost_dev *dev, @@
> > > > -446,7
> > > > +445,6 @@ static void vhost_commit(MemoryListener *listener)
> > > >                         dev->n_mem_sections * sizeof dev->mem-
> >regions[0];
> > > >      dev->mem =3D g_realloc(dev->mem, regions_size);
> > > >      dev->mem->nregions =3D dev->n_mem_sections;
> > > > -    used_memslots =3D dev->mem->nregions;
> > > >      for (i =3D 0; i < dev->n_mem_sections; i++) {
> > > >          struct vhost_memory_region *cur_vmr =3D dev->mem->regions =
+ i;
> > > >          struct MemoryRegionSection *mrs =3D dev->mem_sections + i;
> > > > @@
> > > > -458,6 +456,7 @@ static void vhost_commit(MemoryListener *listener)
> > > >              mrs->offset_within_region;
> > > >          cur_vmr->flags_padding   =3D 0;
> > > >      }
> > > > +    dev->vhost_ops->vhost_set_used_memslots(dev);
> > > >
> > > >      if (!dev->started) {
> > > >          goto out;
> > > > @@ -1202,7 +1201,7 @@ int vhost_dev_init(struct vhost_dev *hdev,
> > > > void
> > > *opaque,
> > > >      memory_listener_register(&hdev->memory_listener,
> > > &address_space_memory);
> > > >      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
> > > >
> > > > -    if (used_memslots > hdev->vhost_ops-
> > > >vhost_backend_memslots_limit(hdev)) {
> > > > +    if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev))
> > > > + {
> > > >          error_report("vhost backend memory slots limit is less"
> > > >                  " than current number of present memory slots");
> > > >          r =3D -1;
> > > > diff --git a/include/hw/virtio/vhost-backend.h
> > > > b/include/hw/virtio/vhost-backend.h
> > > > index 5dac61f..ff06c2d 100644
> > > > --- a/include/hw/virtio/vhost-backend.h
> > > > +++ b/include/hw/virtio/vhost-backend.h
> > > > @@ -36,7 +36,7 @@ struct vhost_iotlb_msg;
> > > >
> > > >  typedef int (*vhost_backend_init)(struct vhost_dev *dev, void
> > > > *opaque);  typedef int (*vhost_backend_cleanup)(struct vhost_dev
> > > > *dev); -typedef int (*vhost_backend_memslots_limit)(struct
> > > > vhost_dev *dev);
> > > > +typedef bool (*vhost_backend_has_free_memslots)(struct vhost_dev
> > > > +*dev);
> > > >
> > > >  typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
> > > >                                  struct vhost_vring_file *file);
> > > > @@
> > > > -94,6 +94,7 @@ typedef int (*vhost_set_config_op)(struct vhost_dev
> > > > *dev,
> > > const uint8_t *data,
> > > >                                     uint32_t flags);  typedef int
> > > > (*vhost_get_config_op)(struct vhost_dev *dev, uint8_t *config,
> > > >                                     uint32_t config_len);
> > > > +typedef void (*vhost_set_used_memslots_op)(struct vhost_dev
> > > > +*dev);
> > > >
> > > >  typedef int (*vhost_crypto_create_session_op)(struct vhost_dev *de=
v,
> > > >                                                void *session_info,
> > > > @@
> > > > -105,7 +106,7 @@ typedef struct VhostOps {
> > > >      VhostBackendType backend_type;
> > > >      vhost_backend_init vhost_backend_init;
> > > >      vhost_backend_cleanup vhost_backend_cleanup;
> > > > -    vhost_backend_memslots_limit vhost_backend_memslots_limit;
> > > > +    vhost_backend_has_free_memslots
> > > > + vhost_backend_has_free_memslots;
> > > >      vhost_net_set_backend_op vhost_net_set_backend;
> > > >      vhost_net_set_mtu_op vhost_net_set_mtu;
> > > >      vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint; @@ -136,6
> > > > +137,7 @@ typedef struct VhostOps {
> > > >      vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
> > > >      vhost_get_config_op vhost_get_config;
> > > >      vhost_set_config_op vhost_set_config;
> > > > +    vhost_set_used_memslots_op vhost_set_used_memslots;
> > > >      vhost_crypto_create_session_op vhost_crypto_create_session;
> > > >      vhost_crypto_close_session_op vhost_crypto_close_session;  }
> > > > VhostOps;
> > > > --
> > > > 1.8.3.1
> > > >
