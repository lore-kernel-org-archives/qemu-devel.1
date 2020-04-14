Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833B2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 01:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED8B20771
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 01:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED8B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPcZp-0002yA-EA
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 21:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPcYg-0002LQ-Jk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 21:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPcYe-0002LR-Ee
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 21:46:13 -0400
Received: from [192.146.154.243] (port=11250 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1jPcYe-0002J8-9L
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 21:46:12 -0400
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id 70A451030DF9;
 Sat, 18 Apr 2020 01:46:10 +0000 (UTC)
Date: Tue, 14 Apr 2020 06:02:08 -0400
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: ni.xun.intel@gmail.com, tonnylu@tencent.com, leomyan@tencent.com,
 lucascye@tencent.com
Subject: Re: [PATCH] resend slave fd to vhost when reconnect to vhost
Message-ID: <20200414100208.GA14282@localhost.localdomain>
References: <20200417051400.30398-1-richardni@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417051400.30398-1-richardni@tencent.com>
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 17, 2020 at 01:14:00PM +0800, ni.xun.intel@gmail.com wrote:
>=20
> From: Ni Xun <richardni@tencent.com>
>=20
> when reconnecting to vhost server, it doesn't send slave fd to vhost
> as the slave fd is only sent in vhost_user_init. also resend the slave =
fd
> in vhost reconnect.
>=20

I don=E2=80=99t think that=E2=80=99s correct. See vhost_user_init() here:

https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/virtio/vhost-user.c;h=3D=
08e7e63790e5bcfae6cd31bf9ccd32c3a7347f4e;hb=3DHEAD#l1898

Rather, vhost_setup_slave_channel() is called by vhost_user_backend_init(=
),
which is called on every reconnect inside vhost_dev_init().

see vhost_user_blk_connect(): https://git.qemu.org/?p=3Dqemu.git;a=3Dblob=
;f=3Dhw/block/vhost-user-blk.c;h=3D17df5338e77c684175a86e882b508849c246e7=
8a;hb=3DHEAD#l297
and vhost_dev_init():https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/v=
irtio/vhost.c;h=3D01ebe12f28e9d7e3150375dda6f55b6b8f04a42a;hb=3DHEAD#l122=
4

Note that the dev->vq_index is also set to 0 right before the
vhost_dev_init() call.

I tested myself and saw a VHOST_USER_SET_SLAVE_REQ_FD message sent on eac=
h
reconnect with the vhost-user-blk sample.

Are you seeing different behavior? If so, please provide more details on
your setup?

>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index 17df5338e7..59650a570b 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -138,6 +138,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev=
)
>              error_report("Error get inflight: %d", -ret);
>              goto err_guest_notifiers;
>          }

What's the justification for sending the slave fd here? Please elaborate.

> +    } else {
> +        ret =3D vhost_setup_slave_channel(&s->dev);
> +        if (ret < 0) {
> +            error_report("Error setting vhost slave channel: %d", -ret=
);
> +            return ret;
> +        }
>      }
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..cad60ad521 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h

Why expose this through vhost.h? This is vhost-user specific.

> @@ -100,6 +100,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev);
>  void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev);
>  int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *v=
dev);
>  void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice =
*vdev);
> +int vhost_setup_slave_channel(struct vhost_dev *hdev);
> =20
>  /* Test and clear masked event pending status.
>   * Should be called after unmask to avoid losing events.
> --=20
> 2.24.1 (Apple Git-126)
>=20
>=20

