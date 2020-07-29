Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B8EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CCF20658
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="DrGdwO/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CCF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sNw-0002SS-4y
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sNO-0001xo-4h; Wed, 29 Jul 2020 16:08:34 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1k0sNK-0000wB-Mn; Wed, 29 Jul 2020 16:08:33 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 382A7BF616;
 Wed, 29 Jul 2020 20:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
 s=default; t=1596053307;
 bh=vLAxAlQcaQFV7/tIA7e1PgFJAwF2GCs5v3eTFDpV7rs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DrGdwO/mn1MQnd2ejxcxDeFw5M2V853zhYDWWK3IdjjRJe0VALWyZ92+DyhjzC7vW
 dy0V6zEmJZAxVh6Q3In6KMp2iELBIxiBEXsgPZjrvqrc4SstEPq4gkxmgfSE23w+t7
 4wlz1n8Qcgop5V+ZTci/lR0dmV9Xm5sDODmM1hswd2Jsex65HQa+4lGygAvIUOxALX
 NJ+Q1TLh8Qo9dWVGg4QJczTuUOorc6VGrMnsHaFb9JNr71hQofre+5QwTEUrq585T2
 7y9U0/HVp+3DEeaRWrEetVWbS75yt5rX2XN2MGnOXVdpkUUBSEQsd38XRNW7FDvM3I
 uNooN+pi50LBw==
Date: Wed, 29 Jul 2020 22:08:23 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v3 08/18] hw/block/nvme: add support for the asynchronous
 event request command
Message-ID: <20200729200823.GA318046@apples.localdomain>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-9-its@irrelevant.dk>
 <233870089fe3b268bfb73cc7c41dc5beecd7904d.camel@redhat.com>
 <20200729133703.GB159410@apples.localdomain>
 <230636e83c8e3c9f51136c169f81f6c4a047b3c4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <230636e83c8e3c9f51136c169f81f6c4a047b3c4.camel@redhat.com>
Received-SPF: pass client-ip=128.199.63.193; envelope-from=its@irrelevant.dk;
 helo=charlie.dont.surf
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 14:23:15
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
 Javier Gonzalez <javier.gonz@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 29 21:45, Maxim Levitsky wrote:
> On Wed, 2020-07-29 at 15:37 +0200, Klaus Jensen wrote:
> > On Jul 29 13:43, Maxim Levitsky wrote:
> > > On Mon, 2020-07-06 at 08:12 +0200, Klaus Jensen wrote:
> > > > +    DEFINE_PROP_UINT8("aerl", NvmeCtrl, params.aerl, 3),
> > > So this is number of AERs that we allow the user to be outstanding
> > 
> > Yeah, and per the spec, 0's based.
> > 
> > > > +    DEFINE_PROP_UINT32("aer_max_queued", NvmeCtrl, params.aer_max_queued, 64),
> > > And this is the number of AERs that we keep in our internal AER queue untill user posts and AER so that we
> > > can complete it.
> > > 
> > 
> > Correct.
> 
> Yep - this is what I understood after examining all of the patch, but from the names itself it is hard to understand this.
> Maybe a comment next to property to at least make it easier for advanced user (e.g user that reads code)
> to understand?
> 
> (I often end up reading source to understand various qemu device parameters).
> 

I should add this in docs/specs/nvme.txt (which shows up in one of my
next series when I add a new PCI id for the device). For now, I will add
it to the top of the file like the rest of the parameters.

Subsequent series contains a lot more additions of new parameters that
is directly from the spec and to me it really only makes sense that they
share the names if they can.

We could consider having them under a "spec namespace"? So, say, we do
DEFINE_PROP_UINT("spec.aerl", ...)?

