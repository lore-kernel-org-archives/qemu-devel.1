Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB93C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716342148D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716342148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDRGj-0003DX-Hl
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 06:12:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRFt-0002sV-9G
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDRFr-0005LD-Tv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:11:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDRFn-0005Hk-RU; Mon, 08 Apr 2019 06:11:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B54081243;
	Mon,  8 Apr 2019 10:04:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-165.ams2.redhat.com [10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ACE75D719;
	Mon,  8 Apr 2019 10:04:43 +0000 (UTC)
Date: Mon, 8 Apr 2019 12:04:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190408100442.GA11997@linux.fritz.box>
References: <1554474244-553661-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<ad53e61a-a911-c019-3f68-2bd05b7be944@redhat.com>
	<468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <468cc6c9-c338-a4fe-57b1-b4df5b2b24c0@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 08 Apr 2019 10:04:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/io.c: fix for the
 allocation failure
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
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408100442.rzSKMqL3bcpumUB2fTe9iYXyekiC_5ncHq4U3YjiDcI@z>

Am 08.04.2019 um 11:44 hat Andrey Shinkevich geschrieben:
> 
> 
> On 06/04/2019 01:50, John Snow wrote:
> > 
> > 
> > On 4/5/19 10:24 AM, Andrey Shinkevich wrote:
> >> On a file system used by the customer, fallocate() returns an error
> >> if the block is not properly aligned. So, bdrv_co_pwrite_zeroes()
> >> fails. We can handle that case the same way as it is done for the
> >> unsupported cases, namely, call to bdrv_driver_pwritev() that writes
> >> zeroes to an image for the unaligned chunk of the block.
> >>
> >> Suggested-by: Denis V. Lunev <den@openvz.org>
> >> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> >> ---
> >>   block/io.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/io.c b/block/io.c
> >> index dfc153b..0412a51 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -1516,7 +1516,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> >>               assert(!bs->supported_zero_flags);
> >>           }
> >>   
> >> -        if (ret == -ENOTSUP && !(flags & BDRV_REQ_NO_FALLBACK)) {
> >> +        if (ret < 0 && !(flags & BDRV_REQ_NO_FALLBACK)) {
> >>               /* Fall back to bounce buffer if write zeroes is unsupported */
> >>               BdrvRequestFlags write_flags = flags & ~BDRV_REQ_ZERO_WRITE;
> >>   
> >>
> > 
> > I suppose that if fallocate fails for any reason and we're allowing
> > fallback, we're either going to succeed ... or fail again very soon
> > thereafter.
> > 
> > Are there any cases where it is vital to not ignore the first fallocate
> > failure? I'm a little wary of ignoring the return code from
> > bdrv_co_pwrite_zeroes, but I am assuming that if there is a "real"
> > failure here that the following bounce writes will also fail "safely."
> > 
> > I'm not completely confident, but I have no tangible objections:
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > 
> 
> Thank you for your review, John!
> 
> Let me clarify the circumstances and quote the bug report:
> "Customer had Win-2012 VM with 50GB system disk which was later resized 
> to 256GB without resizing the partition inside VM.
> Now, while trying to resize to 50G, the following error will appear
> 'Failed to reduce the number of L2 tables: Invalid argument'
> It was found that it is possible to shrink the disk to 128G and any size 
> above that number, but size below 128G will bring the mentioned error."
> 
> The fallocate() returns no error on that file system if the offset and
> the (offset + bytes) parameters of the bdrv_co_do_pwrite_zeroes() both
> are aligned to 4K.

What is the return value you get from this file system?

Maybe turning that into ENOTSUP in file-posix would be less invasive.
Just falling back for any error gives me the vague feeling that it could
cause problems sooner or later.

Kevin

