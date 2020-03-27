Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2422C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE3020714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 08:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbFDQdnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE3020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHklB-0007xo-IG
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 04:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1jHkkd-0007Xz-3O
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1jHkkc-0006rz-0Y
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:54:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1jHkkb-0006qm-Sx
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 04:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585299241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzENusaLyoJHS2f2UlqAF2JKAGUSgZ5MQjiNRaWeL6c=;
 b=MbFDQdntyz27+Q8qSPFGZ/vnsqNJq/iVRuK/5wK7wqLg5dzsyPB38ulJIXzFjYH1Z7T73d
 pL+33R0vSDOuxSIcO3c/qyZxvZ8sHgZ0XMaJLlKJwQaxV6rHDzClHAOeCM84Fs1I1mHu7n
 g6BvmHyyRgG0GOUhUIFYkP3rI/F9twA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-WoT5pBT2OmG-TzqReUArtw-1; Fri, 27 Mar 2020 04:53:57 -0400
X-MC-Unique: WoT5pBT2OmG-TzqReUArtw-1
Received: by mail-wr1-f71.google.com with SMTP id y1so3103027wrp.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 01:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gWwFnTPuR856nYSH8BVNEeOmEcPbbyl1kf+iHiMceY4=;
 b=pPfOys6ICGNKYFt2Ynly77t5+iN3ETWkbpzEpqCNo8WohPFhylIiP7xO905zmEKm+I
 aZkBTgJCFaIshvQf2svMy/F+e1Khw7fahw1APigaruRJ35WsFWg3KfmhT/H9mqxgMKIQ
 keZCqVjZo0kDvk22nYiEe8d3yCMaqGMHTwnC97dmZhZqFFqfsu1/29ZcpiSo1NoedQ1i
 1+VDJBQvNGuQudzII8w2oJNKq07vsr1NO+EMOpF/WURsQLWoOswHVjHQA9YMmpydE0Lp
 mkz+4p9uxVP6fPqUBJanultAbBIXC8+5G1HU8H/AD/wUeMLy/eJ+0jIknRvUz7soCkX+
 +3yg==
X-Gm-Message-State: ANhLgQ2qHfdvpg2job2Tren/y0vzrYHFMVKal1M6YkS4VpCh6CO62TYm
 iXHaNw3ZxIQ8RveD1gYTXXipbHuiAkaOeD7xPj6rjC1WWN3T0Aw8Il56OgR/AgQEb+Oyf5C7I7x
 /NtS0pn+Et3LP+Zo=
X-Received: by 2002:a7b:c0d3:: with SMTP id s19mr4119786wmh.19.1585299236140; 
 Fri, 27 Mar 2020 01:53:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvo9n/M/35ZGxP/ViOEtHO5pJ4A//vYJKczkVlFh3iT3a144F6wBdu2YSKWXyRYJdhuXbedjg==
X-Received: by 2002:a7b:c0d3:: with SMTP id s19mr4119770wmh.19.1585299235920; 
 Fri, 27 Mar 2020 01:53:55 -0700 (PDT)
Received: from steredhat (host32-201-dynamic.27-79-r.retail.telecomitalia.it.
 [79.27.201.32])
 by smtp.gmail.com with ESMTPSA id u17sm8078014wra.63.2020.03.27.01.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 01:53:55 -0700 (PDT)
Date: Fri, 27 Mar 2020 09:53:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 2/2] virtio-iommu: delete vqs in unrealize to fix memleaks
Message-ID: <20200327085352.ncjwiscl5jvjtvmp@steredhat>
References: <20200327035650.2085-1-pannengyuan@huawei.com>
 <20200327035650.2085-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200327035650.2085-3-pannengyuan@huawei.com>
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

On Fri, Mar 27, 2020 at 11:56:50AM +0800, Pan Nengyuan wrote:
> req_vq/event_vq forgot to free in unrealize(). Fix that.
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
thanks for this fix.

Since we are here, should we also clean 's->as_by_busptr' hash table?

Maybe adding this in the unrealize:

    g_hash_table_destroy(s->as_by_busptr);

Thanks,
Stefano


