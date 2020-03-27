Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C1FC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8D420658
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbkrAl83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8D420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHroz-0002fF-T9
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHroL-000291-2e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHroJ-0002Zj-GS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:26:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHroJ-0002Xq-Cw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585326378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezOFnLzUADpyQ4GrkDQ00Tfq0u1WbZB2xcWvMfBtHDM=;
 b=cbkrAl83x5B3TR2erW46odLSflsQELgsTlM8G+aGDLrtzcth6XMNuo3LnORTuj5BucIVCw
 4wmCGwZCkYjjUPEZ0tc/gSuie/hbwKHEcXmjPUB75D7N6n2MHVmtUieZ1gewLczLjLP69h
 aghxSfq1mLEGUUPf2snCsp64OQoY65E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-MCnkKiPPPKKXKqptzfflZw-1; Fri, 27 Mar 2020 12:26:16 -0400
X-MC-Unique: MCnkKiPPPKKXKqptzfflZw-1
Received: by mail-wm1-f70.google.com with SMTP id s14so4038398wmj.9
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 09:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FeDpo2CmL1gGY6sENPZxKlfP/U2QVlpoTA3tv+IamEM=;
 b=X85E3tlzclnUmlXpSifUjUtCXsoMHVjio4y84A/DONgMV2hmJKfaVHhh3YXn2CWuhz
 dBJcGci4X3J7RQDtnAq5jFHWHmhFK1xQNudknMUA0HXq00iMF1iXP6RHJb8BT3EO4xNt
 qYZEbi0cLbOE+YoslW5nKfCz3dyaTEe6F83lEGwvufNfB2nKEINUub0yca9kSJuC4EyH
 klol4WscN65VlSJyp3ggDHZiDeTAb+YR/sVQ3L2liDYB0eJBtnzcjEHwqrrFvBp2sUcl
 GWQdQ8W+DCdcvHmAO91augs++43ndxDWcPkBqIej95etT8fgldB8gpUMAKU8KKVi1gIN
 tsEA==
X-Gm-Message-State: ANhLgQ2LaGQvRUmZOBkidhC03mSZjkjGmblFd56chs+G1w3iwA5uL/N9
 MgTYVJIeqsBPYIddbOJziODIxsIn4nbsuxtHWxC7gsszBvsLqCFRaodgky2VWiOsoK7BbiMu+eP
 RbWd5nkoGOD2ZwoE=
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr183712wrq.345.1585326375546;
 Fri, 27 Mar 2020 09:26:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtA9vW6/qwn891AaDNo88Nafyl4cml1tflw36Lh+4bZnhbzn2t+CBOv01wKwUJnjWP8gNb2XA==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr183698wrq.345.1585326375361;
 Fri, 27 Mar 2020 09:26:15 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id i21sm9091175wmb.23.2020.03.27.09.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 09:26:14 -0700 (PDT)
Date: Fri, 27 Mar 2020 17:26:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH v3 2/2] virtio-iommu: delete vqs in unrealize to fix
 memleak
Message-ID: <20200327162612.ic2ymmpfvyt5xbnp@steredhat>
References: <20200327095642.18424-1-pannengyuan@huawei.com>
 <20200327095642.18424-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200327095642.18424-3-pannengyuan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Fri, Mar 27, 2020 at 05:56:42PM +0800, Pan Nengyuan wrote:
> req_vq/event_vq forgot to free in unrealize. Fix that.
> And aslo do clean 's->as_by_busptr' hash table in unrealize to fix anothe=
r leak.

s/aslo/also

Maybe we can also update the subject in something like this:
"virtio-iommu: avoid memleak in the unrealize"

>=20
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Acked-by: Eric Auger <eric.auger@redhat.com>
> ---
> Cc: Eric Auger <eric.auger@redhat.com>
> ---
> v3->v1/v2:
> - Aslo clean 's->as_by_busptr' hash table in unrealize.(Suggested by Stef=
ano Garzarella)
> ---
>  hw/virtio/virtio-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 4cee8083bc..694698fa0f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -696,7 +696,10 @@ static void virtio_iommu_device_unrealize(DeviceStat=
e *dev, Error **errp)
>      g_tree_destroy(s->domains);
>      g_tree_destroy(s->endpoints);
> =20
> +    virtio_delete_queue(s->req_vq);
> +    virtio_delete_queue(s->event_vq);
>      virtio_cleanup(vdev);
> +    g_hash_table_destroy(s->as_by_busptr);

If you need to respin, you could move g_hash_table_destroy()
at the beggining of unrealize(), just to follow a reverse order of
realize().

Thanks,
Stefano

>  }
> =20
>  static void virtio_iommu_device_reset(VirtIODevice *vdev)
> --=20
> 2.18.2
>=20
>=20


