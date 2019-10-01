Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6F3ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6837D21855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6837D21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFLDd-0006aA-N3
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFKp3-0007jC-90
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFKp1-00045c-3a
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 12:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFKoy-00043g-QI; Tue, 01 Oct 2019 12:16:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10C1F30917EF;
 Tue,  1 Oct 2019 16:16:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2957B5D712;
 Tue,  1 Oct 2019 16:16:12 +0000 (UTC)
Date: Tue, 1 Oct 2019 18:16:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191001161610.GG4688@linux.fritz.box>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 01 Oct 2019 16:16:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2019 um 17:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 01.10.2019 17:10, John Snow wrote:
> > 
> > 
> > On 10/1/19 10:00 AM, Vladimir Sementsov-Ogievskiy wrote:
> >>> Otherwise: I have a lot of cloudy ideas on how to solve this, but
> >>> ultimately what we want is to be able to find the "addressable" name for
> >>> the node the bitmap is attached to, which would be the name of the first
> >>> ancestor node that isn't a filter. (OR, the name of the block-backend
> >>> above that node.)
> >> Not the name of ancestor node, it will break mapping: it must be name of the
> >> node itself or name of parent (may be through several filters) block-backend
> >>
> > 
> > Ah, you are right of course -- because block-backends are the only
> > "nodes" for which we actually descend the graph and add the bitmap to
> > its child.
> > 
> > So the real back-resolution mechanism is:
> > 
> > - Find the first non-filter ancestor, A
> > - if A is not a block-backend, we must use our node-local name.
> > - if A's name is empty, we must use our node-local name.
> > - If the name we have chosen is not id_wellformed, we have no
> > migration-stable addressable name for this bitmap and the migration must
> > fail!
> > 
> > 
> > For resolving bitmap addresses via QMP (node, name) pairs; the
> > resolution method would be this:
> > 
> > - if the node-name N is a block-backend, descend the tree until we find
> > the first non-filter node V.
> > - if the node-name N is a BlockDriverState, use this node directly.
> > 
> 
> Looks good for me.
> 
> I also think if on destination we have both block-backend with name N and
> block-node with name N and the latter is not (filtered) child of the former,
> we should fail migration of at least that bitmap. (Hope, nobody reuse
> block-backend names as node-names in practice.. (should we restrict it
> explicitly ?))

You can't have a node and a BlockBackend of the same name, they share a
single namespace. If you try to do so, you get an error.

Kevin

