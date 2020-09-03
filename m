Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD51C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3143720767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee1Krm27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3143720767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoGc-00011Y-9r
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDoFf-0000PD-W3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:22:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDoFd-0006yT-Pt
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599135720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bL4+RLZNPtPowLWyZzqifgoTNmE/onbJQ3rg0Lg+lfI=;
 b=Ee1Krm27kH+hj7HoOOq+LddTmTQ3wfD+S0C9Jg6hbrZ2G1z7p3BaR/WT5fgo5oH4z1YZo9
 b8e8dsr2WXbjqBFq1Tc6mRoeQo227HYLTeOJev1sNs9+fSvlYSW/iATAok0eXzvy+F2wLh
 VER3/HJHNCtixlWHJ44rptSBv+BgdhY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-9rCuhk1mOQOaMeBYRakzhQ-1; Thu, 03 Sep 2020 08:21:57 -0400
X-MC-Unique: 9rCuhk1mOQOaMeBYRakzhQ-1
Received: by mail-qt1-f200.google.com with SMTP id e11so1961864qth.21
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bL4+RLZNPtPowLWyZzqifgoTNmE/onbJQ3rg0Lg+lfI=;
 b=WWEhaoLJF74pyeE3+n/l9psAz/9Df68uSL+oGooFG+l/29C4DHtTVb7UA4ezfi36Zb
 lYodP7uyJ9VJGsGbzbFMe3qgtNMpHHlya8+PFI1jT+gTgxVdUtDSYsNpOnF4aS9RGMQi
 u+Dz4wOh6y6+uyEwu28xrONl48Bfx4qZb64B+CK8mPEesO30eh2Qbju5yirFZ6Mv7l58
 wbokrL4qHiChaPvrvhEo9e4+dNISskDono9Udf1B4G9+DMT1AKhbylIYrslSRImcaDh2
 Sutqxqv1LHl19Iby5xtltOAZFXLEOU+HG81ISm62swlVFmwrvIuP9obYN58CL4LIV651
 e5XQ==
X-Gm-Message-State: AOAM530JEbkJSwP0Zx9ZEpd9Y7nYsHtmLpJR/wmLi91wic3UixTLOofO
 Qf0/FEIarEHx0JuRL5JnoZfiqVXMdKGz0VQBzUxy4LIiRQRJZczLpxDqwbWZnLco/dDLVPp4vMd
 +dkTpEZF2XAiyZcH650NnjFOH3ES9TMg=
X-Received: by 2002:ac8:7551:: with SMTP id b17mr3023338qtr.27.1599135716854; 
 Thu, 03 Sep 2020 05:21:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLvIbxdfTZTrwiGtkbC8yGjb4AzhkbqQ7alDrIVSOBDGyq1z5PSHAGMtu4pM0Qa/raZThj7uclFJj+c0lVV6w=
X-Received: by 2002:ac8:7551:: with SMTP id b17mr3023315qtr.27.1599135716608; 
 Thu, 03 Sep 2020 05:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-4-eperezma@redhat.com>
 <58783cf8-ef7f-1481-8c5e-acd76a8b752f@redhat.com>
 <CAJaqyWeTruYQGz5CedQW3ogMNO_B77QFRYW-+M_e-pemjvoobg@mail.gmail.com>
 <99c1436d-7701-e7d9-ec3a-c47566aa1ce2@redhat.com>
In-Reply-To: <99c1436d-7701-e7d9-ec3a-c47566aa1ce2@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 3 Sep 2020 14:21:19 +0200
Message-ID: <CAJaqyWefuJEAzLhnyyH=2tLQw90BqT9r53-HWGno29rUNXLnhg@mail.gmail.com>
Subject: Re: [RFC v8 3/5] memory: Add IOMMU_DEVIOTLB_UNMAP
 IOMMUTLBNotificationType
To: Auger Eric <eric.auger@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eperezma@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 3, 2020 at 1:06 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Eugenio,
> On 9/3/20 12:13 PM, Eugenio Perez Martin wrote:
> > Hi Eric,
> >
> > On Wed, Sep 2, 2020 at 12:32 PM Auger Eric <eric.auger@redhat.com> wrot=
e:
> >>
> >> Hi Eugenio,
> >>
> >> On 9/1/20 4:26 PM, Eugenio P=C3=A9rez wrote:
> >>> Adapt intel and vhost to use this new notification type
> >> I think you should explain in the commit message what is the benefice =
to
> >> introduce this new event type.
> >
> > Will do, thanks!
> >
> >>>
> >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>> ---
> >>>  hw/i386/intel_iommu.c | 2 +-
> >>>  hw/virtio/vhost.c     | 2 +-
> >>>  include/exec/memory.h | 2 ++
> >>>  3 files changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >>> index 0c4aef5cb5..cdddb089e7 100644
> >>> --- a/hw/i386/intel_iommu.c
> >>> +++ b/hw/i386/intel_iommu.c
> >>> @@ -2468,7 +2468,7 @@ static bool vtd_process_device_iotlb_desc(Intel=
IOMMUState *s,
> >>>          sz =3D VTD_PAGE_SIZE;
> >>>      }
> >>>
> >>> -    event.type =3D IOMMU_NOTIFIER_UNMAP;
> >>> +    event.type =3D IOMMU_NOTIFIER_DEVIOTLB;
> >> If this is used only for device IOTLB cache invalidation, shouldn't th=
is
> >> be named IOMMU_NOTIFIER_DEVIOTLB_UNMAP to be consistent with the rest?
> >>>      event.entry.target_as =3D &vtd_dev_as->as;
> >>>      event.entry.addr_mask =3D sz - 1;
> >>>      event.entry.iova =3D addr;
> >>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>> index 1a1384e7a6..6ca168b47e 100644
> >>> --- a/hw/virtio/vhost.c
> >>> +++ b/hw/virtio/vhost.c
> >>> @@ -729,7 +729,7 @@ static void vhost_iommu_region_add(MemoryListener=
 *listener,
> >>>      iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> >>>                                                     MEMTXATTRS_UNSPEC=
IFIED);
> >>>      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> >>> -                        IOMMU_NOTIFIER_UNMAP,
> >>> +                        IOMMU_NOTIFIER_DEVIOTLB,
> >>>                          section->offset_within_region,
> >>>                          int128_get64(end),
> >>>                          iommu_idx);
> >>> diff --git a/include/exec/memory.h b/include/exec/memory.h
> >>> index 8a56707169..215e23973d 100644
> >>> --- a/include/exec/memory.h
> >>> +++ b/include/exec/memory.h
> >>> @@ -87,6 +87,8 @@ typedef enum {
> >>>      IOMMU_NOTIFIER_UNMAP =3D 0x1,
> >>>      /* Notify entry changes (newly created entries) */
> >>>      IOMMU_NOTIFIER_MAP =3D 0x2,
> >>> +    /* Notify changes on device IOTLB entries */
> >>> +    IOMMU_NOTIFIER_DEVIOTLB =3D 0x04,
> >>>  } IOMMUNotifierFlag;
> >>>
> >>>  #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMA=
P)
> >> shouldn't we rename this one??
> >>>
> >>
> >
> > Agree, but I'm not sure about the right name. IOMMU_NOTIFIER_ALL_ROOT?
> > IOMMU_NOTIFIER_ALL_REGULAR?
> I would rather name it IOMMU_NOTIFIER_IOTLB_EVENTS versus
> IOMMU_NOTIFIER_DEVIOTLB_EVENTS? This is the cache type that differs,
> isn't it?
>

Ok will propose it.

Thanks!

> Thanks
>
> Eric
> >
> > Thanks!
> >
> >> Thanks
> >>
> >> Eric
> >>
> >
> >
>


