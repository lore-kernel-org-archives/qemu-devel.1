Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149EC433EA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D41720714
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 13:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="C/BAR+8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D41720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyayi-0006Ba-QM
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 09:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jyaxx-0005Ff-Ng; Thu, 23 Jul 2020 09:08:53 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:23860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jyaxv-00023N-J1; Thu, 23 Jul 2020 09:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1595509731;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ru1h5kiVooJ3D8JVY2sHsCOoG6Bq/817pLT0l0++Z0Y=;
 b=C/BAR+8skhFWTtFMxWQdA0dzfMLvCdRBsccR98iwFo06giki9B3L4ebv
 cvaL630adaFKo6JS/QyF1gjOJlA6unsAs4YsrLniRv9RMBKhNSAhZCjl1
 Ab85mUKXEa9/ODPRepVAhhmbWvb+De2SOSurMk+raIY+iI3W4yNvUMRyM 8=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: +6CifU0dRpEslmYwo1wsOTzZmAK7K+mC3nBrIeo2kF5Hm4oTsQcoPOAA6/bw4Ncdz3SwTAQktd
 FKwl/Oywt4vy8xhwr6QY6l1PmGArKRHw0QXfOE1EPMR49az3Sx3rVUy0YYu+qvcacp+copqQUJ
 SM7NNmMU3sNo8DUtO8B3TUdOhqHEMUvsKR7z6d6KG1pIad7NDN4KOwYJCN2R74wCEjfwnKnIgP
 TihjYeV3qYWGiL2GomAflm2TXGpStHOpMBvbCljGoVyszifCzikjUBltTyuNgjTyjxZulgB7MG
 70Q=
X-SBRS: 2.7
X-MesageID: 23363242
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,386,1589256000"; d="scan'208";a="23363242"
Date: Thu, 23 Jul 2020 14:08:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200723130842.GA2866@perard.uk.xensource.com>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
 <20200701124836.GD2030@perard.uk.xensource.com>
 <20200702063310-mutt-send-email-mst@kernel.org>
 <20200710094258.GF2030@perard.uk.xensource.com>
 <20200723084405-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723084405-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=anthony.perard@citrix.com; helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 09:08:47
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 23, 2020 at 08:44:27AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 10:42:58AM +0100, Anthony PERARD wrote:
> > On Thu, Jul 02, 2020 at 07:12:08AM -0400, Michael S. Tsirkin wrote:
> > > memory: align to min access size
> > > 
> > > If impl.min_access_size > valid.min_access_size access callbacks
> > > can get a misaligned access as size is increased.
> > > They don't expect that, let's fix it in the memory core.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > ---
> > > 
> > > 
> > > diff --git a/memory.c b/memory.c
> > > index 9200b20130..ea489ce405 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -532,6 +532,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
> > >      }
> > >  
> > >      /* FIXME: support unaligned access? */
> > > +    addr &= ~(access_size_min - 1);
> > >      access_size = MAX(MIN(size, access_size_max), access_size_min);
> > >      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> > >      if (memory_region_big_endian(mr)) {
> > 
> > I've tried this (and .impl.min_access_size=2) but that wasn't enough.
> > 
> > In the guest, I did `inb(base_addr + 1)`, but I've got back the value as
> > if `inb(base_addr)` was run.
> > 
> > The device emulation read callbacks did get addr=0 width=2, so that's
> > fine, but the result returned to the guest wasn't shifted. Same thing
> > for write access, the write value isn't shifted, so a write to the
> > second byte would be written to the first.
> > 
> > Thanks,
> 
> So is there still an issue with my latest pull req?
> Or is everything fixed?

I can boot a guest with that pull req, it fixes the issue introduced by
the CVE fix.

Thanks!

-- 
Anthony PERARD

