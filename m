Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FBCA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 11:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DF121D7C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 11:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DF121D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLn4f-0004VJ-Jm
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 07:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <th.huth@gmail.com>) id 1iLn3y-0003z3-50
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 07:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <th.huth@gmail.com>) id 1iLn3w-0006VL-Vn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 07:38:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1iLn3w-0006Ui-Px
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 07:38:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id o18so8809686wrv.13
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 04:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PoAT52G3J2ya2EFlG9Oj1RsHPUVUSmRTq3hL5B3Gcws=;
 b=K9jMni6JQ71NPjq7Jud4L+CTjHKa61wnSHnDJk1/MUVuiVnmUjQUDAG3+u4cKdy23Z
 qzvxBNt++v4+qKZc4rK3IHqS/LSyHdhn0f+N+QC1G3K3eQKUevrDlSqWUIfA4FsgNrAF
 shyBCQKVrI1uWV3J+nd6WkccwPN3bRvQBieGcMMHwBRq/3IL+wrPA1R50N56QqesrRwQ
 UmfxVWH4T22eZXPLrnvG2nwPTbHH2EZ9LRO1oPZW7ayp1RAFHEkSisEXe5fxA6Tla86F
 y1taRP26XN4/hbdule044yQvTgUXGPeQWRzoOHPXattVYNHTLsnmBG62GpJwXRqu91Ds
 PKMA==
X-Gm-Message-State: APjAAAUOJS0YueGDnhohagcsFoI3/Tw0dAkwT7aPFlnX1JQIFAJuNDa0
 goPksCxNEZlU4iIJwgfiq1o=
X-Google-Smtp-Source: APXvYqycZALyOBocp03Qs8yF6OCnG+v5DC8lNNydK0l7g9ywLIwLZaOouVb47MCO2t/ku1+rdiDUIQ==
X-Received: by 2002:a5d:5444:: with SMTP id w4mr11236821wrv.18.1571485103707; 
 Sat, 19 Oct 2019 04:38:23 -0700 (PDT)
Received: from thl530 (x2f7f4ae.dyn.telefonica.de. [2.247.244.174])
 by smtp.gmail.com with ESMTPSA id g185sm8241356wme.10.2019.10.19.04.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 04:38:23 -0700 (PDT)
Date: Sat, 19 Oct 2019 13:38:21 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 7/8] hw/m68k/mcf5206.c: Switch to transaction-based
 ptimer API
Message-ID: <20191019133821.645ecbe3@thl530>
In-Reply-To: <20191019131027.018dc911@thl530>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-8-peter.maydell@linaro.org>
 <20191019124859.6a85e220@thl530> <20191019131027.018dc911@thl530>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sat, 19 Oct 2019 13:10:27 +0200
schrieb Thomas Huth <huth@tuxfamily.org>:

> Am Sat, 19 Oct 2019 12:48:59 +0200
> schrieb Thomas Huth <huth@tuxfamily.org>:
> 
> > Am Thu, 17 Oct 2019 14:29:04 +0100
> > schrieb Peter Maydell <peter.maydell@linaro.org>:
> > 
> > > Switch the mcf5206 code away from bottom-half based ptimers to
> > > the new transaction-based ptimer API.  This just requires adding
> > > begin/commit calls around the various places that modify the
> > > ptimer state, and using the new ptimer_init() function to create
> > > the timer.
> > > 
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  hw/m68k/mcf5206.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)  
> > 
> > After applying the patch, I now get an assertion:
> > 
> > $ qemu-system-m68k -nographic -kernel
> > ~/tmp/images/image-an5206-big-20000706.bin -M an5206
> > 
> > uClinux/COLDFIRE(m5206)
> > COLDFIRE port done by Greg Ungerer, gerg@moreton.com.au
> > Flat model support (C) 1998,1999 Kenneth Albanowski, D. Jeff Dionne
> > KERNEL -> TEXT=0x010000-0x077cb8 DATA=0x077cb8-0x08b0d0
> > BSS=0x08b0d0-0x0a2d58 KERNEL -> ROMFS=0x0a2d58-0x183b10
> > MEM=0x183b10-0x1fff000 STACK=0x1fff000-0x2000000 qemu-system-m68k:
> > hw/core/ptimer.c:410: ptimer_transaction_begin: Assertion
> > `!s->in_transaction || !s->callback' failed.
> > 
> > Looks like something is still wrong here...

Looking at the code a little bit, I think you missed the early return
in m5206_timer_recalibrate() :

    if ((s->tmr & TMR_RST) == 0)
        return;

That needs a ptimer_transaction_commit() now, too.

 Thomas

