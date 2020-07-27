Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B14C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:42:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED31206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YueTggc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED31206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzze1-00034Z-23
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzzdR-0002eh-K1
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:41:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzzdP-0005Sy-6y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595842884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZHRcPFuiIoRSfCEck7//ov3NxeyTxAiTVJANTRtOxj4=;
 b=YueTggc1M/oSA/PsfHV6n1AxX9DsdRKRkZlPRw1PRm36hQMcOzS/jn6vD94gyY1IVSG0l2
 Rk1f5P0WDv7ecEutcHGEtjkDiMbflLqyC+joqesLw9ewbofGGzpsV7q7DHA4LDz1p7ppgq
 b7AkRsjbK0bliw/yDhEV/U0v95QWw4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-PkS1-goWOp-J1fxuWC-q7g-1; Mon, 27 Jul 2020 05:41:22 -0400
X-MC-Unique: PkS1-goWOp-J1fxuWC-q7g-1
Received: by mail-wm1-f71.google.com with SMTP id t26so7011939wmn.4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 02:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZHRcPFuiIoRSfCEck7//ov3NxeyTxAiTVJANTRtOxj4=;
 b=tkiO62RKTnb6PJRSTD0CevV2uTX+wVXqp2f4sA5+IGbSkoGGPyLwO6B1j7KE47U/AS
 f3LV4YMfvAsdHGZ/FUSIW5j2f2sCGEjZ5gDvey8B3RVw8D8ltruDBVsxJ6f+wRT6HhR2
 /wJYkzujUcfP3yyIV4Wo1g66r+dkDWAdWrzgvfuNISqXlkQSNmp2LlIn6B2hkvvRQDqQ
 D4Euq7nJDts809U3QC2BaOSUuvsIDd4ryjoMg/E+EFaeAcj/qJI5iEa5951P5J/DOWT+
 ndQm+zw/OgbrvbwPIupyxMiSV6RbdIcXS8HKk4GTZ6MZkzd/Fm3XijblKxLvWLVoEcFm
 a6wg==
X-Gm-Message-State: AOAM530uaeCgxvkRUhRs+Ajnj8xUZpRlbPzllC3FMmlNw9F/gbLRNkVF
 aYUGLQTFLlDtNdIiqOYPBgdt2dS3OPlE8kqEI29igZlzBTRmBBQQobMfwKqxnYUw5UskkRXSgmY
 ZzN/WqFtY7VDBJpA=
X-Received: by 2002:adf:90d1:: with SMTP id i75mr10651126wri.278.1595842881589; 
 Mon, 27 Jul 2020 02:41:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoF+eS9zAHyhTXkpzvrs8B0C8OcDEqK5qtlgaqOZwjfzpUbbNnSRfu5ndqP9/4sa8np7q3ZQ==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr10651110wri.278.1595842881369; 
 Mon, 27 Jul 2020 02:41:21 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id n5sm4650514wrx.22.2020.07.27.02.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 02:41:20 -0700 (PDT)
Date: Mon, 27 Jul 2020 05:41:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727053954-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727074328.2279-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
> We try to get config from peer unconditionally which may lead NULL
> pointer dereference. Add a check before trying to access the config.
> 
> Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> Cc: Cindy Lu <lulu@redhat.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I am a bit lost here. Isn't this invoked
when guest attempts to read the config?
With no peer, what do we return to guest?
A code comment might be helpful here.

> ---
>  hw/net/virtio-net.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4895af1cbe..935b9ef5c7 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -125,6 +125,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg;
> +    NetClientState *nc = qemu_get_queue(n->nic);
>  
>      int ret = 0;
>      memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> @@ -142,13 +143,12 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>                   VIRTIO_NET_RSS_SUPPORTED_HASHES);
>      memcpy(config, &netcfg, n->config_size);
>  
> -    NetClientState *nc = qemu_get_queue(n->nic);
> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>          ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> -                             n->config_size);
> -    if (ret != -1) {
> -        memcpy(config, &netcfg, n->config_size);
> -    }
> +                                   n->config_size);
> +        if (ret != -1) {
> +            memcpy(config, &netcfg, n->config_size);
> +        }
>      }
>  }
>  
> @@ -156,6 +156,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg = {};
> +    NetClientState *nc = qemu_get_queue(n->nic);
>  
>      memcpy(&netcfg, config, n->config_size);
>  
> @@ -166,11 +167,10 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>          qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>      }
>  
> -    NetClientState *nc = qemu_get_queue(n->nic);
> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> -        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> -                               0, n->config_size,
> -                        VHOST_SET_CONFIG_TYPE_MASTER);
> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        vhost_net_set_config(get_vhost_net(nc->peer),
> +                             (uint8_t *)&netcfg, 0, n->config_size,
> +                             VHOST_SET_CONFIG_TYPE_MASTER);
>        }
>  }
>  
> -- 
> 2.20.1


