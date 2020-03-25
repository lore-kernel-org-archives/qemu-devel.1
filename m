Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1054DC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 03:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10AE20732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 03:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10AE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIkja-0002Qv-VK
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 23:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jIkj1-0001wf-Gd
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 23:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jIkj0-0001of-Bg
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 23:04:31 -0400
Received: from [192.146.154.243] (port=30230 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>)
 id 1jIkiw-0001je-NG; Sun, 29 Mar 2020 23:04:26 -0400
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id 98DAD100ABE3;
 Mon, 30 Mar 2020 03:04:24 +0000 (UTC)
Date: Wed, 25 Mar 2020 19:03:32 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH] fix vhost_user_blk_watch crash
Message-ID: <20200325230332.GA18793@localhost.localdomain>
References: <20200323052924.29286-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323052924.29286-1-fengli@smartx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 01:29:24PM +0800, Li Feng wrote:
>=20
> the G_IO_HUP is watched in tcp_chr_connect, and the callback
> vhost_user_blk_watch is not needed, because tcp_chr_hup is registered a=
s
> callback. And it will close the tcp link.
>=20
> Signed-off-by: Li Feng <fengli@smartx.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/block/vhost-user-blk.c          | 19 -------------------
>  include/hw/virtio/vhost-user-blk.h |  1 -
>  2 files changed, 20 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 12925a47ec..17df5338e7 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -349,18 +349,6 @@ static void vhost_user_blk_disconnect(DeviceState =
*dev)
>      vhost_dev_cleanup(&s->dev);
>  }
> =20
> -static gboolean vhost_user_blk_watch(GIOChannel *chan, GIOCondition co=
nd,
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
> @@ -373,15 +361,9 @@ static void vhost_user_blk_event(void *opaque, QEM=
UChrEvent event)
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
> @@ -428,7 +410,6 @@ static void vhost_user_blk_device_realize(DeviceSta=
te *dev, Error **errp)
> =20
>      s->inflight =3D g_new0(struct vhost_inflight, 1);
>      s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
> -    s->watch =3D 0;
>      s->connected =3D false;
> =20
>      qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_=
event,
> diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vho=
st-user-blk.h
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
>=20
>=20
>=20

