Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91217C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61CED208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 11:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61CED208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55181 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ8pj-0006lc-Ar
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 07:09:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQ8op-0006PS-EV
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hQ8oo-0000k3-9Y
	for qemu-devel@nongnu.org; Mon, 13 May 2019 07:08:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hQ8om-0000iS-4a; Mon, 13 May 2019 07:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A3573079B6B;
	Mon, 13 May 2019 11:08:25 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-130.ams2.redhat.com [10.36.117.130])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 97CE66A481;
	Mon, 13 May 2019 11:08:24 +0000 (UTC)
Date: Mon, 13 May 2019 13:08:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190513110823.GA19114@linux.fritz.box>
References: <20190510211244.26461-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510211244.26461-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Mon, 13 May 2019 11:08:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: Truncate in
 xfs_write_zeroes()
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.05.2019 um 23:12 hat Max Reitz geschrieben:
> XFS_IOC_ZERO_RANGE does not increase the file length:
> $ touch foo
> $ xfs_io -c 'zero 0 65536' foo
> $ stat -c "size=%s, blocks=%b" foo
> size=0, blocks=128
> 
> We do want writes beyond the EOF to automatically increase the file
> length, however.  This is evidenced by the fact that iotest 061 is
> broken on XFS since qcow2's check implementation checks for blocks
> beyond the EOF.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Just for the record, the commit that made the problem visible in 061 is
commit a5fff8d4.

Thanks, applied to the block branch.

Though I wonder if we should prefer FALLOC_FL_ZERO_RANGE now if
available, which is a single syscall and consistent for all filesystems.

Kevin

