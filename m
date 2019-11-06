Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABD6C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CB2E2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2sCq1nY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB2E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJlH-00026I-6K
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iSJbi-0007b6-At
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iSJbg-0000m8-E7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:36:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46107
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iSJbg-0000k1-63
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573040170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6GbtVkqMn8e7KyIR5htvnEt0gGFckuaExeSuebWM80=;
 b=S2sCq1nY3Z/UwmZ8zPA7Geh/WR0maq9Ov/vdGMgx7qousyGfAl7kCfszYHBuMEhBfSiC52
 S48UsIqYSR/LbofjFt9ZwiVTgv+t78cU4hTmpyhYbAjxDSpbIr6WyPdTPC4LS5uGa+vR7s
 6DpjstoHZ25BWMEt7lBbTY7f6AJGAOw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-mf07VJQXNZiybfHCDDzNag-1; Wed, 06 Nov 2019 06:36:06 -0500
Received: by mail-qt1-f198.google.com with SMTP id 6so25792083qtu.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3mVoeidQFZSgKvuGPvvqiw5F9jMs9BCUPGMaoqHpr+A=;
 b=ubeiUixZsWmkv4VPD255lag9Y9qiOmosHFqS6rQAj7llQs9W0o60cXcBbQQRj6tWUD
 VYJEsOJ6H1NbCyBj0vzZETTwVQ5yLD0N4AN+9qkdBK7dED+8Dqrl6IzN4LbsZlEaY0/Z
 K9VL9GpL8Jq1frvSdC3XK/kNYLZIkYdo20T0cm3edoY047QG1yjYpFIinZVgRu0FuQ1E
 MQDZJiaWN4V5NNf4vsCdQj2n5Yzfi9KZu8XYiZiKJw0ty0GfZoka7b+t0LrjyD85/T1U
 tkri2ZKBbLi1FhFHchPyRHw6NMr7Rx48Sr62Gi2YcdQVRmyrVCWPjz8Cf8qcKbllWn7Z
 +fdg==
X-Gm-Message-State: APjAAAUW3/BxDPyX3HHInf4VCeNVsPYJb/VI4FBpwgMZPe+x8QL4ev9I
 2SrMvp2klQJTQ2Bk29ZgD6O099mHhIl+of/KS6i9Bzi7ayGEfpYY8JcCe9WEzknJsPIfDKmA5oh
 B7znPGYiGBlJyjmE=
X-Received: by 2002:a0c:c684:: with SMTP id d4mr1741696qvj.148.1573040166456; 
 Wed, 06 Nov 2019 03:36:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwIVFrgI+hYWhHi/L2Zb2VaHlHrELU76TpHcKuIxMCoLSyWqPTrD2/1CvpHQXABlyGhwvdyvg==
X-Received: by 2002:a0c:c684:: with SMTP id d4mr1741664qvj.148.1573040165975; 
 Wed, 06 Nov 2019 03:36:05 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
 by smtp.gmail.com with ESMTPSA id t26sm5856231qta.75.2019.11.06.03.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 03:36:05 -0800 (PST)
Date: Wed, 6 Nov 2019 06:36:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH 1/2] vhost-user: add VHOST_USER_RESET_DEVICE to reset
 devices
Message-ID: <20191106063525-mutt-send-email-mst@kernel.org>
References: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
 <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: mf07VJQXNZiybfHCDDzNag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: David Vrabel <david.vrabel@nutanix.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 29, 2019 at 05:38:02PM -0400, Raphael Norwitz wrote:
> Add a VHOST_USER_RESET_DEVICE message which will reset the vhost user
> backend. Disabling all rings, and resetting all internal state, ready
> for the backend to be reinitialized.
>=20
> A backend has to report it supports this features with the
> VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol feature bit. If it does
> so, the new message is used instead of sending a RESET_OWNER which has
> had inconsistent implementations.
>=20
> Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Looks ok, pls ping me after the release to apply this.
> ---
>  docs/interop/vhost-user.rst | 15 +++++++++++++++
>  hw/virtio/vhost-user.c      |  8 +++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 7827b71..d213d4a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -785,6 +785,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
>    #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
>    #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
> +  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
> =20
>  Master message types
>  --------------------
> @@ -1190,6 +1191,20 @@ Master message types
>    ancillary data. The GPU protocol is used to inform the master of
>    rendering state and updates. See vhost-user-gpu.rst for details.
> =20
> +``VHOST_USER_RESET_DEVICE``
> +  :id: 34
> +  :equivalent ioctl: N/A
> +  :master payload: N/A
> +  :slave payload: N/A
> +
> +  Ask the vhost user backend to disable all rings and reset all
> +  internal device state to the initial state, ready to be
> +  reinitialized. The backend retains ownership of the device
> +  throughout the reset operation.
> +
> +  Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
> +  feature is set by the backend.
> +
>  Slave message types
>  -------------------
> =20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 02a9b25..d27a10f 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -58,6 +58,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
>      VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
>      VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
> +    VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
> =20
> @@ -98,6 +99,7 @@ typedef enum VhostUserRequest {
>      VHOST_USER_GET_INFLIGHT_FD =3D 31,
>      VHOST_USER_SET_INFLIGHT_FD =3D 32,
>      VHOST_USER_GPU_SET_SOCKET =3D 33,
> +    VHOST_USER_RESET_DEVICE =3D 34,
>      VHOST_USER_MAX
>  } VhostUserRequest;
> =20
> @@ -890,10 +892,14 @@ static int vhost_user_set_owner(struct vhost_dev *d=
ev)
>  static int vhost_user_reset_device(struct vhost_dev *dev)
>  {
>      VhostUserMsg msg =3D {
> -        .hdr.request =3D VHOST_USER_RESET_OWNER,
>          .hdr.flags =3D VHOST_USER_VERSION,
>      };
> =20
> +    msg.hdr.request =3D virtio_has_feature(dev->protocol_features,
> +                                         VHOST_USER_PROTOCOL_F_RESET_DEV=
ICE)
> +        ? VHOST_USER_RESET_DEVICE
> +        : VHOST_USER_RESET_OWNER;
> +
>      if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
>          return -1;
>      }
> --=20
> 1.8.3.1


