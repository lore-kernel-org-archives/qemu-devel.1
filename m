Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18DBC74A3F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E0321019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E0321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlNVh-0000Ji-QA
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhexu@redhat.com>) id 1hlNVE-0008M1-Du
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhexu@redhat.com>) id 1hlNVD-0002eu-55
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:04:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhexu@redhat.com>) id 1hlNVC-0002cj-U9
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:04:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so2075953plr.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 18:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fD6QrnL9oHHFPFtLusHVcNMqwsdqi93+7m3pWRWe2s8=;
 b=EopjXNUf51Ll9Is/m0BlJ7gzetAXQ8lb3vWfk6Co3my1XBLzqJUtFRYgUAxpVqjMVp
 AIvn0m6wCHUKVYH1gbjY2A6lEelQdTe30KoQxQJ0ndAeSTPmxZ0xk9R8klzjrEErT47+
 9CgQBeQE3Hl2DEBBjnvB9LoU1wQIIfwJiO/dgnXxlOrls6m+EW6IK7iU1DPe0bjL1d98
 8N5cj0H6d5LHS6tdD4scojt2/QQL53cFdEBERlTGAwl4d7YLJiDxa+VpMT8C3RsehG1E
 svY5xBm79jgsu/j86zSA0tCZ5emsQMfCYSmRyWdwRHP/4A/4UdAqAWAPkJ6Ydxs46Md7
 oHQQ==
X-Gm-Message-State: APjAAAWyWq5bTvO0Tdnko4EybySIJEdCadU0+oOk86jRm+yciKf1LSMm
 yfoIo16quwsO3XPxiAaqEdHQKA==
X-Google-Smtp-Source: APXvYqyCzj3Ow36pVMoJgAeUfO45i99Sl9Gp3cv1U5/TSFiHBQCKnNYZufh1nW0FOEG9+pSu6ATocA==
X-Received: by 2002:a17:902:76c7:: with SMTP id
 j7mr886064plt.247.1562807040379; 
 Wed, 10 Jul 2019 18:04:00 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 195sm4114394pfu.75.2019.07.10.18.03.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 10 Jul 2019 18:03:58 -0700 (PDT)
From: Peter Xu <zhexu@redhat.com>
X-Google-Original-From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 Jul 2019 09:03:47 +0800
To: "Liu, Yi L" <yi.l.liu@intel.com>
Message-ID: <20190711010347.GI5178@xz-x1>
References: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
 <1562324511-2910-5-git-send-email-yi.l.liu@intel.com>
 <20190709021554.GB5178@xz-x1>
 <A2975661238FB949B60364EF0F2C257439F2A6D3@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439F2A6D3@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [RFC v1 04/18] intel_iommu: add "sm_model" option
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
Cc: "tianyu.lan@intel.com" <tianyu.lan@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <zhexu@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 12:14:44PM +0000, Liu, Yi L wrote:
> > From: Peter Xu [mailto:zhexu@redhat.com]
> > Sent: Tuesday, July 9, 2019 10:16 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v1 04/18] intel_iommu: add "sm_model" option
> > 
> > On Fri, Jul 05, 2019 at 07:01:37PM +0800, Liu Yi L wrote:
> > > Intel VT-d 3.0 introduces scalable mode, and it has a bunch of
> > > capabilities related to scalable mode translation, thus there
> > > are multiple combinations. While this vIOMMU implementation
> > > wants simplify it for user by providing typical combinations.
> > > User could config it by "sm_model" option. The usage is as
> > > below:
> > >
> > > "-device intel-iommu,x-scalable-mode=on,sm_model=["legacy"|"scalable"]"
> > 
> > Is it a requirement to split into two parameters, instead of just
> > exposing everything about scalable mode when x-scalable-mode is set?
> 
> yes, it is. Scalable mode has multiple capabilities. And we want to support
> the most typical combinations to simplify software. e.g. current scalable mode
> vIOMMU exposes only 2nd level translation to guest, and guest IOVA support
> is via shadowing guest 2nd level page table. We have plan to move IOVA from
> 2nd level page table to 1st level page table, thus guest IOVA can be supported
> with nested translation. And this also addresses the co-existence issue of guest
> SVA and guest IOVA. So in future we will have scalable mode vIOMMU expose
> 1st level translation only. To differentiate this config with current vIOMMU,
> we need an extra option to control it. But yes, it is still scalable mode vIOMMU.
> just has different capability exposed to guest.

I see.  Thanks for explaining.

> 
> BTW. do you know if I can add sub-options under "x-scalable-mode"? I think
> that may demonstrate the dependency better.

I'm not an expert of that, but I think at least we can make it a
string parameter depends on what you prefer, then we can do
"x-scalable-mode=legacy|modern".  Or keep this would be fine too.

> 
> > >
> > >  - "legacy": gives support for SL page table
> > >  - "scalable": gives support for FL page table, pasid, virtual command
> > >  - default to be "legacy" if "x-scalable-mode=on while no sm_model is
> > >    configured
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 28 +++++++++++++++++++++++++++-
> > >  hw/i386/intel_iommu_internal.h |  2 ++
> > >  include/hw/i386/intel_iommu.h  |  1 +
> > >  3 files changed, 30 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index 44b1231..3160a05 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -3014,6 +3014,7 @@ static Property vtd_properties[] = {
> > >      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode,
> > FALSE),
> > >      DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode,
> > FALSE),
> > >      DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
> > > +    DEFINE_PROP_STRING("sm_model", IntelIOMMUState, sm_model),
> > 
> > Can do 's/-/_/' to follow the rest if we need it.
> 
> Do you mean sub-options after "x-scalable-mode"?

No, I only mean "sm-model". :)

Regards,

-- 
Peter Xu

