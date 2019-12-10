Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A812C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291C620828
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hpi8Xmys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291C620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ielMT-0008Sh-9y
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 14:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1ielLh-0007sZ-6q
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1ielLg-0001hp-3l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:39:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33864
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ielLf-0001hS-VM
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 14:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576006746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgAyacV+nZ8CBkg+wqkyy4NV8IkZ01Jpe3cd7x9PNsc=;
 b=Hpi8XmyshdM5vgkcLOMrhLSv80hLwbijdOJyQA9nwH8qSNbmTs3r34/eo79uI7M2Vfu6l9
 oAgCKEWu/5DcfMwuE2/KfJgdKNwPXzNZ1Ev3QEYvpb8Rwgz2Y61HYbc5vDmK0U3ONNsr2J
 95pJRyB7oI8c/Ym/VFkdCh7su0LXZPQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-rlD3eeNeO7-LuhQXzIVORw-1; Tue, 10 Dec 2019 14:39:05 -0500
Received: by mail-qt1-f198.google.com with SMTP id z12so2692341qts.15
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 11:39:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1mymb3Sv3zpDU5FJ6RFLPGZz5uXl0s3penVzv5qXOaM=;
 b=JOVbriUjSQmXPD/N3gceE4QUBVCaYiYlg7DlsHA2kNo1S12TdVR8qBuTQhOPm6ewk0
 nC+7nlXkUd3OIufouLJU6gfF2qHYHnHXdsBNW3hz+1o5mnpKc7OsheFUFT/Re5x3ECim
 MOllyvhhWfSi/ostZR6jVv4Beq+Fk5WoxRY10UrKcDRcWf+gmvU55+Vak4rBhx4QAyi+
 2KAONPKxRqM4f2YnL/UQ8ssX5tUXtwwOo9JwU0QQ67DUehy9OIVr+sRSpPweXOHD9VXG
 4jGckMmrNE1LQ4WXZcEKlJh2u/vJ3slVmDYlyti0WyS1BvzbFBkCifpMISjkG3Bss+B3
 oUeg==
X-Gm-Message-State: APjAAAX9cZmF1w4Cq5457Hzpw6hbkC7NLPFVONvv9XjVsEiRDNZJEHAv
 KXrA1xARGC46aqeHYb8q+HZiES0sKvX3/xBgp6tc3bbUvOFKA792v86E9CMnaYWccnonh87kVTW
 5fOvqD0BDa5vXNc0=
X-Received: by 2002:ad4:498d:: with SMTP id t13mr29235096qvx.58.1576006745420; 
 Tue, 10 Dec 2019 11:39:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvXllWwZgZQ8+UpFxHdOU5dKoBDqTeaIxph01U8VD7I0FDDqMbw38c6MtFbOLuNnmNbHthdw==
X-Received: by 2002:ad4:498d:: with SMTP id t13mr29235067qvx.58.1576006745175; 
 Tue, 10 Dec 2019 11:39:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id o10sm1346480qtp.38.2019.12.10.11.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2019 11:39:04 -0800 (PST)
Date: Tue, 10 Dec 2019 14:39:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH for-5.0 v11 14/20] virtio-iommu: Handle reserved regions
 in the translation process
Message-ID: <20191210193903.GL3352@xz-x1>
References: <20191122182943.4656-1-eric.auger@redhat.com>
 <20191122182943.4656-15-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191122182943.4656-15-eric.auger@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: rlD3eeNeO7-LuhQXzIVORw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, jean-philippe.brucker@arm.com,
 quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 bharatb.linux@gmail.com, qemu-arm@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 07:29:37PM +0100, Eric Auger wrote:
> When translating an address we need to check if it belongs to
> a reserved virtual address range. If it does, there are 2 cases:
>=20
> - it belongs to a RESERVED region: the guest should neither use
>   this address in a MAP not instruct the end-point to DMA on
>   them. We report an error
>=20
> - It belongs to an MSI region: we bypass the translation.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> ---
>=20
> v10 -> v11:
> - directly use the reserved_regions properties array
>=20
> v9 -> v10:
> - in case of MSI region, we immediatly return
> ---
>  hw/virtio/virtio-iommu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1ce2218935..c5b202fab7 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -548,6 +548,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemo=
ryRegion *mr, hwaddr addr,
>      uint32_t sid, flags;
>      bool bypass_allowed;
>      bool found;
> +    int i;
> =20
>      interval.low =3D addr;
>      interval.high =3D addr + 1;
> @@ -580,6 +581,22 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMem=
oryRegion *mr, hwaddr addr,
>          goto unlock;
>      }
> =20
> +    for (i =3D 0; i < s->nb_reserved_regions; i++) {
> +        if (interval.low >=3D s->reserved_regions[i].low &&
> +            interval.low <=3D s->reserved_regions[i].high) {
> +            switch (s->reserved_regions[i].type) {
> +            case VIRTIO_IOMMU_RESV_MEM_T_MSI:
> +                entry.perm =3D flag;
> +                goto unlock;

Might be a bit clearer to break here instead of goto, then..

> +            case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:

               /* Passthrough */

> +            default:
> +                virtio_iommu_report_fault(s, VIRTIO_IOMMU_FAULT_R_MAPPIN=
G,
> +                                          0, sid, addr);
> +            goto unlock;

.. do the same thing here, and...

> +           }

.. goto unlock here..

> +        }
> +    }
> +
>      if (!ep->domain) {
>          if (!bypass_allowed) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> --=20
> 2.20.1
>=20

--=20
Peter Xu


