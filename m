Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82888C352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470E7208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 08:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470E7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j14Pe-0003R7-H8
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 03:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j14P4-00031s-8k
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j14P0-0000tj-OA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:26:49 -0500
Received: from [192.146.154.1] (port=16508 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j14P0-0000tI-D2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 03:26:46 -0500
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id 651461007A33;
 Mon, 10 Feb 2020 08:26:45 +0000 (UTC)
Date: Sun, 9 Feb 2020 12:43:35 -0500
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/3] Lift max memory slots limit imposed by vhost-user
Message-ID: <20200209174335.GA15050@localhost.localdomain>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-4-git-send-email-raphael.norwitz@nutanix.com>
 <20200206032332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206032332-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On Thu, Feb 06, 2020 at 03:32:38AM -0500, Michael S. Tsirkin wrote:
>=20
> On Wed, Jan 15, 2020 at 09:57:06PM -0500, Raphael Norwitz wrote:
> > The current vhost-user implementation in Qemu imposes a limit on the
> > maximum number of memory slots exposed to a VM using a vhost-user
> > device. This change provides a new protocol feature
> > VHOST_USER_F_CONFIGURE_SLOTS which, when enabled, lifts this limit an=
d
> > allows a VM with a vhost-user device to expose a configurable number =
of
> > memory slots, up to the ACPI defined maximum. Existing backends which
> > do not support this protocol feature are unaffected.
>=20
> Hmm ACPI maximum seems to be up to 512 - is this too much to fit in a
> single message?  So can't we just increase the number (after negotiatin=
g
> with remote) and be done with it, instead of add/remove?  Or is there
> another reason to prefer add/remove?
>

As mentioned in my cover letter, we experimented with simply increasing t=
he
message size and it didn=E2=80=99t work on our setup. We debugged down to=
 the socket
layer and found that on the receiving end the messages were truncated at
around 512 bytes, or around 16 memory regions.=C2=A0To support 512 memory=
 regions
we would need a message size of around=C2=A0=C2=A032 <bytes per region> *=
 512 <regions>
+ 8 <bytes for padding and region count> ~=3D 16k packet size. That would=
 be 64
times larger than the next largest message size. We thought it would be c=
leaner
and more in line with the rest of the protocol to keep the message sizes
smaller. In particular, we thought memory regions should be treated like =
the
rings, which are sent over one message at a time instead of in one large =
message.
Whether or not such a large message size can be made to work in our case,
separate messages will always work on Linux, and most likely all other UN=
IX
platforms QEMU is used on.

> >=20
> > This feature works by using three new messages,
> > VHOST_USER_GET_MAX_MEM_SLOTS, VHOST_USER_ADD_MEM_REG and
> > VHOST_USER_REM_MEM_REG. VHOST_USER_GET_MAX_MEM_SLOTS gets the
> > number of memory slots the backend is willing to accept when the
> > backend is initialized. Then, when the memory tables are set or updat=
ed,
> > a series of VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG message=
s
> > are sent to transmit the regions to map and/or unmap instead of tryin=
g
> > to send all the regions in one fixed size VHOST_USER_SET_MEM_TABLE
> > message.
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
> > by the new regions to be mapped in. After all the messages have been
> > sent, the shadow state is set to the current virtual device state.
> >=20
> > The current feature implementation does not work with postcopy migrat=
ion
> > and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK feature =
has
> > also been negotiated.
>=20
> Hmm what would it take to lift the restrictions?
> conflicting features like this makes is very hard for users to make
> an informed choice what to support.
>

We would need a setup with a backend which supports these features (REPLY=
_ACK
and postcopy migration). At first glance it looks like DPDK could work bu=
t
I'm not sure how easy it will be to test postcopy migration with the reso=
urces
we have.
=20
> > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> > Suggested-by: Mike Cui <cui@nutanix.com>
> > ---
> >  docs/interop/vhost-user.rst |  43 ++++++++
> >  hw/virtio/vhost-user.c      | 254 ++++++++++++++++++++++++++++++++++=
++++++----
> >  2 files changed, 275 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rs=
t
> > index 5f8b3a4..ae9acf2 100644
> > --- a/docs/interop/vhost-user.rst
> > +++ b/docs/interop/vhost-user.rst
> > @@ -786,6 +786,7 @@ Protocol features
> >    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
> >    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> >    #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
> > +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS   14
> > =20
> >  Master message types
> >  --------------------
> > @@ -1205,6 +1206,48 @@ Master message types
> >    Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
> >    feature is set by the backend.
> > =20
> > +``VHOST_USER_GET_MAX_MEM_SLOTS``
> > +  :id: 35
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
> > +  :id: 37
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
> > index af83fdd..fed6d02 100644
> > --- a/hw/virtio/vhost-user.c
> > +++ b/hw/virtio/vhost-user.c
> > @@ -35,11 +35,29 @@
> >  #include <linux/userfaultfd.h>
> >  #endif
> > =20
> > -#define VHOST_MEMORY_MAX_NREGIONS    8
> > +#define VHOST_MEMORY_LEGACY_NREGIONS    8
>=20
> Hardly legacy when this is intended to always be used e.g. with
> postcopy, right?
>

How about 'BASELINE'?
=20
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
> > @@ -59,6 +77,7 @@ enum VhostUserProtocolFeature {
> >      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
> >      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
> >      VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> > +    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS =3D 14,
> >      VHOST_USER_PROTOCOL_F_MAX
> >  };
> > =20
> > @@ -100,6 +119,9 @@ typedef enum VhostUserRequest {
> >      VHOST_USER_SET_INFLIGHT_FD =3D 32,
> >      VHOST_USER_GPU_SET_SOCKET =3D 33,
> >      VHOST_USER_RESET_DEVICE =3D 34,
> > +    VHOST_USER_GET_MAX_MEM_SLOTS =3D 35,
> > +    VHOST_USER_ADD_MEM_REG =3D 36,
> > +    VHOST_USER_REM_MEM_REG =3D 37,
> >      VHOST_USER_MAX
> >  } VhostUserRequest;
> > =20
> > @@ -121,9 +143,14 @@ typedef struct VhostUserMemoryRegion {
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
> > @@ -182,6 +209,7 @@ typedef union {
> >          struct vhost_vring_state state;
> >          struct vhost_vring_addr addr;
> >          VhostUserMemory memory;
> > +        VhostUserMemRegMsg mem_reg;
> >          VhostUserLog log;
> >          struct vhost_iotlb_msg iotlb;
> >          VhostUserConfig config;
> > @@ -210,7 +238,7 @@ struct vhost_user {
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
> > @@ -222,6 +250,13 @@ struct vhost_user {
> > =20
> >      /* True once we've entered postcopy_listen */
> >      bool               postcopy_listen;
> > +
> > +    /* Maximum number of RAM slots supported by the backend */
> > +    uint64_t memory_slots;
> > +
> > +    /* Our current regions */
> > +    int num_shadow_regions;
> > +    VhostUserMemoryRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
> >  };
> > =20
> >  static bool ioeventfd_enabled(void)
> > @@ -370,7 +405,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *d=
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
> > @@ -429,7 +464,7 @@ static int vhost_user_fill_set_mem_table_msg(stru=
ct vhost_user *u,
> >          fd =3D memory_region_get_fd(mr);
> >          if (fd > 0) {
> >              if (postcopy) {
> > -                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
> > +                assert(*fd_num < VHOST_MEMORY_LEGACY_NREGIONS);
> >                  trace_vhost_user_set_mem_table_withfd(*fd_num, mr->n=
ame,
> >                                                        reg->memory_si=
ze,
> >                                                        reg->guest_phy=
s_addr,
> > @@ -437,7 +472,7 @@ static int vhost_user_fill_set_mem_table_msg(stru=
ct vhost_user *u,
> >                                                        offset);
> >                  u->region_rb_offset[i] =3D offset;
> >                  u->region_rb[i] =3D mr->ram_block;
> > -            } else if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> > +            } else if (*fd_num =3D=3D VHOST_MEMORY_LEGACY_NREGIONS) =
{
> >                  error_report("Failed preparing vhost-user memory tab=
le msg");
> >                  return -1;
> >              }
> > @@ -474,7 +509,7 @@ static int vhost_user_set_mem_table_postcopy(stru=
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
> > @@ -523,7 +558,7 @@ static int vhost_user_set_mem_table_postcopy(stru=
ct vhost_dev *dev,
> >      }
> > =20
> >      memset(u->postcopy_client_bases, 0,
> > -           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> > +           sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> > =20
> >      /* They're in the same order as the regions that were sent
> >       * but some of the regions were skipped (above) if they
> > @@ -564,18 +599,151 @@ static int vhost_user_set_mem_table_postcopy(s=
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
>=20
> double negation - could not parse this.
>

Apologies - typo here. It should say =E2=80=9CSend VHOST_USER_REM_MEM_REG=
 for memory
regions in our shadow state which are not found in the device's memory st=
ate.=E2=80=9D=20
i.e. send messages to remove regions in the shadow state but not in the u=
pdated
device state.=20
=20
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
> > +                         "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feat=
ure "
> > +                         "enabled.");
> > +            return -1;
> > +        }
> > +
> > +        /*
> > +         * Postcopy has enough differences that it's best done in it=
's own
> >           * version
> >           */
> >          return vhost_user_set_mem_table_postcopy(dev, mem);
> > @@ -589,17 +757,22 @@ static int vhost_user_set_mem_table(struct vhos=
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
> > @@ -764,7 +937,7 @@ static int vhost_set_vring_file(struct vhost_dev =
*dev,
> >                                  VhostUserRequest request,
> >                                  struct vhost_vring_file *file)
> >  {
> > -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> > +    int fds[VHOST_USER_MAX_RAM_SLOTS];
> >      size_t fd_num =3D 0;
> >      VhostUserMsg msg =3D {
> >          .hdr.request =3D request,
> > @@ -866,6 +1039,23 @@ static int vhost_user_get_features(struct vhost=
_dev *dev, uint64_t *features)
> >      return vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features=
);
> >  }
> > =20
> > +static int vhost_user_get_max_memslots(struct vhost_dev *dev,
> > +                                       uint64_t *max_memslots)
> > +{
> > +    uint64_t backend_max_memslots;
> > +    int err;
> > +
> > +    err =3D vhost_user_get_u64(dev, VHOST_USER_GET_MAX_MEM_SLOTS,
> > +                             &backend_max_memslots);
> > +    if (err < 0) {
> > +        return err;
> > +    }
> > +
> > +    *max_memslots =3D MIN(backend_max_memslots, VHOST_USER_MAX_RAM_S=
LOTS);
> > +
> > +    return *max_memslots;
> > +}
> > +
> >  static int vhost_user_set_owner(struct vhost_dev *dev)
> >  {
> >      VhostUserMsg msg =3D {
> > @@ -1439,6 +1629,24 @@ static int vhost_user_backend_init(struct vhos=
t_dev *dev, void *opaque)
> >                           "slave-req protocol features.");
> >              return -1;
> >          }
> > +
> > +        /* get max memory regions if backend supports configurable R=
AM slots */
> > +        if (!virtio_has_feature(dev->protocol_features,
> > +                                VHOST_USER_PROTOCOL_F_CONFIGURE_SLOT=
S)) {
> > +            u->memory_slots =3D VHOST_MEMORY_LEGACY_NREGIONS;
> > +        } else if (virtio_has_feature(dev->protocol_features,
> > +                           VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> > +            error_report("The VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS =
protocol "
> > +                         "feature is not supported when the "
> > +                         "VHOST_USER_PROTOCOL_F_REPLY_ACK features h=
as also "
> > +                         "been negotiated");
> > +            return -1;
> > +        } else {
> > +            err =3D vhost_user_get_max_memslots(dev, &u->memory_slot=
s);
> > +            if (err < 0) {
> > +                return err;
> > +            }
> > +        }
> >      }
> > =20
> >      if (dev->migration_blocker =3D=3D NULL &&
> > @@ -1502,7 +1710,9 @@ static int vhost_user_get_vq_index(struct vhost=
_dev *dev, int idx)
> > =20
> >  static int vhost_user_memslots_limit(struct vhost_dev *dev)
> >  {
> > -    return VHOST_MEMORY_MAX_NREGIONS;
> > +    struct vhost_user *u =3D dev->opaque;
> > +
> > +    return u->memory_slots;
> >  }
> > =20
> >  static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
> > --=20
> > 1.8.3.1
>=20
>=20

