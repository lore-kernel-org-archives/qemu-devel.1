Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA3420658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 18:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsHtd1iO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA3420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGo4C-0003sr-Fe
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 14:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jGo3b-0003Ss-MZ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jGo3a-00082G-6k
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:13:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49377)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jGo3a-00081T-2r
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 14:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585073621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIq0hAueNaw2xaBzJhuVrKwYaJVaIT0bXwreTSpjy7s=;
 b=HsHtd1iO2LzRMLugmrECT0sC2CIy0OKYuYwo1jcfFdcEEO16b767BTN0KdGoaHTthd5Nua
 HGrk9kso31WYrdRZwwsnyXkhhBtGTF5N/a4RtF+WDDsiREluGZ/BZijN/RqwPDg1RVPp7D
 ybXgssnWH+bevkGhhZ/ufs6Y+NIjZP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-Rqx2ebosPJOx-eVXUniLvQ-1; Tue, 24 Mar 2020 14:13:35 -0400
X-MC-Unique: Rqx2ebosPJOx-eVXUniLvQ-1
Received: by mail-wr1-f71.google.com with SMTP id w11so9599243wrp.20
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z6QLK33i849af4hEmu/J5wDSq8WslN7JUyycX0ysPho=;
 b=e2kMJINny4O+Hnxw4uPepOPQBHEjqDzuA/2nL/hxwkmJ3Ei5XN/3l9ltf9ekbb4p4G
 VulUiiQj3kLIhzjiA9Z79c/GEln4Gbewgh/r7VWHAizQw2CHV0cFGqSXotWsfWePmCk/
 gLuOa+P517W5fZHXfLfIux6mqc7XXefKwx++PzabbrB1JFOzHZD9G6R0mM7kdywDyvaG
 xj7G2GE9xan9mTqFadPiqJ2CIjUKYFXQgC62Hl/ywYPum6ycBeaR5sFXGL0sXQnGLqJr
 CehYRwkBDf1DJ7hRTndT5zZcCQrbZmcvTut5DQes13WdxrRkDTRrXsxQleF5kt3FLr+C
 OamA==
X-Gm-Message-State: ANhLgQ0r5X+640S20Ilv+focHQ0Pi6xmStsBSCEd6oYgqXQPSMoSgsjn
 07/UaKYcpUflCLopFSEu09/8oHVKgsCAz0a6Kha9vJZAz+S69CV89yXH9NEZOqwtGWH7jL4UzQu
 KiKvNeMS7mjufY20=
X-Received: by 2002:a5d:5447:: with SMTP id w7mr9724213wrv.299.1585073613835; 
 Tue, 24 Mar 2020 11:13:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vutjFibWsKyOpF1Og+qU3JJjjdCrScHYPPtGzcpKNpj4B7DycBDMcVXBCXiqossd0yd7z0fGQ==
X-Received: by 2002:a5d:5447:: with SMTP id w7mr9724175wrv.299.1585073613529; 
 Tue, 24 Mar 2020 11:13:33 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k204sm5490292wma.17.2020.03.24.11.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:13:32 -0700 (PDT)
Date: Tue, 24 Mar 2020 14:13:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 17/22] intel_iommu: do not pass down pasid bind for
 PASID #0
Message-ID: <20200324181326.GB127076@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-18-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1584880579-12178-18-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 22, 2020 at 05:36:14AM -0700, Liu Yi L wrote:
> RID_PASID field was introduced in VT-d 3.0 spec, it is used
> for DMA requests w/o PASID in scalable mode VT-d. It is also
> known as IOVA. And in VT-d 3.1 spec, there is definition on it:
>=20
> "Implementations not supporting RID_PASID capability
> (ECAP_REG.RPS is 0b), use a PASID value of 0 to perform
> address translation for requests without PASID."
>=20
> This patch adds a check against the PASIDs which are going to be
> bound to device. For PASID #0, it is not necessary to pass down
> pasid bind request for it since PASID #0 is used as RID_PASID for
> DMA requests without pasid. Further reason is current Intel vIOMMU
> supports gIOVA by shadowing guest 2nd level page table. However,
> in future, if guest IOMMU driver uses 1st level page table to store
> IOVA mappings, then guest IOVA support will also be done via nested
> translation. When gIOVA is over FLPT, then vIOMMU should pass down
> the pasid bind request for PASID #0 to host, host needs to bind the
> guest IOVA page table to a proper PASID. e.g PASID value in RID_PASID
> field for PF/VF if ECAP_REG.RPS is clear or default PASID for ADI
> (Assignable Device Interface in Scalable IOV solution).
>=20
> IOVA over FLPT support on Intel VT-d:
> https://lkml.org/lkml/2019/9/23/297
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  hw/i386/intel_iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1e0ccde..b007715 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1886,6 +1886,16 @@ static int vtd_bind_guest_pasid(IntelIOMMUState *s=
, VTDBus *vtd_bus,
>      struct iommu_gpasid_bind_data *g_bind_data;
>      int ret =3D -1;
> =20
> +    if (pasid < VTD_MIN_HPASID) {
> +        /*
> +         * If pasid < VTD_HPASID_MIN, this pasid is not allocated

s/VTD_HPASID_MIN/VTD_MIN_HPASID/.

> +         * from host. No need to pass down the changes on it to host.
> +         * TODO: when IOVA over FLPT is ready, this switch should be
> +         * refined.

What will happen if without this patch?  Is it a must?

> +         */
> +        return 0;
> +    }
> +
>      vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
>      if (!vtd_dev_icx) {
>          return -EINVAL;
> --=20
> 2.7.4
>=20

--=20
Peter Xu


