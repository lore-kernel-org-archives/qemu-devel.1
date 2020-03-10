Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273BDC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E902E24673
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 06:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOW0oqRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E902E24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBYDW-0007Vr-53
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 02:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jBYCh-00077E-0R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jBYCf-0003FY-Oc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:17:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26888
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jBYCf-0003Dy-K7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 02:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583821040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=antYVGqQ4fMBU8l3cH5xXEI7Ixim+Ty7mOSKivU5aXU=;
 b=ZOW0oqRxcV6GZLOaATklxCGguIglVPTC1JIUvU4UL02nX0Cmk4/I8QQtaJFnNuHElt5dIk
 HAAFOqwfxwh77jZ52zuTT4muyssYrXJ39f7FZJQ/1L/6vwckkHj/IH3jhmQ97wyj6fvVl1
 pSXrq1axJOydC4rfWjqufo4RAZgPeps=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-90dz36TrOIO95DaJaKL2Tw-1; Tue, 10 Mar 2020 02:17:18 -0400
X-MC-Unique: 90dz36TrOIO95DaJaKL2Tw-1
Received: by mail-qv1-f72.google.com with SMTP id a12so7937590qvv.8
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 23:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2aLXRCyOKZ9NAGMwUaZ6oQBFcQxIeobLzU1Hb3riRKY=;
 b=DJd/S1AS4OhqwK/9ZYYZNZhbt0h0WWIfyW/ktdIK1IkBJ1XfEQGb4AtgY4HbgqjlWK
 QrJJyygvAXQilcr1VlVADdKzPqi05ru14Ks8cBu5GVvSXcrDEIixUvHaYNjAQmAEuRbt
 TGFlzdzN7LJT/ORX40vlRa1/EfoPOAieuVUMsIWl/ig7S4ZGEkiPF/YirOiRVVsOU6J7
 a/MJnCqJK5VXh9g5GE5bteVn8U/legpJWyCG9fDCqP4jDdivdO0JgCmXAElsNqDjvh8B
 eM0IVNSvOdKSHF1TS0qat8Kv94fiueva3gYB4v2foEYSZiAb39n/JeNIhTWPkniplLHw
 VBZg==
X-Gm-Message-State: ANhLgQ0eNoaYFml09uenJoUuBHEVelXQ6o+widbQHykUK6XrqtktBRTM
 2nL5eR89ThpKfhu2/5JW1WDHJ2jRn6Fo7WPT1kikHgGiBy5zwcm2i9ZXvEMM7YK6RPY1u+oxR93
 kN7tkhB55HsMCp1Q=
X-Received: by 2002:a37:8b01:: with SMTP id n1mr7001106qkd.407.1583821038329; 
 Mon, 09 Mar 2020 23:17:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vso+xk87tTVgGL8a/NBPI+2/cehBqjRCRNvxGb5+Iqib6ak7aGoSGR4Gws75N3Fvgb+TM1UYQ==
X-Received: by 2002:a37:8b01:: with SMTP id n1mr7001096qkd.407.1583821038075; 
 Mon, 09 Mar 2020 23:17:18 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id w4sm9953644qts.92.2020.03.09.23.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 23:17:17 -0700 (PDT)
Date: Tue, 10 Mar 2020 02:17:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-net: block migration if RSS feature
 negotiated
Message-ID: <20200310021356-mutt-send-email-mst@kernel.org>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
 <20200309083438.2389-5-yuri.benditovich@daynix.com>
 <32451b9c-f10d-d683-24b4-29497e73ca65@redhat.com>
MIME-Version: 1.0
In-Reply-To: <32451b9c-f10d-d683-24b4-29497e73ca65@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: yan@daynix.com, Yuri Benditovich <yuri.benditovich@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 11:12:05AM +0800, Jason Wang wrote:
>=20
> On 2020/3/9 =E4=B8=8B=E5=8D=884:34, Yuri Benditovich wrote:
> > Block migration for reference implementation of
> > RSS feature in QEMU. When we add support for RSS
> > on backend side, we'll implement migration of
> > current RSS settings.
> >=20
> > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > ---
> >   hw/net/virtio-net.c            | 18 ++++++++++++++++++
> >   include/hw/virtio/virtio-net.h |  1 +
> >   2 files changed, 19 insertions(+)
> >=20
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index abc41fdb16..943d1931a2 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -37,6 +37,7 @@
> >   #include "qapi/qapi-events-migration.h"
> >   #include "hw/virtio/virtio-access.h"
> >   #include "migration/misc.h"
> > +#include "migration/blocker.h"
> >   #include "standard-headers/linux/ethtool.h"
> >   #include "sysemu/sysemu.h"
> >   #include "trace.h"
> > @@ -627,6 +628,12 @@ static void virtio_net_reset(VirtIODevice *vdev)
> >       n->announce_timer.round =3D 0;
> >       n->status &=3D ~VIRTIO_NET_S_ANNOUNCE;
> > +    if (n->migration_blocker) {
> > +        migrate_del_blocker(n->migration_blocker);
> > +        error_free(n->migration_blocker);
> > +        n->migration_blocker =3D NULL;
> > +    }
> > +
> >       /* Flush any MAC and VLAN filter table state */
> >       n->mac_table.in_use =3D 0;
> >       n->mac_table.first_multi =3D 0;
> > @@ -1003,6 +1010,17 @@ static void virtio_net_set_features(VirtIODevice=
 *vdev, uint64_t features)
> >           vhost_net_ack_features(get_vhost_net(nc->peer), features);
> >       }
> > +    if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
> > +        if (!n->migration_blocker) {
> > +            error_setg(&n->migration_blocker, "virtio-net: RSS negotia=
ted");
> > +            migrate_add_blocker(n->migration_blocker, &err);
> > +            if (err) {
> > +                error_report_err(err);
> > +                err =3D NULL;
> > +            }
> > +        }
> > +    }
>=20
>=20
> It looks to me we should add the blocker unconditionally based on
> virtio_host_has_feature() instead of depending the negotiated feature her=
e.
>=20
> Thanks

I agree, this is a stopgap measure anyway.  If this is merged in its
current form, there should also be a big TODO here that we must fix this
ASAP, and maybe a warning produced.


>=20
> > +
> >       if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
> >           memset(n->vlans, 0, MAX_VLAN >> 3);
> >       } else {
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
> > index 45670dd054..fba768ba9b 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -180,6 +180,7 @@ struct VirtIONet {
> >       virtio_net_conf net_conf;
> >       NICConf nic_conf;
> >       DeviceState *qdev;
> > +    Error *migration_blocker;
> >       int multiqueue;
> >       uint16_t max_queues;
> >       uint16_t curr_queues;


