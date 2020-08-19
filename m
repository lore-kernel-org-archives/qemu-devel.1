Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A222063A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2eqxVNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A222063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QNY-0001c1-HM
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8QMe-0000r8-3w
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:51:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k8QMc-0003ug-2k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597852256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adAG/6yF1So8VKZ3uQx5ywkx0auEsLqx6jb5yUPVDLk=;
 b=H2eqxVNx3UEYEKO3puD8iR5mbE2wtfAxljkMoLyDCx4E/NzBNDSxL3cUBVx3SKMeV4otub
 6ZlHR2fwoAqLs++JH3IMdSCD4v8OjJQMrWQ0FLCFeyrriPNcZe+X6hgbudWL/chQB0reCU
 R6XrRTuGHzNkRITMPhafF8s9gSwBRe0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-4oPvDrNXNnuu-kI8K4O5DA-1; Wed, 19 Aug 2020 11:50:54 -0400
X-MC-Unique: 4oPvDrNXNnuu-kI8K4O5DA-1
Received: by mail-qv1-f71.google.com with SMTP id j8so15937016qvu.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 08:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=adAG/6yF1So8VKZ3uQx5ywkx0auEsLqx6jb5yUPVDLk=;
 b=P6nx0mH+r0tNbPcowDAvWjoRod5Q21oq6ATpqc7MaY0Q12MoykVXOvWio3eUrAEcCl
 nEDusN/DLMmYwBxbp+6QIBq/M7QrwpkjwwahkAbBBLSqGazOGJ3nVPUebgqpjIzegdp1
 GRF8W8JJDQrW01A4k3mdFeNqzDn44fcCSzZJLC/NtumzDZsp2m2cYRW99VVOJ7Ah5kXR
 ZnLAcPLPtgisuIeI1kYGWZjVldOt7QUynNbvttSevheFM/8pRD03h4oDCyRWTO/WA0R9
 EhkAE4iETnDmkhjBH5HW9M1/Nfk7d7Zl55jXL1qxmBBgsz4QcNv9wIErpIWMGm7xKoLV
 8Tfg==
X-Gm-Message-State: AOAM533eMN+tk35GF6/xzUtSFGA91fI+i5btlb7lqaDyjI2vPdmNQIuj
 o+KJLg6DrOa0+LkDmbG9AcOj0ueVPDmJHmi0KKPj+z7zWiM3d7PTYOuXZhGH0Jyxls7ZtpIxjXh
 3UNUC09nIvbJNiX4=
X-Received: by 2002:a05:6214:184a:: with SMTP id
 d10mr23498448qvy.190.1597852254413; 
 Wed, 19 Aug 2020 08:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT34VtSuyIy0QExtGgE8yuD7wu0/2CTCPxBhpvQqZwUUYlVwZ9Z3fBP4TvdEwuy7ESQ+RjOg==
X-Received: by 2002:a05:6214:184a:: with SMTP id
 d10mr23498427qvy.190.1597852254140; 
 Wed, 19 Aug 2020 08:50:54 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id n23sm24550091qkk.105.2020.08.19.08.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 08:50:53 -0700 (PDT)
Date: Wed, 19 Aug 2020 11:50:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
Message-ID: <20200819155051.GA275003@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
MIME-Version: 1.0
In-Reply-To: <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 Avi Kivity <avi@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 03:15:26PM +0800, Jason Wang wrote:
> Yes, actually, I feel confused after reading the codes. Is notifier->start
> IOVA or GPA?
> 
> In vfio.c, we did:
> 
>         iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
>                             IOMMU_NOTIFIER_ALL,
>                             section->offset_within_region,
>                             int128_get64(llend),
>                             iommu_idx);
> 
> So it looks to me the start and end are GPA, but the assertion above check
> it against IOVA which seems to be wrong ....

It should be iova; both section->offset_within_region and llend are for the
device's iova address space.  Thanks,

-- 
Peter Xu


