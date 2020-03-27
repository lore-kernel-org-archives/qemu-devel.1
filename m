Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD3C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:04:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C007206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsP661kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C007206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHkuY-000372-Ff
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHktp-0002ao-A8
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHktn-00049w-RH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:03:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHktn-000473-Ms
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585299810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9ZXxd+otGLFKV9zNmsAMnci/ht8sgy82YcJhprkxhY=;
 b=VsP661kQfNWou9xDduQjCmLdcE9isv96B8/PcCoIiPkoakAC3fi8pG/E/6frOTt5fT8UFC
 78+8FDYjr4m4f3c9UNOjYrAxHbl2tz2fgfX4tinnECZZqtwQWIXbFNeYR258eVVmZL2zg0
 qmFviayNpsdw0EziCnKvLeRdg/q47PI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-KzXho_BRMYeUXX0PY016bg-1; Fri, 27 Mar 2020 05:03:26 -0400
X-MC-Unique: KzXho_BRMYeUXX0PY016bg-1
Received: by mail-wm1-f72.google.com with SMTP id s14so3634195wmj.9
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=esJ1e/t5lGoB4qLbZ7c/zNcWYUZebybi7hCiQoFubUU=;
 b=ZdWq6GWDQfDkwk6Z5lkTItSLrIbEVt9QcwRseFgz7WUJd4m7SSTa8V4pjTuFgEkhUG
 4ngOJRPRVFmfdDzz3V2LJzKPRgBIYi3AUR50kG5uJFgALjKY5D8K3n2gpff7tuaPbPaB
 7GHrEjomM/aqb/RwcWGZjhID2vfnTk8mZ1L25YdnKtUb7S0BZGCQQUb7F9H7pepJoVjX
 N87WJKCjk7altFiCIHPwCTs/Za3DpleI+30XDbArQWVIZQNPi2r0CiPav+dDcR48BBXE
 SL5F+oCmSnGmct/0v+cOrPB8wCeXTX3XjgwkILlDFnb9GI2lXNraMzetQy5IJCm1MGho
 NPtw==
X-Gm-Message-State: ANhLgQ3L791uUF2H0PvpYeN1favcLtE7wnyoN5n0qdn4184/i9qCKAQM
 /K1NhzB6NVtx8uUsZC4Kb1dvI+oA63BrxobSGDHyK9DUoC4DRiCKQxYvv28pkqb27Qzl7COsHCZ
 G2FfxVKE2zU7zjEs=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr4246197wma.158.1585299805477; 
 Fri, 27 Mar 2020 02:03:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvApV1+WLa8a9fg8Rld5ZuOJMw8kl81XQ4g9wXqFKGDxXUQyJbL08h6yBgevQy0ztVi7T/RaA==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr4246173wma.158.1585299805270; 
 Fri, 27 Mar 2020 02:03:25 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id r11sm7830875wrn.24.2020.03.27.02.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:03:24 -0700 (PDT)
Date: Fri, 27 Mar 2020 10:03:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v2 2/2] virtio-iommu: delete vqs in unrealize to fix
 memleak
Message-ID: <20200327090322.gxlfxmbuvcjut5dk@steredhat>
References: <20200327045620.9082-1-pannengyuan@huawei.com>
 <20200327045620.9082-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200327045620.9082-3-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Eric Auger <eric.auger@redhat.com>, zhang.zhanghailiang@huawei.com,
 mst@redhat.com, qemu-devel@nongnu.org, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 12:56:20PM +0800, Pan Nengyuan wrote:
> req_vq/event_vq forgot to free in unrealize. Fix that.
>=20
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/virtio/virtio-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..9d2ff0693c 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -696,6 +696,8 @@ static void virtio_iommu_device_unrealize(DeviceState=
 *dev, Error **errp)
>      g_tree_destroy(s->domains);
>      g_tree_destroy(s->endpoints);
> =20
> +    virtio_delete_queue(s->req_vq);
> +    virtio_delete_queue(s->event_vq);
>      virtio_cleanup(vdev);
>  }

Hi Pan,
this patch LGTM, I left a comment on v1 about cleaning 's->as_by_busptr'
hash table as well.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano


