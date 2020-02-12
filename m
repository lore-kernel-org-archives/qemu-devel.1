Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D117C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD232082F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 16:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuH+gBsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD232082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1uRd-0001ai-39
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 11:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1uQp-000106-L3
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1uQo-00053M-Jw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:00:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1uQo-000537-GN
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 11:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581523206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bExETVtjEqkPQzINtarb3yhP9uj2p/noU2YZvyMga8g=;
 b=HuH+gBsYPDp3tDqViA9aAsPB2SuDBValN/KzIwuEnESb/7RMroFTUWqL+n1NhjJKfRBbu1
 MVeXA0+snfspqEJvRtRUffPnJK1zjHR+WqP3KV3o5cdEwQ8x7/ln4WPI4a+jGXN/y1OV5c
 QU1GJz7/R6kGOzNGU47NDZKgb/gSy3s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-uAM82SIzMgKNLIXUhSmsTw-1; Wed, 12 Feb 2020 11:00:03 -0500
Received: by mail-qv1-f70.google.com with SMTP id b8so1656713qvw.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 08:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GIgWy4UzqzvKKoSqexQFDNIRRINuD+NmWSIWAy1UUjw=;
 b=niEyAyZCiJa+xT0lXy/P3ySdIfj/e/NTx1Fi2SCtQsXC/pUkXEr+97P9EaKS7OxDzn
 HTbvCpMQzAw3oZrfV39GyG99Zd0KbLhtp0yqleJUyYOiSIivhd4dai9J0xCaNRcQDfWs
 pMvVZz3Dp/t00kcfoA38Tz8BAAWltajrAkT9tqxnAEzDoZavNXTx/u9jCY1fxc6wc0Zl
 wouaRZWxgPLG5HWrhzYdR1Z4BrybRbjZdnaJFigLkPq4B4YGCFnbep5aTR8ggdRIINVZ
 pGHJcrMZC6u/trGPJu/SJj0VKbmEBEcM9t8IAzwU52iZGiztly9oyUtuKbBAfPPMZ4Ad
 2yrw==
X-Gm-Message-State: APjAAAWnXyyjSLWW68XnEt+UxDbOvudzB0cNsj5GMQNoRZyELPnEBXka
 Ty4uEtTDHdrLfDrBZCLHgxXyqSwKzenkWwct1JcadW3lbonHJ8168BMbAKSEyld6RdY+eZfeNYy
 MYupVTcMFmc6NlA4=
X-Received: by 2002:ac8:5510:: with SMTP id j16mr20022921qtq.262.1581523202877; 
 Wed, 12 Feb 2020 08:00:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNF1roNv2zMtbIsGRMgoRPnCGtj8LPssqv/WDb1qtL0FOOHYKRnnc8HynjcKjY1JyS2w3suw==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr20022896qtq.262.1581523202567; 
 Wed, 12 Feb 2020 08:00:02 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id 89sm390685qth.3.2020.02.12.08.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 08:00:01 -0800 (PST)
Date: Wed, 12 Feb 2020 10:59:58 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 03/25] hw/iommu: introduce IOMMUContext
Message-ID: <20200212155958.GB1083891@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-4-git-send-email-yi.l.liu@intel.com>
 <20200131040644.GG15210@umbus.fritz.box>
 <A2975661238FB949B60364EF0F2C25743A199306@SHSMSX104.ccr.corp.intel.com>
 <20200211165843.GG984290@xz-x1>
 <A2975661238FB949B60364EF0F2C25743A1BA4D8@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1BA4D8@SHSMSX104.ccr.corp.intel.com>
X-MC-Unique: uAM82SIzMgKNLIXUhSmsTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Wu, Hao" <hao.wu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 07:15:13AM +0000, Liu, Yi L wrote:

[...]

> While considering your suggestion on dropping one of the two abstract
> layers. I came up a new proposal as below:
>=20
> We may drop the IOMMUContext in this series, and rename DualStageIOMMUObj=
ect
> to HostIOMMUContext, which is per-vfio-container. Add an interface in PCI
> layer(e.g. an callback in  PCIDevice) to let vIOMMU get HostIOMMUContext.
> I think this could cover the requirement of providing explicit method for
> vIOMMU to call into VFIO and then program host IOMMU.
>=20
> While for the requirement of VFIO to vIOMMU callings (e.g. PRQ), I think =
it
> could be done via PCI layer by adding an operation in PCIIOMMUOps. Though=
ts?

Hmm sounds good. :)

The thing is for the calls to the other direction (e.g. VFIO injecting
faults to vIOMMU), that's neither per-container nor per-device, but
per-vIOMMU.  PCIIOMMUOps suites for that job I'd say, which is per-vIOMMU.

Let's see how it goes.

--=20
Peter Xu


