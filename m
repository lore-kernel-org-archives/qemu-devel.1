Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821DEC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35362087C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 21:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbsNPrhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35362087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEJ4g-0005fv-L8
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 17:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kEJ3w-00056c-FR; Fri, 04 Sep 2020 17:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kEJ3u-0000OU-Q4; Fri, 04 Sep 2020 17:16:00 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D655D2087C;
 Fri,  4 Sep 2020 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599254156;
 bh=l0OdagDI/gG7HQrUddTrxVQUrIvjjDKvBCj6s2gjPvE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hbsNPrhcz3WbMeysPOps1qmEbf444RQPuS0T+vpga3BFPN0HWI4WGoyNbcmgNY5gj
 NvP993FccyBICW3yMSq3k6aluKu3d4kFsbLcCaEJUkp7FwcFtbXm2c2PVhofLKmtFz
 7phtNlJMB+U6wtsYybfDZvOAg/byFzQja2b/Qe0U=
Date: Fri, 4 Sep 2020 14:15:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 08/17] hw/block/nvme: refactor aio submission
Message-ID: <20200904211553.GB3318909@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200904141956.576630-1-its@irrelevant.dk>
 <20200904141956.576630-9-its@irrelevant.dk>
 <20200904194708.GA3318909@dhcp-10-100-145-180.wdl.wdc.com>
 <20200904203839.GA610544@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203839.GA610544@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 15:47:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Fri, Sep 04, 2020 at 10:38:39PM +0200, Klaus Jensen wrote:
> On Sep  4 12:47, Keith Busch wrote:
> > On Fri, Sep 04, 2020 at 04:19:47PM +0200, Klaus Jensen wrote:
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index bfac3385cb64..3e32f39c7c1d 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -110,6 +110,7 @@ static const uint32_t nvme_feature_cap[NVME_FID_MAX] = {
> > >  };
> > >  
> > >  static void nvme_process_sq(void *opaque);
> > > +static void nvme_aio_cb(void *opaque, int ret);
> > 
> > You don't need the forward declaration here. Just move the
> > implementation above where it's used. It looks safe: nvme_aio_cb()
> > doesn't have any circular dependencies.
> 
> You are right, of course. But it is getting a circular dependency in a
> later patch. I left it there to reduce code movement later.

Is that coming in a future patch? Not finding it in this series.

About the whole patch in general, are multiple aio's per-request coming
in later patch as well? I didn't see any use for it here, and the
overhead of dynamic allocation and zeroing a new struct in the IO path
is a bit concerning for performance. I'd like to see your intended use
for this.

