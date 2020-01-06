Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F395C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5852072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 10:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5852072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioQ2Q-0004RM-6r
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 05:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioQ1r-0003qo-T1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioQ1q-0006Ux-Ei
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:54:35 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:36161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioQ1q-0006TO-8b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 05:54:34 -0500
Received: from player688.ha.ovh.net (unknown [10.108.16.68])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id B25AF12B2C5
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 11:54:31 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 8BB7ADCBF39B;
 Mon,  6 Jan 2020 10:54:27 +0000 (UTC)
Date: Mon, 6 Jan 2020 11:54:25 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9p: local: fix memory leak
Message-ID: <20200106115425.1ef819d8@bahia.lan>
In-Reply-To: <1582630.xPu3mGmscH@silver>
References: <20191230022347.36932-1-wangyan122@huawei.com>
 <1582630.xPu3mGmscH@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1289999819293497664
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhnuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Yan Wang <wangyan122@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 12:34:51 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 30. Dezember 2019 03:23:47 CET Yan Wang wrote:
> > Signed-off-by: Yan Wang <wangyan122@huawei.com>
> > ---
> >  hw/9pfs/9p-local.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index ca641390fb..d0592c3b45 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -947,7 +947,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpath,
> > if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
> >          local_is_mapped_file_metadata(ctx, name)) {
> >          errno = EINVAL;
> > -        return -1;
> > +        goto out;
> >      }
> > 
> >      odirfd = local_opendir_nofollow(ctx, odirpath);
> 
> This issue was already addressed 10 days ago and is scheduled for merge on 
> Greg's 9p-next branch:
> 
> https://github.com/gkurz/qemu/commit/ac5987075f42e44419a461846fdefde8ab4dd624
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg04774.html
> 
> 

That's correct.

Philippe,

If the commit description meets your expectations, just tell me and
I'll add your R-b.

Cheers and happy new year,

--
Greg

