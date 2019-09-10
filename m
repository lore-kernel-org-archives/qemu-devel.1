Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3914C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB418206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB418206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hqm-00049x-Mk
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7hVT-0004sr-OA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7hVS-0000kY-K9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:52:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7hVQ-0000jg-7I; Tue, 10 Sep 2019 10:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8C4B93082B40;
 Tue, 10 Sep 2019 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 822A960BF3;
 Tue, 10 Sep 2019 14:52:30 +0000 (UTC)
Date: Tue, 10 Sep 2019 16:52:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910145229.GI4446@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-23-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 10 Sep 2019 14:52:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 22/42] block: Fix
 bdrv_get_allocated_file_size's fallback
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> If the driver does not implement bdrv_get_allocated_file_size(), we
> should fall back to cumulating the allocated size of all non-COW
> children instead of just bs->file.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

This smells like an overgeneralisation, but if we want to count all vmdk
extents, the qcow2 external data file, etc. it's an improvement anyway.
A driver that has a child that should not be counted must just remember
to implement the callback.

Let me think of an example... How about quorum, for a change? :-)
Or the second blkverify child.

Or eventually the block job filter nodes.

Ehm... Maybe I should just take back what I said first. It almost feels
like it would be better if qcow2 and vmdk explicitly used a handler that
counts all children (could still be a generic one in block.c) rather
than having to remember to disable the functionality everywhere where we
don't want to have it.

And please adjust the comment for bdrv_get_allocated_file_size(), it
only talks about a single file as if trees didn't exist. Actually, it
doesn't even seem so easy to define. Maybe primary node + storage nodes?
Then vmdk needs to expose its extents as storage nodes (plural!), but
in the long run that might be needed anyway.

Kevin

