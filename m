Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FB0C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD111215EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD111215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFZl4-0007dm-MV
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 04:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFZkP-0007B7-CM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFZkO-00072J-FM
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFZkL-000717-Ea; Wed, 02 Oct 2019 04:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8716B34CC;
 Wed,  2 Oct 2019 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4229A5D6A3;
 Wed,  2 Oct 2019 08:12:24 +0000 (UTC)
Date: Wed, 2 Oct 2019 10:12:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: bitmap migration bug with -drive while block mirror runs
Message-ID: <20191002081223.GA5819@localhost.localdomain>
References: <315cff78-dcdb-a3ce-2742-da3cc9f0ca97@redhat.com>
 <d897c755-40e7-6392-23e3-c06b1a371f28@virtuozzo.com>
 <4bc910ef-0bec-cfd6-89f6-a93d35367218@redhat.com>
 <9431d242-bfe1-b9db-17d0-6c1a280a05da@virtuozzo.com>
 <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e112c85a-684f-5721-2da7-d23312c9e487@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 02 Oct 2019 08:12:28 +0000 (UTC)
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2019 um 18:07 hat John Snow geschrieben:
> >> So the real back-resolution mechanism is:
> 
> Amendment:
>    - If our local node-name N is well-formed, use this.
>    - Otherwise:
> >> - Find the first non-filter ancestor, A
> >> - if A is not a block-backend, we must use our node-local name.
>      Amendment: If it's not a BB, we have no addressable name
>                 for the bitmap and this is an error.
> >> - if A's name is empty, we must use our node-local name.
>      Amendment: If it's empty, we have no addressable name
>                 for the bitmap and this is an error.
> >> - If the name we have chosen is not id_wellformed, we have no
> >> migration-stable addressable name for this bitmap and the migration must
> >> fail!
>      (Handled by above amendments.)
> 
> The reason for the change is to prefer user-defined node names whenever
> possible; only trying to find a "device" or "backend" name whenever we
> fail to find one.

I think we also need to clarify what "find the first non-filter" means:
"first" means not skipping over non-filters, but there can still be
multiple parents, and we can take the name of any of them.

In legacy setups, we can expect that there is only one BB that has a
defined name (i.e. nodes aren't reused in multiple subtrees) whereas the
other BBs may come from things like block jobs. We must not give up and
error out when the job BB is returned first.

Kevin

