Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50918C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6FF206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlbQ2YfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6FF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJLS-0000M9-3z
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ijJKY-0008GS-VB
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ijJKX-0003Jr-1l
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:44:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ijJKW-0003HR-Hs
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577090683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cw532sAiHhS1YqBQQllFWTOIsFXO4rLBpV23r16ZDc0=;
 b=ZlbQ2YfOj9QNLfmRAM1w6jaY9S+LgO7sOcDKNWlTMqr2rrCMCa4ywtRMvw45BTpY8wZHFs
 SjBHjZLS/JaW0I6QIKrf7K+d3p56QVhqlM3I41VM0SprQP0Cdp2DoxoRC5skKzItb5c7io
 KZoiW/RFzBnXJhTQeVMs1FLh2TcrpCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-d8hpV1DyNwi6BcuyiMSdXg-1; Mon, 23 Dec 2019 03:44:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id f15so2183414wrr.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 00:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cw532sAiHhS1YqBQQllFWTOIsFXO4rLBpV23r16ZDc0=;
 b=rX5BAIR4n2x8waJw50xwk1YX7tRdrUxjieGEJnd1+bBW/bNeg1uuUiMctRSpBdm5gR
 Gu3io1zwcbLjcyMXwIHT04I1oWJQ1vH5SugHauMM2RzqyhTdobacIPKAjvl7C/BJa4/K
 VISA0VDnKStlVguo88vtXBBIVJ3+VQMTbKldYuIdkwEVN6CarFXW7WSjNQtskv/xWtX9
 nshYcSGZEsX41J19TIUCRvOhw2pRADzV61veQ5SKKouVsmyo44hot1mOa2CKhdsA5P/G
 51Gf2r7eHzd1i4Jg5hTuQ057Rv/jypnQ9zmJL4EY10dWJkBpXCwWXyKdse2TvWeLuLQq
 UDwA==
X-Gm-Message-State: APjAAAUZorKSbGh9nUy01UI/s/+1E/MVIZsIzuGJ0hDWv3ts6S1TiWxS
 AVr0UdcqUaxoO/MVENl80vI40Jc/n0yXZD4/t776wPhUVHGpKt8C1ehmR0E8EIV8d/ATpyTVZf5
 yb/GDkYz5XB9FJWo=
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr31040507wmf.65.1577090681085; 
 Mon, 23 Dec 2019 00:44:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+V1FXaTpaH0vtSvakMj7RX0eM4PgtjCcBpgYAzO4gggTrC9zk9JS3ACfudHx7KMhjM5IJ1w==
X-Received: by 2002:a05:600c:2298:: with SMTP id
 24mr31040493wmf.65.1577090680835; 
 Mon, 23 Dec 2019 00:44:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id h2sm21313073wrt.45.2019.12.23.00.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Dec 2019 00:44:40 -0800 (PST)
Subject: Re: [PATCH] virtio: add the queue number check
To: Yang Zhong <yang.zhong@intel.com>, mst@redhat.com, stefanha@redhat.com
References: <20191223082813.28930-1-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
Date: Mon, 23 Dec 2019 09:44:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191223082813.28930-1-yang.zhong@intel.com>
Content-Language: en-US
X-MC-Unique: d8hpV1DyNwi6BcuyiMSdXg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On 23/12/19 09:28, Yang Zhong wrote:
> In the guest kernel driver, like virtio_blk.c and virtio_scsi.c,
> there are some definitions like below:
> 
> num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs)
> 
> If the queue number is bigger than vcpu number, the VM will be
> stuck in the guest driver because the qemu and guest driver have
> different queue number. So, this check can avoid this issues.

Can you explain how the bug happens? This would be an issue in the
kernel driver, QEMU shouldn't care about how the kernel driver chooses
to steer requests to virtqueues.

Paolo

> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  hw/block/vhost-user-blk.c | 11 +++++++++++
>  hw/block/virtio-blk.c     | 11 ++++++++++-
>  hw/scsi/virtio-scsi.c     | 12 ++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 63da9bb619..250e72abe4 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -23,6 +23,8 @@
>  #include "qom/object.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-user-blk.h"
>  #include "hw/virtio/virtio.h"
> @@ -391,6 +393,7 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VHostUserBlk *s = VHOST_USER_BLK(vdev);
>      Error *err = NULL;
> +    unsigned cpus;
>      int i, ret;
>  
>      if (!s->chardev.chr) {
> @@ -403,6 +406,14 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> +                               "cpus", 0);
> +    if (s->num_queues > cpus ) {
> +        error_setg(errp, "vhost-user-blk: the queue number should be equal "
> +                "or less than vcpu number");
> +        return;
> +    }
> +
>      if (!s->queue_size) {
>          error_setg(errp, "vhost-user-blk: queue size must be non-zero");
>          return;
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index d62e6377c2..b2f4d01148 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -18,6 +18,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "trace.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
>  #include "hw/block/block.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/blockdev.h"
> @@ -1119,7 +1121,7 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>      VirtIOBlock *s = VIRTIO_BLK(dev);
>      VirtIOBlkConf *conf = &s->conf;
>      Error *err = NULL;
> -    unsigned i;
> +    unsigned i,cpus;
>  
>      if (!conf->conf.blk) {
>          error_setg(errp, "drive property not set");
> @@ -1133,6 +1135,13 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>          error_setg(errp, "num-queues property must be larger than 0");
>          return;
>      }
> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> +                               "cpus", 0);
> +    if (conf->num_queues > cpus ) {
> +        error_setg(errp, "virtio-blk: the queue number should be equal "
> +                "or less than vcpu number");
> +        return;
> +    }
>      if (!is_power_of_2(conf->queue_size) ||
>          conf->queue_size > VIRTQUEUE_MAX_SIZE) {
>          error_setg(errp, "invalid queue-size property (%" PRIu16 "), "
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index e8b2b64d09..8e3e44f6b9 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -21,6 +21,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu/config-file.h"
>  #include "sysemu/block-backend.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/scsi/scsi.h"
> @@ -880,6 +882,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIOSCSICommon *s = VIRTIO_SCSI_COMMON(dev);
> +    unsigned cpus;
>      int i;
>  
>      virtio_init(vdev, "virtio-scsi", VIRTIO_ID_SCSI,
> @@ -893,6 +896,15 @@ void virtio_scsi_common_realize(DeviceState *dev,
>          virtio_cleanup(vdev);
>          return;
>      }
> +
> +    cpus = qemu_opt_get_number(qemu_opts_find(qemu_find_opts("smp-opts"), NULL),
> +                               "cpus", 0);
> +    if (s->conf.num_queues > cpus ) {
> +        error_setg(errp, "virtio-scsi: the queue number should be equal "
> +                "or less than vcpu number");
> +        return;
> +    }
> +
>      s->cmd_vqs = g_new0(VirtQueue *, s->conf.num_queues);
>      s->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
>      s->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
> 


