Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623C5C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 03:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E092084D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 03:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E092084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irvlM-00041C-99
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 22:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1irvkd-0003Iq-0w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 22:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1irvkZ-0000f7-Ly
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 22:23:18 -0500
Received: from [192.146.154.1] (port=7812 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1irvkZ-0000ev-Bp
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 22:23:15 -0500
Received: from raphael-norwitz.user.nutanix.com
 (raphael-norwitz.dev.nutanix.com [10.41.25.241])
 by mcp01.nutanix.com (Postfix) with ESMTP id 749BB100AC14;
 Thu, 16 Jan 2020 03:23:14 +0000 (UTC)
Date: Wed, 15 Jan 2020 19:23:14 -0800
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH 3/3] Introduce Configurable Number of Memory Slots
 Exposed by vhost-user:
Message-ID: <20200116032314.GA86980@raphael-norwitz.user.nutanix.com>
References: <1575874847-5792-1-git-send-email-raphael.norwitz@nutanix.com>
 <1575874847-5792-4-git-send-email-raphael.norwitz@nutanix.com>
 <20200114020807-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114020807-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.146.154.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 02:12:46AM -0500, Michael S. Tsirkin wrote:
>=20
> On Mon, Dec 09, 2019 at 02:00:47AM -0500, Raphael Norwitz wrote:
> > The current vhost-user implementation in Qemu imposes a limit on the
> > maximum number of memory slots exposed to a VM using a vhost-user
> > device. This change provides a new protocol feature
> > VHOST_USER_F_CONFIGURE_SLOTS which, when enabled, lifts this limit
> > and allows a VM with a vhost-user device to expose a configurable
> > number of memory slots, up to the maximum supported by the platform.
> > Existing backends are unaffected.
> >=20
> > This feature works by using three new messages,
> > VHOST_USER_GET_MAX_MEM_SLOTS, VHOST_USER_ADD_MEM_REG and
> > VHOST_USER_REM_MEM_REG. VHOST_USER_GET_MAX_MEM_SLOTS gets the
> > number of memory slots the backend is willing to accept. Then,
> > when the memory tables are set or updated, a series of
> > VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG messages are sent
> > to transmit the regions to map and/or unmap instead of trying to
> > send all the regions in one fixed size VHOST_USER_SET_MEM_TABLE messa=
ge.
> >=20
> > The vhost_user struct maintains a shadow state of the VM=E2=80=99s me=
mory
> > regions. When the memory tables are modified, the
> > vhost_user_set_mem_table() function compares the new device memory st=
ate
> > to the shadow state and only sends regions which need to be unmapped =
or
> > mapped in. The regions which must be unmapped are sent first, followe=
d
> > by the new regions to be mapped in. After all the messages have been =
sent,
> > the shadow state is set to the current virtual device state.
> >=20
> > The current feature implementation does not work with postcopy migrat=
ion
> > and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK feature =
has
> > also been negotiated.
> >=20
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > ---
> >  docs/interop/vhost-user.rst |  43 ++++++++
> >  hw/virtio/vhost-user.c      | 251 ++++++++++++++++++++++++++++++++++=
++++++----
> >  2 files changed, 273 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rs=
t
> > index 7827b71..855a072 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -785,6 +785,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
> >    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
> >    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> > +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS   13
> > =20
> >  Master message types
> >  --------------------
> > @@ -1190,6 +1191,48 @@ Master message types
> >    ancillary data. The GPU protocol is used to inform the master of
> >    rendering state and updates. See vhost-user-gpu.rst for details.
> > =20
> > +``VHOST_USER_GET_MAX_MEM_SLOTS``
> > +  :id: 34
> > +  :equivalent ioctl: N/A
> > +  :slave payload: u64
> > +
> > +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature ha=
s been
> > +  successfully negotiated, this message is submitted by master to th=
e
> > +  slave. The slave should return the message with a u64 payload
> > +  containing the maximum number of memory slots for QEMU to expose t=
o
> > +  the guest. This message is not supported with postcopy migration o=
r if
> > +  the VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiat=
ed.
> > +
> > +``VHOST_USER_ADD_MEM_REG``
> > +  :id: 35
> > +  :equivalent ioctl: N/A
> > +  :slave payload: memory region
> > +
> > +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature ha=
s been
> > +  successfully negotiated, this message is submitted by master to th=
e slave.
> > +  The message payload contains a memory region descriptor struct, de=
scribing
> > +  a region of guest memory which the slave device must map in. When =
the
> > +  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been su=
ccessfully
> > +  negotiated, along with the VHOST_USER_REM_MEM_REG message, this me=
ssage is
> > +  used to set and update the memory tables of the slave device. This=
 message
> > +  is not supported with postcopy migration or if the
> > +  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
> > +
> > +``VHOST_USER_REM_MEM_REG``
> > +  :id: 36
> > +  :equivalent ioctl: N/A
> > +  :slave payload: memory region
> > +
> > +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature ha=
s been
> > +  successfully negotiated, this message is submitted by master to th=
e slave.
> > +  The message payload contains a memory region descriptor struct, de=
scribing
> > +  a region of guest memory which the slave device must unmap. When t=
he
> > +  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been su=
ccessfully
> > +  negotiated, along with the VHOST_USER_ADD_MEM_REG message, this me=
ssage is
> > +  used to set and update the memory tables of the slave device. This=
 message
> > +  is not supported with postcopy migration or if the
> > +  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
> > +
> >  Slave message types
> >  -------------------
> > =20
> > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > index 2134e81..3432462 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -35,11 +35,29 @@
> >  #include <linux/userfaultfd.h>
> >  #endif
> > =20
> > -#define VHOST_MEMORY_MAX_NREGIONS    8
> > +#define VHOST_MEMORY_LEGACY_NREGIONS    8
> >  #define VHOST_USER_F_PROTOCOL_FEATURES 30
> >  #define VHOST_USER_SLAVE_MAX_FDS     8
> > =20
> >  /*
> > + * Set maximum number of RAM slots supported to
> > + * the maximum number supported by the target
> > + * hardware plaform.
> > + */
> > +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> > +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> > +#include "hw/acpi/acpi.h"
> > +#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
> > +
> > +#elif defined(TARGET_PPC) || defined(TARGET_PPC_64)
> > +#include "hw/ppc/spapr.h"
> > +#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
> > +
> > +#else
> > +#define VHOST_USER_MAX_RAM_SLOTS 512
> > +#endif
> > +
> > +/*
> >   * Maximum size of virtio device config space
> >   */
> >  #define VHOST_USER_MAX_CONFIG_SIZE 256
> > @@ -58,6 +76,7 @@ enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
> >      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
> >      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
> > +    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS =3D 13,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> > =20
> > @@ -98,6 +117,9 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_GET_INFLIGHT_FD =3D 31,
> >      VHOST_USER_SET_INFLIGHT_FD =3D 32,
> >      VHOST_USER_GPU_SET_SOCKET =3D 33,
> > +    VHOST_USER_GET_MAX_MEM_SLOTS =3D 34,
> > +    VHOST_USER_ADD_MEM_REG =3D 35,
> > +    VHOST_USER_REM_MEM_REG =3D 36,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> > =20
> > @@ -119,9 +141,14 @@ typedef struct VhostUserMemoryRegion {
> >  typedef struct VhostUserMemory {
> >      uint32_t nregions;
> >      uint32_t padding;
> > -    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
> > +    VhostUserMemoryRegion regions[VHOST_MEMORY_LEGACY_NREGIONS];
> >  } VhostUserMemory;
> > =20
> > +typedef struct VhostUserMemRegMsg {
> > +    uint32_t padding;
> > +    VhostUserMemoryRegion region;
> > +} VhostUserMemRegMsg;
> > +
> >  typedef struct VhostUserLog {
> >      uint64_t mmap_size;
> >      uint64_t mmap_offset;
> > @@ -180,6 +207,7 @@ typedef union {
> >          struct vhost_vring_state state;
> >          struct vhost_vring_addr addr;
> >          VhostUserMemory memory;
> > +        VhostUserMemRegMsg mem_reg;
> >          VhostUserLog log;
> >          struct vhost_iotlb_msg iotlb;
> >          VhostUserConfig config;
> > @@ -208,7 +236,7 @@ struct vhost_user {
> >      int slave_fd;
> >      NotifierWithReturn postcopy_notifier;
> >      struct PostCopyFD  postcopy_fd;
> > -    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIO=
NS];
> > +    uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOT=
S];
> >      /* Length of the region_rb and region_rb_offset arrays */
> >      size_t             region_rb_len;
> >      /* RAMBlock associated with a given region */
> > @@ -220,6 +248,10 @@ struct vhost_user {
> > =20
> >      /* True once we've entered postcopy_listen */
> >      bool               postcopy_listen;
> > +
> > +    /* Our current regions */
> > +    int num_shadow_regions;
> > +    VhostUserMemoryRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
> >  };
> > =20
> >  static bool ioeventfd_enabled(void)
> > @@ -368,7 +400,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *d=
ev, int fd)
> >  static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t b=
ase,
> >                                     struct vhost_log *log)
> >  {
> > -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    int fds[VHOST_USER_MAX_RAM_SLOTS];
> >      size_t fd_num =3D 0;
> >      bool shmfd =3D virtio_has_feature(dev->protocol_features,
> >                                      VHOST_USER_PROTOCOL_F_LOG_SHMFD)=
;
> > @@ -426,7 +458,7 @@ static int vhost_user_fill_set_mem_table_msg(stru=
ct vhost_user *u,
> >                                       &offset);
> >          fd =3D memory_region_get_fd(mr);
> >          if (fd > 0) {
> > -            if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > +            if (*fd_num =3D=3D VHOST_MEMORY_LEGACY_NREGIONS) {
> >                  error_report("Failed preparing vhost-user memory tab=
le msg");
> >                  return -1;
> >              }
> > @@ -472,7 +504,7 @@ static int vhost_user_set_mem_table_postcopy(stru=
ct vhost_dev *dev,
> >                                               struct vhost_memory *me=
m)
> >  {
> >      struct vhost_user *u =3D dev->opaque;
> > -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
> >      size_t fd_num =3D 0;
> >      VhostUserMsg msg_reply;
> >      int region_i, msg_i;
> > @@ -521,7 +553,7 @@ static int vhost_user_set_mem_table_postcopy(stru=
ct vhost_dev *dev,
> >      }
> > =20
> >      memset(u->postcopy_client_bases, 0,
> > -           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> > +           sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> > =20
> >      /* They're in the same order as the regions that were sent
> >       * but some of the regions were skipped (above) if they
> > @@ -562,18 +594,151 @@ static int vhost_user_set_mem_table_postcopy(s=
truct vhost_dev *dev,
> >      return 0;
> >  }
> > =20
> > +static inline bool reg_equal(VhostUserMemoryRegion *shadow_reg,
> > +                             struct vhost_memory_region *vdev_reg)
> > +{
> > +    if (shadow_reg->guest_phys_addr =3D=3D vdev_reg->guest_phys_addr=
 &&
> > +        shadow_reg->userspace_addr =3D=3D vdev_reg->userspace_addr &=
&
> > +        shadow_reg->memory_size =3D=3D vdev_reg->memory_size) {
> > +        return true;
> > +    } else {
> > +        return false;
> > +    }
> > +}
> > +
> > +static int vhost_user_send_add_remove_regions(struct vhost_dev *dev,
> > +                                              struct vhost_memory *m=
em,
> > +                                              VhostUserMsg *msg)
> > +{
> > +    struct vhost_user *u =3D dev->opaque;
> > +    int i, j, fd;
> > +    bool found[VHOST_USER_MAX_RAM_SLOTS] =3D {};
> > +    bool matching =3D false;
> > +    struct vhost_memory_region *reg;
> > +    ram_addr_t offset;
> > +    MemoryRegion *mr;
> > +
> > +    /*
> > +     * Ensure the VHOST_USER_PROTOCOL_F_REPLY_ACK has not been
> > +     * negotiated and no postcopy migration is in progress.
> > +     */
> > +    assert(!virtio_has_feature(dev->protocol_features,
> > +                               VHOST_USER_PROTOCOL_F_REPLY_ACK));
> > +    if (u->postcopy_listen && u->postcopy_fd.handler) {
> > +        error_report("Postcopy migration is not supported when the "
> > +                     "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feature =
"
> > +                     "has been negotiated");
> > +        return -1;
> > +    }
> > +
> > +    msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding);
> > +    msg->hdr.size +=3D sizeof(VhostUserMemoryRegion);
> > +
> > +    /*
> > +     * Send VHOST_USER_REM_MEM_REG for memory regions in our shadow =
state
> > +     * which are not found not in the device's memory state.
> > +     */
> > +    for (i =3D 0; i < u->num_shadow_regions; ++i) {
> > +        reg =3D dev->mem->regions;
> > +
> > +        for (j =3D 0; j < dev->mem->nregions; j++) {
> > +            reg =3D dev->mem->regions + j;
> > +
> > +            assert((uintptr_t)reg->userspace_addr =3D=3D reg->usersp=
ace_addr);
> > +            mr =3D memory_region_from_host((void *)(uintptr_t)reg->u=
serspace_addr,
> > +                                         &offset);
> > +            fd =3D memory_region_get_fd(mr);
> > +
> > +            if (reg_equal(&u->shadow_regions[i], reg)) {
> > +                matching =3D true;
> > +                found[j] =3D true;
> > +                break;
> > +            }
> > +        }
> > +
> > +        if (fd > 0 && !matching) {
> > +            msg->hdr.request =3D VHOST_USER_REM_MEM_REG;
> > +            msg->payload.mem_reg.region.userspace_addr =3D reg->user=
space_addr;
> > +            msg->payload.mem_reg.region.memory_size =3D reg->memory_=
size;
> > +            msg->payload.mem_reg.region.guest_phys_addr =3D
> > +                reg->guest_phys_addr;
> > +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> > +
> > +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> > +                return -1;
> > +            }
> > +        }
> > +    }
> > +
> > +    /*
> > +     * Send messages to add regions present in the device which are =
not
> > +     * in our shadow state.
> > +     */
> > +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> > +        reg =3D dev->mem->regions + i;
> > +
> > +        /*
> > +         * If the region was in both the shadow and vdev state we do=
n't
> > +         * need to send a VHOST_USER_ADD_MEM_REG message for it.
> > +         */
> > +        if (found[i]) {
> > +            continue;
> > +        }
> > +
> > +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_=
addr);
> > +        mr =3D memory_region_from_host((void *)(uintptr_t)reg->users=
pace_addr,
> > +                                     &offset);
> > +        fd =3D memory_region_get_fd(mr);
> > +
> > +        if (fd > 0) {
> > +            msg->hdr.request =3D VHOST_USER_ADD_MEM_REG;
> > +            msg->payload.mem_reg.region.userspace_addr =3D reg->user=
space_addr;
> > +            msg->payload.mem_reg.region.memory_size =3D reg->memory_=
size;
> > +            msg->payload.mem_reg.region.guest_phys_addr =3D
> > +                reg->guest_phys_addr;
> > +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> > +
> > +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> > +                return -1;
> > +            }
> > +        }
> > +    }
> > +
> > +    /* Make our shadow state match the updated device state. */
> > +    u->num_shadow_regions =3D dev->mem->nregions;
> > +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> > +        reg =3D dev->mem->regions + i;
> > +        u->shadow_regions[i].guest_phys_addr =3D reg->guest_phys_add=
r;
> > +        u->shadow_regions[i].userspace_addr =3D reg->userspace_addr;
> > +        u->shadow_regions[i].memory_size =3D reg->memory_size;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static int vhost_user_set_mem_table(struct vhost_dev *dev,
> >                                      struct vhost_memory *mem)
> >  {
> >      struct vhost_user *u =3D dev->opaque;
> > -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
> >      size_t fd_num =3D 0;
> >      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handle=
r;
> >      bool reply_supported =3D virtio_has_feature(dev->protocol_featur=
es,
> >                                                VHOST_USER_PROTOCOL_F_=
REPLY_ACK);
> > +    bool config_slots =3D
> > +        virtio_has_feature(dev->protocol_features,
> > +                           VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS);
> > =20
> >      if (do_postcopy) {
> > -        /* Postcopy has enough differences that it's best done in it=
's own
> > +        if (config_slots) {
> > +            error_report("Postcopy migration not supported with "
> > +                          "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS fea=
ture "
> > +                          "enabled.");
> > +            return -1;
> > +        }
> > +
> > +        /*
> > +         * Postcopy has enough differences that it's best done in it=
's own
> >           * version
> >           */
> >          return vhost_user_set_mem_table_postcopy(dev, mem);
> > @@ -587,17 +752,22 @@ static int vhost_user_set_mem_table(struct vhos=
t_dev *dev,
> >          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
> >      }
> > =20
> > -    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num=
,
> > -                                          false) < 0) {
> > -        return -1;
> > -    }
> > -
> > -    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> > -        return -1;
> > -    }
> > +    if (config_slots && !reply_supported) {
> > +        if (vhost_user_send_add_remove_regions(dev, mem, &msg) < 0) =
{
> > +            return -1;
> > +        }
> > +    } else {
> > +        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd=
_num,
> > +                                              false) < 0) {
> > +            return -1;
> > +        }
> > +        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> > +            return -1;
> > +        }
> > =20
> > -    if (reply_supported) {
> > -        return process_message_reply(dev, &msg);
> > +        if (reply_supported) {
> > +            return process_message_reply(dev, &msg);
> > +        }
> >      }
> > =20
> >      return 0;
> > @@ -762,7 +932,7 @@ static int vhost_set_vring_file(struct vhost_dev =
*dev,
> >                                  VhostUserRequest request,
> >                                  struct vhost_vring_file *file)
> >  {
> > -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    int fds[VHOST_USER_MAX_RAM_SLOTS];
> >      size_t fd_num =3D 0;
> >      VhostUserMsg msg =3D {
> >          .hdr.request =3D request,
> > @@ -1496,7 +1666,46 @@ static int vhost_user_get_vq_index(struct vhos=
t_dev *dev, int idx)
> > =20
> >  static int vhost_user_memslots_limit(struct vhost_dev *dev)
> >  {
> > -    return VHOST_MEMORY_MAX_NREGIONS;
> > +    VhostUserMsg msg =3D {
> > +        .hdr.request =3D VHOST_USER_GET_MAX_MEM_SLOTS,
> > +        .hdr.flags =3D VHOST_USER_VERSION,
> > +    };
> > +
> > +    if (!virtio_has_feature(dev->protocol_features,
> > +                            VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS)) =
{
> > +        return VHOST_MEMORY_LEGACY_NREGIONS;
> > +    }
> > +
> > +    if (virtio_has_feature(dev->protocol_features,
> > +                           VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
>=20
> I'd just assume that VHOST_USER_GET_MAX_MEM_SLOTS always
> gets a response.
>=20
>
Makes sense
> > +        error_report("The VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS prot=
ocol "
> > +                     "feature is not supported when the "
> > +                     "VHOST_USER_PROTOCOL_F_REPLY_ACK features has a=
lso "
> > +                     "been negotiated");
> > +        return -1;
> > +    }
> > +
> > +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> > +        return -1;
> > +    }
>=20
> This will send the message each time e.g. memory hotplug
> triggers. Why not just get this value during init time?
> Also, any way we can cut down number of round trips?
> Can we combine this value in a single message with
> some other stuff we are fetching on startup?
>=20

Agreed, sending a VHOST_USER_GET_MEMSLOTS message on every hot-add is
unnessesary. I can think of a couple ways to get number of memslots witho=
ut
adding any additional round trips. I don=E2=80=99t like either of them th=
ough.`

1.
Only 14 of the 64 bits are used in the VHOST_USER_GET_FEATURES message ar=
e
used to store feature flags. If CONFIGURE SLOTS is enabled, we could use
the remaining 64 - VHOST_USER_PROTOCOL_F_MAX bits to store the maximum nu=
mber
of memory slots. We would only need around 10 bits to express a reasonabl=
e
number of slots so that still leaves room for plenty of future features w=
ith
VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS negotiated.

2.
We could always have it sent from the backend with an existing VHOST_USER=
_GET_*
message in vhost_user_backend_init(). The best option I see is using the
VHOST_USER_GET_QUEUE_NUM if the VHOST_USER_PROTOCOL_F_MQ is negotiated. T=
his has
the obvious drawback of requiring VHOST_USER_PROTOCOL_F_MQ to negotiate
VHOST_USER_PROTOCOL_F_CONFIGURE_SOTS. I don=E2=80=99t see another option =
without such a
limitation.

Both (1) and (2) seem hacky. I think it=E2=80=99s preferable to keep the
VHOST_USER_GET_MAX_MEM_SLOTS message but send it once on init and cache t=
he
response in the vhost-user struct.

Do you agree?
> > +
> > +    if (vhost_user_read(dev, &msg) < 0) {
> > +        return -1;
> > +    }
> > +
> > +    if (msg.hdr.request !=3D VHOST_USER_GET_MAX_MEM_SLOTS) {
> > +        error_report("Received unexpected msg type. Expected %d rece=
ived %d",
> > +                     VHOST_USER_GET_MAX_MEM_SLOTS, msg.hdr.request);
> > +        return -1;
> > +    }
> > +
> > +    if (msg.hdr.size !=3D sizeof(msg.payload.u64)) {
> > +        error_report("Received bad msg size");
> > +        return -1;
> > +    }
> > +
> > +    return MIN(MAX(msg.payload.u64, VHOST_MEMORY_LEGACY_NREGIONS),
> > +               VHOST_USER_MAX_RAM_SLOTS);
>=20
> What's this trying to do? Pls add code comments.
>=20
Should be MIN(msg.payload.u64, VHOST_USER_MAX_RAM_SLOTS) - will fix
> >  }
> > =20
> >  static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
> > --=20
> > 1.8.3.1
>=20
>=20

