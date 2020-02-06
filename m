Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080FC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98CB9206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 08:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVLwtEgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CB9206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izcQz-0005dF-OJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 03:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1izcQ4-0004gt-2C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1izcQ2-0003Un-H9
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52505
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1izcQ2-0003Ry-BT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580977309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qY9MIor2o64fB1dHHfvmRyO4ev47FJmEMKzoFePzoz8=;
 b=jVLwtEgW42/dLI0BWCPbM1GZibToQWlM3KvNBBO6oaWjUo6XYTW4CT+CYA+y241ieTK5Mv
 1fvlCizbPcf49y05fTB07zHNMQik/xDJTLiMb88IVKjV/K9WaDmHgeNkajeAOEcdlcAP3b
 DetAYkgB6+ZDcnmTWGVCjuznU6iLRDA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-zo1o4E_TNku3teiOIpIbIQ-1; Thu, 06 Feb 2020 03:21:47 -0500
Received: by mail-qv1-f72.google.com with SMTP id v3so3246034qvm.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 00:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v2tnri4h8bSQUTRGrcXbd3cS02r41FabQCFyKkbpt1A=;
 b=U69khG9yNdbsGnSNnNEZqP0nBTZQJItoXix6dfIpp6kE9FBUUACffVOlNai1mP9t8O
 dAjxgc7fXbca5aeI2UlYfHDGMHGn1QML9vmAfcTrPUZX6mn+NK9qRwpCu80fKLv/SQPH
 nrIG7oYhdaV9lpxqdqymhtVLRU6/QbENeAAqfHCeRQkBJ5Qp7eZhJ/O7Lv5JrkLCuwZS
 zhKcvoPgyOeDbhvPnqKguBTPEJ5tvjCeJyexyA0mTCTXl5PqMbz/P6MRwz23eyMGdhrO
 mESWVsTbMFHQwZ6yQ516kPV19X+Se49hQrToYcz2Zi5FjLi38rjUc/yQetHwIPPM/zru
 pMww==
X-Gm-Message-State: APjAAAVMD63D1PVewdQpdo82SRm1QLZzkJwHqSoCGg0nQiRg8zcP0xvX
 DNbleXBSsevVKyIdv7CCzMHAS+VLu2OpdXDoz6jx8lTXWY51ltJVjUW8HFSH2fvYetv3WgSUc+T
 VyJPIgKRv6uAovjU=
X-Received: by 2002:a37:a54b:: with SMTP id o72mr1345203qke.489.1580977307021; 
 Thu, 06 Feb 2020 00:21:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXjLh8+/6qWKEve/aO6x+92+nDwvsIki7RpLi4M8BclZ8IGefo4LUtruUWnfwR7rNoRwmt2A==
X-Received: by 2002:a37:a54b:: with SMTP id o72mr1345191qke.489.1580977306746; 
 Thu, 06 Feb 2020 00:21:46 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id b24sm1247517qto.71.2020.02.06.00.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 00:21:45 -0800 (PST)
Date: Thu, 6 Feb 2020 03:21:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v2 2/3] Refactor vhost_user_set_mem_table functions
Message-ID: <20200206032007-mutt-send-email-mst@kernel.org>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-3-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1579143426-18305-3-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: zo1o4E_TNku3teiOIpIbIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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

On Wed, Jan 15, 2020 at 09:57:05PM -0500, Raphael Norwitz wrote:
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


Looks ok, but just cosmetics: let's have the flag say what
it does, not who uses it.

So s/postcopy/track_ramblocks/ ?


> ---
>  hw/virtio/vhost-user.c | 143 +++++++++++++++++++++++--------------------=
------
>  1 file changed, 67 insertions(+), 76 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cce851a..af83fdd 100644
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
> +                                             bool postcopy)
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
> +            if (postcopy) {
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
> +        } else if (postcopy) {
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


