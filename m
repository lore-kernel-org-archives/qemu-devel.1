Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6275C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84555208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPteukQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84555208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4Ve-0004IT-LV
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1if4UY-0003AN-42
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1if4UW-00048r-FL
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1if4UW-00047y-9y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576080331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UV6nopb1zc62kP2n1lxTmW0LC7jeDzFSNycoALyvH0w=;
 b=WPteukQTsnonPXU5lpSq0yXKBPZKzKPLLFkAYB7kQX4pZ/0YO8kRBOi9q3PiQxVARxylCP
 /wqBqdNW8zXSJRS06EQjgBRYUBYXcVcfP2HKbuim81JpgM/FTCkjyBj0f6j/LqtQn4cUPf
 Yx74JTDe+TmH92e+I6j0uAGhNfarQEg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-yiNwXglGPOiM197wW9lpRw-1; Wed, 11 Dec 2019 11:05:22 -0500
Received: by mail-qt1-f199.google.com with SMTP id e37so4681346qtk.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 08:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fsSJ+LS6x0r1qCD4dGVRbbZsMZSPf90DyUEncvctSbo=;
 b=N9P93UuHiAz0NFbX+7KXRz6jWxUB+mc2yR8QTPstZhswt3jOqcRV220UKoxPG6kzhY
 SZPZwuJs012dHQkqjRrb7jwC2yxh1CDP1IrqSqehDoHxXaO9mx1trGilDwvaDrIgAQBp
 83s6UNEnnDhMyVOdMaZMzGs+3QzBxv3Wb4iFUetczOu/jtZ7bylfn6xQioWSD1gRy4bE
 3/r2+sRgpkayzoLeXhLXdM4E2XmxOM7kmV8oaaBTRBPWVT+yTliEKpIAMRfpC8yAjjDC
 K2mL88vwnzqGDz1pav9LiHp9BQngadVHlQdxtDrYs5UHBTUyUsWt4xTpUUIDl/R4TxcF
 WnQA==
X-Gm-Message-State: APjAAAWq7Pu1PDUpUEmqvwsPqXHvMaql+RtanXNSeZzIBB7mEdlOwf8D
 cga/JH0xPEUg2QS2Zm6tzYTbUMgOjhzpflxOSGhc6EgzGseChlnQZM8bgTmxVG61CMLegaS7Bm6
 b9y7JbzBVWbZQ1Ig=
X-Received: by 2002:a37:8b85:: with SMTP id n127mr3702110qkd.353.1576080322470; 
 Wed, 11 Dec 2019 08:05:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQltV6PHLtPIrxgLqnMmQeew1hakDwLMvsr8lSdsjO7Eez8OfUohXLpj4Gn8fUkiy2gER8gw==
X-Received: by 2002:a37:8b85:: with SMTP id n127mr3702086qkd.353.1576080322250; 
 Wed, 11 Dec 2019 08:05:22 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id h28sm793145qkk.48.2019.12.11.08.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 08:05:21 -0800 (PST)
Date: Wed, 11 Dec 2019 11:05:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Message-ID: <20191211110504-mutt-send-email-mst@kernel.org>
References: <20191209110759.35227-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191209110759.35227-1-stefanha@redhat.com>
X-MC-Unique: yiNwXglGPOiM197wW9lpRw-1
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
Cc: qemu-devel@nongnu.org, Vivek Goyal <vgoyal@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 09, 2019 at 11:07:59AM +0000, Stefan Hajnoczi wrote:
> The following MSI-X vectors are required:
>  * VIRTIO Configuration Change
>  * hiprio virtqueue
>  * requests virtqueues
>=20
> Fix the calculation to reserve enough MSI-X vectors.  Otherwise guest
> drivers fall back to a sub-optional configuration where all virtqueues
> share a single vector.
>=20
> This change does not break live migration compatibility since
> vhost-user-fs-pci devices are not migratable yet.
>=20
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/virtio/vhost-user-fs-pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.=
c
> index 933a3f265b..e3a649d4a6 100644
> --- a/hw/virtio/vhost-user-fs-pci.c
> +++ b/hw/virtio/vhost-user-fs-pci.c
> @@ -40,7 +40,8 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> =20
>      if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
> -        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 1;
> +        /* Also reserve config change and hiprio queue vectors */
> +        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
>      }
> =20
>      qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> --=20
> 2.23.0


