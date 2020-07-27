Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A35206D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da/F4hkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A35206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02pa-0001bO-N4
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02op-0000hn-Vh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:05:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k02ol-00042J-PE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595855122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3iL0Ga76o5mqsHT+1bt+obLrRfbTroQYHS3r2ivUGk=;
 b=Da/F4hkTYtcPlBKo6aeVlSwCAaKW3RkExsGlimhfrGGZ2oawvS1cuyXC117ghyI0a69ULr
 MYgSsGqP29uOu+ifwaNmdMeQdlxbx9TpVFzdqhjX8OkJMJPCgKaw7qux51BWhs72HgELBM
 gfkR9zWqGQwIHB2MCkDK2ggu9F40ils=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-WbXzdOeVMR6C_Lp3LYd5_w-1; Mon, 27 Jul 2020 09:05:20 -0400
X-MC-Unique: WbXzdOeVMR6C_Lp3LYd5_w-1
Received: by mail-wr1-f69.google.com with SMTP id k11so3418361wrv.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X3iL0Ga76o5mqsHT+1bt+obLrRfbTroQYHS3r2ivUGk=;
 b=RRZU3cd10l56kbGoKjhhInIs4gGU4Xy+HAEoDpyXXdmePHFgdfAjFBacnw58Jx3mk0
 VSY5hgFmJO5ilhTdkSk8ql8g4eqJFmolAT4yXcReJhYu9q9s3ENENs+t89H+H12rSyHN
 ZnZ5pdMDdmsFzisC4m3qKaATh9dWLaBXS25y79MqyYhPjulPTQ/MES7g6l5/5rDpf32b
 +y2ltNCoYoeQu0XvVlItNnFRqGUXPzq/XvR9DQtJdIEyAqykfGcAEd4O2C+Y4zgPdXsP
 9tgW/epS4HT63ZoJA2hY8iHwYuII6PheoXMftO4wEgro9v0jIK0pp8XeuYu+Eh+3b3d1
 Dgxg==
X-Gm-Message-State: AOAM532jXwekJF1FlZQfzTXCQPto5xjPaifr8SZ9Rw6ezqSvatrza2U9
 TKyawvA9biqtdz80oxxsZgaoflXxhFeIWDjfiTxxD4tcvzTwXBAjQPTawtXStyTDryQ38MmuPDM
 hcS34joWFLBD6cR4=
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr21109914wmj.174.1595855119107; 
 Mon, 27 Jul 2020 06:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIzFnncfZQvPJP9Yfl9u4KUeMJkLSSLj+fyXyAGkx7pWUehxMpav3FowqtG6YwTvNIbWeUWQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr21109876wmj.174.1595855118555; 
 Mon, 27 Jul 2020 06:05:18 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id x11sm9719967wmc.33.2020.07.27.06.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:05:17 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:05:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] virtio-net: check the existence of peer before
 accessing vDPA config
Message-ID: <20200727090332-mutt-send-email-mst@kernel.org>
References: <20200727125150.4687-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727125150.4687-1-jasowang@redhat.com>
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
Cc: cohuck@redhat.com, qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 08:51:50PM +0800, Jason Wang wrote:
> We try to check whether a peer is VDPA in order to get config from
> there - with no peer, this leads to a NULL
> pointer dereference. Add a check before trying to access the peer
> type. No peer means not VDPA.
> 
> Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> Cc: Cindy Lu <lulu@redhat.com>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - Tweak the log
> - Add the comment in the code
> ---
>  hw/net/virtio-net.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 4895af1cbe..a1fe9e9285 100644
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
> @@ -142,13 +143,16 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>                   VIRTIO_NET_RSS_SUPPORTED_HASHES);
>      memcpy(config, &netcfg, n->config_size);
>  
> -    NetClientState *nc = qemu_get_queue(n->nic);
> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +    /*
> +     * Is this VDPA? No peer means not VDPA: there's no way to
> +     * disconnect/reconnect a VDPA peer.
> +     */
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
> @@ -156,6 +160,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg = {};
> +    NetClientState *nc = qemu_get_queue(n->nic);
>  
>      memcpy(&netcfg, config, n->config_size);
>  
> @@ -166,11 +171,14 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
>          qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>      }
>  
> -    NetClientState *nc = qemu_get_queue(n->nic);
> -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> -        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> -                               0, n->config_size,
> -                        VHOST_SET_CONFIG_TYPE_MASTER);
> +    /*
> +     * Is this VDPA? No peer means not VDPA: there's no way to
> +     * disconnect/reconnect a VDPA peer.
> +     */
> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        vhost_net_set_config(get_vhost_net(nc->peer),
> +                             (uint8_t *)&netcfg, 0, n->config_size,
> +                             VHOST_SET_CONFIG_TYPE_MASTER);
>        }
>  }


Do we want a helper for this? E.g. qemu_test_peer_type?

Anyway:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> -- 
> 2.20.1


