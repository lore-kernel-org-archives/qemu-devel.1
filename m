Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BECC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938052098B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNVmxWKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938052098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcPG-0006vu-PW
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFcOX-0006WL-QH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFcOV-00053Z-Nx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599566798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3TbXxVaSjuZDPLhUfvVLRpXbVaORnN358zIb7gmiNA=;
 b=jNVmxWKOaYGwoX9vz+nt9AghoeljD0q8oDOdUWq0P5t+SNhgEfhuyaJtIMzkFkIWCkYBlg
 QBci0ec+1stXjQv2qyWU0DdnvIeD8wOCDyt6mBjHg7HrE1IrdNk+UQY22HEWAo09A0YBPx
 GzRXVA2yqD7KCXYVmyz0Nk5Y8+Truxo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-hs-Os-b_N8i_foS1_zorNA-1; Tue, 08 Sep 2020 08:06:36 -0400
X-MC-Unique: hs-Os-b_N8i_foS1_zorNA-1
Received: by mail-wr1-f69.google.com with SMTP id 3so6933874wrm.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 05:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v3TbXxVaSjuZDPLhUfvVLRpXbVaORnN358zIb7gmiNA=;
 b=RKA0Txv5BCy+7yUWj+OoP6TOXkLAgha+EmCQyWavb2EMnndFABIqczfxbPoFaCjRrm
 y2Qzsb22UT3JCfAuxEvlUSMq2I5attxHnUy/1XF792vayoJ+0Pg0S3JORC1NXIo1rAF1
 6BXTuP7FPC706Q/tKld3fmi9ZDD+Dk5ovdv4qB7u1XMpTsIvxfDteXRuGLuwmUzFCKOf
 GFEzU2dtWxMgCGBxxamajfOnJeYr/02QSNXFMciSwv+XJtuNB2Ig9DbEf/C3Wxm0NWQl
 GzYqVDHkRIvSL6I1OtIPPtRbBKiwFaiTHlMK3a7UMd3FdvL0bOQSlRrGE/r/topt9dUH
 DMNA==
X-Gm-Message-State: AOAM533PwFMzH+ItqL2DJAOGZBCRus61bK0qh4rSX/O7731rB+g6Y21L
 uGuci8W0PYxMg0nhKosgED1fsvKpkuwcj58w+pq/FTN5md8J8wZ2+lW6HU/FRNwd/lHI/873PP0
 XO7zL7XktAs9PS08=
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr4176988wmj.107.1599566795298; 
 Tue, 08 Sep 2020 05:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLNwSyFL79qUB6qXQ2VpT0DqfOVm8FjZaZwDjDHp0VR14vKc1qaF5kGH5zK8dzTNtThe1maA==
X-Received: by 2002:a05:600c:21c4:: with SMTP id
 x4mr4176968wmj.107.1599566795068; 
 Tue, 08 Sep 2020 05:06:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 c4sm34116292wrp.85.2020.09.08.05.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 05:06:34 -0700 (PDT)
Date: Tue, 8 Sep 2020 08:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/3] virtio-gpu: make virtio_gpu_ops static
Message-ID: <20200908080622-mutt-send-email-mst@kernel.org>
References: <20200907094719.12850-1-kraxel@redhat.com>
 <20200907094719.12850-2-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200907094719.12850-2-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 07, 2020 at 11:47:18AM +0200, Gerd Hoffmann wrote:
> Reference it via ops pointer instead, simliar to the vga one.
> Removes hard symbol reference, needed to build virtio-gpu modular.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.

> ---
>  include/hw/virtio/virtio-gpu.h |  3 +--
>  hw/display/virtio-gpu-base.c   |  3 ++-
>  hw/display/virtio-vga.c        | 16 ++++++++--------
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 7517438e10aa..6c639a0e0272 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -107,6 +107,7 @@ typedef struct VirtIOGPUBase {
>  
>      struct virtio_gpu_base_conf conf;
>      struct virtio_gpu_config virtio_config;
> +    const GraphicHwOps *hw_ops;
>  
>      bool use_virgl_renderer;
>      int renderer_blocked;
> @@ -172,8 +173,6 @@ typedef struct VhostUserGPU {
>      bool backend_blocked;
>  } VhostUserGPU;
>  
> -extern const GraphicHwOps virtio_gpu_ops;
> -
>  #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>          size_t s;                                                       \
>          s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 796130860657..aeb87235420a 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -112,7 +112,7 @@ virtio_gpu_gl_block(void *opaque, bool block)
>      }
>  }
>  
> -const GraphicHwOps virtio_gpu_ops = {
> +static const GraphicHwOps virtio_gpu_ops = {
>      .invalidate = virtio_gpu_invalidate_display,
>      .gfx_update = virtio_gpu_update_display,
>      .text_update = virtio_gpu_text_update,
> @@ -162,6 +162,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>      g->req_state[0].width = g->conf.xres;
>      g->req_state[0].height = g->conf.yres;
>  
> +    g->hw_ops = &virtio_gpu_ops;
>      for (i = 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =
>              graphic_console_init(DEVICE(g), i, &virtio_gpu_ops, g);
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index f533d7d1b415..28006d6e8224 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -12,7 +12,7 @@ static void virtio_vga_base_invalidate_display(void *opaque)
>      VirtIOGPUBase *g = vvga->vgpu;
>  
>      if (g->enable) {
> -        virtio_gpu_ops.invalidate(g);
> +        g->hw_ops->invalidate(g);
>      } else {
>          vvga->vga.hw_ops->invalidate(&vvga->vga);
>      }
> @@ -24,7 +24,7 @@ static void virtio_vga_base_update_display(void *opaque)
>      VirtIOGPUBase *g = vvga->vgpu;
>  
>      if (g->enable) {
> -        virtio_gpu_ops.gfx_update(g);
> +        g->hw_ops->gfx_update(g);
>      } else {
>          vvga->vga.hw_ops->gfx_update(&vvga->vga);
>      }
> @@ -36,8 +36,8 @@ static void virtio_vga_base_text_update(void *opaque, console_ch_t *chardata)
>      VirtIOGPUBase *g = vvga->vgpu;
>  
>      if (g->enable) {
> -        if (virtio_gpu_ops.text_update) {
> -            virtio_gpu_ops.text_update(g, chardata);
> +        if (g->hw_ops->text_update) {
> +            g->hw_ops->text_update(g, chardata);
>          }
>      } else {
>          if (vvga->vga.hw_ops->text_update) {
> @@ -51,8 +51,8 @@ static int virtio_vga_base_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
>      VirtIOVGABase *vvga = opaque;
>      VirtIOGPUBase *g = vvga->vgpu;
>  
> -    if (virtio_gpu_ops.ui_info) {
> -        return virtio_gpu_ops.ui_info(g, idx, info);
> +    if (g->hw_ops->ui_info) {
> +        return g->hw_ops->ui_info(g, idx, info);
>      }
>      return -1;
>  }
> @@ -62,8 +62,8 @@ static void virtio_vga_base_gl_block(void *opaque, bool block)
>      VirtIOVGABase *vvga = opaque;
>      VirtIOGPUBase *g = vvga->vgpu;
>  
> -    if (virtio_gpu_ops.gl_block) {
> -        virtio_gpu_ops.gl_block(g, block);
> +    if (g->hw_ops->gl_block) {
> +        g->hw_ops->gl_block(g, block);
>      }
>  }
>  
> -- 
> 2.27.0


