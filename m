Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB33C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358BB27D7A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358BB27D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35227 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmt5-0008GZ-43
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 09:20:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXms9-0007rJ-9Y
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hXms8-00075U-9J
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hXms4-0006v4-7L; Mon, 03 Jun 2019 09:19:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCE9681E0E;
	Mon,  3 Jun 2019 13:19:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-129.ams2.redhat.com [10.36.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED5275D9C6;
	Mon,  3 Jun 2019 13:19:17 +0000 (UTC)
Date: Mon, 3 Jun 2019 15:19:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Message-ID: <20190603131912.GE6523@linux.fritz.box>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 03 Jun 2019 13:19:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/15] block: AioContext management, part 2
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.05.2019 um 18:00 hat Kevin Wolf geschrieben:
> Recently, a few bugs were reported that resulted from an inconsistent
> state regarding AioContexts. Block nodes can end up in different
> contexts than their users expect - the AioContext of a node can even
> change under the feet of a device with no way for the device to forbid
> this. We recently added a few basic checks to scsi-disk and virtio-blk,
> but they are by far not enough.
> 
> Part 1 solved the first half of the problem and made sure that
> AioContext changes are propagated through the graph as necessary, so
> that a bdrv_set_aio_context() correctly pulls everything that uses the
> node into the right context.
> 
> This is part 2 that fixes the second half: Attaching new child nodes
> where the parent and child are already in different AioContexts. This
> operation may only succeed if we can move one of the node into the
> context of the other node.
> 
> After applying this series, unchecked bdrv_set_aio_context() doesn't
> exist any more and all users call functions that make sure that the
> AioContext assignments across the graph stays consistent.

Applied to the block branch.

Kevin

