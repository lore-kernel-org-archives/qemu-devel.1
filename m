Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867ACC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512022100A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 07:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSsNH1ZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512022100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeZGq-0005Jg-HI
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 03:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZFp-0004JU-EU
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:16:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45438
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jeZFo-0006cG-5C
 for qemu-devel@nongnu.org; Fri, 29 May 2020 03:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590736590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBb70j/ph5L8XwC8EC70AY94OVuiC1I3+b3G+d2pSU0=;
 b=YSsNH1ZKBSW0kSjphOIuZ8WBdE2W3IS+g9an+SI7MmeOFDxEwAyko/YnIzTLWR76EgMxs4
 G/7E5QP2zyZ2xbwLSgUE8Kf7VX9QqL8/BCYqj8ZtCjBOLHKJrHUYS1mfdMoI+JDEJsXc0l
 S4OJtP4oVcUXxoprUBV6ILAWtwzcZBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-yzvqyTF5OBuolf0QFqzrjg-1; Fri, 29 May 2020 03:16:25 -0400
X-MC-Unique: yzvqyTF5OBuolf0QFqzrjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057A8A0BDB;
 Fri, 29 May 2020 07:16:24 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F87E5C1B0;
 Fri, 29 May 2020 07:16:00 +0000 (UTC)
Subject: Re: [PATCH 5/5] virtio: enable VIRTIO_F_RING_PACKED for all devices
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-6-stefanha@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8e3a0ac5-9294-ca7e-071e-3074c43204c3@redhat.com>
Date: Fri, 29 May 2020 15:15:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522171726.648279-6-stefanha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 cohuck@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/23 上午1:17, Stefan Hajnoczi wrote:
> The packed virtqueue layout was introduced in VIRTIO 1.1. It is a single
> ring instead of a split avail/used ring design. There are CPU cache
> advantages to this layout and it is also suited better to hardware
> implementation.
>
> The vhost-net backend has already supported packed virtqueues for some
> time. Performance benchmarks show that virtio-blk performance on NVMe
> drives is also improved.
>
> Go ahead and enable this feature for all VIRTIO devices. Keep it
> disabled for QEMU 5.0 and earlier machine types.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/virtio.h |  2 +-
>   hw/core/machine.c          | 18 +++++++++++++++++-
>   2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b69d517496..fd5b4a2044 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -292,7 +292,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>       DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
>                         VIRTIO_F_IOMMU_PLATFORM, false), \
>       DEFINE_PROP_BIT64("packed", _state, _field, \
> -                      VIRTIO_F_RING_PACKED, false)
> +                      VIRTIO_F_RING_PACKED, true)
>   
>   hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>   bool virtio_queue_enabled(VirtIODevice *vdev, int n);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bb3a7b18b1..3598c3c825 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,7 +28,23 @@
>   #include "hw/mem/nvdimm.h"
>   #include "migration/vmstate.h"
>   
> -GlobalProperty hw_compat_5_0[] = {};
> +GlobalProperty hw_compat_5_0[] = {
> +    { "vhost-user-blk", "packed", "off" },
> +    { "vhost-user-fs-device", "packed", "off" },
> +    { "vhost-vsock-device", "packed", "off" },
> +    { "virtio-9p-device", "packed", "off" },
> +    { "virtio-balloon-device", "packed", "off" },
> +    { "virtio-blk-device", "packed", "off" },
> +    { "virtio-crypto-device", "packed", "off" },
> +    { "virtio-gpu-device", "packed", "off" },
> +    { "virtio-input-device", "packed", "off" },
> +    { "virtio-iommu-device", "packed", "off" },
> +    { "virtio-net-device", "packed", "off" },
> +    { "virtio-pmem", "packed", "off" },
> +    { "virtio-rng-device", "packed", "off" },
> +    { "virtio-scsi-common", "packed", "off" },
> +    { "virtio-serial-device", "packed", "off" },


Missing "vhost-user-gpu" here?

I try to do something like this in the past but give up since I end up 
with similar list.

It would be better to consider something more smart, probably need some 
refactor for a common parent class.

Thanks


> +};
>   const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
>   
>   GlobalProperty hw_compat_4_2[] = {


