Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3553C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C13206DB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYplOF3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C13206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIY3i-0000Wb-SN
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 09:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIY2o-0008VG-PE
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIY2n-0005TL-7J
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:32:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIY2n-0005Sx-2C
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585488724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IK3NAecskNvaW02IWiVG5Ofy2QobvrLB90ecnq3o/vs=;
 b=RYplOF3OWS6zshkDjCFSgdx/kRIT2u8D0w6F/74slKQKHqwB5L7XxDTWEI9ioX21qsqzl2
 ZzjYDB93vqbBf6l4nYOfnuVEPDuxxHlFVFpKXW8L8hM8dgEnx9N/cG3rXxA28jNifHNpVB
 pOLiwdeu2Jwox8VRSDrgK28VO8+vZnw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-4pt4OT5RMq-w8gmGsruXnw-1; Sun, 29 Mar 2020 09:32:02 -0400
X-MC-Unique: 4pt4OT5RMq-w8gmGsruXnw-1
Received: by mail-wr1-f69.google.com with SMTP id f8so8480867wrp.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 06:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q7bseOhrNfYH5QDL5LzEJ3wCK1IGUVYa9a2swqHlwPw=;
 b=lnkO2SnwRYU34QzLEvB+0IsQ3xdS2rk7L/538P7W9BMiY2xrUJH2b2vLM5jlTYnmYB
 C3c2JvLd1ma6G4PAPO8V4TnKR1mNobwAqUkuLSwdJEb0DySylTDoPv8LSACil1nZIvzA
 oNMc3jXhOGNnkxc27sKcpEZ949qmT7OV2z69msmzcITFK+ubunAo6qpEfT3SDUTCkEht
 BKIhFJBG3lTwqy+oeBx09kfdWs81Xb26xBQ31njKW/0HlOZvpHWcoJ0saACLb/+0Gvtd
 47btbnLsn7hqH0+W6RfLGyWkKN3kSArNDKUT4POogJb0i+QCHLPYDTBxSAI4sACjUtH/
 HfZg==
X-Gm-Message-State: ANhLgQ2uWHVopGTuH59qu36+sbWqRdUbMhB4xelhBqsmNvOLIeT62ZNb
 PFyS6I2hE1pyHwcSlUbS9DeE55HFO3qOJpNqL/bNq2AWp8138eaASnUy7Nq2QpyXOzbK57XC31Y
 gNZVLu3baibnaqjc=
X-Received: by 2002:a1c:8090:: with SMTP id b138mr8879350wmd.55.1585488721766; 
 Sun, 29 Mar 2020 06:32:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtyn+XZvjGkTBB711h7N5oYucS2VIRCrfdUe2qq6txWXuTrndqS0WZo/0uUFGBraiVPxeFJng==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr8879330wmd.55.1585488721464; 
 Sun, 29 Mar 2020 06:32:01 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id s15sm17127924wrt.16.2020.03.29.06.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 06:32:00 -0700 (PDT)
Date: Sun, 29 Mar 2020 09:31:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] Refactor vhost_user_set_mem_table functions
Message-ID: <20200329093125-mutt-send-email-mst@kernel.org>
References: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Wed, Mar 25, 2020 at 06:35:06AM -0400, Raphael Norwitz wrote:
> vhost_user_set_mem_table() and vhost_user_set_mem_table_postcopy() have
> gotten convoluted, and have some identical code.
>=20
> This change moves the logic populating the VhostUserMemory struct and
> fds array from vhost_user_set_mem_table() and
> vhost_user_set_mem_table_postcopy() to a new function,
> vhost_user_fill_set_mem_table_msg().
>=20
> No functionality is impacted.
>=20
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>


Thanks!

I'd like to queue it for merge after the release. If possible
please ping me after the release to help make sure it didn't get
dropped.


> ---
>  hw/virtio/vhost-user.c | 143 +++++++++++++++++++++++--------------------=
------
>  1 file changed, 67 insertions(+), 76 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 08e7e63..ec21e8f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -407,18 +407,79 @@ static int vhost_user_set_log_base(struct vhost_dev=
 *dev, uint64_t base,
>      return 0;
>  }
> =20
> +static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
> +                                             struct vhost_dev *dev,
> +                                             VhostUserMsg *msg,
> +                                             int *fds, size_t *fd_num,
> +                                             bool track_ramblocks)
> +{
> +    int i, fd;
> +    ram_addr_t offset;
> +    MemoryRegion *mr;
> +    struct vhost_memory_region *reg;
> +
> +    msg->hdr.request =3D VHOST_USER_SET_MEM_TABLE;
> +
> +    for (i =3D 0; i < dev->mem->nregions; ++i) {
> +        reg =3D dev->mem->regions + i;
> +
> +        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> +        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
> +                                     &offset);
> +        fd =3D memory_region_get_fd(mr);
> +        if (fd > 0) {
> +            if (track_ramblocks) {
> +                assert(*fd_num < VHOST_MEMORY_MAX_NREGIONS);
> +                trace_vhost_user_set_mem_table_withfd(*fd_num, mr->name,
> +                                                      reg->memory_size,
> +                                                      reg->guest_phys_ad=
dr,
> +                                                      reg->userspace_add=
r,
> +                                                      offset);
> +                u->region_rb_offset[i] =3D offset;
> +                u->region_rb[i] =3D mr->ram_block;
> +            } else if (*fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> +                error_report("Failed preparing vhost-user memory table m=
sg");
> +                return -1;
> +            }
> +            msg->payload.memory.regions[*fd_num].userspace_addr =3D
> +                reg->userspace_addr;
> +            msg->payload.memory.regions[*fd_num].memory_size =3D
> +                reg->memory_size;
> +            msg->payload.memory.regions[*fd_num].guest_phys_addr =3D
> +                reg->guest_phys_addr;
> +            msg->payload.memory.regions[*fd_num].mmap_offset =3D offset;
> +            fds[(*fd_num)++] =3D fd;
> +        } else if (track_ramblocks) {
> +            u->region_rb_offset[i] =3D 0;
> +            u->region_rb[i] =3D NULL;
> +        }
> +    }
> +
> +    msg->payload.memory.nregions =3D *fd_num;
> +
> +    if (!*fd_num) {
> +        error_report("Failed initializing vhost-user memory map, "
> +                     "consider using -object memory-backend-file share=
=3Don");
> +        return -1;
> +    }
> +
> +    msg->hdr.size =3D sizeof(msg->payload.memory.nregions);
> +    msg->hdr.size +=3D sizeof(msg->payload.memory.padding);
> +    msg->hdr.size +=3D *fd_num * sizeof(VhostUserMemoryRegion);
> +
> +    return 1;
> +}
> +
>  static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>                                               struct vhost_memory *mem)
>  {
>      struct vhost_user *u =3D dev->opaque;
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> -    int i, fd;
>      size_t fd_num =3D 0;
>      VhostUserMsg msg_reply;
>      int region_i, msg_i;
> =20
>      VhostUserMsg msg =3D {
> -        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
> =20
> @@ -433,48 +494,11 @@ static int vhost_user_set_mem_table_postcopy(struct=
 vhost_dev *dev,
>          u->region_rb_len =3D dev->mem->nregions;
>      }
> =20
> -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> -        ram_addr_t offset;
> -        MemoryRegion *mr;
> -
> -        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> -        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
> -                                     &offset);
> -        fd =3D memory_region_get_fd(mr);
> -        if (fd > 0) {
> -            assert(fd_num < VHOST_MEMORY_MAX_NREGIONS);
> -            trace_vhost_user_set_mem_table_withfd(fd_num, mr->name,
> -                                                  reg->memory_size,
> -                                                  reg->guest_phys_addr,
> -                                                  reg->userspace_addr, o=
ffset);
> -            u->region_rb_offset[i] =3D offset;
> -            u->region_rb[i] =3D mr->ram_block;
> -            msg.payload.memory.regions[fd_num].userspace_addr =3D
> -                reg->userspace_addr;
> -            msg.payload.memory.regions[fd_num].memory_size  =3D reg->mem=
ory_size;
> -            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> -                reg->guest_phys_addr;
> -            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> -            fds[fd_num++] =3D fd;
> -        } else {
> -            u->region_rb_offset[i] =3D 0;
> -            u->region_rb[i] =3D NULL;
> -        }
> -    }
> -
> -    msg.payload.memory.nregions =3D fd_num;
> -
> -    if (!fd_num) {
> -        error_report("Failed initializing vhost-user memory map, "
> -                     "consider using -object memory-backend-file share=
=3Don");
> +    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
> +                                          true) < 0) {
>          return -1;
>      }
> =20
> -    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
> -    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
> -    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
> -
>      if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
>          return -1;
>      }
> @@ -545,7 +569,6 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
>  {
>      struct vhost_user *u =3D dev->opaque;
>      int fds[VHOST_MEMORY_MAX_NREGIONS];
> -    int i, fd;
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
>      bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> @@ -559,7 +582,6 @@ static int vhost_user_set_mem_table(struct vhost_dev =
*dev,
>      }
> =20
>      VhostUserMsg msg =3D {
> -        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
> =20
> @@ -567,42 +589,11 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
> =20
> -    for (i =3D 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg =3D dev->mem->regions + i;
> -        ram_addr_t offset;
> -        MemoryRegion *mr;
> -
> -        assert((uintptr_t)reg->userspace_addr =3D=3D reg->userspace_addr=
);
> -        mr =3D memory_region_from_host((void *)(uintptr_t)reg->userspace=
_addr,
> -                                     &offset);
> -        fd =3D memory_region_get_fd(mr);
> -        if (fd > 0) {
> -            if (fd_num =3D=3D VHOST_MEMORY_MAX_NREGIONS) {
> -                error_report("Failed preparing vhost-user memory table m=
sg");
> -                return -1;
> -            }
> -            msg.payload.memory.regions[fd_num].userspace_addr =3D
> -                reg->userspace_addr;
> -            msg.payload.memory.regions[fd_num].memory_size  =3D reg->mem=
ory_size;
> -            msg.payload.memory.regions[fd_num].guest_phys_addr =3D
> -                reg->guest_phys_addr;
> -            msg.payload.memory.regions[fd_num].mmap_offset =3D offset;
> -            fds[fd_num++] =3D fd;
> -        }
> -    }
> -
> -    msg.payload.memory.nregions =3D fd_num;
> -
> -    if (!fd_num) {
> -        error_report("Failed initializing vhost-user memory map, "
> -                     "consider using -object memory-backend-file share=
=3Don");
> +    if (vhost_user_fill_set_mem_table_msg(u, dev, &msg, fds, &fd_num,
> +                                          false) < 0) {
>          return -1;
>      }
> =20
> -    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
> -    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
> -    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
> -
>      if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
>          return -1;
>      }
> --=20
> 1.8.3.1


