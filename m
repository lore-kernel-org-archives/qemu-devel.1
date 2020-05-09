Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEC8C38A2A
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 02:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9F221655
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 02:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyAwaHWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXF6h-0003Sq-AC
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 22:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXF62-0002zC-30
 for qemu-devel@nongnu.org; Fri, 08 May 2020 22:20:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40644
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jXF60-0004R6-8v
 for qemu-devel@nongnu.org; Fri, 08 May 2020 22:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588990806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DKPL0Ha2ykcxel3F2y5lx5YITr/BBYGzU7BcUR+epKo=;
 b=UyAwaHWC3UB6ZUCljOw3FidQYF5nkpDSJQgt0V7yyo53ucliCTJ/xmeQ9Snn3uNeQ+LCuu
 0sSTUrm8tbJX3dZ3dUCEavw8bAeNp2zeFXcDuHBTmMOmC7A5vinEQWsHSIRY5yp27/IJzd
 JQEQutO8Ftjkculsk3yNF0pf2l+cviU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-yQzwVhSEMWyzTy9Tx6muEA-1; Fri, 08 May 2020 22:20:03 -0400
X-MC-Unique: yQzwVhSEMWyzTy9Tx6muEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8D4BFC1;
 Sat,  9 May 2020 02:20:00 +0000 (UTC)
Received: from [10.72.13.128] (ovpn-13-128.pek2.redhat.com [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B64625262;
 Sat,  9 May 2020 02:19:37 +0000 (UTC)
Subject: Re: [RFC v2 2/9] net: use the function qemu_get_peer
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-3-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ef489ec2-1af9-3987-8f36-2993104e48d7@redhat.com>
Date: Sat, 9 May 2020 10:19:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-3-lulu@redhat.com>
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
> user the qemu_get_peer to replace the old process


The title should be "vhost_net: use the function qemu_get_peer".

Thanks


>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   hw/net/vhost_net.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6b82803fa7..d1d421e3d9 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>       BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
>       VirtioBusState *vbus = VIRTIO_BUS(qbus);
>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
> +    struct vhost_net *net;
>       int r, e, i;
> +    NetClientState *peer;
>   
>       if (!k->set_guest_notifiers) {
>           error_report("binding does not support guest notifiers");
> @@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>       }
>   
>       for (i = 0; i < total_queues; i++) {
> -        struct vhost_net *net;
>   
> -        net = get_vhost_net(ncs[i].peer);
> +        peer = qemu_get_peer(ncs, i);
> +        net = get_vhost_net(peer);
>           vhost_net_set_vq_index(net, i * 2);
>   
>           /* Suppress the masking guest notifiers on vhost user
> @@ -335,7 +337,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>       }
>   
>       for (i = 0; i < total_queues; i++) {
> -        r = vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
> +        peer = qemu_get_peer(ncs, i);
> +        r = vhost_net_start_one(get_vhost_net(peer), dev);
>   
>           if (r < 0) {
>               goto err_start;
> @@ -343,7 +346,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>   
>           if (ncs[i].peer->vring_enable) {
>               /* restore vring enable state */
> -            r = vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vring_enable);
> +            r = vhost_set_vring_enable(peer, peer->vring_enable);
>   
>               if (r < 0) {
>                   goto err_start;
> @@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
>   
>   err_start:
>       while (--i >= 0) {
> -        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
> +        peer = qemu_get_peer(ncs , i);
> +        vhost_net_stop_one(get_vhost_net(peer), dev);
>       }
>       e = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
>       if (e < 0) {


