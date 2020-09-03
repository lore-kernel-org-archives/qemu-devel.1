Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31D1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A11320775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BYqpq54A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A11320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrUB-0000BF-Mu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDrTb-0007r0-Mo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:48:39 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:33395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kDrTZ-0004L8-CU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=FlhUan+HiAwQUr7FnO9j+r3lOwU34M6i45XNLrgdz3s=; b=BYqpq54Aba6siac++61IMjNqj+
 CBP0HMW4f+DmiI+pgzjfqmyqXeWoPbXe+BhBNtev/7pMT0NVBe1cDJ0RUiU2ajwmSxyLWUHu19e06
 yAK5lhcx1x9uvVC+qieg9GHRiC3k/c48+GDErGJXJzsAx5c5cH5Nkl+LyU4xbS4KutfrcuSCAh1ll
 UAD8/HgOQnG1VApnYb11Ch11whexri1Zkfc/U9ZQiZYNMQI0A1N8/+zz4lBSZ2l47DpZkQMc7GZl4
 KdusGvTJgB+Mrfw8NtgrkfZOkmlKNAKrxHZJFNgmoJgGo5RHZTPWBnaI8V8CkoUTMXk6fPUFvK0u0
 8e074zZg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, berrange@redhat.com
Subject: Re: [PATCH v2 0/1] 9pfs: log warning if msize <= 8192
Date: Thu, 03 Sep 2020 17:48:33 +0200
Message-ID: <2806958.T35s8Q7qhx@silver>
In-Reply-To: <20200903174123.6b754055@bahia.lan>
References: <cover.1599144062.git.qemu_oss@crudebyte.com>
 <20200903171931.3bfe611a@bahia.lan> <20200903174123.6b754055@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 10:59:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 3. September 2020 17:41:23 CEST Greg Kurz wrote:
> On Thu, 3 Sep 2020 17:19:31 +0200
> 
> Greg Kurz <groug@kaod.org> wrote:
> > On Thu, 3 Sep 2020 16:41:02 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > I have updated the QEMU 9P setup wiki page about this 'msize' issue. For
> > > some reason the dedicated anchor 'msize' does not work though:
> > > 
> > > https://wiki.qemu.org/Documentation/9psetup#msize
> > 
> > AFAICT the wiki derives the anchor from the section name, ie.
> > 
> > https://wiki.qemu.org/Documentation/9psetup#Performance_Considerations
> > 
> > It's a bit longer than #msize but it works. I don't know if you can
> > add anchors manually in the wiki.
> 
> It seems you could achieve this without the template:
> 
> == <span id="msize">Performance Considerations</span> ==

What I tried was this (as wiki source):

<!-- NOTE: anchor 'msize' is linked by a QEMU 9pfs log message in 9p.c  -->
{{anchor|msize}}
== Performance Considerations ==

Which "should" work according to:
https://en.wikipedia.org/wiki/Template:Anchor

However after I did those changes I saw some template errors as comment in the 
generated HTML sources, which now are gone at least.

I wait a bit to see if it is maybe just a caching problem. If it still doesn't 
work in a while, I will update it with your solution a bit later.

Thanks for the hint!

Best regards,
Christian Schoenebeck



