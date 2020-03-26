Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32AEC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFB520714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="su4TbvnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFB520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQf7-0003z7-O0
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jHQeW-0003Xn-Vv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jHQeV-00039j-7U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:26:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jHQeU-00038s-UP
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:26:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id 26so7172706wmk.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nDcEZ6qoR/rOozwjBqKd7lzHWnwCqeCIBrMvVj8BIGM=;
 b=su4TbvnHPZ2nXeBx3i/9nTU7B53cpKjd3YQZdDsazF2gD/I0xAi/tuNOwK5sQX+d3f
 AIWp4cMG3JRVYOYdSJREJ03W27ooOmAZnNQSqpFXJEBpOIg7RvFlJ2mEgc3wF3R0dsHy
 kB73GTnPBWcCFrWNq6iqkkrdsUeiY7KyDJONnJS7mGW4vohpiKEXXPrj0xDjzSuvVkDa
 aGhivkwn9HNFm1DYPrkdJEk7DTZ2f15MsZZBcO87Fm7PyIkdJZEBdHnWhkJCfnXeiutG
 /xUD/1cayaa/+HgWxnB0LWjBkgfG0qAhREUtQaYrZ/Ec+6P+aPC/JCyHSW5rzPSATEj6
 S0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nDcEZ6qoR/rOozwjBqKd7lzHWnwCqeCIBrMvVj8BIGM=;
 b=aKYei6MoHhc1v/QP8UcF60PvVeIwq6W6POf3OdFFcDh+UULHSnluKE6Z2TANF2Tzmg
 HPE2Js/+TVJSRHDgTeW6ViRcEbldu1FLyaTzHZkjGBoRAy+wASXg5oUAQWMbW6vTEpPw
 uxVgtc1NWuFGSpyrKpLiyNjqCdA17evT/I1EQM9fKU9ZaPNTClRID1Cf/za5rDAgTrDb
 IZ1MeLG2k8KUgb+F/BekLqZidW5/ItxD+aSOuE7WBXBjzWcGYRvHZddtcNZGLqPagMLT
 L1P0b7Z4HJ9lokk5AAp2I2V9pppblYt92uFHkHy456xJoEP8EFLzk8sBG5fKoXzSYpfL
 8nLA==
X-Gm-Message-State: ANhLgQ3bJ/MskPRSUyKyVS9iAc4nqRT4ob5Us8fRb4/+5m1z4WmOQMwv
 h7qH+HpVPUbXcWpKnW9eLdhydVF+cTAkVV/Pzjo=
X-Google-Smtp-Source: ADFU+vt+Rkpi8p7utZTftcjaRRdV6zRenu1/bXEMxQpZRy8oPYKoqf5avVTKhtYYEXKcz2CO72pw1dySBOFuehJ6+h4=
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr2807677wmd.26.1585221981504; 
 Thu, 26 Mar 2020 04:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
In-Reply-To: <1585132506-13316-1-git-send-email-raphael.norwitz@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Mar 2020 12:26:09 +0100
Message-ID: <CAJ+F1C+siXi-stSq6O0+Kkg2z51wqKURAkjk2PQx1jpMNuVN+w@mail.gmail.com>
Subject: Re: [PATCH] Refactor vhost_user_set_mem_table functions
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 6:39 AM Raphael Norwitz
<raphael.norwitz@nutanix.com> wrote:
>
> vhost_user_set_mem_table() and vhost_user_set_mem_table_postcopy() have
> gotten convoluted, and have some identical code.
>
> This change moves the logic populating the VhostUserMemory struct and
> fds array from vhost_user_set_mem_table() and
> vhost_user_set_mem_table_postcopy() to a new function,
> vhost_user_fill_set_mem_table_msg().
>
> No functionality is impacted.
>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/virtio/vhost-user.c | 143 +++++++++++++++++++++++--------------------=
------
>  1 file changed, 67 insertions(+), 76 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 08e7e63..ec21e8f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -407,18 +407,79 @@ static int vhost_user_set_log_base(struct vhost_dev=
 *dev, uint64_t base,
>      return 0;
>  }
>
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
>
>      VhostUserMsg msg =3D {
> -        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
>
> @@ -433,48 +494,11 @@ static int vhost_user_set_mem_table_postcopy(struct=
 vhost_dev *dev,
>          u->region_rb_len =3D dev->mem->nregions;
>      }
>
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
>
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
>
>      VhostUserMsg msg =3D {
> -        .hdr.request =3D VHOST_USER_SET_MEM_TABLE,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
>
> @@ -567,42 +589,11 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
>
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
>
> -    msg.hdr.size =3D sizeof(msg.payload.memory.nregions);
> -    msg.hdr.size +=3D sizeof(msg.payload.memory.padding);
> -    msg.hdr.size +=3D fd_num * sizeof(VhostUserMemoryRegion);
> -
>      if (vhost_user_write(dev, &msg, fds, fd_num) < 0) {
>          return -1;
>      }
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

