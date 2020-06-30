Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3304CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34902073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aAVAGAHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34902073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqI0y-0002o4-4n
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jqI06-00020g-Nn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:16:46 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jqI04-0007RT-Hu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=KDQWI0FaVGdGoRH/Dz48VuGe9n/8VBttUXugNDRkXw0=; b=aAVAGAHlnxhqapyFwsjSwsK/1B
 yp+lzik065eY5KCnQsnnO5yOFE2aVvCMogu9KH8XoOEBjTvH5uTJQ+6A9WSWiVxZSwzFLaog9Nh1a
 kgQGNXft034Id5CEo4e5Kbx8RvOTGNkIt4Vo7Ebu47poQJ36xPVrBIPC8mrOINaCcxrRYTh4NdxUL
 cU8iv+KoBVn3CV7QgI1+LGjwI1O2Z6BgVC0nv78oXbStiwQNI5RizjELbURAuqsgGBReNGBu9s+uU
 p7RYq1fjJB0F2pIpzqW/7uhh8ByWsgBgeYXydgIwsdOhCzUIhb7zi/G7lclCmC67y9Tlmquo9fd+d
 dF7Or5sA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v6 4/5] 9pfs: T_readdir latency optimization
Date: Tue, 30 Jun 2020 17:16:40 +0200
Message-ID: <33906767.5Uf7ihArhA@silver>
In-Reply-To: <20200629183902.75d6fb0b@bahia.lan>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
 <3959658.0YslYoXCm0@silver> <20200629183902.75d6fb0b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:16:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Montag, 29. Juni 2020 18:39:02 CEST Greg Kurz wrote:
> On Wed, 03 Jun 2020 19:16:08 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > On Sonntag, 19. April 2020 17:06:17 CEST Christian Schoenebeck wrote:
> > > Make top half really top half and bottom half really bottom half:
> > > 
> > > Each T_readdir request handling is hopping between threads (main
> > > I/O thread and background I/O driver threads) several times for
> > > every individual directory entry, which sums up to huge latencies
> > > for handling just a single T_readdir request.
> > > 
> > > Instead of doing that, collect now all required directory entries
> > > (including all potentially required stat buffers for each entry) in
> > > one rush on a background I/O thread from fs driver by calling the
> > > previously added function v9fs_co_readdir_many() instead of
> > > v9fs_co_readdir(), then assemble the entire resulting network
> > > response message for the readdir request on main I/O thread. The
> > > fs driver is still aborting the directory entry retrieval loop
> > > (on the background I/O thread inside of v9fs_co_readdir_many())
> > > as soon as it would exceed the client's requested maximum R_readdir
> > > response size. So this will not introduce a performance penalty on
> > > another end.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  hw/9pfs/9p.c | 122 +++++++++++++++++++++++----------------------------
> > >  1 file changed, 55 insertions(+), 67 deletions(-)
> > 
> > Ping. Anybody?
> > 
> > I would like to roll out this patch set soon and this is the only patch in
> > this series missing a review yet.
> 
> Hi Christian,

Hi Greg,

> Sorry for getting back to this only now :-\
> 
> So I still have some concerns about the locking of the directory stream
> pointer a fid. It was initially introduced to avoid concurrent accesses
> by multiple threads to the corresponding internal glibc object, as
> recommended in the readdir(3) manual page. Now, this patch considerably
> extends the critical section to also contain calls to telldir() and all
> the _many_ readdir()... so I'm not sure exactly what's the purpose of
> that mutex right now. Please provide more details.

The intention of this lock is to prevent concurrent r/w (i.e. telldir()/
readdir()) of the dir stream position by two or more active readdir requests 
handled in parallel, provided that they would use the same FID. Due to the 
latter requirement for this to become relevant, we already agreed that this is 
not something that would usually happen with a Linux 9p client, but there is 
nothing from protocol point of view that would prohibit this to be done by a 
client, so the resulting undefined behaviour should be prevented, which this 
lock does.

What's your precise concern?

Best regards,
Christian Schoenebeck



