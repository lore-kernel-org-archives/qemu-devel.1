Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD257C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFAEA20728
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkAp47lM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAEA20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQBO-0002oG-Rv
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQAa-0002DT-G0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQAX-0000eV-Mz
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O5RrLpTYa43fjCq1KGnXa0GcnhU5yFW51NBspWRS8So=;
 b=CkAp47lMTfGIECtcqXJPOwd47T9QcvL0b5XtT8kIpB3kD4HxWro/KTSKLgvOYr+NJ3xNic
 xNJj12kZSQ+HSYMoVCiwowvwu6Gnx37ivgO9VqaXFv3DaQsmbxpAhTIl+x18oZV7xGjU/S
 1ie7LwFhcZYpnhP8EaqdCN5RqvWqQv4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-4V-uDQjfOvyTkUbAvQoOUA-1; Fri, 30 Oct 2020 04:53:53 -0400
X-MC-Unique: 4V-uDQjfOvyTkUbAvQoOUA-1
Received: by mail-wm1-f69.google.com with SMTP id s85so412681wme.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 01:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O5RrLpTYa43fjCq1KGnXa0GcnhU5yFW51NBspWRS8So=;
 b=ti8B46zoIuFHvBy/ANourv7mPMkZENcrZB54W/MsLitiTDmUgNylJ3Ix1/z+uDlwrn
 zN+h2aaBjj+GfhxskgTkIV8kz36Q2RMXZnREEhVUFdbmeju7uoduBo+tEfzObhC2gYuK
 yyjbTZam6YdRx8FGM+cJ99TTdB2AqzRTtcRN6ucn6kTH6vUD6Bgn2kriix3zIrQEJvDb
 eqd0P8CC2v3jU02hJKA81xiWPHqrQ3s+OUC0EfKpP6aqwo9rAkKqluitdmdIsDoqiG/A
 9/t6xmtxtIZbquRFi4wnrcuG8usGN0pyJ9Xh3jMMNbTTeVhFEFCts0EgQIPe5K/crhEE
 F5LA==
X-Gm-Message-State: AOAM531U+50T7kk+O3FfmmIq6EUV9EmsoUYCHubnUNXXzd39bqDL1KL2
 40+qot8CERtjrErlUf6jR1Qm8cV6TlNePnG6x4IWb/QVOANKwYxYQsKKLoSt6Hr183FuChKksI2
 oohdidnjGvzrk/ow=
X-Received: by 2002:adf:ab50:: with SMTP id r16mr1609568wrc.235.1604048031995; 
 Fri, 30 Oct 2020 01:53:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxHe+vjfbmQoayOPkhAqIZ4VKThpr4pV9ynuG2dzZyM8tacSh3zEIquFBS6oLqFIQBUoPbDQ==
X-Received: by 2002:adf:ab50:: with SMTP id r16mr1609552wrc.235.1604048031778; 
 Fri, 30 Oct 2020 01:53:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 71sm10329897wrm.20.2020.10.30.01.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 01:53:51 -0700 (PDT)
Date: Fri, 30 Oct 2020 04:53:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3] virtio-net: Add check for mac address while peer is
 vdpa
Message-ID: <20201030045228-mutt-send-email-mst@kernel.org>
References: <20201026062126.25255-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026062126.25255-1-lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 02:21:26PM +0800, Cindy Lu wrote:
> Sometime vdpa get an all 0 mac address from the hardware, this will cause the traffic down
> So we add the check for this part.
> if we get an 0 mac address we will use the default mac address instead
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  hw/net/virtio-net.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9179013ac4..65a3a84573 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>      VirtIONet *n = VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg;
>      NetClientState *nc = qemu_get_queue(n->nic);
> +    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
>  
>      int ret = 0;
>      memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> @@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>          ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
>                                     n->config_size);
>          if (ret != -1) {
> -            memcpy(config, &netcfg, n->config_size);
> +            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) != 0) {
> +                memcpy(config, &netcfg, n->config_size);
> +            } else {
> +                info_report("Get an all zero mac address from hardware");

s/Get/Got/

let's add more data here please "hardware" does not really
tell users what is going on. Let's mention at least the device
name and type, maybe peer name and type ...

> +            }
>          }
>      }
>  }
> -- 
> 2.21.3


