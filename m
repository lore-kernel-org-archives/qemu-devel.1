Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF04C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5050C2531E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 08:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5050C2531E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49311 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGee-0006wu-If
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 04:43:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWGdl-0006bd-41
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWGdk-0002Be-6r
	for qemu-devel@nongnu.org; Thu, 30 May 2019 04:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWGdi-0002As-48; Thu, 30 May 2019 04:42:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D08FA0B47;
	Thu, 30 May 2019 08:42:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 649248195;
	Thu, 30 May 2019 08:42:16 +0000 (UTC)
Date: Thu, 30 May 2019 10:42:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190530084214.GA4890@linux.fritz.box>
References: <20190527092319.15844-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527092319.15844-1-stefanha@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 30 May 2019 08:42:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: explictly clear laiocb->co
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	pbonzini@redhat.com, Julia Suvorova <jusual@mail.ru>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.05.2019 um 11:23 hat Stefan Hajnoczi geschrieben:
> qemu_aio_get() does not zero allocated memory.  Explicitly initialize
> laiocb->co to prevent an uninitialized memory access in
> qemu_laio_process_completion().
> 
> Note that this bug has never manifested itself.  I guess we're lucky!
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

That the bug never manifested itself might be because it's in an unused
function. How about we finally just remove the unused callback-based
laio_submit() from the code?

At the time when I converted linux-aio to coroutines, someone (maybe
Paolo?) insisted that we keep the old interface because we might add a
new user sometime with possible shortcuts that bypass the whole coroutine
path, but it hasn't happened and I think we've moved even further in the
opposite direction since then.

Kevin

> I challenge you to find a place where laiocb->co is initialized and then
> we can drop this patch.  I've double-checked and cannot find it...
> 
>  block/linux-aio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/linux-aio.c b/block/linux-aio.c
> index d4b61fb251..a097653be6 100644
> --- a/block/linux-aio.c
> +++ b/block/linux-aio.c
> @@ -440,6 +440,7 @@ BlockAIOCB *laio_submit(BlockDriverState *bs, LinuxAioState *s, int fd,
>      int ret;
>  
>      laiocb = qemu_aio_get(&laio_aiocb_info, bs, cb, opaque);
> +    laiocb->co = NULL;
>      laiocb->nbytes = nb_sectors * BDRV_SECTOR_SIZE;
>      laiocb->ctx = s;
>      laiocb->ret = -EINPROGRESS;
> -- 
> 2.21.0
> 

