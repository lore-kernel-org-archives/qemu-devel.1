Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959F3C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB5D2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1GXLSbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB5D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK4I3-0004AD-HJ
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jK4HU-0003iX-GI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jK4HS-0003Y5-T6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:09:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jK4HS-0003XT-P2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585850969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KUuii1QviN2lUgMH8u/i/G+Gbe3w+f2TOZmoPq9pvDU=;
 b=F1GXLSbseFeQfX0bG06TLMD6FbXuRfXNOAlhnA9dB3g1qqGg6nGy9KSWpB1AFFf7U8mIxC
 4JxPXGRRe66NG890FCJACsSrDqLAFxubi8Vshsv1q/bY3ewYac1wgcdVldPEdPGnB5mlBR
 3xKH/erAKg3l5ZHsbREp8nQh9ovo1c4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-mL7a17zSPna08YRzqI9nMA-1; Thu, 02 Apr 2020 14:09:27 -0400
X-MC-Unique: mL7a17zSPna08YRzqI9nMA-1
Received: by mail-wr1-f72.google.com with SMTP id q14so1818715wro.7
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BYGlXLwwyBgS36YV5wEkNKPI/aX5YIakZvgpmmU8bos=;
 b=NUxDF8mcLWoSjYZzUwRLAv16kXpU3uHyUoNmdBDulWEqhZWbPoyb7DuEvm5dFd3GGX
 JPZsb3iJsttWge9MKYksUR3d4pjWJ7mLA0N2+cdVuESv9vYIJFNp68lcgwuBh43Q1XyV
 4DnniH2/JrqzhoKsMNzVij3+b6qIoCGRTUV86Xvowf41iH+w5cHNiWmFGPo8TNA6hnXk
 issvZFQRALdTI1onnDYpNiVspxSVviR5nYcxjsxu3jP29cd+j8bttgqcPspRgOcPWCth
 /IstP8qHlW4NkfCZahYw1kTzjij7agKW9up0kce5Utw6Jnv+dsef9xUSLy0BKF1A2tHJ
 dY4A==
X-Gm-Message-State: AGi0PubO17fHrkK+jlldnvxQThfjmfRP9OE3AaAr6/Z/qmzfwidcmAud
 0OtR2lO5BqBq6rlHk86ss9ETRJiAu7cF7TeAkVrtY6paYvE0OrpQR89Nlo29qFkB45HJ+QaTXxM
 BMnRB2YEFv+QKhgY=
X-Received: by 2002:a7b:c343:: with SMTP id l3mr4761400wmj.38.1585850966853;
 Thu, 02 Apr 2020 11:09:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyG70A7UCR5fhQk5BBlq4+WqeXvaVHltohvb6yhXwm60j2oQgl8OXZkqzptTlvn5SGWC9XLQ==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr4761369wmj.38.1585850966592;
 Thu, 02 Apr 2020 11:09:26 -0700 (PDT)
Received: from xz-x1 (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca.
 [72.137.123.47])
 by smtp.gmail.com with ESMTPSA id n11sm9367892wrg.72.2020.04.02.11.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 11:09:25 -0700 (PDT)
Date: Thu, 2 Apr 2020 14:09:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 15/22] intel_iommu: bind/unbind guest page table to host
Message-ID: <20200402180920.GD103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-16-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-16-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 09:24:54PM -0700, Liu Yi L wrote:
> +static int vtd_bind_guest_pasid(IntelIOMMUState *s, VTDBus *vtd_bus,
> +                                int devfn, int pasid, VTDPASIDEntry *pe,
> +                                VTDPASIDOp op)
> +{
> +    VTDHostIOMMUContext *vtd_dev_icx;
> +    HostIOMMUContext *iommu_ctx;
> +    DualIOMMUStage1BindData *bind_data;
> +    struct iommu_gpasid_bind_data *g_bind_data;
> +    int ret =3D -1;
> +
> +    vtd_dev_icx =3D vtd_bus->dev_icx[devfn];
> +    if (!vtd_dev_icx) {
> +        /* means no need to go further, e.g. for emulated devices */
> +        return 0;
> +    }
> +
> +    iommu_ctx =3D vtd_dev_icx->iommu_ctx;
> +    if (!iommu_ctx) {
> +        return -EINVAL;
> +    }
> +
> +    if (!(iommu_ctx->stage1_formats
> +             & IOMMU_PASID_FORMAT_INTEL_VTD)) {
> +        error_report_once("IOMMU Stage 1 format is not compatible!\n");
> +        return -EINVAL;
> +    }
> +
> +    bind_data =3D g_malloc0(sizeof(*bind_data));
> +    bind_data->pasid =3D pasid;
> +    g_bind_data =3D &bind_data->bind_data.gpasid_bind;
> +
> +    g_bind_data->flags =3D 0;
> +    g_bind_data->vtd.flags =3D 0;
> +    switch (op) {
> +    case VTD_PASID_BIND:
> +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> +        g_bind_data->gpgd =3D vtd_pe_get_flpt_base(pe);
> +        g_bind_data->addr_width =3D vtd_pe_get_fl_aw(pe);
> +        g_bind_data->hpasid =3D pasid;
> +        g_bind_data->gpasid =3D pasid;
> +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> +        g_bind_data->vtd.flags =3D
> +                             (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ? 1=
 : 0)

This evaluates to 1 if VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]), or 0.
Do you want to use IOMMU_SVA_VTD_GPASID_SRE instead of 1?  Same
question to all the rest.

> +                           | (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ? =
1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PCD_BIT(pe->val[1]) ? 1=
 : 0)
> +                           | (VTD_SM_PASID_ENTRY_PWT_BIT(pe->val[1]) ? 1=
 : 0)
> +                           | (VTD_SM_PASID_ENTRY_EMTE_BIT(pe->val[1]) ? =
1 : 0)
> +                           | (VTD_SM_PASID_ENTRY_CD_BIT(pe->val[1]) ? 1 =
: 0);
> +        g_bind_data->vtd.pat =3D VTD_SM_PASID_ENTRY_PAT(pe->val[1]);
> +        g_bind_data->vtd.emt =3D VTD_SM_PASID_ENTRY_EMT(pe->val[1]);
> +        ret =3D host_iommu_ctx_bind_stage1_pgtbl(iommu_ctx, bind_data);
> +        break;
> +    case VTD_PASID_UNBIND:
> +        g_bind_data->version =3D IOMMU_UAPI_VERSION;
> +        g_bind_data->format =3D IOMMU_PASID_FORMAT_INTEL_VTD;
> +        g_bind_data->gpgd =3D 0;
> +        g_bind_data->addr_width =3D 0;
> +        g_bind_data->hpasid =3D pasid;
> +        g_bind_data->gpasid =3D pasid;
> +        g_bind_data->flags |=3D IOMMU_SVA_GPASID_VAL;
> +        ret =3D host_iommu_ctx_unbind_stage1_pgtbl(iommu_ctx, bind_data)=
;
> +        break;
> +    default:
> +        error_report_once("Unknown VTDPASIDOp!!!\n");
> +        break;
> +    }
> +
> +    g_free(bind_data);
> +
> +    return ret;
> +}

--=20
Peter Xu


