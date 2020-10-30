Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5C4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A5B120704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh7DZF/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5B120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRh2-0005mG-6B
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRcJ-00086B-Ho
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYRcF-0001K7-D0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604053597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XURLfmIBmkN3M8zln9MT16idTxjsy7ulWWJmF/4Hn7c=;
 b=Yh7DZF/YMClMujn8e78D+3lbwMsG87411uV3QI2JmiIKZ/PUe9X6Tt8/DhIe/tQU9BepT6
 CcJAZznuC4AWj2J3SyIfdPMfgXCwp9BLmH/9w1Q5RhNUJu83zd8pc+ve5pC02S0CwEfVOB
 KKGBsn8lEsXgquOjgU994KN9IhO+fA4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-MZvcCpOTPf2R5-rqbaUALg-1; Fri, 30 Oct 2020 06:26:35 -0400
X-MC-Unique: MZvcCpOTPf2R5-rqbaUALg-1
Received: by mail-wr1-f70.google.com with SMTP id n14so2486993wrp.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XURLfmIBmkN3M8zln9MT16idTxjsy7ulWWJmF/4Hn7c=;
 b=gBFW8LusAY/2NknVxUwjD8MEqYeT41n3LliBHBwMSegCyAO/7xCmlRNRiTgrWdFDgT
 q3FnGQ6ynQdRuNLGsVH3qDKrp70DT56paCjRoibTGp58ItQpNMtjFKWXWmD1vFlXMxk0
 Z5+xcCbetph8gE0LLb0mh2n6j7UpDiDZEuNdfwC2zgCf9L9PWyI4d4KLz/AP5t7N4wvD
 chsY0tiEIFgm87u6EiclQ4EV4MsQSxkq2fYSJSgRq2i2S9+0dMW/MZ5hbop6+xEP1GXQ
 7urG9dCiHk5ugGBWFkusEuJ1qqGTHts8XO8HvAyblrJDtRwgDSrz7WVWf3PYoaU6BNsg
 uyZQ==
X-Gm-Message-State: AOAM5324yQIYQ3QlB15pHaqSxLsbeqFPeUUVqdwddDp7kkjovEqiP7Ul
 wdrPYNjPyFziC/IC9UopyCpLINIKH3dZihpUGsTl9x18GnaJv7wnOrDZtruJzZSRZTewj6+cbE9
 cp2rZcFK1bLzkx/8=
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr2064743wrw.145.1604053594649; 
 Fri, 30 Oct 2020 03:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvStEsspwMX49OCer+ApIvMxH9kj62MpYaj6h+m4Wg/ilKldx6iDWMWNv8Gvdm4UMJYBjF6A==
X-Received: by 2002:a5d:4fc5:: with SMTP id h5mr2064724wrw.145.1604053594518; 
 Fri, 30 Oct 2020 03:26:34 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t7sm9505805wrx.42.2020.10.30.03.26.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:26:33 -0700 (PDT)
Date: Fri, 30 Oct 2020 06:26:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v10 08/10] vfio: Set IOMMU page size as per host
 supported page size
Message-ID: <20201030062606-mutt-send-email-mst@kernel.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-9-jean-philippe@linaro.org>
 <20201008152254.7bf6d8a7@w520.home>
MIME-Version: 1.0
In-Reply-To: <20201008152254.7bf6d8a7@w520.home>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, qemu-devel@nongnu.org,
 peterx@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 08, 2020 at 03:22:54PM -0600, Alex Williamson wrote:
> On Thu,  8 Oct 2020 19:15:56 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Bharat Bhushan <bbhushan2@marvell.com>
> > 
> > Set IOMMU supported page size mask same as host Linux supported page
> > size mask.
> > 
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  hw/vfio/common.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index 13471ae2943..e66054b02a7 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -636,6 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
> >                              int128_get64(llend),
> >                              iommu_idx);
> >  
> > +        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
> > +                                                     container->pgsizes,
> > +                                                     &err);
> > +        if (ret) {
> > +            g_free(giommu);
> > +            goto fail;
> > +        }
> > +
> >          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
> >                                                      &err);
> >          if (ret) {
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>

This one too, seems independent of the rest of the
patchset and can be merged separately, right?
If so

Acked-by: Michael S. Tsirkin <mst@redhat.com>


