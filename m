Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2351CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A1C206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TAB2Y6wA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A1C206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcbY-0002qd-UA
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izcag-0002PL-Pa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izcae-0001U5-6f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:32:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izcad-0001O7-Ux
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/L7JcgWxiALqoHhpQWJbHuWyH5Ys85bEUjNRkmZzD1Y=;
 b=TAB2Y6wASviAopwk9Je4zGcGdqCdNjAH0UxFOWJayfMR3Etyia4rzTi7idf/XQxK8BKF3B
 kO8YGExJYunKEZV3rR2OUMOE/VPcW5A+oODdc9MF2t3qVf6N0tbcDt8utB9Z4XoelqP4Ud
 K5x7abV4Lvy9xyfEeCJtdrw2iVMYlg0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-UyGB2JKOOUGFWPisA8plmA-1; Thu, 06 Feb 2020 03:32:45 -0500
Received: by mail-qk1-f200.google.com with SMTP id 24so3071102qka.16
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:32:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xRmCPl33q5wApiK/kJGosKnS8m9y/HTMv1nvSgjjcKI=;
 b=c2nFj0DwmpP/sstbmlDa8CmiJb/hFXXVl7fwhfh7VLV9m/Eo0toy7FCSch4YPLZIPT
 uKwjVoyafgo9YluSeEmp79ERfS3QJZi9WgsWUCb4TN68OF6g1v25o7TPh5enloVd8stg
 d05LRxscCg4RTFOmO8qOU/WavzQkbPAAVoyoVXIeHi5lj/fjvoo9mgIywTirI1sVAD9Y
 6NEunA9SGrxi3bNweomOGoxjs5gGbhOkhXIB3KtUkDcZZR/DeiuJDIT9HWraACP6WQDU
 IuZolNFWVXmuG9n9q5MRJod/0eOHgAdQHY5uiyKCtHJ8kWHiXiMWDsRu8wToN4i5ujZP
 XocQ==
X-Gm-Message-State: APjAAAVRDZX25CgOqmE9K3oH4bI1lNeCNB/FfdjFHM7B8RP9Qu9umjaF
 7xefna/IS6YYK4KTTLJw4BBSThd5O7qyMGYgjfASA02VbAoJHTchLh9hz3xa1QliXRbwYPpPGHb
 t85HZQzWBoJ3T+Ks=
X-Received: by 2002:a05:620a:145c:: with SMTP id
 i28mr1569502qkl.30.1580977964464; 
 Thu, 06 Feb 2020 00:32:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/iOR7XMWciP+jO/gZ1vg8GDyvlmjno7jqQ4KPuZNsezpqaLhIJ5CC+1DTKOFR6dqQ7E/YPg==
X-Received: by 2002:a05:620a:145c:: with SMTP id
 i28mr1569466qkl.30.1580977963870; 
 Thu, 06 Feb 2020 00:32:43 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id r1sm1278936qtu.83.2020.02.06.00.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 00:32:42 -0800 (PST)
Date: Thu, 6 Feb 2020 03:32:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 3/3] Lift max memory slots limit imposed by vhost-user
Message-ID: <20200206032332-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-4-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1579143426-18305-4-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: UyGB2JKOOUGFWPisA8plmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>, raphael.s.norwitz@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 09:57:06PM -0500, Raphael Norwitz wrote:
> The current vhost-user implementation in Qemu imposes a limit on the
> maximum number of memory slots exposed to a VM using a vhost-user
> device. This change provides a new protocol feature
> VHOST_USER_F_CONFIGURE_SLOTS which, when enabled, lifts this limit and
> allows a VM with a vhost-user device to expose a configurable number of
> memory slots, up to the ACPI defined maximum. Existing backends which
> do not support this protocol feature are unaffected.

Hmm ACPI maximum seems to be up to 512 - is this too much to fit in a
single message?  So can't we just increase the number (after negotiating
with remote) and be done with it, instead of add/remove?  Or is there
another reason to prefer add/remove?

>=20
> This feature works by using three new messages,
> VHOST_USER_GET_MAX_MEM_SLOTS, VHOST_USER_ADD_MEM_REG and
> VHOST_USER_REM_MEM_REG. VHOST_USER_GET_MAX_MEM_SLOTS gets the
> number of memory slots the backend is willing to accept when the
> backend is initialized. Then, when the memory tables are set or updated,
> a series of VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG messages
> are sent to transmit the regions to map and/or unmap instead of trying
> to send all the regions in one fixed size VHOST_USER_SET_MEM_TABLE
> message.
>=20
> The vhost_user struct maintains a shadow state of the VM=E2=80=99s memory
> regions. When the memory tables are modified, the
> vhost_user_set_mem_table() function compares the new device memory state
> to the shadow state and only sends regions which need to be unmapped or
> mapped in. The regions which must be unmapped are sent first, followed
> by the new regions to be mapped in. After all the messages have been
> sent, the shadow state is set to the current virtual device state.
>=20
> The current feature implementation does not work with postcopy migration
> and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK feature has
> also been negotiated.

Hmm what would it take to lift the restrictions?
conflicting features like this makes is very hard for users to make
an informed choice what to support.


> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> Suggested-by: Mike Cui <cui@nutanix.com>
> ---
>  docs/interop/vhost-user.rst |  43 ++++++++
>  hw/virtio/vhost-user.c      | 254 ++++++++++++++++++++++++++++++++++++++=
++----
>  2 files changed, 275 insertions(+), 22 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5f8b3a4..ae9acf2 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -786,6 +786,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
>    #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
> +  #define VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS   14
> =20
>  Master message types
>  --------------------
> @@ -1205,6 +1206,48 @@ Master message types
>    Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
>    feature is set by the backend.
> =20
> +``VHOST_USER_GET_MAX_MEM_SLOTS``
> +  :id: 35
> +  :equivalent ioctl: N/A
> +  :slave payload: u64
> +
> +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
> +  successfully negotiated, this message is submitted by master to the
> +  slave. The slave should return the message with a u64 payload
> +  containing the maximum number of memory slots for QEMU to expose to
> +  the guest. This message is not supported with postcopy migration or if
> +  the VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
> +
> +``VHOST_USER_ADD_MEM_REG``
> +  :id: 36
> +  :equivalent ioctl: N/A
> +  :slave payload: memory region
> +
> +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
> +  successfully negotiated, this message is submitted by master to the sl=
ave.
> +  The message payload contains a memory region descriptor struct, descri=
bing
> +  a region of guest memory which the slave device must map in. When the
> +  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been succes=
sfully
> +  negotiated, along with the VHOST_USER_REM_MEM_REG message, this messag=
e is
> +  used to set and update the memory tables of the slave device. This mes=
sage
> +  is not supported with postcopy migration or if the
> +  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
> +
> +``VHOST_USER_REM_MEM_REG``
> +  :id: 37
> +  :equivalent ioctl: N/A
> +  :slave payload: memory region
> +
> +  When the VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has be=
en
> +  successfully negotiated, this message is submitted by master to the sl=
ave.
> +  The message payload contains a memory region descriptor struct, descri=
bing
> +  a region of guest memory which the slave device must unmap. When the
> +  VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS protocol feature has been succes=
sfully
> +  negotiated, along with the VHOST_USER_ADD_MEM_REG message, this messag=
e is
> +  used to set and update the memory tables of the slave device. This mes=
sage
> +  is not supported with postcopy migration or if the
> +  VHOST_USER_PROTOCOL_F_REPLY_ACK feature has also been negotiated.
> +
>  Slave message types
>  -------------------
> =20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index af83fdd..fed6d02 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -35,11 +35,29 @@
>  #include <linux/userfaultfd.h>
>  #endif
> =20
> -#define VHOST_MEMORY_MAX_NREGIONS    8
> +#define VHOST_MEMORY_LEGACY_NREGIONS    8

Hardly legacy when this is intended to always be used e.g. with
postcopy, right?

>  #define VHOST_USER_F_PROTOCOL_FEATURES 30
>  #define VHOST_USER_SLAVE_MAX_FDS     8
> =20
>  /*
> + * Set maximum number of RAM slots supported to
> + * the maximum number supported by the target
> + * hardware plaform.
> + */
> +#if defined(TARGET_X86) || defined(TARGET_X86_64) || \
> +    defined(TARGET_ARM) || defined(TARGET_ARM_64)
> +#include "hw/acpi/acpi.h"
> +#define VHOST_USER_MAX_RAM_SLOTS ACPI_MAX_RAM_SLOTS
> +
> +#elif defined(TARGET_PPC) || defined(TARGET_PPC_64)
> +#include "hw/ppc/spapr.h"
> +#define VHOST_USER_MAX_RAM_SLOTS SPAPR_MAX_RAM_SLOTS
> +
> +#else
> +#define VHOST_USER_MAX_RAM_SLOTS 512
> +#endif
> +
> +/*
>   * Maximum size of virtio device config space
>   */
>  #define VHOST_USER_MAX_CONFIG_SIZE 256
> @@ -59,6 +77,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
>      VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
> +    VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS =3D 14,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> =20
> @@ -100,6 +119,9 @@ typedef enum VhostUserRequest {
>      VHOST_USER_SET_INFLIGHT_FD =3D 32,
>      VHOST_USER_GPU_SET_SOCKET =3D 33,
>      VHOST_USER_RESET_DEVICE =3D 34,
> +    VHOST_USER_GET_MAX_MEM_SLOTS =3D 35,
> +    VHOST_USER_ADD_MEM_REG =3D 36,
> +    VHOST_USER_REM_MEM_REG =3D 37,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -121,9 +143,14 @@ typedef struct VhostUserMemoryRegion {
>  typedef struct VhostUserMemory {
>      uint32_t nregions;
>      uint32_t padding;
> -    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
> +    VhostUserMemoryRegion regions[VHOST_MEMORY_LEGACY_NREGIONS];
>  } VhostUserMemory;
> =20
> +typedef struct VhostUserMemRegMsg {
> +    uint32_t padding;
> +    VhostUserMemoryRegion region;
> +} VhostUserMemRegMsg;
> +
>  typedef struct VhostUserLog {
>      uint64_t mmap_size;
>      uint64_t mmap_offset;
> @@ -182,6 +209,7 @@ typedef union {
>          struct vhost_vring_state state;
>          struct vhost_vring_addr addr;
>          VhostUserMemory memory;
> +        VhostUserMemRegMsg mem_reg;
>          VhostUserLog log;
>          struct vhost_iotlb_msg iotlb;
>          VhostUserConfig config;
> @@ -210,7 +238,7 @@ struct vhost_user {
>      int slave_fd;
>      NotifierWithReturn postcopy_notifier;
>      struct PostCopyFD  postcopy_fd;
> -    uint64_t           postcopy_client_bases[VHOST_MEMORY_MAX_NREGIONS];
> +    uint64_t           postcopy_client_bases[VHOST_USER_MAX_RAM_SLOTS];
>      /* Length of the region_rb and region_rb_offset arrays */
>      size_t             region_rb_len;
>      /* RAMBlock associated with a given region */
> @@ -222,6 +250,13 @@ struct vhost_user {
> =20
>      /* True once we've entered postcopy_listen */
>      bool               postcopy_listen;
> +
> +    /* Maximum number of RAM slots supported by the backend */
> +    uint64_t memory_slots;
> +
> +    /* Our current regions */
> +    int num_shadow_regions;
> +    VhostUserMemoryRegion shadow_regions[VHOST_USER_MAX_RAM_SLOTS];
>  };
> =20
>  static bool ioeventfd_enabled(void)
> @@ -370,7 +405,7 @@ int vhost_user_gpu_set_socket(struct vhost_dev *dev, =
int fd)
>  static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>                                     struct vhost_log *log)
>  {
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
>      bool shmfd =3D virtio_has_feature(dev->protocol_features,
>                                      VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> @@ -429,7 +464,7 @@ static int vhost_user_fill_set_mem_table_msg(struct v=
host_user *u,
>          fd =3D memory_region_get_fd(mr);
>          if (fd > 0) {
>              if (postcopy) {
> -                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
> +                assert(*fd_num < VHOST_MEMORY_LEGACY_NREGIONS);
>                  trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
>                                                        reg->memory_size,
>                                                        reg->guest_phys_ad=
dr,
> @@ -437,7 +472,7 @@ static int vhost_user_fill_set_mem_table_msg(struct v=
host_user *u,
>                                                        offset);
>                  u->region_rb_offset[i] =3D offset;
>                  u->region_rb[i] =3D mr->ram_block;
> -            } else if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> +            } else if (*fd_num =3D=3D VHOST_MEMORY_LEGACY_NREGIONS) {
>                  error_report("Failed preparing vhost-user memory table m=
sg");
>                  return -1;
>              }
> @@ -474,7 +509,7 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
>                                               struct vhost_memory *mem)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
>      size_t fd_num =3D 0;
>      VhostUserMsg msg_reply;
>      int region_i, msg_i;
> @@ -523,7 +558,7 @@ static int vhost_user_set_mem_table_postcopy(struct v=
host_dev *dev,
>      }
> =20
>      memset(u->postcopy_client_bases, 0,
> -           sizeof(uint64_t) * VHOST_MEMORY_MAX_NREGIONS);
> +           sizeof(uint64_t) * VHOST_USER_MAX_RAM_SLOTS);
> =20
>      /* They're in the same order as the regions that were sent
>       * but some of the regions were skipped (above) if they
> @@ -564,18 +599,151 @@ static int vhost_user_set_mem_table_postcopy(struc=
t vhost_dev *dev,
>      return 0;
>  }
> =20
> +static inline bool reg_equal(VhostUserMemoryRegion *shadow_reg,
> +                             struct vhost_memory_region *vdev_reg)
> +{
> +    if (shadow_reg->guest_phys_addr =3D=3D vdev_reg->guest_phys_addr &&
> +        shadow_reg->userspace_addr =3D=3D vdev_reg->userspace_addr &&
> +        shadow_reg->memory_size =3D=3D vdev_reg->memory_size) {
> +        return true;
> +    } else {
> +        return false;
> +    }
> +}
> +
> +static int vhost_user_send_add_remove_regions(struct vhost_dev *dev,
> +                                              struct vhost_memory *mem,
> +                                              VhostUserMsg *msg)
> +{
> +    struct vhost_user *u =3D dev->opaque;
> +    int i, j, fd;
> +    bool found[VHOST_USER_MAX_RAM_SLOTS] =3D {};
> +    bool matching =3D false;
> +    struct vhost_memory_region *reg;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +
> +    /*
> +     * Ensure the VHOST_USER_PROTOCOL_F_REPLY_ACK has not been
> +     * negotiated and no postcopy migration is in progress.
> +     */
> +    assert(!virtio_has_feature(dev->protocol_features,
> +                               VHOST_USER_PROTOCOL_F_REPLY_ACK));
> +    if (u->postcopy_listen && u->postcopy_fd.handler) {
> +        error_report("Postcopy migration is not supported when the "
> +                     "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feature "
> +                     "has been negotiated");
> +        return -1;
> +    }
> +
> +    msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding);
> +    msg->hdr.size +=3D sizeof(VhostUserMemoryRegion);
> +
> +    /*
> +     * Send VHOST_USER_REM_MEM_REG for memory regions in our shadow stat=
e
> +     * which are not found not in the device's memory state.

double negation - could not parse this.

> +     */
> +    for (i =3D 0; i < u->num_shadow_regions; ++i) {
> +        reg =3D dev->mem->regions;
> +
> +        for (j =3D 0; j < dev->mem->nregions; j++) {
> +            reg =3D dev->mem->regions + j;
> +
> +            assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_=
addr);
> +            mr =3D memory_region_from_host((void *)(uintptr_t)reg->users=
pace_addr,
> +                                         &offset);
> +            fd =3D memory_region_get_fd(mr);
> +
> +            if (reg_equal(&u->shadow_regions[i], reg)) {
> +                matching =3D true;
> +                found[j] =3D true;
> +                break;
> +            }
> +        }
> +
> +        if (fd > 0 && !matching) {
> +            msg->hdr.request =3D VHOST_USER_REM_MEM_REG;
> +            msg->payload.mem_reg.region.userspace_addr =3D reg->userspac=
e_addr;
> +            msg->payload.mem_reg.region.memory_size =3D reg->memory_size=
;
> +            msg->payload.mem_reg.region.guest_phys_addr =3D
> +                reg->guest_phys_addr;
> +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> +
> +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> +                return -1;
> +            }
> +        }
> +    }
> +
> +    /*
> +     * Send messages to add regions present in the device which are not
> +     * in our shadow state.
> +     */
> +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> +        reg =3D dev->mem->regions + i;
> +
> +        /*
> +         * If the region was in both the shadow and vdev state we don't
> +         * need to send a VHOST_USER_ADD_MEM_REG message for it.
> +         */
> +        if (found[i]) {
> +            continue;
> +        }
> +
> +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> +        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
> +                                     &offset);
> +        fd =3D memory_region_get_fd(mr);
> +
> +        if (fd > 0) {
> +            msg->hdr.request =3D VHOST_USER_ADD_MEM_REG;
> +            msg->payload.mem_reg.region.userspace_addr =3D reg->userspac=
e_addr;
> +            msg->payload.mem_reg.region.memory_size =3D reg->memory_size=
;
> +            msg->payload.mem_reg.region.guest_phys_addr =3D
> +                reg->guest_phys_addr;
> +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> +
> +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> +                return -1;
> +            }
> +        }
> +    }
> +
> +    /* Make our shadow state match the updated device state. */
> +    u->num_shadow_regions =3D dev->mem->nregions;
> +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> +        reg =3D dev->mem->regions + i;
> +        u->shadow_regions[i].guest_phys_addr =3D reg->guest_phys_addr;
> +        u->shadow_regions[i].userspace_addr =3D reg->userspace_addr;
> +        u->shadow_regions[i].memory_size =3D reg->memory_size;
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_user_set_mem_table(struct vhost_dev *dev,
>                                      struct vhost_memory *mem)
>  {
>      struct vhost_user *u =3D dev->opaque;
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_MEMORY_LEGACY_NREGIONS];
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported =3D virtio_has_feature(dev->protocol_features,
>                                                VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool config_slots =3D
> +        virtio_has_feature(dev->protocol_features,
> +                           VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS);
> =20
>      if (do_postcopy) {
> -        /* Postcopy has enough differences that it's best done in it's o=
wn
> +        if (config_slots) {
> +            error_report("Postcopy migration not supported with "
> +                         "VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS feature =
"
> +                         "enabled.");
> +            return -1;
> +        }
> +
> +        /*
> +         * Postcopy has enough differences that it's best done in it's o=
wn
>           * version
>           */
>          return vhost_user_set_mem_table_postcopy(dev, mem);
> @@ -589,17 +757,22 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
> =20
> -    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
> -                                          false) < 0) {
> -        return -1;
> -    }
> -
> -    if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> -        return -1;
> -    }
> +    if (config_slots && !reply_supported) {
> +        if (vhost_user_send_add_remove_regions(dev, mem, &msg) < 0) {
> +            return -1;
> +        }
> +    } else {
> +        if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num=
,
> +                                              false) < 0) {
> +            return -1;
> +        }
> +        if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
> +            return -1;
> +        }
> =20
> -    if (reply_supported) {
> -        return process_message_reply(dev, &msg);
> +        if (reply_supported) {
> +            return process_message_reply(dev, &msg);
> +        }
>      }
> =20
>      return 0;
> @@ -764,7 +937,7 @@ static int vhost_set_vring_file(struct vhost_dev *dev=
,
>                                  VhostUserRequest request,
>                                  struct vhost_vring_file *file)
>  {
> -    int fds[VHOST_MEMORY_MAX_NREGIONS];
> +    int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D request,
> @@ -866,6 +1039,23 @@ static int vhost_user_get_features(struct vhost_dev=
 *dev, uint64_t *features)
>      return vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features);
>  }
> =20
> +static int vhost_user_get_max_memslots(struct vhost_dev *dev,
> +                                       uint64_t *max_memslots)
> +{
> +    uint64_t backend_max_memslots;
> +    int err;
> +
> +    err =3D vhost_user_get_u64(dev, VHOST_USER_GET_MAX_MEM_SLOTS,
> +                             &backend_max_memslots);
> +    if (err < 0) {
> +        return err;
> +    }
> +
> +    *max_memslots =3D MIN(backend_max_memslots, VHOST_USER_MAX_RAM_SLOTS=
);
> +
> +    return *max_memslots;
> +}
> +
>  static int vhost_user_set_owner(struct vhost_dev *dev)
>  {
>      VhostUserMsg msg =3D {
> @@ -1439,6 +1629,24 @@ static int vhost_user_backend_init(struct vhost_de=
v *dev, void *opaque)
>                           "slave-req protocol features.");
>              return -1;
>          }
> +
> +        /* get max memory regions if backend supports configurable RAM s=
lots */
> +        if (!virtio_has_feature(dev->protocol_features,
> +                                VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS)) =
{
> +            u->memory_slots =3D VHOST_MEMORY_LEGACY_NREGIONS;
> +        } else if (virtio_has_feature(dev->protocol_features,
> +                           VHOST_USER_PROTOCOL_F_REPLY_ACK)) {
> +            error_report("The VHOST_USER_PROTOCOL_F_CONFIGURE_SLOTS prot=
ocol "
> +                         "feature is not supported when the "
> +                         "VHOST_USER_PROTOCOL_F_REPLY_ACK features has a=
lso "
> +                         "been negotiated");
> +            return -1;
> +        } else {
> +            err =3D vhost_user_get_max_memslots(dev, &u->memory_slots);
> +            if (err < 0) {
> +                return err;
> +            }
> +        }
>      }
> =20
>      if (dev->migration_blocker =3D=3D NULL &&
> @@ -1502,7 +1710,9 @@ static int vhost_user_get_vq_index(struct vhost_dev=
 *dev, int idx)
> =20
>  static int vhost_user_memslots_limit(struct vhost_dev *dev)
>  {
> -    return VHOST_MEMORY_MAX_NREGIONS;
> +    struct vhost_user *u =3D dev->opaque;
> +
> +    return u->memory_slots;
>  }
> =20
>  static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
> --=20
> 1.8.3.1


