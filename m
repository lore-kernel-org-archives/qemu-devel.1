Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A2EC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683AB2687B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683AB2687B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45461 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWjo0-0007Ht-O1
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 11:50:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWjmm-0006cV-0z
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWjml-0004Zz-0L
	for qemu-devel@nongnu.org; Fri, 31 May 2019 11:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWjmi-0004W1-IV; Fri, 31 May 2019 11:49:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D826E3087945;
	Fri, 31 May 2019 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-126.ams2.redhat.com
	[10.36.117.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EB6B5C57D;
	Fri, 31 May 2019 15:49:32 +0000 (UTC)
Date: Fri, 31 May 2019 17:49:30 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190531154930.GF9842@localhost.localdomain>
References: <20190528084544.183558-1-vsementsov@virtuozzo.com>
	<20190528084544.183558-3-vsementsov@virtuozzo.com>
	<20190531105101.GB29868@stefanha-x1.localdomain>
	<6cddd33f-9d09-cff0-b8dd-c2c0e8696e69@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cddd33f-9d09-cff0-b8dd-c2c0e8696e69@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Fri, 31 May 2019 15:49:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] block/io: refactor padding
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "fam@euphon.net" <fam@euphon.net>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.05.2019 um 16:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 31.05.2019 13:51, Stefan Hajnoczi wrote:
> > On Tue, May 28, 2019 at 11:45:44AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> We have similar padding code in bdrv_co_pwritev,
> >> bdrv_co_do_pwrite_zeroes and bdrv_co_preadv. Let's combine and unify
> >> it.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   block/io.c | 344 ++++++++++++++++++++++++++++-------------------------
> > 
> > Hmmm...this adds more lines than it removes.  O_o
> 
> It's near to be the same size, and keep in mind big comment.

If you take the whole series into account, it looks even less
favourable, despite some comments:

3 files changed, 273 insertions(+), 165 deletions(-)

> > 
> > Merging a change like this can still be useful but there's a risk of
> > making the code harder to understand due to the additional layers of
> > abstraction.
> 
> It's a preparation for adding qiov_offset parameter to read/write path. Seems
> correct to unify similar things, which I'm going to change. And I really want
> to make code more understandable than it was.. But my view is not general
> of course.

Depending on the changes you're going to make (e.g. adding more users of
the same functionality, or making the duplicated code much larger), this
can be a good justification even if the code size increases.

I'd suggest to add the explanation (like 'This is in preparation for
...') to the commit message then.

Kevin

