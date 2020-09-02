Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197F9C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2262084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6GhyQrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2262084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNjf-00038p-2W
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDNj5-0002U9-38
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:02:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1kDNj3-00011Q-E7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599033756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwgCfN6HrAvoUq/u/IelGJOEpCbdgEM2cmZ9l+uCD98=;
 b=L6GhyQrmzYMlFFZCF54EIiNA+AYrwpb/RoCiV7Uapov4MQXefbe2xKcmB++scT90+oxBTU
 7qx3me7oFHq+RwO9uEd1S7fwuDraaX8G1P6eamoHewuhlO181muqOVPRcNybDgD1o2lGiy
 EBlX5cS0z7ihB1/hP/qsARDIm8FSmOA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-EEHoUdcTO06abhGFVllDCg-1; Wed, 02 Sep 2020 04:02:35 -0400
X-MC-Unique: EEHoUdcTO06abhGFVllDCg-1
Received: by mail-qv1-f71.google.com with SMTP id k17so2848363qvj.12
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VwgCfN6HrAvoUq/u/IelGJOEpCbdgEM2cmZ9l+uCD98=;
 b=mSPUGOO1N0X27Sphxa7fskcz9sLrndzWYN9/t3i19M+T+4N3iNUMFU3RYVumz6UZd6
 B+AScFgPiviulgdhEH20OMHDQrwKHnQ4tdYGow3g4RZNKiIY9GDk67JFu1Lf1E6WP876
 LI+XESywq7AZHlTDTUJdmeexxEz7apn36qKOCHfE8aXfZJh894prrFaoDPSc56Qm1YPs
 CvBjWe+dt+PhXAl3kq5612HA/t1DZQN3u8Hi/Gu0PNkumsrIL+v3N5NVF+FmkOS94w/5
 cc8lzshjC6U71rnAVTriPjIFNf8rucO4vvnMd3o0kbZe0QycVtHn0XnzEva54Vm+euc1
 o7Eg==
X-Gm-Message-State: AOAM532xOmgGdsr1d3VLFIP9aYk6iDn5NoqfV+M2EdhFvgzcIQgRKP9X
 yYVJb5xX+MHhajfPju852JjqPiYGw84eR9cqCztbnV1RKFnJbsva5F/8lPreEvHLFDnu4BK2Udk
 4ea//aQwryqsMlSTb3Dc8Mw89CoztiGY=
X-Received: by 2002:a05:620a:ed3:: with SMTP id
 x19mr5464540qkm.89.1599033754876; 
 Wed, 02 Sep 2020 01:02:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3Q4tX7RC2kdnB0NX2d2SepmXL90MvcajWr9dRb+rJCiebiF3Hswl4zysUBfvc22DK5TL26mUfPoU7yj1H0KE=
X-Received: by 2002:a05:620a:ed3:: with SMTP id
 x19mr5464530qkm.89.1599033754703; 
 Wed, 02 Sep 2020 01:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901211357.GH3053@xz-x1>
In-Reply-To: <20200901211357.GH3053@xz-x1>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Sep 2020 10:01:58 +0200
Message-ID: <CAJaqyWftJ1+3S6ukmU2cTbwDUUD=vnZC=Mu+E=EtLeyHXCiiVg@mail.gmail.com>
Subject: Re: [RFC v8 0/5] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Peter Xu <peterx@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eperezma@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 03:24:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 1, 2020 at 11:14 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 01, 2020 at 04:26:03PM +0200, Eugenio P=C3=A9rez wrote:
> > I am able to hit this assertion when a Red Hat 7 guest virtio_net devic=
e
> > raises an "Invalidation" of all the TLB entries. This happens in the
> > guest's startup if 'intel_iommu=3Don' argument is passed to the guest
> > kernel and right IOMMU/ATS devices are declared in qemu's command line.
>
> Thanks for working on this, Eugenio!  Sorry to let the original one-liner=
 patch
> grow into a patchset... :)
>

On the contrary, I knew it was not going to be so easy and it's been a
pleasure to learn the DEVIOTLB intrinsics with it :).

> I think it at least looks very good to me in general, besides another tri=
vial
> comment on patch 4.
>

Will address it and send PATCH then.

Thanks!


> --
> Peter Xu
>


