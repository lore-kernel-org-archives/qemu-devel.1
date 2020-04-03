Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC0DC2BA15
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8821F206E9
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLI6NNt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKOwQ-00086K-NV
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jKOux-0006co-HW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:11:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jKOuq-0001gz-19
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:11:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jKOup-0001fr-SJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585930290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7nqJ2qnwNFKSPL63S2CQMULtmx1H1KHl6imE70TMb0=;
 b=HLI6NNt0ypMYsFSPnknaPHLNKql/ydurLOYFG0w7vAbsW9boh+DWKICChGeQajlfVom3n6
 GGlzNQK/EXYooJF3aRbh8Tm/KFKQ/MN4+ntWB2Okry91hsvkIt8NqiJrRuJ+q3NsMvpDhr
 L+wfQT5X4oQx2GJ8qcE2ws5FJYuWGhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-g3q_CS6BPqSTdwOLr0r16g-1; Fri, 03 Apr 2020 12:11:28 -0400
X-MC-Unique: g3q_CS6BPqSTdwOLr0r16g-1
Received: by mail-wm1-f70.google.com with SMTP id s15so2256487wmc.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 09:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=euLe8LsYBnPZG0Qe2AS2hMfw70OeheAVO3ddIA8WGx8=;
 b=KQTQLOWsmTeP023IXXNMZYFr+yRQWC5K7PDtSnHpq39AdmCzhHShqkYfxZLDZiXkEw
 l1mLiD7k3GkxuPGeRIN02qp1jRx5ikPq0ae2Y079lHjhBLXlv1FOIQ1ZjqlG3fehl9Z9
 oof4/a+B99o0UcEKv/uOk3RojblHtaXbZ664VWcAMBexJGpHVgeaWpfkMCkUBLxuSmJP
 Ulqwd9pT/cF02KJPqkarEC+TDtrVai4bOXTi6g1Z1O3eWNsuj2zrthBIrg0NEqsFyyzE
 vm5IUD1WPwJkwsl02o+Mooq0YUHaeUJbI9+XxcUnBd3mCD1seFwxmYjACxh9MKK8wigG
 QYsw==
X-Gm-Message-State: AGi0PuaY+O5ajXHvztG8NYbhjVLbADNwxL6NqCY06e1ZZVpvDOvJKOus
 cHWDWo6KHxyX70WYcZDpG3QHrX63mgB+0wGXIoDecsvt+Mw6RSe0/QyY4vDp2NQ/q/XAIclCDGH
 0x77BF9nR8HDYEtA=
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1014965wmj.111.1585930286218; 
 Fri, 03 Apr 2020 09:11:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIUgCEYS2IEjZ1+hA2TwQEfFKKDwrwFQdA4Bv7H2g7I9Ahi8qXO9yqjEYcPz3lj/W3lFFSfg==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr1014938wmj.111.1585930285955; 
 Fri, 03 Apr 2020 09:11:25 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id s131sm12259015wmf.35.2020.04.03.09.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 09:11:25 -0700 (PDT)
Date: Fri, 3 Apr 2020 12:11:20 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after context
 cache invalidation
Message-ID: <20200403161120.GN103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-17-git-send-email-yi.l.liu@intel.com>
 <20200403144548.GK103677@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A220E44@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A220E44@SHSMSX104.ccr.corp.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On Fri, Apr 03, 2020 at 03:21:10PM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Friday, April 3, 2020 10:46 PM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [PATCH v2 16/22] intel_iommu: replay pasid binds after con=
text cache
> > invalidation
> >=20
> > On Sun, Mar 29, 2020 at 09:24:55PM -0700, Liu Yi L wrote:
> > > This patch replays guest pasid bindings after context cache
> > > invalidation. This is a behavior to ensure safety. Actually,
> > > programmer should issue pasid cache invalidation with proper
> > > granularity after issuing a context cache invalidation.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Cc: Yi Sun <yi.y.sun@linux.intel.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <rth@twiddle.net>
> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  hw/i386/intel_iommu.c          | 51
> > ++++++++++++++++++++++++++++++++++++++++++
> > >  hw/i386/intel_iommu_internal.h |  6 ++++-
> > >  hw/i386/trace-events           |  1 +
> > >  3 files changed, 57 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index d87f608..883aeac 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -68,6 +68,10 @@ static void
> > vtd_address_space_refresh_all(IntelIOMMUState *s);
> > >  static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifi=
er *n);
> > >
> > >  static void vtd_pasid_cache_reset(IntelIOMMUState *s);
> > > +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> > > +                                 VTDPASIDCacheInfo *pc_info);
> > > +static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
> > > +                                  VTDBus *vtd_bus, uint16_t devfn);
> > >
> > >  static void vtd_panic_require_caching_mode(void)
> > >  {
> > > @@ -1853,7 +1857,10 @@ static void vtd_iommu_replay_all(IntelIOMMUSta=
te
> > *s)
> > >
> > >  static void vtd_context_global_invalidate(IntelIOMMUState *s)
> > >  {
> > > +    VTDPASIDCacheInfo pc_info;
> > > +
> > >      trace_vtd_inv_desc_cc_global();
> > > +
> > >      /* Protects context cache */
> > >      vtd_iommu_lock(s);
> > >      s->context_cache_gen++;
> > > @@ -1870,6 +1877,9 @@ static void
> > vtd_context_global_invalidate(IntelIOMMUState *s)
> > >       * VT-d emulation codes.
> > >       */
> > >      vtd_iommu_replay_all(s);
> > > +
> > > +    pc_info.flags =3D VTD_PASID_CACHE_GLOBAL;
> > > +    vtd_pasid_cache_sync(s, &pc_info);
> > >  }
> > >
> > >  /**
> > > @@ -2005,6 +2015,22 @@ static void
> > vtd_context_device_invalidate(IntelIOMMUState *s,
> > >                   * happened.
> > >                   */
> > >                  vtd_sync_shadow_page_table(vtd_as);
> > > +                /*
> > > +                 * Per spec, context flush should also followed with=
 PASID
> > > +                 * cache and iotlb flush. Regards to a device select=
ive
> > > +                 * context cache invalidation:
> >=20
> > If context entry flush should also follow another pasid cache flush,
> > then this is still needed?  Shouldn't the pasid flush do the same
> > thing again?
>=20
> yes, but how about guest software failed to follow it? It will do
> the same thing when pasid cache flush comes. But this only happens
> for the rid2pasid case (the IOVA page table).

Do you mean it will not happen when nested page table is used (so it's
required for nested tables)?

Yeah we can keep them for safe no matter what; at least I'm fine with
it (I believe most of the code we're discussing is not fast path).
Just want to be sure of it since if it's definitely duplicated then we
can instead drop it.

Thanks,

--=20
Peter Xu


