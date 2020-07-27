Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0425C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E9E2065E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmX+cSeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E9E2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00H6-0005Rl-L1
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k00GE-0004rb-PT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:21:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k00GC-0004am-0V
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595845291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTdS2jgbCsHXN2gIHy8smHunZAoJ6NLAqIL1/NehehQ=;
 b=NmX+cSeL4LQ68qwTvsWdo03x0rlRU3ERAywUgFM4n18/MOOawYAGgA8rYA0smsIVeSEDDx
 YJbtNzfLzxkNRJgk7HbDbjLoHk2uNTnoiUSAJjZ0D5oqrRcXBjOFOiAwx+9EzthQcC8+Fv
 D0jLTVFOFYenFcjuodAlWlUfJuNyBQo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-ihaFkRvnNMalvLsQtZkVJQ-1; Mon, 27 Jul 2020 06:21:29 -0400
X-MC-Unique: ihaFkRvnNMalvLsQtZkVJQ-1
Received: by mail-wr1-f71.google.com with SMTP id m7so3747647wrb.20
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 03:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dTdS2jgbCsHXN2gIHy8smHunZAoJ6NLAqIL1/NehehQ=;
 b=oOgo9mUpznjuQzJn3J2wlemUo6z9he4CZNAxDUZEptuS/fSI4hX26AwcnQoIB9VMqI
 mXCI/UZgG/Gz4UqTZ7M2CjZQvYIZJbh86Rfr6xzJ+T/gPfUBFs9lUpYYS8XygH+5Qxd+
 Lk+V7JJoc2QgH1j4EJdu15/fOS6tS86qfuAY8RYVLQsYcMj+3tPJ+3F5bXgDJu0oOIwh
 hFdH9hstxTlAVW3Z6gMbw8+P8ZoquBpPnxvRS/FylVR1KrkjbDf5iy2UyREpwDTF8UnO
 Eu+yGGKi38fEGO6cbdZIBLwa5r/DH37s+pAvUif4KcXHWhnXy7wcm6Lt8iqVPdAnQP+k
 Jitw==
X-Gm-Message-State: AOAM5329z/860WuoPj8tkIxM0NKrxi0CMqzeylW6OXkLutOQo6G/kaju
 BFkjP1DFeY1XPqclzkO76ZJYzz2b/AQvScwkqC4fjyfnUlmaxFLyk7PQ1n0Fqm4OATMdFRAwyuE
 cJbPd2wt9Rx2ijrs=
X-Received: by 2002:adf:f486:: with SMTP id l6mr15067534wro.265.1595845287758; 
 Mon, 27 Jul 2020 03:21:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywCB3vjOQNKNMkdsjIsKHwpD5xuj7S0H+bGzlh9a7+j+t8FphlAYgnwi++HzA+ZPgmiKhkcQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr15067519wro.265.1595845287571; 
 Mon, 27 Jul 2020 03:21:27 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t25sm4348585wmj.18.2020.07.27.03.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 03:21:26 -0700 (PDT)
Date: Mon, 27 Jul 2020 06:21:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-net: check the existence of peer before accesing
 its config
Message-ID: <20200727061812-mutt-send-email-mst@kernel.org>
References: <20200727074328.2279-1-jasowang@redhat.com>
 <20200727053954-mutt-send-email-mst@kernel.org>
 <b5a42ac8-b3cf-d52e-298a-d957a9e8cb1d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b5a42ac8-b3cf-d52e-298a-d957a9e8cb1d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
> 
> 
> > A code comment might be helpful here.
> 
> 
> Does something like above help?
> 
> Thanks

I think this part of commit log caused confusion:

	 Add a check before trying to access the config.

looking more at the code, imho in fact here is a better description of
what is going on:

	We try to check whether a peer is VDPA in order to get config from
	there - with no peer, this leads to a NULL
	pointer dereference. Add a check before trying to access the peer
	type. No peer means not VDPA.


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


