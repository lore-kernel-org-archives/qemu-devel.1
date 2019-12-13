Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4F1C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 139412073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erTmIo3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139412073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhsW-0000ig-9m
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ifhrr-0000HA-J2
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ifhrq-0001dP-Au
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:08:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ifhrq-0001cN-58
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576231693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDdwAgemZVc7YhVIPE07TzB+nds87pE0sD2S/uWtRL4=;
 b=erTmIo3QCnYfpubqC2duanFb/pDT0rwqSXZrxNe9EnPRWkZ0rJLlB3MMJOFVEIQfqpfn7V
 aLzycCcm5XxHRAC9GMqffoNU2nnrlxXZvXLsDGI7HWrwDV15+jXsc3HfW6L3VbYibb+mnf
 WBj3CgFA9xkJQQuyra4JHmoBAxD3VMA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-1gBvSeylOvuFAd8_5AzNgg-1; Fri, 13 Dec 2019 05:08:10 -0500
Received: by mail-qv1-f71.google.com with SMTP id s18so1364715qvr.7
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 02:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oS8oMTE/ejXKHNwU4YUfdE7RTFalo/ln47ScNyNKV9M=;
 b=f1+mmpQS7UOE/YxEU0O9zpgXaBFXtXKoGs+hL4wH1Qb1afHZsSoCtb3dY2WXC2bAxH
 t2mhb7d6Bnl1O3D2JJPAtwYdsSjWnoyW4HJFuFm94SSJYecjuomNEb83/h0j4cGOWREd
 DYzWibfqyKCjYLRZiKVHnuOvyIUt9r1jANcZxi0mo07b/61WEB0d+5QSZTnhtbwrWK+O
 KaGyBRwEdcdNbNb+SAAO8giXOQgZ6MXercvqQkrPSzWJ9/5Ll0/2jpS4uEh1Mt/CFM8n
 RrytiS+TrExEjr/J48J8nBxSZHrQNiU2Uv3Dvqut2dtTMr4dz4MrcKadNasx45aSpgyE
 tyaw==
X-Gm-Message-State: APjAAAVqiWyfNAoUus6Gqx0q1AFoqwB6FQC+CRLG55YfJzPzHlmhtLCF
 CQ1sjKguxBzgudjP6sw0jFQmeiAkb1flXUi9nCu+DMBFN/Xs65L22bPNREp76MILt+t3IoWsCyB
 sa9w1y6xXaItj3Bs=
X-Received: by 2002:ac8:4904:: with SMTP id e4mr11440734qtq.125.1576231689955; 
 Fri, 13 Dec 2019 02:08:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIykGI1QqrYhz/DQN9YailyTb3ds8Y19jMm0uAwvQ4yWtywI+euF8kvz0LanqoRSAsenitJg==
X-Received: by 2002:ac8:4904:: with SMTP id e4mr11440712qtq.125.1576231689688; 
 Fri, 13 Dec 2019 02:08:09 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id l20sm969364qtj.60.2019.12.13.02.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2019 02:08:08 -0800 (PST)
Date: Fri, 13 Dec 2019 05:08:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [PATCH 1/2] vhost-user: add VHOST_USER_RESET_DEVICE to reset
 devices
Message-ID: <20191213050742-mutt-send-email-mst@kernel.org>
References: <1572385083-5254-1-git-send-email-raphael.norwitz@nutanix.com>
 <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
X-MC-Unique: 1gBvSeylOvuFAd8_5AzNgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Looks good to me, I'll queue it for merge after the release. If possible
please ping me after the release to help make sure it didn't get
dropped. Same for 2/2.


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


