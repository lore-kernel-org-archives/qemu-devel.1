Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD2DC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:34:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C49216C8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C49216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4mTF-0001vy-Gx
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 09:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i4mRh-00011R-43
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i4mRc-0002Mu-Nn
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 09:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i4mRW-00027y-VL; Mon, 02 Sep 2019 09:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0237D3082E10;
 Mon,  2 Sep 2019 13:32:25 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-189.ams2.redhat.com
 [10.36.116.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76EA810016EB;
 Mon,  2 Sep 2019 13:32:21 +0000 (UTC)
Date: Mon, 2 Sep 2019 15:32:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190902133219.GG13140@localhost.localdomain>
References: <20190823184733.18929-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823184733.18929-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 02 Sep 2019 13:32:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] block: Let blockdev-create return 0 on
 success
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.08.2019 um 20:47 hat Max Reitz geschrieben:
> Jobs are expected to return 0 on success.  .bdrv_co_create() on the
> other hand is a block layer function, and as such returns a
> non-negative value on success.

I don't agree that >= 0 is the block layer way. The block layer uses
0/-errno for the largest part of its interfaces; and I think the
BlockDriver callbacks might even be consistent in this. Of course, we
never documented this anywhere, maybe we should...

The only historical exceptions I'm aware of are blk/bdrv_pread/pwrite(),
which return the byte count instead of 0. They should be fixed
eventually, but it just never seemed important enough, even though it
did cause bugs every now and then.

> blockdev_create_run() should translate between the two (patch 1).
> 
> Without patch 1, blockdev-create is likely to fail for VPC images.
> Hence patch 2.

I'd argue this is a VPC bug. In the success path, it shouldn't return
ret as it happens to be at the end (it comes from bdrv_pwrite()), but
set it to 0 right before the 'fail:' label.

This is really a regression Jeff introduced in commit fef6070eff2,
though the bug was only latent then (five years ago).

Kevin

