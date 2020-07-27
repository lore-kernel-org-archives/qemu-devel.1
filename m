Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3EEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57735206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="tKK4zD+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57735206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzKP-00050L-JM
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jzzJg-0004Po-Vw; Mon, 27 Jul 2020 05:21:05 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jzzJe-0002cq-HB; Mon, 27 Jul 2020 05:21:04 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 59CD8BF62F;
 Mon, 27 Jul 2020 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1595841659;
 bh=oMOrA8tEQcE8nsD7gY1GtZVsj1oaxo6GbDcd5YE54IA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tKK4zD+iz3XvG9UOgVSQePn02a9auai/dSNsGoME2A42qIam40HlAGiqNCyTjCggs
 W4YTOj26Ds3aldf08foRt2cN2cJVSwvIx6C1DK1l7rPUsWrkJdWkirM5N3xtmvlJkD
 SXy12zRHd6Jk0ti5i4YTYIvi+2uVlt4TLGxrmj1WzZNBCRxiC8CGqcKxl2/1TLXEUA
 YRRoyo9HCeyY9zTlxQls2DwchQxraMz4PaPMfspaDqVHKAMRWRcJFvCkVl1JL/D6BU
 wDURGnmBVP+0J8BnG4fm/g1SVt+kmR4A7Ymf2A++aZ0/l2xqGwQFnBCp+gKVXyG2+z
 kfQCcDZwNOZPw==
Date: Mon, 27 Jul 2020 11:20:55 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] pci: pass along the return value of dma_memory_rw
Message-ID: <20200727092055.GA52912@apples.localdomain>
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <20200629202053.1223342-2-its@irrelevant.dk>
 <20200722074834-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722074834-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 05:06:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 22 07:48, Michael S. Tsirkin wrote:
> On Mon, Jun 29, 2020 at 10:20:52PM +0200, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > Some devices might want to know the return value of dma_memory_rw, so
> > pass it along instead of ignoring it.
> > 
> > There are no existing users of the return value, so this patch should be
> > safe.
> > 
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> 
> 
> Please feel free to merge this with the patch that uses the
> return value.
> 

Hi Michael,

Noted. The patch depends on another series that have not been merged
yet, so this is why it is lying around and waiting to be added.


Thanks,
Klaus

