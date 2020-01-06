Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB74C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8507520731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoFz/+8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8507520731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRkN-0007Jo-JT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioRjd-0006u1-1G
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioRjb-0003UK-Oo
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:43:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioRjb-0003Tw-LQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578314630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXKdof+MVdjvGYVFNSS24nw7VWqWRsd/U913Bm3yu/8=;
 b=YoFz/+8hx2f6Np//auHayziD5qBsaFP3DzQoMqJm81QITEg8/ieAVveVCL0Pu7naNH1LgJ
 Gt6ZAv4Vhhgmop7J6HDVSAfxaljmiob5o/B/CmHSKIpdvp4PvF1UVETk657yqpkLNCdkm+
 WI/8wYHtzYvpfaADmDZ3PL5I5MsFx20=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-VWkdhOTbPWagvKNm48M-HA-1; Mon, 06 Jan 2020 07:43:49 -0500
Received: by mail-qt1-f197.google.com with SMTP id t4so34257435qtd.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 04:43:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XI0PgSw7b875iFaieplG/MXErHrY8BKiY4MOxCdG/O0=;
 b=lPocts+oHA6JrSc7sKtppXt18rIUe24fbxcgy6RQPFf2MLYTN/FvZwM+qmcgH1SYsm
 Jilo9sX2Mb2l8r/z2lRfe76Cutc5NvHj4K9l0ySnH4TjOp3WrVsu5s9NhOJWGVqq0Rae
 qgQlk/pFX4j+V0b8xORGAbIQg65llqj7i5Q3k278hmFRts1VZVFWgl/DzIYbImXFhB4l
 rL6ni15d+rxq2tcJPweZ959o16ywi8XqXESQ5ESqEwYMecGwgoN5ozSCpKlbwh71aSJI
 6Rl36g6U92TqUmd9IfRRUXgZgCO2OiPNNjKZAQ4wit54lJDLyI2GmzT+3XhQIEJ46AQb
 RqHg==
X-Gm-Message-State: APjAAAXl0D3zWa51z+lpPRV+hQVaub983iZDc86G08iN08DHlnARtcFs
 pyQrbKBlpc3cPmkKzu1ES5Q++tRZ2zSbRYXAtMDoGA5IRQaZrgk8CrJSLXzFvpdhR9jVQ3fwQzE
 NyTrCIi8fL1GQsQE=
X-Received: by 2002:aed:3f32:: with SMTP id p47mr77028275qtf.374.1578314629294; 
 Mon, 06 Jan 2020 04:43:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzMw+R3XzhlyX7WlOxkGfBQ6pHCo0xj/Sf5+Md+U7kMqByrUURZXX5EgDn5rYyCQNyuo4wunw==
X-Received: by 2002:aed:3f32:: with SMTP id p47mr77028262qtf.374.1578314629119; 
 Mon, 06 Jan 2020 04:43:49 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i2sm23368610qte.87.2020.01.06.04.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 04:43:47 -0800 (PST)
Date: Mon, 6 Jan 2020 07:43:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [RFC PATCH] virtio: Change order of appling runstate to device
 and bus
Message-ID: <20200106074302-mutt-send-email-mst@kernel.org>
References: <20191220125245.7679-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20191220125245.7679-1-antonkuchin@yandex-team.ru>
X-MC-Unique: VWkdhOTbPWagvKNm48M-HA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 03:52:45PM +0300, Anton Kuchin wrote:
> On transition to running first apply state to bus and then to device
> so device can access bus functions correctly. When going to stopped
> notify device first and then the bus.
>=20
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>

I kind of like this but this has the potential to break lots of things.
How was this tested?

> ---
>  hw/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 04716b5f6c..2ea2edba10 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3096,7 +3096,7 @@ static void virtio_vmstate_change(void *opaque, int=
 running, RunState state)
>      bool backend_run =3D running && virtio_device_started(vdev, vdev->st=
atus);
>      vdev->vm_running =3D running;
> =20
> -    if (backend_run) {
> +    if (!backend_run) {
>          virtio_set_status(vdev, vdev->status);
>      }
> =20
> @@ -3104,7 +3104,7 @@ static void virtio_vmstate_change(void *opaque, int=
 running, RunState state)
>          k->vmstate_change(qbus->parent, backend_run);
>      }
> =20
> -    if (!backend_run) {
> +    if (backend_run) {
>          virtio_set_status(vdev, vdev->status);
>      }
>  }
> --=20
> 2.20.1


