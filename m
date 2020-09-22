Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5DC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C319D22206
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3uAQmLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C319D22206
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmE8-0000Ha-Rc
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKmBL-0005ry-U1; Tue, 22 Sep 2020 13:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kKmBJ-0002mP-RI; Tue, 22 Sep 2020 13:34:23 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 515ED2311C;
 Tue, 22 Sep 2020 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600796060;
 bh=oaMjeiUJzqwLKrkA6B37I43fgp/F0a5361JLfAwt/RI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F3uAQmLy7LupGAIB38hJ+0RPNgGbU0NZRyF/N15fqjqqKWDgoxWitug+11G9ZLUO8
 SQZuWIo2kIiU0WOACWI9oAJFGVZSSQoMYUUgMGL6Ty5zGR0MbGN8hdNLwVjxwozs+E
 S2VYuWG7SBh8UmhGO9CDNTQnkn+UNNiexGGSkkYg=
Date: Tue, 22 Sep 2020 10:34:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 00/17] hw/block/nvme: multiple namespaces support
Message-ID: <20200922173417.GB4035546@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200922084533.1273962-1-its@irrelevant.dk>
 <20200922153125.GC4035426@dhcp-10-100-145-180.wdl.wdc.com>
 <20200922172730.GB1236186@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922172730.GB1236186@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:34:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

On Tue, Sep 22, 2020 at 07:27:30PM +0200, Klaus Jensen wrote:
> On Sep 22 08:31, Keith Busch wrote:
> > On Tue, Sep 22, 2020 at 10:45:16AM +0200, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > > 
> > > This is the next round of my patches for the nvme device.
> > > 
> > > This includes a bit of cleanup and two new features:
> > > 
> > >   * support for scatter/gather lists
> > > 
> > >   * multiple namespaces support through a new nvme-ns device
> > > 
> > > Finally, the series wraps up with changing the PCI vendor and device ID to get
> > > rid of the internal Intel id and as a side-effect get rid of some Linux kernel
> > > quirks that no longer applies.
> > > 
> > > "pci: pass along the return value of dma_memory_rw" has already been posted by
> > > Philippe in another series, but since it is not applied yet, I am including it
> > > here.
> > 
> > For the rest of the patches I haven't individually commented:
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Sorry if I am being thick here Keith, but didn't you R-b all patches
> (except 3 and 9) in v2 yesterday?
> 
> I do not see any comments to any of the v3 patches, so I'm not sure how
> to interpret this ;)

Ha, I thought I did yesterday too, but it's not showing in my "Sent"
mail so I sent it again. But since it apparently did send, you can
interpret the 2nd as "two thumbs up!". :)

