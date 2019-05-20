Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA4CC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151C420675
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 11:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151C420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSgAL-00032C-9q
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 07:09:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSg9R-0002hY-5t
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hSg9Q-0005VJ-8n
	for qemu-devel@nongnu.org; Mon, 20 May 2019 07:08:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hSg9O-0005SM-4w; Mon, 20 May 2019 07:08:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E685C04FFF1;
	Mon, 20 May 2019 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-208.ams2.redhat.com
	[10.36.117.208])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4E560BEC;
	Mon, 20 May 2019 11:08:03 +0000 (UTC)
Date: Mon, 20 May 2019 13:08:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Message-ID: <20190520110801.GD5699@localhost.localdomain>
References: <20190506171805.14236-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506171805.14236-1-kwolf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 20 May 2019 11:08:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/10] block: AioContext management, part 1
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

Am 06.05.2019 um 19:17 hat Kevin Wolf geschrieben:
> Recently, a few bugs were reported that resulted from an inconsistent
> state regarding AioContexts. Block nodes can end up in different
> contexts than their users expect - the AioContext of a node can even
> change under the feet of a device with no way for the device to forbid
> this. We recently added a few basic checks to scsi-disk and virtio-blk,
> but they are by far not enough.
> 
> This is the first part of my work to actually properly manage
> AioContexts in the block layer rather than just doing some ad-hoc calls
> to bdrv_set_aio_context() and hoping that everything will work out.
> 
> The goal of this first part is that bdrv_set_aio_context() propagates
> the AioContext change not only to the children of the node like we
> already do, but also to any other affected nodes, such as additional
> parents or nodes connected to the requested one only through a block job
> that operates on both nodes.
> 
> Keep in mind that a second part will follow and that this is visible in
> some functions that may not seem that useful in this series. In
> particular, bdrv_try_set_aio_context() isn't used much outside of test
> cases in this series. This will change in the second part.

Applied to the block branch.

Kevin

