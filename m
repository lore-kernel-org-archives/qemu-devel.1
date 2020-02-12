Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E4C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FEF2073C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUYdkrqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FEF2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uX4-00067v-FP
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1uWT-0005iT-CK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1uWS-0001hl-34
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:05:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40527
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1uWR-0001gt-VU
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581523554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDTzAWetViihjeQZuhjhJ8Q4Obs/fyUHT4EwEz960Fo=;
 b=JUYdkrqSAHVokP7aR1BvS+cM8zv8fC/+TIGa+VCjnkSS3j0+aBkKM+OTNSUHKghr/m17b/
 EP9izUyzsHatcN+tqyQuZg4/TCIY5QVAlGPcfyD4GGf4QeYqeruRoN8aFXBYXsrExZJOeJ
 NPxlAJMgJ8hqMRRCyfy2qbC0/mtWXU4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-DtmQzs3wO7SKTaa0CknGiQ-1; Wed, 12 Feb 2020 11:05:48 -0500
Received: by mail-qk1-f198.google.com with SMTP id n126so1645983qkc.18
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BuiFEByjTOdPJEqSzlof5kdw7dqIMMEevCIbGA7HPC0=;
 b=lGNoO6NKKt6tBX6BU0al+fSfsPX/U7USwiyoQ8mfQ0xetGWOlR8CxnuJt+FoNJZrDh
 BvShI7glzwjA7AVk7N55uVeAWpKxoX0aaQBXnR2T5B5zR+QGZH8pZ2z11uD6hZaWkvZ9
 aSYhNjHdh39Knd7gWM3hfOmRZHe2VQ83LWNcgZhiJWhUMWm6oNYG1f37c5iOV91+P6qp
 GSU2DWC2X94qeADDnC4CCIEOdw6wpXlNBQoZiiuAmChWmuGF+PvRlu2Bzc8aYBvMWY/U
 IQGO0Zl+F4OYTOjgvxpxfYIhGmqi2riN3JQkjeQi25YTwPMkwANS+Ly6XRuawuU8rQ5t
 NerQ==
X-Gm-Message-State: APjAAAVaZe1OVvmacI+G4JQxQ757ESPsTnONOmyEpZbja9N5jwn/qD7R
 CmzNGGC1EEM9It7DhM2hp0N063WQwdQi0XbwwjoB3t+NXvXrXNW7jdVtLQuphT+LfZHmyPQ6Z7d
 VVWsH5TEXRCxt35o=
X-Received: by 2002:aed:27de:: with SMTP id m30mr19941623qtg.151.1581523548234; 
 Wed, 12 Feb 2020 08:05:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNDm2UfrjOrDJPfYOACk8aWkMeivWc5hd+gjQaGVxgdqdXt5A3hx1c1nj6DLkByyf8owdTKg==
X-Received: by 2002:aed:27de:: with SMTP id m30mr19941603qtg.151.1581523548025; 
 Wed, 12 Feb 2020 08:05:48 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id v2sm376207qto.73.2020.02.12.08.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:05:46 -0800 (PST)
Date: Wed, 12 Feb 2020 11:05:44 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 13/25] intel_iommu: modify x-scalable-mode to be string
 option
Message-ID: <20200212160544.GC1083891@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-14-git-send-email-yi.l.liu@intel.com>
 <20200211194331.GK984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA573@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1BA573@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: DtmQzs3wO7SKTaa0CknGiQ-1
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
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

On Wed, Feb 12, 2020 at 07:28:24AM +0000, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > Sent: Wednesday, February 12, 2020 3:44 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 13/25] intel_iommu: modify x-scalable-mode to be s=
tring
> > option
> >=20
> > On Wed, Jan 29, 2020 at 04:16:44AM -0800, Liu, Yi L wrote:
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > Intel VT-d 3.0 introduces scalable mode, and it has a bunch of
> > > capabilities related to scalable mode translation, thus there are mul=
tiple
> > combinations.
> > > While this vIOMMU implementation wants simplify it for user by
> > > providing typical combinations. User could config it by
> > > "x-scalable-mode" option. The usage is as below:
> > >
> > > "-device intel-iommu,x-scalable-mode=3D["legacy"|"modern"]"
> >=20
> > Maybe also "off" when someone wants to explicitly disable it?
>=20
> emmm, I  think x-scalable-mode should be disabled by default. It is enabl=
ed
> only when "legacy" or "modern" is configured. I'm fine to add "off" as an
> explicit way to turn it off if you think it is necessary. :-)

It's not necessary.  It'll be necessary when we remove "x-" and change
the default value.  However it'll always be good to provide all
options explicitly in the parameter starting from when we design it,
imho.  It's still experimental, so... Your call. :)

--=20
Peter Xu


