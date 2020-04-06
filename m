Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1EBC2BA1A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE2A20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 19:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETuvV05v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE2A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLXku-0000aR-OB
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 15:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jLXkG-0008C1-Uc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jLXkE-0004xf-UU
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:49:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43624)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jLXkE-0004xA-Po
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 15:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586202557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjNAoiJoQ0ywe3nRBwydYpgtpSZN6534yCfTO4GDpUo=;
 b=ETuvV05v7RoLORJcIJ21W+nByiRskFdmmnLB3UXmMdRybSkupYrxiDNCLJ9w8LRIu7AOM5
 he+8aoNHxSnpTE9nW5UczOwxoz/E1YTUnAz69kX+BgxBrA/9TwzpmFQzpsjx+mhHkRDCgr
 xDLzMfXXahQ3Qufn7r7abJ5uu5/9AGQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-ZUVyqtoqM1STlBtej14c7Q-1; Mon, 06 Apr 2020 15:49:15 -0400
X-MC-Unique: ZUVyqtoqM1STlBtej14c7Q-1
Received: by mail-qk1-f197.google.com with SMTP id d18so945651qkj.8
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 12:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3SAc7/INURO0fUmTRoJHT56cMjNB24w7zVKVwcxLIzw=;
 b=EGugT3JAcwa5r84A9qJaHemoqjQJRoMs5IY24fVcYJLAOQ68SZdKLBq0ibXAOekHkM
 asuwxbm4DY6rUC9tjrIbsIaUL+mkCFVa1ypJ+Szn1vsxrbgudH4EzL9M9ffskqNhiuIS
 bfo30J0UY2JgUi6LZIynwJMWDb3UYcwNolVDbATZOFw2/B8otyTJvIXw1CrA9t1U/opz
 HqDy+h30ooH9wkklTcS+ByPg26m/Q4i4kAvskj20qjJIfhlJ2gSgLxW6h5KWeBfzRrOg
 crOt1iHhTrvNPRdDJcEnVZQL9/5+/7M7euAF6cGeYd4Ay/QUmEW8rJLdv/DTH9NDsBKJ
 H3Ww==
X-Gm-Message-State: AGi0PubdnEA5anI61czlDj8kiggKsXXxXMjeEr2IJ+0L6zhn0I9egSx5
 05EJzuonVP7kZM7F4Oj1+5jMMRRVkcHTF5RFgr2DF3E8fdOzNVh2DYGquevh+5OjvXaitk+Mg90
 US3WVhp0Bqn+4vCc=
X-Received: by 2002:ac8:8d0:: with SMTP id y16mr1270776qth.340.1586202555447; 
 Mon, 06 Apr 2020 12:49:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypIsQ+naX+Z38cNb4BpPpyftxPdr6Pz+MXwVkluFeAVGofZZPwR4AZcFrqU7Egyx3/QvySVzMQ==
X-Received: by 2002:ac8:8d0:: with SMTP id y16mr1270746qth.340.1586202555194; 
 Mon, 06 Apr 2020 12:49:15 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id f138sm2635656qke.105.2020.04.06.12.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 12:49:14 -0700 (PDT)
Date: Mon, 6 Apr 2020 15:48:40 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Message-ID: <20200406194840.GS103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-17-git-send-email-yi.l.liu@intel.com>
 <20200403144548.GK103677@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A220E44@SHSMSX104.ccr.corp.intel.com>
 <20200403161120.GN103677@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A221BD4@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A221BD4@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, Richard Henderson <rth@twiddle.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 04, 2020 at 12:00:12PM +0000, Liu, Yi L wrote:
> Hi Peter,
>=20
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Saturday, April 4, 2020 12:11 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after con=
text cache
> > invalidation
> >=20
> > On Fri, Apr 03, 2020 at 03:21:10PM +0000, Liu, Yi L wrote:
> > > > From: Peter Xu <peterx@redhat.com>
> > > > Sent: Friday, April 3, 2020 10:46 PM
> > > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > > Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after=
 context
> > cache
> > > > invalidation
> > > >
> > > > On Sun, Mar 29, 2020 at 09:24:55PM -0700, Liu Yi L wrote:
> > > > > This patch replays guest pasid bindings after context cache
> > > > > invalidation. This is a behavior to ensure safety. Actually,
> > > > > programmer should issue pasid cache invalidation with proper
> > > > > granularity after issuing a context cache invalidation.
> > > > >
> > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Cc: Peter Xu <peterx@redhat.com>
> > > > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > > > Cc: Richard Henderson <rth@twiddle.net>
> > > > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > > ---
> > > > >  hw/i386/intel_iommu.c          | 51
> > > > ++++++++++++++++++++++++++++++++++++++++++
> > > > >  hw/i386/intel_iommu_internal.h |  6 ++++-
> > > > >  hw/i386/trace-events           |  1 +
> > > > >  3 files changed, 57 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > > > index d87f608..883aeac 100644
> > > > > --- a/hw/i386/intel_iommu.c
> > > > > +++ b/hw/i386/intel_iommu.c
> > > > > @@ -68,6 +68,10 @@ static void
> > > > vtd_address_space_refresh_all(IntelIOMMUState *s);
> > > > >  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNo=
tifier
> > *n);
> > > > >
> > > > >  static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> > > > > +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> > > > > +                                 VTDPASIDCacheInfo *pc_info);
> > > > > +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> > > > > +                                  VTDBus *vtd_bus, uint16_t devf=
n);
> > > > >
> > > > >  static void vtd_panic_require_caching_mode(void)
> > > > >  {
> > > > > @@ -1853,7 +1857,10 @@ static void
> > vtd_iommu_replay_all(IntelIOMMUState
> > > > *s)
> > > > >
> > > > >  static void vtd_context_global_invalidate(IntelIOMMUState *s)
> > > > >  {
> > > > > +    VTDPASIDCacheInfo pc_info;
> > > > > +
> > > > >      trace_vtd_inv_desc_cc_global();
> > > > > +
> > > > >      /* Protects context cache */
> > > > >      vtd_iommu_lock(s);
> > > > >      s->context_cache_gen++;
> > > > > @@ -1870,6 +1877,9 @@ static void
> > > > vtd_context_global_invalidate(IntelIOMMUState *s)
> > > > >       * VT-d emulation codes.
> > > > >       */
> > > > >      vtd_iommu_replay_all(s);
> > > > > +
> > > > > +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> > > > > +    vtd_pasid_cache_sync(s, &pc_info);
> > > > >  }
> > > > >
> > > > >  /**
> > > > > @@ -2005,6 +2015,22 @@ static void
> > > > vtd_context_device_invalidate(IntelIOMMUState *s,
> > > > >                   * happened.
> > > > >                   */
> > > > >                  vtd_sync_shadow_page_table(vtd_as);
> > > > > +                /*
> > > > > +                 * Per spec, context flush should also
> > > > > followed with PASID
> > > > > +                 * cache and iotlb flush. Regards to
> > > > > a device selective
> > > > > +                 * context cache invalidation:
> > > >
> > > > If context entry flush should also follow another pasid cache flush=
,
> > > > then this is still needed?  Shouldn't the pasid flush do the same
> > > > thing again?
> > >
> > > yes, but how about guest software failed to follow it? It will do
> > > the same thing when pasid cache flush comes. But this only happens
> > > for the rid2pasid case (the IOVA page table).
> >=20
> > Do you mean it will not happen when nested page table is used (so it's
> > required for nested tables)?
>=20
> no, by the IOVA page table case, I just want to confirm the duplicate
> replay is true. But it is not "only" case. :-) my bad. any scalable mode
> context entry modification will result in duplicate replay as this patch
> enforces a pasid replay after context cache invalidation. But for normal
> guest SVM usage, it won't have such duplicate work as it only modifies
> pasid entry.
>=20
> > Yeah we can keep them for safe no matter what; at least I'm fine with
> > it (I believe most of the code we're discussing is not fast path).
> > Just want to be sure of it since if it's definitely duplicated then we
> > can instead drop it.
>=20
> yes, it is not fast path. BTW. I guess the iova shadow sync applies
> the same notion. right?

Yes I rem we have similar things, but the same to that - if we can
confirm that it'll be duplicated then I think we should remove that
too.  But feel free to ignore this question for now and keep it.  The
comment explaining that would be helpful, as you already did.  Thanks,

--=20
Peter Xu


