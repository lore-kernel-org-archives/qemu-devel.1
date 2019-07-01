Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE57C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24BDD20652
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6r0OJiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BDD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5P7-00077m-29
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hi3cB-0003zZ-OZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hi3c6-0000yp-0z
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:31 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hi3c5-0000HR-Kc
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:25 -0400
Received: by mail-oi1-f173.google.com with SMTP id m202so11175856oig.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XYQR9jP5S8jstoPzfaXsLfCb2tOUGQDtXbORRsv8ATM=;
 b=o6r0OJiBhJ3b7f+KvnzmC3Eq05O6gww2RlS3MdLFiqnnjqZljvjFjGPgsEQL7sIZT5
 MD8zMqL6NfXJEJMNt2+F1maTB9DMYGiJqZiB8y2iVZ22iHVc+a0U5lKOBQGalcfisciX
 eYlfGPJY+lkiT0Zjob0wC+CT27ukc+tsr++y3/BVfV8PBzDV/H1lUu5x84rlDAeU/h/g
 ps9kfQxwdOHrNT9dhrvb2jcbT3eoSL+gifddVKTVAkUB8gs7Nzyh9G2zzdRln/GQL4tb
 CAfsTwXxLQmVs8qhtjAbN+BgFC/2wyO+sD44uhBiMQYPhHcZZsGQzDwJZkZDIjcl9Pqe
 TxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition:in-reply-to
 :user-agent;
 bh=XYQR9jP5S8jstoPzfaXsLfCb2tOUGQDtXbORRsv8ATM=;
 b=hp7tD8HlXeKVOXVCtqiqKN+rSN7pXXZnr597fAbszXc7w7IXh+xUb5X2pSWbBK+5AN
 ULRcMNKF1MZKB47XfsY85G7VwdnTQ3o3HrtdxDhp7vSDbtSYY1ekSy4dCv87UN9wb3F9
 hzw9EnHQq9hnj+65OBVk51mxR1ntIyl0jHREVB5NVlDtSnNkDyPKyf46BO1A7Xt15VPH
 sKPSXaGQI4e3DXjI0Df51GsePE+YzgbrdSWy7FWRCBLgngM3+G5VtApKwNl27wMxt/hk
 HpBezI6pq1MlzhuYZTw/dD2vnBa1YYVMnU789tutrqeL5FCHSk3kFMdHNba5eJRUf7FW
 FfSA==
X-Gm-Message-State: APjAAAVXujThO8vJGgWJNBFmbV5X9TTDG8bhz+97YYWIKbjyTTJf7+DR
 Z7XdedWyQLK9wK3ZUr4lBSx4YCU=
X-Google-Smtp-Source: APXvYqzu9Os6VfNoF5s55aif9MyY7+yunjvy8p9IYb9PZrd+ZTXAnhV5bgrmHdseyfOJXOaaSNmvOw==
X-Received: by 2002:aca:b554:: with SMTP id e81mr434691oif.7.1562005511245;
 Mon, 01 Jul 2019 11:25:11 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id v18sm5141041otn.17.2019.07.01.11.25.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 11:25:09 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9997:a955:13ad:73b])
 by serve.minyard.net (Postfix) with ESMTPSA id 7FAEA1800D1;
 Mon,  1 Jul 2019 18:25:07 +0000 (UTC)
Date: Mon, 1 Jul 2019 13:25:03 -0500
From: Corey Minyard <minyard@acm.org>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190701182503.GA4336@minyard.net>
References: <20190627124815.29536-1-minyard@acm.org>
 <CAFEAcA_YcEtXDMR-7D4R0Tdb0zM7LARpisvV5VjTnoki=9_WPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_YcEtXDMR-7D4R0Tdb0zM7LARpisvV5VjTnoki=9_WPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.173
Subject: Re: [Qemu-devel] [PULL 0/2] Add a UUID device property to IPMI
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
Reply-To: minyard@acm.org
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 07:10:50PM +0100, Peter Maydell wrote:
> On Thu, 27 Jun 2019 at 13:48, <minyard@acm.org> wrote:
> >
> > I believe we are not in softfreeze yet, and this is the only real
> > fix I have for IPMI at the moment.
> >
> > This was posted Nov 2018 with little commentary.
> >
> > The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
> >
> >   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/cminyard/qemu.git tags/ipmi-for-release-20190627
> >
> > for you to fetch changes up to bddef5881d0c935a5d9d8e15f822d9d700666ae6:
> >
> >   ipmi: Add a UUID device property (2019-06-26 15:31:33 -0500)
> >
> > ----------------------------------------------------------------
> > Add a UUID device property to IPMI
> >
> > This is fairly important for two reasons:
> >
> > * It allows a BMC to be created with no UUID, returning an error, which
> >   is the behavior of many BMCs in the world.
> > * It lets the user set the UUID to a fixed value.
> >
> > Some software using IPMI will get confused if it gets different UUIDs
> > from what should be the same device, which is what happens now if qemu
> > quits and restarts.
> >
> > ----------------------------------------------------------------
> > Corey Minyard (2):
> >       qdev: Add a no default uuid property
> >       ipmi: Add a UUID device property
> 
> I have to say I'm not entirely happy with applying a pullreq
> with patches that are unreviewed and were last posted on list
> over six months ago. Can you post a v2 to try to solicit code
> review for them before we put them into master, please?
> 
> (Sometimes patches don't get review, and we generally take
> them anyway; I do that myself from time to time. It's the
> combination of the six-months-since-patches-posted plus the
> imminent freeze deadline that gives me pause in this case.)

Will do.

I looked around and tried to find the freeze dates, and I couldn't
find anything published.  If I had known it was close, I would have
waited.

-corey

