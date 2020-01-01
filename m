Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88192C2D0DE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 23:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D68120722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 23:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7TEZi08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D68120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imnfK-0004o5-B9
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 18:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1imneg-0004P0-SR
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1imnee-0001HK-6e
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:43:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35140
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1imned-0001DP-Rs
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 18:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577922234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/5tuwMscxP1GV6aVSN3u9jCI6bMeFI6luevqafuacA=;
 b=e7TEZi08uWJFlR8kHe6q+VvG20O2gzAlwG5a/c4AnAoE9O9AhUYvUHQxwBd/UgdWOw9lO2
 lpKY/tdYPfx2Xni1SCNR6tbeTOjiRoxCQr2t5xFTFQHQ9LEuBBuC+p12kjE6ZQcMiDwQi6
 fTUxQFZqB+NOkFOdf/4sT5f9At5rfMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-_k2uwXE-NvSH-tGltudsIw-1; Wed, 01 Jan 2020 18:43:52 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so14712333wrp.10
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 15:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CiXFn+iZBeRp0P9E9p0aFCnuW/O3DRy5jdc/3JHhR9w=;
 b=eYgDAmEOoFJ/yTOryfFTeR5yQ+dEyX4gaf9BwxGzqzUwrXUgBUS3ML0+Ul+xFowK0o
 9AuCnsO0UfqyMhfdx3GyERc+4l5KnpE/HJb86L9JpMcGS3TZqPkbgnS7e/Uhkshzno9h
 nIsBIl0SQSahhz/Kw0sje7LjvzjegbWdH+uv2eA7bf9NAz7VwhYPmpdCu63bOKcjUjA8
 2eQI/rzcP1syjXMbzl6TKo5tWnOkZQBC82iMm4ygVf2UdLy6l1eCduxsob+MAf8hleZ5
 NFbhhQNFM5kfJTT+rNz/NdkU+wp5/DkinhwrWrdoUu3SW47FyoLoN0rHWLlA0ZxNODy3
 Irqw==
X-Gm-Message-State: APjAAAXXw42DlXdpRIkOny10f0bw8M7HjRZ4mLmU7wIvL9RBN10So7Gf
 r/O4l32NiQuteWCeUBcIQUTB/M0tJdOW2EoEiyQT8ITwScwMvnaIDXTTJhwGvWRHeMVGFAYDCJb
 alD3u1+6w1wdxv7A=
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr31526458wrt.343.1577922231691; 
 Wed, 01 Jan 2020 15:43:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmm0cP7JZ+D/Gcy1zzx/K+JFm0ydIpaWOmJnhjugG6WkbJPofegVE/BHKU+Xgq4pTo2XeLvw==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr31526447wrt.343.1577922231491; 
 Wed, 01 Jan 2020 15:43:51 -0800 (PST)
Received: from redhat.com (89.20.181.189.static.ef-service.nl. [89.20.181.189])
 by smtp.gmail.com with ESMTPSA id r5sm53381842wrt.43.2020.01.01.15.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2020 15:43:50 -0800 (PST)
Date: Wed, 1 Jan 2020 18:43:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 2/2] virtio-net: delete also control queue when TX/RX
 deleted
Message-ID: <20200101184128-mutt-send-email-mst@kernel.org>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-3-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20191226043649.14481-3-yuri.benditovich@daynix.com>
X-MC-Unique: _k2uwXE-NvSH-tGltudsIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 26, 2019 at 06:36:49AM +0200, Yuri Benditovich wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1708480
> If the control queue is not deleted together with TX/RX, it
> later will be ignored in freeing cache resources and hot
> unplug will not be completed.
>=20
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index db3d7c38e6..f325440d01 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3101,7 +3101,8 @@ static void virtio_net_device_unrealize(DeviceState=
 *dev, Error **errp)
>      for (i =3D 0; i < max_queues; i++) {
>          virtio_net_del_queue(n, i);
>      }
> -
> +    /* delete also control vq */
> +    virtio_del_queue(vdev, max_queues * 2);
>      qemu_announce_timer_del(&n->announce_timer, false);
>      g_free(n->vqs);
>      qemu_del_nic(n->nic);

Do we need to limit this to when ctrl vq exists?

> --=20
> 2.17.1


