Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09CEC0650E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 08:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE9D2064B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 08:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE9D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk2qx-0008PT-HN
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 04:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hk2pZ-0007qg-Ui
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 04:47:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hk2pY-0003kP-N1
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 04:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hk2pU-0003c9-Ma; Sun, 07 Jul 2019 04:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 390C381F22;
 Sun,  7 Jul 2019 08:47:23 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B7EC608A4;
 Sun,  7 Jul 2019 08:47:19 +0000 (UTC)
Message-ID: <7e767e2192c7fea9d765f2aafd6d9772121e5a0d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jul 2019 11:47:17 +0300
In-Reply-To: <1a2f433a-f5cb-f119-a3ed-62ddc1039f91@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-3-mlevitsk@redhat.com>
 <3f2dad51-aa82-c7dc-ec8b-953607270ea9@redhat.com>
 <1a2f433a-f5cb-f119-a3ed-62ddc1039f91@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sun, 07 Jul 2019 08:47:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/6] block/nvme: fix doorbell stride
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-05 at 13:10 +0200, Max Reitz wrote:
> On 05.07.19 13:09, Max Reitz wrote:
> > On 03.07.19 17:59, Maxim Levitsky wrote:
> > > Fix the math involving non standard doorbell stride
> > > 
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  block/nvme.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/block/nvme.c b/block/nvme.c
> > > index 6d4e7f3d83..52798081b2 100644
> > > --- a/block/nvme.c
> > > +++ b/block/nvme.c
> > > @@ -217,7 +217,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BlockDriverState *bs,
> > >          error_propagate(errp, local_err);
> > >          goto fail;
> > >      }
> > > -    q->cq.doorbell = &s->regs->doorbells[idx * 2 * s->doorbell_scale + 1];
> > > +    q->cq.doorbell = &s->regs->doorbells[(idx * 2 + 1) * s->doorbell_scale];
> > >  
> > >      return q;
> > >  fail:
> > 
> > Hm.  How has this ever worked?
> 
> (Ah, because CAP.DSTRD has probably been 0 in most devices.)
> 
Exactly, and I used cache line stride in my nvme-mdev, which broke this and I spend an evening figuring out
what is going on. I was sure that there is some memory ordering bug or something even weirder before (as usual)
finding that this is a very simple bug.
I tested nvme-mdev pretty much with everything I could get my hands on, including this driver.


Best regards,
	Maxim Levitsky



