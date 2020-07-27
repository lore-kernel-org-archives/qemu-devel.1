Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE40C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85572070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KaNGCTAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85572070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00DZ-0003Ll-6A
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k00Cw-0002vJ-DF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:18:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44551
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k00Cu-0003kX-Nw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595845087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4J/vYpGpTbtpR6n5sjM4NFktWbEcVmb29NlTMDcaJ2s=;
 b=KaNGCTAHDr5r/EFWb/Yb9cjnW1+JY3geIDjh/ywaA9iPQ8RwUBH10JwNgbyfIH95kf0lh8
 GuwD04prVhdVhvreJGiDUsbChqdnimgu3/kpS8kNgX/0aRjDfh7aKv2lIRlzuqCmP6Cfjx
 uOplBwqMWIpL/kCxZ8fChAjWR0YPpQY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-ixkN98h1PLiRm2ojSQINdw-1; Mon, 27 Jul 2020 06:17:59 -0400
X-MC-Unique: ixkN98h1PLiRm2ojSQINdw-1
Received: by mail-wr1-f69.google.com with SMTP id h4so3760191wrh.10
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 03:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4J/vYpGpTbtpR6n5sjM4NFktWbEcVmb29NlTMDcaJ2s=;
 b=TqwiUCaY0NKqcWd9WPaPk1JqVyeNwX8rFX9C3O6TElmc6yStfqQo7YGjCLTaPNnqTm
 HmD1XcUvNIJCFV6OJnEJ58pDVdXnd2g9eeZYpFIE3Ti5sQXY1/6mTldoaSi1btOc1Dsj
 9etcyUd73Bivjo3SweLzJ1EkxtL5KWnp3D9Yy6EtooTM2wxsN6pSC6PDb8Y85FU0p92S
 5O6Dt2UrIbXa1KaNO/5kRdQ9qAOqNL3qorH8vKKEuA6ilj7EY6lLIk/lL4TS9zjrGT9b
 IhchTjbi4uK2/Hge09C92r7iGee4/U0VIOp/RffTLBEt3FAZx3ScejQPPOqvhhO4k+bS
 b6CA==
X-Gm-Message-State: AOAM532ffuXqdYhgCKMza/YJI14zfBzLWLCaIfr0ncu56HhV0O7PKrQM
 flHUzBiL0tSZRqUCPqrDKk+JPs0MaI0plpaKEs1BVy9d7hIZnt42I/sSf79lD65sKtbf/OeyHiZ
 rI6jIbHZVvcPH3qo=
X-Received: by 2002:a05:6000:1211:: with SMTP id
 e17mr20092794wrx.263.1595845078219; 
 Mon, 27 Jul 2020 03:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbN9Lb2hSPH4x0j8rlnZTzeUQRVNUCjPM/PjjpRAoS2ImQSu6Gf/9hHGv7RTbVXbVneyRpGw==
X-Received: by 2002:a05:6000:1211:: with SMTP id
 e17mr20092781wrx.263.1595845078011; 
 Mon, 27 Jul 2020 03:17:58 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id b8sm11671427wrv.4.2020.07.27.03.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 03:17:57 -0700 (PDT)
Date: Mon, 27 Jul 2020 06:17:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727061623-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <b5a42ac8-b3cf-d52e-298a-d957a9e8cb1d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b5a42ac8-b3cf-d52e-298a-d957a9e8cb1d@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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

On Mon, Jul 27, 2020 at 05:49:47PM +0800, Jason Wang wrote:
> 
> On 2020/7/27 下午5:41, Michael S. Tsirkin wrote:
> > On Mon, Jul 27, 2020 at 03:43:28PM +0800, Jason Wang wrote:
> > > We try to get config from peer unconditionally which may lead NULL
> > > pointer dereference. Add a check before trying to access the config.
> > > 
> > > Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
> > > Cc: Cindy Lu <lulu@redhat.com>
> > > Tested-by: Cornelia Huck <cohuck@redhat.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > I am a bit lost here. Isn't this invoked
> > when guest attempts to read the config?
> > With no peer, what do we return to guest?
> 
> 
> With no peer, it just work as in the past (read from the qemu's own emulated
> config space). With a vDPA as its peer, it tries to read it from vhost-vDPA.

Are these scenarios where guest would sometimes get one and
sometimes another? E.g. does it happen on disconnect?
If yes that might become a problem ...

> 
> > A code comment might be helpful here.
> 
> 
> Does something like above help?
> 
> Thanks
> 
> 
> > 
> > > ---
> > >   hw/net/virtio-net.c | 22 +++++++++++-----------
> > >   1 file changed, 11 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index 4895af1cbe..935b9ef5c7 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -125,6 +125,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> > >   {
> > >       VirtIONet *n = VIRTIO_NET(vdev);
> > >       struct virtio_net_config netcfg;
> > > +    NetClientState *nc = qemu_get_queue(n->nic);
> > >       int ret = 0;
> > >       memset(&netcfg, 0 , sizeof(struct virtio_net_config));
> > > @@ -142,13 +143,12 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> > >                    VIRTIO_NET_RSS_SUPPORTED_HASHES);
> > >       memcpy(config, &netcfg, n->config_size);
> > > -    NetClientState *nc = qemu_get_queue(n->nic);
> > > -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > >           ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> > > -                             n->config_size);
> > > -    if (ret != -1) {
> > > -        memcpy(config, &netcfg, n->config_size);
> > > -    }
> > > +                                   n->config_size);
> > > +        if (ret != -1) {
> > > +            memcpy(config, &netcfg, n->config_size);
> > > +        }
> > >       }
> > >   }
> > > @@ -156,6 +156,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
> > >   {
> > >       VirtIONet *n = VIRTIO_NET(vdev);
> > >       struct virtio_net_config netcfg = {};
> > > +    NetClientState *nc = qemu_get_queue(n->nic);
> > >       memcpy(&netcfg, config, n->config_size);
> > > @@ -166,11 +167,10 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
> > >           qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
> > >       }
> > > -    NetClientState *nc = qemu_get_queue(n->nic);
> > > -    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > -        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
> > > -                               0, n->config_size,
> > > -                        VHOST_SET_CONFIG_TYPE_MASTER);
> > > +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > > +        vhost_net_set_config(get_vhost_net(nc->peer),
> > > +                             (uint8_t *)&netcfg, 0, n->config_size,
> > > +                             VHOST_SET_CONFIG_TYPE_MASTER);
> > >         }
> > >   }
> > > -- 
> > > 2.20.1


