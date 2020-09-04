Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA7C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860BC2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="LvQg35+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860BC2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEJQZ-0001mt-Ed
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 17:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEJQ2-0001HU-5p; Fri, 04 Sep 2020 17:38:50 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1kEJPz-0002xs-7B; Fri, 04 Sep 2020 17:38:49 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 11E3EBF7D3;
 Fri,  4 Sep 2020 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1599255523;
 bh=FzDmCfr45SzEmOZiMZJmhENneI440snS2i9M3f4qmNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LvQg35+sQTOr9sX3pvJj6abv2T1dxrLdXOzK+3noqIAJN7/vzGuQGbXS2ErDi+6i/
 xyWYExfyet3ky3R4yeV09iI5G5EBwpEb7lxL29mJNcZoSdW/W65mpgDPU+OXTSZMrg
 4B2jM7OPmuVbGbUsXcM2eO1PfnWff/NYEvqCyMGTf0feMNa37+GymFjkzIcIw3uZIF
 uXYDK2/Vp/BvWsFgfqg3pbI+8D+jPA8FHzqtdd0Ds+GNb4VKL4sQIR9GtLaTcUKOOb
 A58MIGk0SxViKMYTNz9DEKIFrl5s4eMvvF4DW5M7/A6Mudi/IeHwpR4Yqz7M+EeMWk
 7cJWS7+JasL4w==
Date: Fri, 4 Sep 2020 23:38:41 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/17] hw/block/nvme: refactor aio submission
Message-ID: <20200904213841.GB610544@apples.localdomain>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-9-its@irrelevant.dk>
 <20200904194708.GA3318909@dhcp-10-100-145-180.wdl.wdc.com>
 <20200904203839.GA610544@apples.localdomain>
 <20200904211553.GB3318909@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200904211553.GB3318909@dhcp-10-100-145-180.wdl.wdc.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 16:38:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sep  4 14:15, Keith Busch wrote:
> On Fri, Sep 04, 2020 at 10:38:39PM +0200, Klaus Jensen wrote:
> > On Sep  4 12:47, Keith Busch wrote:
> > > On Fri, Sep 04, 2020 at 04:19:47PM +0200, Klaus Jensen wrote:
> > > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > > index bfac3385cb64..3e32f39c7c1d 100644
> > > > --- a/hw/block/nvme.c
> > > > +++ b/hw/block/nvme.c
> > > > @@ -110,6 +110,7 @@ static const uint32_t nvme_feature_cap[NVME_FID=
_MAX] =3D {
> > > >  };
> > > > =20
> > > >  static void nvme_process_sq(void *opaque);
> > > > +static void nvme_aio_cb(void *opaque, int ret);
> > >=20
> > > You don't need the forward declaration here. Just move the
> > > implementation above where it's used. It looks safe: nvme_aio_cb()
> > > doesn't have any circular dependencies.
> >=20
> > You are right, of course. But it is getting a circular dependency in a
> > later patch. I left it there to reduce code movement later.
>=20
> Is that coming in a future patch? Not finding it in this series.
>=20
> About the whole patch in general, are multiple aio's per-request coming
> in later patch as well? I didn't see any use for it here, and the
> overhead of dynamic allocation and zeroing a new struct in the IO path
> is a bit concerning for performance. I'd like to see your intended use
> for this.

Intended use-case was parallel aios. There are a lot of use cases for
this, DSM, metadata, block allocation tracking and zns zoneinfo.

But I'll rip it out of the series and repost so we can focus on multiple
namespaces.

