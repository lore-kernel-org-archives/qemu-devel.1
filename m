Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DD2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B573206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 19:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8hGnRzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B573206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDCBE-00075N-Vi
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 15:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDCAS-0006f4-FI
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:42:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kDCAP-00081j-Fm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 15:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598989323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wvuoNF3RQTyE5wvEUAKlhL45NwYwjucFNRxr5XvZSI=;
 b=O8hGnRzpYY6PZ7iVkWH2ofI7xDqDSRkJ5Dql1/0+/DKkj/S/oic7Da92yCDwFRHEW7NVb+
 TKYVjSqaUm2zjvXp4zoUr0QXPdZTRWQg/npduv+nQdq40A0aNVnZJvrnOv1wIKjLpGZH+G
 JXN4ME77jWDlDz9umZyAFif83KEUIzo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-fcFrb1GJOZuZO5vNAVyeqA-1; Tue, 01 Sep 2020 15:35:11 -0400
X-MC-Unique: fcFrb1GJOZuZO5vNAVyeqA-1
Received: by mail-qk1-f197.google.com with SMTP id q131so1681895qke.22
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 12:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7wvuoNF3RQTyE5wvEUAKlhL45NwYwjucFNRxr5XvZSI=;
 b=YI+cxlglbtpVVB0ZMsf46/hNSPM0TPnQci5YxBJIlI64kFrkioeyElHKVO56Uk51n7
 fSkcdqDRFDYDkWFjFSFU8+qKzle7+48XPxPUKlC77V+c93CYrbuXp5ef2CVm90WisbBr
 blAoJAku3tIxU42/3m9WauhJTeApp/yxrgJnhNULtiVKVgXBzhsAnT0QZOVHB5eUZD2j
 A2OMBpu8ynlRJOTJTPpYgqLFIdezff0NycHsHvVBfletJvzNcBSxq05FXUnulZoErule
 hw7Qtyy8IGFpGSxav2lqnsKJP8QmiOh8uMsOQ6G5Ehr3ThBX/AZnPp3qUhiklo8zrMBI
 O5vg==
X-Gm-Message-State: AOAM531cWEU5hQ/MkB5d4LcraRrRPLw2lPNJEmUY/o4iK7bO3A6BKbgr
 SymcrUWC4rkSEadg1Al+mIrTcG4vqBFRJ/ejV1FkDKQ7JCqf4f3LK+ozfI1QgyZqzPrhLrRH+Wg
 QN4OySUHjl5mOUJw=
X-Received: by 2002:a37:a5ca:: with SMTP id o193mr3500872qke.126.1598988907830; 
 Tue, 01 Sep 2020 12:35:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5vpDPHuEoeRjA+7G76S4eAH4lBpjIIG/bwy6TAuu1zj//t4DLPGHco7+LkaFww59+A1cHUw==
X-Received: by 2002:a37:a5ca:: with SMTP id o193mr3500847qke.126.1598988907547; 
 Tue, 01 Sep 2020 12:35:07 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id b9sm2540163qtt.39.2020.09.01.12.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 12:35:06 -0700 (PDT)
Date: Tue, 1 Sep 2020 15:35:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
Message-ID: <20200901193504.GA3053@xz-x1>
References: <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
 <20200819155051.GA275003@xz-x1>
 <f010e8c0-6713-a2bc-ce6b-98af5e4638be@redhat.com>
 <20200821141250.GC358043@xz-x1>
 <5e06e59d-7810-6863-20c7-d1660099cc51@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5e06e59d-7810-6863-20c7-d1660099cc51@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 05:11:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 01, 2020 at 11:05:18AM +0800, Jason Wang wrote:
> 
> On 2020/8/21 下午10:12, Peter Xu wrote:
> > On Thu, Aug 20, 2020 at 10:28:00AM +0800, Jason Wang wrote:
> > > On 2020/8/19 下午11:50, Peter Xu wrote:
> > > > On Wed, Aug 19, 2020 at 03:15:26PM +0800, Jason Wang wrote:
> > > > > Yes, actually, I feel confused after reading the codes. Is notifier->start
> > > > > IOVA or GPA?
> > > > > 
> > > > > In vfio.c, we did:
> > > > > 
> > > > >           iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > > > >                               IOMMU_NOTIFIER_ALL,
> > > > >                               section->offset_within_region,
> > > > >                               int128_get64(llend),
> > > > >                               iommu_idx);
> > > > > 
> > > > > So it looks to me the start and end are GPA, but the assertion above check
> > > > > it against IOVA which seems to be wrong ....
> > > > It should be iova; both section->offset_within_region and llend are for the
> > > > device's iova address space.  Thanks,
> > > > 
> > > Interesting, how can memory region know which IOVA is used by guest?
> > Does it need to know? :)
> > 
> > AFAICT what we do here is only register with the whole possible IOVA address
> > space (e.g., across the whole 64bit address space).  Then vfio will get
> > notifications when there're new iova ranges mapped into it.
> 
> 
> Right, but the whole IOVA address space should be something vIOMMU specific,
> e.g for Intel it should be calculated by GAW, but I found:
> 
>         memory_region_init_iommu(&vtd_dev_as->iommu,
> sizeof(vtd_dev_as->iommu),
>                                  TYPE_INTEL_IOMMU_MEMORY_REGION, OBJECT(s),
>                                  name, UINT64_MAX);
> 
> which assumes UINT64_MAX.

Right.  AFAICT it can be reduced to gaw width, but I don't see a problem either
even with UINT64_MAX (as long as it covers the range specified by gaw).  Or did
I miss something?  Thanks,

-- 
Peter Xu


