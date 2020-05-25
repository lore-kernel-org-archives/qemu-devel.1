Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24412068D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24412068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8Me-0001BH-6E
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jd8Lk-0000UZ-2D; Mon, 25 May 2020 04:20:44 -0400
Received: from charlie.dont.surf ([128.199.63.193]:36424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1jd8Li-0002Gt-CB; Mon, 25 May 2020 04:20:43 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id D3274BF66B;
 Mon, 25 May 2020 08:20:37 +0000 (UTC)
Date: Mon, 25 May 2020 10:20:34 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: Re: [PATCH v6 07/20] hw/block/nvme: fix pin-based interrupt behavior
Message-ID: <20200525082034.fmpqi5hn2dfdfwqi@apples.localdomain>
References: <20200514044611.734782-1-its@irrelevant.dk>
 <20200514044611.734782-8-its@irrelevant.dk>
 <20200518050227.i7yxsoovnedqbcqf@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518050227.i7yxsoovnedqbcqf@apples.localdomain>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 04:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 18 07:02, Klaus Jensen wrote:
> On May 14 06:45, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> > 
> > First, since the device only supports MSI-X or pin-based interrupt, if
> > MSI-X is not enabled, it should not accept interrupt vectors different
> > from 0 when creating completion queues.
> > 
> > Secondly, the irq_status NvmeCtrl member is meant to be compared to the
> > INTMS register, so it should only be 32 bits wide. And it is really only
> > useful when used with multi-message MSI.
> > 
> > Third, since we do not force a 1-to-1 correspondence between cqid and
> > interrupt vector, the irq_status register should not have bits set
> > according to cqid, but according to the associated interrupt vector.
> > 
> > Fix these issues, but keep irq_status available so we can easily support
> > multi-message MSI down the line.
> > 
> > Fixes: 5e9aa92eb1a5 ("hw/block: Fix pin-based interrupt behaviour of NVMe")
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >  hw/block/nvme.c | 12 ++++++++----
> >  hw/block/nvme.h |  2 +-
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> > 
> 
> Gentle ping on this and [PATCH v6 08/20].
> 
 
And another ping :)

