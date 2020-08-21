Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E408204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1/gNEp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E408204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97tR-0004GI-Go
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k97mt-0007CH-3y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k97mq-0005Hv-NG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598019175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnu3faAQWyl+e8A6UIKuXR4sQSq+t2oRuGotuy3z5Tg=;
 b=a1/gNEp1GggpSIkre4qB0BYZpmuDSgK1QuMgg4fMadLZf1gJXDcUlZ4lkcS+k7jnCLTKXc
 BOXxyzXpREAeLJ8fLrbTE8GUolfVci4UH47S2yiSMzc3yQAwBjMMZWALE3uX8RYzMbSeHV
 24H+iLcQIih3/g9NEHVM+6HSSEpMAP8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-skL5kW-gMJ21bMJ0_NQoJw-1; Fri, 21 Aug 2020 10:12:54 -0400
X-MC-Unique: skL5kW-gMJ21bMJ0_NQoJw-1
Received: by mail-qt1-f197.google.com with SMTP id m88so1321121qtd.15
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cnu3faAQWyl+e8A6UIKuXR4sQSq+t2oRuGotuy3z5Tg=;
 b=ItZRaj+kzJVZ11JVpdnNbirS7sWq8Vt3YSrap9bYprbHKiOSO8+J9kuHXqPJc6Edtv
 iJV+HpB0AId6tBHE/a+qTou9RocvF6RkL+2p8WHcNUw3W3X69O8g/sSFNewBSGrJ05mS
 /Ri75RaFZKLYLvuofIl087bIa3mJayuYCojIXWU6jN0VGdazU4dvHda5LIFlh9pZXquC
 iccuJbYiADhMmu/5edRgN9tYlhVKiW0v44URKgdz1LpuwFHyoAg5MmjLSwzBtMczYkWm
 zBZ0+I2s55HZGT7lEpQUaLhOSxSTC1kwo4KgdHuzglzkuSYxQH1qMNHEGynSLWzSRKTN
 SBJw==
X-Gm-Message-State: AOAM530dbWEGJ7a6Po3wFUXxjpM3+4a9zVeay5lMiSlwLFRw5ATlZkJK
 jsYJnpHORsytKJvrKK63ny++NWBflWUOz88gAGUZtjrAQcj1iXLtxu5P/7Y5VfXkL2BW2aIlbho
 KkZ09XMT5iWjF/lM=
X-Received: by 2002:a0c:d98d:: with SMTP id y13mr2595322qvj.203.1598019173579; 
 Fri, 21 Aug 2020 07:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUYA6SsM09K1c47H5Xwm/C6fq2Lv7D1/cDKf7zjPMNlMkr+Gda8ruVFbDg5aGyQEHOhsiddw==
X-Received: by 2002:a0c:d98d:: with SMTP id y13mr2595300qvj.203.1598019173319; 
 Fri, 21 Aug 2020 07:12:53 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id p189sm1839139qkb.61.2020.08.21.07.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 07:12:52 -0700 (PDT)
Date: Fri, 21 Aug 2020 10:12:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v3 1/1] memory: Skip bad range assertion if notifier
 supports arbitrary masks
Message-ID: <20200821141250.GC358043@xz-x1>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <20200811175533.7359-1-eperezma@redhat.com>
 <20200811175533.7359-2-eperezma@redhat.com>
 <2443886f-2109-e048-b47f-886c896613ab@redhat.com>
 <CAJaqyWe0_wcXHgbAVAVNCTpG7O4YKF6FMkgKsf6SfW4dEZ4A5g@mail.gmail.com>
 <CAJaqyWe+KgnVegtprpRmVvXo7kFVFDL_erK_5Nyp4K=gTUcN=Q@mail.gmail.com>
 <eb26c5d7-465a-34ed-3f8f-bad11eda5bee@redhat.com>
 <20200819155051.GA275003@xz-x1>
 <f010e8c0-6713-a2bc-ce6b-98af5e4638be@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f010e8c0-6713-a2bc-ce6b-98af5e4638be@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 20, 2020 at 10:28:00AM +0800, Jason Wang wrote:
> 
> On 2020/8/19 下午11:50, Peter Xu wrote:
> > On Wed, Aug 19, 2020 at 03:15:26PM +0800, Jason Wang wrote:
> > > Yes, actually, I feel confused after reading the codes. Is notifier->start
> > > IOVA or GPA?
> > > 
> > > In vfio.c, we did:
> > > 
> > >          iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > >                              IOMMU_NOTIFIER_ALL,
> > >                              section->offset_within_region,
> > >                              int128_get64(llend),
> > >                              iommu_idx);
> > > 
> > > So it looks to me the start and end are GPA, but the assertion above check
> > > it against IOVA which seems to be wrong ....
> > It should be iova; both section->offset_within_region and llend are for the
> > device's iova address space.  Thanks,
> > 
> 
> Interesting, how can memory region know which IOVA is used by guest?

Does it need to know? :)

AFAICT what we do here is only register with the whole possible IOVA address
space (e.g., across the whole 64bit address space).  Then vfio will get
notifications when there're new iova ranges mapped into it.

-- 
Peter Xu


