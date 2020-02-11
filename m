Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CCC35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38A2206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0YD41OV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38A2206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1auH-0000eu-V4
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1atL-00007a-9i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1atI-0002AH-2S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:08:13 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1atH-00027Y-U0
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581448090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zISgOSzBvEUeQus1hqwUUEZ16+KnIQxw/vCNscMqs4M=;
 b=A0YD41OVNaWgILz7YCA6qmvOIOw9N7IIfydlyvcgtg5hO/wFO2RcEtobG3ZpMn+0ayYu0b
 /nWBcHeawVXI40pBQjHUcYz+XGj9yKJQcEKU34z15R9GtPplmGpq7yMzJfGxqJPQgGbQP4
 4uWCrnaHhaQH8eUVdphR9E9D2xzB0tQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Yc7xIp8yOXuLk2Ap0tFTHw-1; Tue, 11 Feb 2020 14:08:06 -0500
Received: by mail-qt1-f199.google.com with SMTP id l25so7299095qtu.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:08:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QeZKa3K6OW2+02/7q9K48BzrFmMElUkLMajzZiIzT6w=;
 b=Y0ExTSj4zude9nlAtHZPctM/7u+bdftMTM7Ctus21M57UIkCGkX3KJ+ObnrLpDV4UP
 TtPIk0ga2FW9Ple0SS/YcM+yX0yOJbm9Wobrgxmlpkhze+p3NjuUgad83903URY7FRqM
 HaKSwmjHz6HDuD3qU5KQFdQV23veiQqAHZGFLmIP6DhXfQECNAzDll+As1m86+C5fv/h
 FVZLVGXK9sboeK3AWEZJo5hNac1gv14jdIajddLVCOf0VqJnD6IwsGwu/d/UEclHst4d
 YWzaJSZFUWf5/WJTZt+iIhsp06qlNZ50z60Uur6CXYp6/2gVEDJRpJxOE5YYQuMzjSNn
 9h9w==
X-Gm-Message-State: APjAAAWG0FHfn53sNr6gU+9x7DLmjG9XZrdpr0EWAyw4CnByaHxVB6rM
 fxub2HQt39kvkvupDmfigEvIo7UnwSfBoj6eEmxbON5WyeuGWY/P7QO2oHWnGcyGo40b3ne/uWw
 zYbFAVJPti4xYQFU=
X-Received: by 2002:a05:6214:923:: with SMTP id
 dk3mr4111424qvb.96.1581448086555; 
 Tue, 11 Feb 2020 11:08:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZN0k9FUgTBnug2e1nb2U+7Hah/t3y++SpkSCUaYmPBw52LRTVszhDsMvutT8soVeGnIjo+w==
X-Received: by 2002:a05:6214:923:: with SMTP id
 dk3mr4111399qvb.96.1581448086193; 
 Tue, 11 Feb 2020 11:08:06 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id x41sm2739974qtj.52.2020.02.11.11.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:08:05 -0800 (PST)
Date: Tue, 11 Feb 2020 14:08:02 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 09/25] vfio: check VFIO_TYPE1_NESTING_IOMMU support
Message-ID: <20200211190802.GH984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-10-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-10-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: Yc7xIp8yOXuLk2Ap0tFTHw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:40AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> VFIO needs to check VFIO_TYPE1_NESTING_IOMMU
> support with Kernel before further using it.
> e.g. requires to check IOMMU UAPI version.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  hw/vfio/common.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 0cc7ff5..a5e70b1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1157,12 +1157,21 @@ static void vfio_put_address_space(VFIOAddressSpa=
ce *space)
>  static int vfio_get_iommu_type(VFIOContainer *container,
>                                 Error **errp)
>  {
> -    int iommu_types[] =3D { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
> +    int iommu_types[] =3D { VFIO_TYPE1_NESTING_IOMMU,
> +                          VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>                            VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU =
};
> -    int i;
> +    int i, version;
> =20
>      for (i =3D 0; i < ARRAY_SIZE(iommu_types); i++) {
>          if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) =
{
> +            if (iommu_types[i] =3D=3D VFIO_TYPE1_NESTING_IOMMU) {
> +                version =3D ioctl(container->fd,
> +                                VFIO_NESTING_GET_IOMMU_UAPI_VERSION);
> +                if (version < IOMMU_UAPI_VERSION) {
> +                    printf("IOMMU UAPI incompatible for nesting\n");

There should have better alternatives than printf()... Maybe
warn_report()?

> +                    continue;
> +                }
> +            }
>              return iommu_types[i];
>          }
>      }
> @@ -1278,6 +1287,7 @@ static int vfio_connect_container(VFIOGroup *group,=
 AddressSpace *as,
>      }
> =20
>      switch (container->iommu_type) {
> +    case VFIO_TYPE1_NESTING_IOMMU:
>      case VFIO_TYPE1v2_IOMMU:
>      case VFIO_TYPE1_IOMMU:
>      {
> --=20
> 2.7.4
>=20

--=20
Peter Xu


