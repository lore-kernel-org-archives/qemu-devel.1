Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41893C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFC22073E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4Wajvym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSUA-00069P-6j
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHSTR-0005At-82
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHSTQ-0002Pm-6q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46869)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHSTQ-0002Pi-3E
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585228983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82oS56E56m2onY0WmFuddM7PFPHPuttK8stZqYvdZqw=;
 b=M4WajvymQRI+p9JnApQvcE5+F5x7oN/x488CXp8NbCWjS2vf13E8LLv4/4WeQB23MVuNN8
 cvK63S2cIaf340mUl0J0lv48wGmiyoF1c1/45/9rRqvT60hW3nqKu+++WdymKRTS6dp0I6
 tnz+pb07j5fr45IlhEK3payyP78vunY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-RX9lS8xFOLeFYkicsRK7cg-1; Thu, 26 Mar 2020 09:22:57 -0400
X-MC-Unique: RX9lS8xFOLeFYkicsRK7cg-1
Received: by mail-wr1-f72.google.com with SMTP id w12so3013750wrl.23
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3D6txT8FsGjiCL0WkA4M4TFIY+W1PhEo7/Tm5hHY34U=;
 b=e70j1I3Z7XCbMA26rMxuB4EGr+MrOrMmpkCljpqlT+ANyX2mXwUVU49ugM/Mawk7yw
 EnG9evBkBoWCRgFyqQ+9+gj8tKO/ln3ValWr8PDTuRXjWWJHiz+7AO92v+7n0uKCpY84
 tJdfnQyVyi9wJLpVxCFJCzatHXEWLCajx03ev12sfGw7nKEi0FunIJ8/Va/8gu7XUvS5
 GFVB7qlyWF0fG8cKgcQPAPCMGphfdc6VY5S3F92IVnFWNk80mo0abBq1tnP908TdW5Jl
 APV6o+S1Xbj3WpIXuK3okAoQ9UXEJlsn9YjAPF8VGPHgC0y1x50uf7KSVSZZRlrD9gGj
 QH3g==
X-Gm-Message-State: ANhLgQ11b1o4nBhmkLrEZ4CD0CY3KznhY7AkeeP0h2bOpoTk0lf6HHD0
 HltLzhP17Mmo7E0fA8oSIHeeynMrgE7IJMevhxtRbscCotSBNjscClIIJvk89xo6gg/Xc2THC/0
 cYR9Vci2XEu5SCcU=
X-Received: by 2002:a05:600c:54d:: with SMTP id
 k13mr3085544wmc.161.1585228975714; 
 Thu, 26 Mar 2020 06:22:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvv6AgL3h/3IT7RwFTgMkWnM/cyySnuKTkNfF59iq3XGQCm+l4821ZVZ8Fyav2c/CafSCTZWg==
X-Received: by 2002:a05:600c:54d:: with SMTP id
 k13mr3085519wmc.161.1585228975490; 
 Thu, 26 Mar 2020 06:22:55 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j188sm3626230wmj.36.2020.03.26.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:22:54 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:22:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 20/22] intel_iommu: propagate PASID-based iotlb
 invalidation to host
Message-ID: <20200326132250.GC422390@xz-x1>
References: <1584880579-12178-1-git-send-email-yi.l.liu@intel.com>
 <1584880579-12178-21-git-send-email-yi.l.liu@intel.com>
 <20200324183423.GE127076@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A2022C5@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A203E63@SHSMSX104.ccr.corp.intel.com>
 <20200326130248.GB422390@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20200326130248.GB422390@xz-x1>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Thu, Mar 26, 2020 at 09:02:48AM -0400, Peter Xu wrote:

[...]

> > > > > +static inline bool vtd_pasid_cache_valid(
> > > > > +                          VTDPASIDAddressSpace *vtd_pasid_as) {
> > > > > +    return vtd_pasid_as->iommu_state &&
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
> > > >
> > > > This check can be dropped because always true?
> > > >
> > > > If you agree with both the changes, please add:
> > > >
> > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > >=20
> > > I think the code should ensure all the pasid_as in hash table is vali=
d. And we can
> > > since all the operations are under protection of iommu_lock.
> > >=20
> > Peter,
> >=20
> > I think my reply was wrong. pasid_as in has table may be stale since
> > the per pasid_as cache_gen may be not identical with the cache_gen
> > in iommu_state. e.g. vtd_pasid_cache_reset() only increases the
> > cache_gen in iommu_state. So there will be pasid_as in hash table
> > which has cached pasid entry but its cache_gen is not equal to the
> > one in iommu_state. For such pasid_as, we should treat it as stale.
> > So I guess the vtd_pasid_cache_valid() is still necessary.
>=20
> I guess you misread my comment. :)
>=20
> I was saying the "vtd_pasid_as->iommu_state" check is not needed,
> because iommu_state was always set if the address space is created.
> vtd_pasid_cache_valid() is needed.
>=20
> Also, please double confirm that vtd_pasid_cache_reset() should drop
> all the address spaces (as I think it should), not "only increase the
> cache_gen".  IMHO you should only increase the cache_gen in the PSI
> hook (vtd_pasid_cache_psi()) only.

Sorry, I mean GSI (vtd_pasid_cache_gsi), not PSI.

--=20
Peter Xu


