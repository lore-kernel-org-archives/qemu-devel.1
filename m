Received: from eggs.gnu.org ([2001:4830:134:3::10]:36083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwGe-00023N-98
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eUwGa-0006St-0Y
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:08:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eUwGZ-0006Ru-Mt
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 10:08:11 -0500
Date: Fri, 29 Dec 2017 16:07:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171229160758.6c9cf890@igors-macbook-pro.local>
In-Reply-To: <B2D15215269B544CADD246097EACE7473AB1E3F5@DGGEMM505-MBS.china.huawei.com>
References: <1514514911-15596-1-git-send-email-jianjay.zhou@huawei.com>
	<20171229103110.40407706@igors-macbook-pro.local>
	<B2D15215269B544CADD246097EACE7473AB1E285@DGGEMM505-MBS.china.huawei.com>
	<20171229122201.5817d070@igors-macbook-pro.local>
	<B2D15215269B544CADD246097EACE7473AB1E3F5@DGGEMM505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number for
 vhost-user and vhost-kernel separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "mst@redhat.com" <mst@redhat.com>, "wangxin
	(U)" <wangxinxin.wang@huawei.com>, "Liuzhe (Cloud Open Labs, NFV)" <gary.liuzhe@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

On Fri, 29 Dec 2017 12:54:44 +0000
"Zhoujian (jay)" <jianjay.zhou@huawei.com> wrote:

> 
> 
> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: Friday, December 29, 2017 7:22 PM
> > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > Cc: qemu-devel@nongnu.org; Huangweidong (C) <weidong.huang@huawei.com>;
> > mst@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>; Liuzhe (Cloud
> > Open Labs, NFV) <gary.liuzhe@huawei.com>; Gonglei (Arei)
> > <arei.gonglei@huawei.com>
> > Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number for
> > vhost-user and vhost-kernel separately
> > 
> > On Fri, 29 Dec 2017 10:37:40 +0000
> > "Zhoujian (jay)" <jianjay.zhou@huawei.com> wrote:
> > 
> > > Hi Igor,
> > >
> > > > -----Original Message-----
> > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > Sent: Friday, December 29, 2017 5:31 PM
> > > > To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> > > > Cc: qemu-devel@nongnu.org; Huangweidong (C)
> > > > <weidong.huang@huawei.com>; mst@redhat.com; wangxin (U)
> > > > <wangxinxin.wang@huawei.com>; Liuzhe (Cloud Open Labs, NFV)
> > > > <gary.liuzhe@huawei.com>; Gonglei (Arei) <arei.gonglei@huawei.com>
> > > > Subject: Re: [Qemu-devel] [PATCH v3] vhost: add used memslot number
> > > > for vhost-user and vhost-kernel separately
> > > >
> > > > On Fri, 29 Dec 2017 10:35:11 +0800
> > > > Jay Zhou <jianjay.zhou@huawei.com> wrote:
> > > >
> > > > > Used_memslots is equal to dev->mem->nregions now, it is true for
> > > > > vhost kernel, but not for vhost user, which uses the memory
> > > > > regions that have file descriptor. In fact, not all of the memory
> > > > > regions have file descriptor.
> > > > > It is usefully in some scenarios, e.g. used_memslots is 8, and
> > > > > only
> > > > > 5 memory slots can be used by vhost user, it is failed to hotplug
> > > > > a new DIMM memory because vhost_has_free_slot just returned false,
> > > > > however we can hotplug it safely in fact.
> > > > >
> > > > > Meanwhile, instead of asserting in vhost_user_set_mem_table(),
> > > > > error number is used to gracefully prevent device to start. This
> > > > > fixed the VM crash issue.
> > > >
> > > > below mostly style related comments, otherwise patch looks good to
> > > > me
> > > > >
> > > > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > > > > Signed-off-by: Zhe Liu <gary.liuzhe@huawei.com>
> > > > > ---
> > > > >  hw/virtio/vhost-backend.c         | 14 +++++++
> > > > >  hw/virtio/vhost-user.c            | 84
> > +++++++++++++++++++++++++++++---
> > > > -------
> > > > >  hw/virtio/vhost.c                 | 16 ++++----
> > > > >  include/hw/virtio/vhost-backend.h |  4 ++
> > > > >  4 files changed, 91 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > > > index 7f09efa..866718c 100644
> > > > > --- a/hw/virtio/vhost-backend.c
> > > > > +++ b/hw/virtio/vhost-backend.c
> > > > > @@ -15,6 +15,8 @@
> > > > >  #include "hw/virtio/vhost-backend.h"
> > > > >  #include "qemu/error-report.h"
> > > > >
> > > > > +static unsigned int vhost_kernel_used_memslots;
> > > > > +
> > > > >  static int vhost_kernel_call(struct vhost_dev *dev, unsigned long
> > > > > int
> > > > request,
> > > > >                               void *arg)  { @@ -233,6 +235,16 @@
> > > > > static void vhost_kernel_set_iotlb_callback(struct vhost_dev *dev,
> > > > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL,
> > > > > NULL);  }
> > > > >
> > > > > +static void vhost_kernel_set_used_memslots(struct vhost_dev *dev) {
> > > > > +    vhost_kernel_used_memslots = dev->mem->nregions; }
> > > > > +
> > > > > +static unsigned int vhost_kernel_get_used_memslots(void)
> > > > > +{
> > > > > +    return vhost_kernel_used_memslots; }
> > > > > +
> > > > >  static const VhostOps kernel_ops = {
> > > > >          .backend_type = VHOST_BACKEND_TYPE_KERNEL,
> > > > >          .vhost_backend_init = vhost_kernel_init, @@ -264,6 +276,8
> > > > > @@ static const VhostOps kernel_ops = {  #endif /*
> > CONFIG_VHOST_VSOCK */
> > > > >          .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
> > > > >          .vhost_send_device_iotlb_msg =
> > > > > vhost_kernel_send_device_iotlb_msg,
> > > > > +        .vhost_set_used_memslots = vhost_kernel_set_used_memslots,
> > > > > +        .vhost_get_used_memslots =
> > > > > + vhost_kernel_get_used_memslots,
> > > > >  };
> > > > >
> > > > >  int vhost_set_backend_type(struct vhost_dev *dev,
> > > > > VhostBackendType
> > > > > backend_type) diff --git a/hw/virtio/vhost-user.c
> > > > > b/hw/virtio/vhost-user.c index 093675e..0f913be 100644
> > > > > --- a/hw/virtio/vhost-user.c
> > > > > +++ b/hw/virtio/vhost-user.c
> > > > > @@ -122,6 +122,8 @@ static VhostUserMsg m __attribute__
> > > > > ((unused));
> > > > >  /* The version of the protocol we support */
> > > > >  #define VHOST_USER_VERSION    (0x1)
> > > > >
> > > > > +static unsigned int vhost_user_used_memslots;
> > > > > +
> > > > >  struct vhost_user {
> > > > >      CharBackend *chr;
> > > > >      int slave_fd;
> > > > > @@ -289,12 +291,53 @@ static int vhost_user_set_log_base(struct
> > > > vhost_dev *dev, uint64_t base,
> > > > >      return 0;
> > > > >  }
> > > > >
> > > > > +static int vhost_user_prepare_msg(struct vhost_dev *dev,
> > > > > +VhostUserMsg
> > > > *msg,
> > > > > +                                  int *fds) {
> > > > > +    int r = 0;
> > > > > +    int i, fd;
> > > > > +    size_t fd_num = 0;
> > > > fd_num is redundant
> > > > you can use msg->payload.memory.nregions as a counter
> > >
> > > If using msg->payload.memory.nregions as a counter, referencing the
> > > member of msg->payload.memory.regions will be like this:
> > >
> > >    msg->payload.memory.regions[msg-
> > >payload.memory.nregions].userspace_addr = ...
> > >    msg->payload.memory.regions[msg->payload.memory.nregions].memory_size
> > = ...
> > >
> > > which will make the line more longer...
> > >
> > > >
> > > > > +
> > > > > +    for (i = 0; i < dev->mem->nregions; ++i) {
> > > >        for (i = 0, msg->payload.memory.nregions = 0; ...
> > > >
> > > > > +        struct vhost_memory_region *reg = dev->mem->regions + i;
> > > > > +        ram_addr_t offset;
> > > > > +        MemoryRegion *mr;
> > > > > +
> > > > > +        assert((uintptr_t)reg->userspace_addr == reg-
> > >userspace_addr);
> > > > > +        mr = memory_region_from_host((void *)(uintptr_t)reg-
> > > > >userspace_addr,
> > > > > +                                     &offset);
> > > > > +        fd = memory_region_get_fd(mr);
> > > > > +        if (fd > 0) {
> > > > > +            if (fd_num < VHOST_MEMORY_MAX_NREGIONS) {
> > > > instead of shifting below block to the right, I'd write it like this:
> > >
> > > Without this patch, the number of characters for these two lines
> > >
> > >         msg.payload.memory.regions[fd_num].userspace_addr = reg-
> > >userspace_addr;
> > >         msg.payload.memory.regions[fd_num].guest_phys_addr =
> > > reg->guest_phys_addr;
> > >
> > > are more than 80 already...
> > >
> > > >
> > > >                if (msg->payload.memory.nregions ==
> > > > VHOST_MEMORY_MAX_NREGIONS) {
> > > >                    return -1;
> > > >                }
> > >
> > > msg->payload.memory.nregions as a counter for vhost-user setting mem
> > > msg->table,
> > > while fd_num as a counter for vhost_user_used_memslots, IIUC they can
> > > not be merged into one counter.
> > >
> > > If return -1 when
> > > msg->payload.memory.nregions == VHOST_MEMORY_MAX_NREGIONS, the
> > > vhost_user_used_memslots maybe not assigned correctly. fd_num should
> > > be added by one if fd > 0 regardless of whether
> > > msg->payload.memory.nregions equals to or larger than
> > VHOST_MEMORY_MAX_NREGIONS.
> > 
> > why do you need to continue counting beyond VHOST_MEMORY_MAX_NREGIONS?
> > 
> 
> I think they're two choices
> (1) stop continue counting beyond VHOST_MEMORY_MAX_NREGIONS, then
>     vhost_user_used_memslots will never larger than 8
that's true but then used_memslots loose meaning of 'used' and become something else.

maybe we should replace vhost_backend_memslots_limit() and vhost_get_used_memslots()
callbacks with vhost_backend_has_free_slot() callback and use it in vhost_dev_init()
for checking. Something like this with twice less code as result:

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 19961b5..e72686f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -31,7 +31,7 @@ struct vhost_iotlb_msg;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
-typedef int (*vhost_backend_memslots_limit)(struct vhost_dev *dev);
+typedef int (*vhost_backend_has_free_memslots)(struct vhost_dev *dev);
 
 typedef int (*vhost_net_set_backend_op)(struct vhost_dev *dev,
                                 struct vhost_vring_file *file);
@@ -85,13 +85,12 @@ typedef void (*vhost_set_iotlb_callback_op)(struct vhost_dev *dev,
 typedef int (*vhost_send_device_iotlb_msg_op)(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg);
 typedef void (*vhost_set_used_memslots_op)(struct vhost_dev *dev);
-typedef unsigned int (*vhost_get_used_memslots_op)(void);
 
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
     vhost_backend_cleanup vhost_backend_cleanup;
-    vhost_backend_memslots_limit vhost_backend_memslots_limit;
+    vhost_backend_has_free_memslots vhost_backend_has_free_memslots;
     vhost_net_set_backend_op vhost_net_set_backend;
     vhost_net_set_mtu_op vhost_net_set_mtu;
     vhost_scsi_set_endpoint_op vhost_scsi_set_endpoint;
@@ -121,7 +120,6 @@ typedef struct VhostOps {
     vhost_set_iotlb_callback_op vhost_set_iotlb_callback;
     vhost_send_device_iotlb_msg_op vhost_send_device_iotlb_msg;
     vhost_set_used_memslots_op vhost_set_used_memslots;
-    vhost_get_used_memslots_op vhost_get_used_memslots;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 866718c..811b305 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -240,11 +240,6 @@ static void vhost_kernel_set_used_memslots(struct vhost_dev *dev)
     vhost_kernel_used_memslots = dev->mem->nregions;
 }
 
-static unsigned int vhost_kernel_get_used_memslots(void)
-{
-    return vhost_kernel_used_memslots;
-}
-
 static const VhostOps kernel_ops = {
         .backend_type = VHOST_BACKEND_TYPE_KERNEL,
         .vhost_backend_init = vhost_kernel_init,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 0f913be..193e598 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -122,7 +122,7 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
-static unsigned int vhost_user_used_memslots;
+static unsigned int vhost_user_free_memslots;
 
 struct vhost_user {
     CharBackend *chr;
@@ -291,14 +291,13 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     return 0;
 }
 
-static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMsg *msg,
+static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMemory *mem,
                                   int *fds)
 {
-    int r = 0;
     int i, fd;
-    size_t fd_num = 0;
 
-    for (i = 0; i < dev->mem->nregions; ++i) {
+    vhost_user_free_memslots = true;
+    for (i = 0, mem->nregions = 0; i < dev->mem->nregions; ++i) {
         struct vhost_memory_region *reg = dev->mem->regions + i;
         ram_addr_t offset;
         MemoryRegion *mr;
@@ -308,29 +307,20 @@ static int vhost_user_prepare_msg(struct vhost_dev *dev, VhostUserMsg *msg,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
-            if (fd_num < VHOST_MEMORY_MAX_NREGIONS) {
-                msg->payload.memory.nregions++;
-                msg->payload.memory.regions[fd_num].userspace_addr =
-                                                    reg->userspace_addr;
-                msg->payload.memory.regions[fd_num].memory_size =
-                                                    reg->memory_size;
-                msg->payload.memory.regions[fd_num].guest_phys_addr =
-                                                    reg->guest_phys_addr;
-                msg->payload.memory.regions[fd_num].mmap_offset = offset;
-                fds[fd_num] = fd;
-            } else {
-                r = -1;
+            if (mem->nregions == VHOST_MEMORY_MAX_NREGIONS) {
+                vhost_user_free_memslots = false;
+                return -1;
             }
-            fd_num++;
+            mem->regions[mem->nregions].userspace_addr = reg->userspace_addr;
+            mem->regions[mem->nregions].memory_size = reg->memory_size;
+            mem->regions[mem->nregions].guest_phys_addr = reg->guest_phys_addr;
+            mem->regions[mem->nregions].mmap_offset = offset;
+            fds[mem->nregions] = fd;
+            mem->nregions++;
         }
     }
 
-    /* Save the number of memory slots available for vhost user,
-     * vhost_user_get_used_memslots() can use it next time
-     */
-    vhost_user_used_memslots = fd_num;
-
-    return r;
+    return 0;
 }
 
 static int vhost_user_set_mem_table(struct vhost_dev *dev,
@@ -350,7 +340,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
         msg.flags |= VHOST_USER_NEED_REPLY_MASK;
     }
 
-    if (vhost_user_prepare_msg(dev, &msg, fds) < 0) {
+    if (vhost_user_prepare_msg(dev, &msg.payload.memory, fds) < 0) {
         error_report("Failed preparing vhost-user memory table msg");
         return -1;
     }
@@ -844,9 +834,9 @@ static int vhost_user_get_vq_index(struct vhost_dev *dev, int idx)
     return idx;
 }
 
-static int vhost_user_memslots_limit(struct vhost_dev *dev)
+static int vhost_user_has_free_memslots(struct vhost_dev *dev)
 {
-    return VHOST_MEMORY_MAX_NREGIONS;
+    return vhost_user_free_memslots;
 }
 
 static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
@@ -956,19 +946,14 @@ static void vhost_user_set_used_memslots(struct vhost_dev *dev)
     int fds[VHOST_MEMORY_MAX_NREGIONS];
     VhostUserMsg msg;
 
-    vhost_user_prepare_msg(dev, &msg, fds);
-}
-
-static unsigned int vhost_user_get_used_memslots(void)
-{
-    return vhost_user_used_memslots;
+    vhost_user_prepare_msg(dev, &msg.payload.memory, fds);
 }
 
 const VhostOps user_ops = {
         .backend_type = VHOST_BACKEND_TYPE_USER,
         .vhost_backend_init = vhost_user_init,
         .vhost_backend_cleanup = vhost_user_cleanup,
-        .vhost_backend_memslots_limit = vhost_user_memslots_limit,
+        .vhost_backend_has_free_memslots = vhost_user_has_free_memslots,
         .vhost_set_log_base = vhost_user_set_log_base,
         .vhost_set_mem_table = vhost_user_set_mem_table,
         .vhost_set_vring_addr = vhost_user_set_vring_addr,
@@ -991,5 +976,4 @@ const VhostOps user_ops = {
         .vhost_set_iotlb_callback = vhost_user_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_user_send_device_iotlb_msg,
         .vhost_set_used_memslots = vhost_user_set_used_memslots,
-        .vhost_get_used_memslots = vhost_user_get_used_memslots,
 };
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 59a32e9..4b3af18 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -51,8 +51,7 @@ bool vhost_has_free_slot(void)
     struct vhost_dev *hdev;
 
     QLIST_FOREACH(hdev, &vhost_devices, entry) {
-        if (hdev->vhost_ops->vhost_get_used_memslots() >=
-            hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+        if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
             return false;
         }
     }
@@ -1252,10 +1251,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    if (hdev->vhost_ops->vhost_get_used_memslots() >
-        hdev->vhost_ops->vhost_backend_memslots_limit(hdev)) {
+    if (!hdev->vhost_ops->vhost_backend_has_free_memslots(hdev)) {
         error_report("vhost backend memory slots limit is less"
-                " than current number of present memory slots");
+                     " than current number of present memory slots");
         r = -1;
         goto fail;
     }

i'ts just idea not even compile tested and without vhost-backend.c parts

> (2) continue counting beyond VHOST_MEMORY_MAX_NREGIONS, then
>    "hdev->vhost_ops->vhost_get_used_memslots() >
>       hdev->vhost_ops->vhost_backend_memslots_limit(hdev)"
>     will have a chance to be true to fail backend intialization early,
>     which keeps commit aebf81680b does
this check aren't always working as intended,
as you mentioned in v1 it works only if there were existing backend of the same type

now start QEMU with more dimm devices than limit but without any vhost backends
and then hotplug a vhost backend => it hotplugs happily instead of expected failure

BTW: you lost patch from v1 where you added extra check after memory listener
is registered.

I'd first put patch that fixes current broken check and
on top of that this patch that introduces new way for limit check.

> which one do you prefer?
> 
> Regards,
> Jay
