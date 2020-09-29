Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C7C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866A12083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHJomT4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866A12083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOZq-0004Cf-Fl
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNOYh-00039h-7U; Tue, 29 Sep 2020 18:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNOYf-0005wV-5m; Tue, 29 Sep 2020 18:57:18 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2FEA320897;
 Tue, 29 Sep 2020 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601420235;
 bh=lr+SoA5K2a3orXOnREESHUWcQ3Jqbg4PxHV8g404vbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UHJomT4oY4rTfTSXCZPyghHtBRx+w/+ztY3JbZr6BbiUL0QneFxKvh0Q7/njpGBKa
 G/XoWATii+CSeVJSjxOAmytSYhs0v6+cvbu2VS1mGj/HS8aUXe8hhp3JoaWHRTo2Pm
 GFZO/z9Hs15BvqGB8d2UCpLrlqfNN/qSpPZGXCfY=
Date: Tue, 29 Sep 2020 15:57:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v3 07/18] hw/block/nvme: add support for the get log page
 command
Message-ID: <20200929225712.GA516327@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200706061303.246057-1-its@irrelevant.dk>
 <20200706061303.246057-8-its@irrelevant.dk>
 <CAFEAcA8dqNBm1YqLPjoJ=79K=6z=SxYHvcvnZiY3MJMvv1n1BQ@mail.gmail.com>
 <20200929214600.GA377237@apples.localdomain>
 <20200929223420.GB508696@dhcp-10-100-145-180.wdl.wdc.com>
 <20200929224248.GB377237@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929224248.GB377237@apples.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 18:34:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Klaus Jensen <k.jensen@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 12:42:48AM +0200, Klaus Jensen wrote:
> On Sep 29 15:34, Keith Busch wrote:
> > Yeah, looks safe as-is, but we're missing out on returning the spec
> > required 'Invalid Field'.
> 
> I can't see where it says that we should do that? Invalid Field in
> Command if offset is *greater* than the size of the log page.
> 
> Some dynamic log pages have side-effects of being read, so while this is
> a super wierd way of specifying that we want nothing returned, I think
> it is valid?

Eh, when spec says "size of the log page", I assume they're using the
"zeroes based" definition for size as aligned with the NUMD field. So
512 is bigger than the sizeof the smart log occupying bytes 0-511.

But I guess there's room to see it the other way, so maybe it is a
way to request a no data log.

