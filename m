Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A29BC43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1C6206DB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYDFIx5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1C6206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIY25-0007oi-7D
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 09:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIY1J-0007KH-TH
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIY1I-0003Yf-43
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:30:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIY1H-0003Y6-Q2
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 09:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585488631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFYBjDamLBSuNobeDsmHsvGAGjBPMR/xdx3zEjOY4wo=;
 b=KYDFIx5xsD0HoylBGgYtNfO+su1pHqYUUCMAGmSOv4dsV9mrLUx9EhPZ1S0NEvY90bUMb0
 4TWRwSGQz2KoaoWFiLDgXDG6kCNZ+vpmE32PjgStIgZcVjJor501ipSzk7Ukh0Q2rsjnmI
 g9SI/1SWKUCxMB9dw7c/wxmBvwmLVzA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-CQYPhnPxPkCOJFNffuiskA-1; Sun, 29 Mar 2020 09:30:29 -0400
X-MC-Unique: CQYPhnPxPkCOJFNffuiskA-1
Received: by mail-wr1-f71.google.com with SMTP id m15so8503927wrb.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 06:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eOryRgvE3BmRhzEzYSzbo3wG3ltfvYRvnpN60Q0Fbmg=;
 b=qVnuoD9mvFjLyUOsGVRSxx0YgG+mC0GRFvAYKSDw/n97OTrGX2KMbmsCiqmtMAHdQY
 Rnvuw5gCJ81Bnm8ssvFddr9F8fIiw6UnFfksYlLluq4d2IQ/DANCM97UCVxTSdwSlM2b
 tW2C8l6nv46xgXf3mWbxNrMSJ21gSZotfzFCDUveKzkLER6+IqhcYj2IRNrTy6sj406n
 mxcemh0gsxtT3lyu+ygosG9MJxU1bg6GJmJ8lXg7AkZlu5CU4iIrWUt3vk+vPWlUAeQS
 4y6iTYRdxd2X2D7Jy6kVMnyQnmMbwHWdBDVvE+6osEucQa0zoQxTtHG7ZPKSYEfcjNrt
 SKeg==
X-Gm-Message-State: ANhLgQ0s6abTk7bWGlG5m4aYo04nysS8sBUUPMG0x1M3Qs0qaXkBxCjR
 lK3OXnTUJbYX/OQg/phw8vHlF7OEvfZOSM/U5Sz40GwJyZdy9pqbSlBBLl4pWLd/zk0Y0BLzn/p
 hXY+cmUmgsalXVGQ=
X-Received: by 2002:a1c:770a:: with SMTP id t10mr8687446wmi.150.1585488627891; 
 Sun, 29 Mar 2020 06:30:27 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtJpV6w8Tzm34hL0OYdx+JWpkEkmxUtFIBaNhTSG1haqoKZpC/xPDNzNL+TSnK3oSNCMzodXw==
X-Received: by 2002:a1c:770a:: with SMTP id t10mr8687413wmi.150.1585488627563; 
 Sun, 29 Mar 2020 06:30:27 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id a192sm18014802wme.5.2020.03.29.06.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 06:30:26 -0700 (PDT)
Date: Sun, 29 Mar 2020 09:30:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH] fix vhost_user_blk_watch crash
Message-ID: <20200329084911-mutt-send-email-mst@kernel.org>
References: <20200323052924.29286-1-fengli@smartx.com>
MIME-Version: 1.0
In-Reply-To: <20200323052924.29286-1-fengli@smartx.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, raphael.norwitz@nutanix.com,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 01:29:24PM +0800, Li Feng wrote:
> the G_IO_HUP is watched in tcp_chr_connect, and the callback
> vhost_user_blk_watch is not needed, because tcp_chr_hup is registered as
> callback. And it will close the tcp link.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Raphael would you like to review this?
Also, I think at this point
nutanix is the biggest contributor to vhost user blk.
So if you want to be added to MAINTAINERS on this
one so people Cc you on patcches, that'd be great.

> ---
>  hw/block/vhost-user-blk.c          | 19 -------------------
>  include/hw/virtio/vhost-user-blk.h |  1 -
>  2 files changed, 20 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 12925a47ec..17df5338e7 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -349,18 +349,6 @@ static void vhost_user_blk_disconnect(DeviceState *d=
ev)
>      vhost_dev_cleanup(&s->dev);
>  }
> =20
> -static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition cond=
,
> -                                     void *opaque)
> -{
> -    DeviceState *dev =3D opaque;
> -    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> -    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
> -
> -    qemu_chr_fe_disconnect(&s->chardev);
> -
> -    return true;
> -}
> -
>  static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
>  {
>      DeviceState *dev =3D opaque;
> @@ -373,15 +361,9 @@ static void vhost_user_blk_event(void *opaque, QEMUC=
hrEvent event)
>              qemu_chr_fe_disconnect(&s->chardev);
>              return;
>          }
> -        s->watch =3D qemu_chr_fe_add_watch(&s->chardev, G_IO_HUP,
> -                                         vhost_user_blk_watch, dev);
>          break;
>      case CHR_EVENT_CLOSED:
>          vhost_user_blk_disconnect(dev);
> -        if (s->watch) {
> -            g_source_remove(s->watch);
> -            s->watch =3D 0;
> -        }
>          break;
>      case CHR_EVENT_BREAK:
>      case CHR_EVENT_MUX_IN:
> @@ -428,7 +410,6 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
> =20
>      s->inflight =3D g_new0(struct vhost_inflight, 1);
>      s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
> -    s->watch =3D 0;
>      s->connected =3D false;
> =20
>      qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_ev=
ent,
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost=
-user-blk.h
> index 05ea0ad183..34ad6f0c0e 100644
> --- a/include/hw/virtio/vhost-user-blk.h
> +++ b/include/hw/virtio/vhost-user-blk.h
> @@ -38,7 +38,6 @@ typedef struct VHostUserBlk {
>      VhostUserState vhost_user;
>      struct vhost_virtqueue *vhost_vqs;
>      VirtQueue **virtqs;
> -    guint watch;
>      bool connected;
>  } VHostUserBlk;
> =20
> --=20
> 2.11.0
>=20
>=20
> --=20
> The SmartX email address is only for business purpose. Any sent message=
=20
> that is not related to the business is not authorized or permitted by=20
> SmartX.
> =E6=9C=AC=E9=82=AE=E7=AE=B1=E4=B8=BA=E5=8C=97=E4=BA=AC=E5=BF=97=E5=87=8C=
=E6=B5=B7=E7=BA=B3=E7=A7=91=E6=8A=80=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=EF=
=BC=88SmartX=EF=BC=89=E5=B7=A5=E4=BD=9C=E9=82=AE=E7=AE=B1. =E5=A6=82=E6=9C=
=AC=E9=82=AE=E7=AE=B1=E5=8F=91=E5=87=BA=E7=9A=84=E9=82=AE=E4=BB=B6=E4=B8=8E=
=E5=B7=A5=E4=BD=9C=E6=97=A0=E5=85=B3,=E8=AF=A5=E9=82=AE=E4=BB=B6=E6=9C=AA=
=E5=BE=97=E5=88=B0=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=BB=BB=E4=BD=95=E7=9A=84=E6=
=98=8E=E7=A4=BA=E6=88=96=E9=BB=98=E7=A4=BA=E7=9A=84=E6=8E=88=E6=9D=83.
>=20


