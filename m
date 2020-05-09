Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1BCC38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D9121655
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 03:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDA5CfCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D9121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXFlW-0004NZ-7K
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 23:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFkb-0003Ls-Qu
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:02:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41734
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXFka-0005lW-QY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 23:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588993324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKWZ4edE9Ha3Kff/94vZTBZ+JsuJ+ANc0PfPuI7ocjA=;
 b=gDA5CfCUqvsZXCyvE35+g8YOY2bkojPj7yTefxbjL/YSzypdljmDdUnnowkRlVhA0pmzJg
 7q/FxmS6gvnqgBUr9/FR/Quo5N+xTSiwbv2sy911cBISFBLbGeImFgAd6cy0L+rWL9PPdj
 JCTxT9lcBWHZDROPsI/ysguU0kqoVbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-M2N5ThR9PS2jYO876b1RhQ-1; Fri, 08 May 2020 23:02:00 -0400
X-MC-Unique: M2N5ThR9PS2jYO876b1RhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9529464;
 Sat,  9 May 2020 03:01:57 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66BCD2E17D;
 Sat,  9 May 2020 03:01:41 +0000 (UTC)
Subject: Re: [RFC v2 6/9] virtio-bus: introduce queue_enabled method
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-7-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7fcf4c3-8659-af81-e915-43140cd68d5a@redhat.com>
Date: Sat, 9 May 2020 11:01:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-7-lulu@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 22:20:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com,
 jgg@mellanox.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/9 上午12:32, Cindy Lu wrote:
> From: Jason Wang <jasowang@redhat.com>
>
> This patch introduces queue_enabled() method which allows the
> transport to implement its own way to report whether or not a queue is
> enabled.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


This patch should come before any of the vhost-vpda patch.

Thanks


> ---
>   hw/virtio/virtio.c             | 6 ++++++
>   include/hw/virtio/virtio-bus.h | 4 ++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..09732a8836 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3169,6 +3169,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
>   
>   bool virtio_queue_enabled(VirtIODevice *vdev, int n)
>   {
> +    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> +    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> +
> +    if (k->queue_enabled)
> +        return k->queue_enabled(qbus->parent, n);
> +
>       return virtio_queue_get_desc_addr(vdev, n) != 0;
>   }
>   
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> index 38c9399cd4..0f6f215925 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
>        */
>       int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
>                               int n, bool assign);
> +    /*
> +     * Whether queue number n is enabled.
> +     */
> +    bool (*queue_enabled)(DeviceState *d, int n);
>       /*
>        * Does the transport have variable vring alignment?
>        * (ie can it ever call virtio_queue_set_align()?)


