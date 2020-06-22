Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E430BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F6E620716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So5wF7I/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F6E620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnU3t-0003tO-1j
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 17:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnU13-0001jI-Qj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:30:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51650
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jnU11-0004hX-A5
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 17:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592861406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CeoeAEHPF4sShm98K9gBUe8aicHiSzE142I02lJm3R4=;
 b=So5wF7I/GZs+xIoRgKB+7hQJkzNHSCDAr9nzJwxN/LSpS1oaylcsPD6w2ap2An04eaOfju
 X8ILIu0zgvOcmtrq9gkC0NeyCq38JlbAez2uzPrlJkBx3XP4/5CRbVstKA78+fDHeoPs3N
 Zp82N+WwuI7Rw68rlHoCkWwnka5IpyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-iE_kQ4ulPiqkO-031JVmdQ-1; Mon, 22 Jun 2020 17:30:04 -0400
X-MC-Unique: iE_kQ4ulPiqkO-031JVmdQ-1
Received: by mail-wr1-f71.google.com with SMTP id m14so11860956wrj.12
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 14:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CeoeAEHPF4sShm98K9gBUe8aicHiSzE142I02lJm3R4=;
 b=t2R8cjrwiBhKqPj+7K4Qjrd8uOhRiv7DdIjXgXbJ4N+0MbRdqThfAm7fFloUpJf/3E
 8VMlf4hL3NhYZ0WaPZj0ULgd9cLMAknXfbqI6X39gkuVBX1paZvpOreJooPd/qBKwbu7
 Yfubd2eGmeqeIllgIdEM5amVv+i8MXrY7fcnxjSU3bka5M3T9JlQvq8yxw/0LOstoceW
 M1oPk5ZRjoiKq8LY7wxy/tNepNusSpCr4D1J/bTItpNGIjqcB2tCIFXZisIte+hq95OK
 XpfOCPzFsFtVPJkNpYsG77u0CSSiw0ZzfA2CLci84BpgDfwQqpgr4cx+hOI1Ekn4TsJv
 VKcw==
X-Gm-Message-State: AOAM5319Ck/trUwCuoJjGgK9g33uy8DdcEr5PgrB10GH4VC/T6NTh4pn
 3D8l7fuF8nBEtXjIMCp85yDPRL1aNsNaleGu1YC3GGShT3mSDM7FrIqNaX/3x8SC2l4tRK2JhuI
 IcCN6OoI7BZDeeNM=
X-Received: by 2002:adf:f450:: with SMTP id f16mr21411358wrp.307.1592861403626; 
 Mon, 22 Jun 2020 14:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRR/ZmrevwkroykiveACCjEtuOkQGbqOrLWXyN7lSjUtd/LuaIC6TV7nsH1JYl1Lxg8D9vDw==
X-Received: by 2002:adf:f450:: with SMTP id f16mr21411325wrp.307.1592861403289; 
 Mon, 22 Jun 2020 14:30:03 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id g195sm957498wme.38.2020.06.22.14.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 14:30:02 -0700 (PDT)
Date: Mon, 22 Jun 2020 17:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH] Stop vhost-user sending uninitialized mmap_offsets
Message-ID: <20200622172940-mutt-send-email-mst@kernel.org>
References: <1592637581-25255-1-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1592637581-25255-1-git-send-email-raphael.norwitz@nutanix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 06:41:39PM +0000, Raphael Norwitz wrote:
> Prior to this change, the vhost_user_fill_msg_region function filled out
> all elements of the VhostUserMemoryRegion struct except the mmap_offset.
> 
> This function is often called on uninitialized structs, which are then
> copied into VHOST_USER_SET_MEM_TABLE and VHOST_USER_ADD/REM_MEM_REG
> messages. In some cases, where the mmap_offset was not needed, it was
> left uninitialized, causing QEMU to send the backend uninitialized data,
> which Coverity flagged as a series of issues.
> 
> This change augments the vhost_user_fill_msg_region API, adding a
> mmap_offset paramenter, forcing the caller to initialize mmap_offset.
> 
> Fixes: CID-1429802, CID-1429803, CID-1429804


Add commit hash of the buggy commit pls.

> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  hw/virtio/vhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 4d6cd4e..3123121 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -460,12 +460,14 @@ static MemoryRegion *vhost_user_get_mr_data(uint64_t addr, ram_addr_t *offset,
>  }
>  
>  static void vhost_user_fill_msg_region(VhostUserMemoryRegion *dst,
> -                                       struct vhost_memory_region *src)
> +                                       struct vhost_memory_region *src,
> +                                       uint64_t mmap_offset)
>  {
>      assert(src != NULL && dst != NULL);
>      dst->userspace_addr = src->userspace_addr;
>      dst->memory_size = src->memory_size;
>      dst->guest_phys_addr = src->guest_phys_addr;
> +    dst->mmap_offset = mmap_offset;
>  }
>  
>  static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
> @@ -500,9 +502,8 @@ static int vhost_user_fill_set_mem_table_msg(struct vhost_user *u,
>                  error_report("Failed preparing vhost-user memory table msg");
>                  return -1;
>              }
> -            vhost_user_fill_msg_region(&region_buffer, reg);
> +            vhost_user_fill_msg_region(&region_buffer, reg, offset);
>              msg->payload.memory.regions[*fd_num] = region_buffer;
> -            msg->payload.memory.regions[*fd_num].mmap_offset = offset;
>              fds[(*fd_num)++] = fd;
>          } else if (track_ramblocks) {
>              u->region_rb_offset[i] = 0;
> @@ -649,7 +650,7 @@ static int send_remove_regions(struct vhost_dev *dev,
>  
>          if (fd > 0) {
>              msg->hdr.request = VHOST_USER_REM_MEM_REG;
> -            vhost_user_fill_msg_region(&region_buffer, shadow_reg);
> +            vhost_user_fill_msg_region(&region_buffer, shadow_reg, 0);
>              msg->payload.mem_reg.region = region_buffer;
>  
>              if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> @@ -709,9 +710,8 @@ static int send_add_regions(struct vhost_dev *dev,
>                  u->region_rb[reg_idx] = mr->ram_block;
>              }
>              msg->hdr.request = VHOST_USER_ADD_MEM_REG;
> -            vhost_user_fill_msg_region(&region_buffer, reg);
> +            vhost_user_fill_msg_region(&region_buffer, reg, offset);
>              msg->payload.mem_reg.region = region_buffer;
> -            msg->payload.mem_reg.region.mmap_offset = offset;
>  
>              if (vhost_user_write(dev, msg, &fd, 1) < 0) {
>                  return -1;
> -- 
> 1.8.3.1


