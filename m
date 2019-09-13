Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B874205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B874205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mFo-0007zV-D5
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8mF2-0007NT-Qm
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8mF1-0001NJ-OU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8mEy-0001KM-JU; Fri, 13 Sep 2019 10:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9636210DCC8B;
 Fri, 13 Sep 2019 14:07:59 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82EA55D9CD;
 Fri, 13 Sep 2019 14:07:57 +0000 (UTC)
Message-ID: <5fdc4891c02c7977762bb76fd877e4383e04be0c.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Date: Fri, 13 Sep 2019 17:07:56 +0300
In-Reply-To: <5d578974-d02d-8b05-8d51-85715d1d4468@virtuozzo.com>
References: <20190913125909.15348-1-mlevitsk@redhat.com>
 <20190913125909.15348-2-mlevitsk@redhat.com>
 <5d578974-d02d-8b05-8d51-85715d1d4468@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 13 Sep 2019 14:07:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block/qcow2: refactoring of
 threaded encryption code
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-13 at 14:01 +0000, Vladimir Sementsov-Ogievskiy wrote:
> 13.09.2019 15:59, Maxim Levitsky wrote:
> > This commit tries to clarify few function arguments,
> > and add comments describing the encrypt/decrypt interface
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   block/qcow2-cluster.c |  9 ++++---
> >   block/qcow2-threads.c | 62 ++++++++++++++++++++++++++++++++++---------
> >   block/qcow2.c         |  5 ++--
> >   block/qcow2.h         |  8 +++---
> >   4 files changed, 61 insertions(+), 23 deletions(-)
> > 
> > diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> > index f09cc992af..46b0854d7e 100644
> > --- a/block/qcow2-cluster.c
> > +++ b/block/qcow2-cluster.c
> > @@ -463,8 +463,8 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
> >   }
> >   
> >   static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> > -                                                uint64_t src_cluster_offset,
> > -                                                uint64_t cluster_offset,
> > +                                                uint64_t guest_cluster_offset,
> > +                                                uint64_t host_cluster_offset,
> >                                                   unsigned offset_in_cluster,
> >                                                   uint8_t *buffer,
> >                                                   unsigned bytes)
> > @@ -474,8 +474,9 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
> >           assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
> >           assert((bytes & ~BDRV_SECTOR_MASK) == 0);
> >           assert(s->crypto);
> > -        if (qcow2_co_encrypt(bs, cluster_offset,
> > -                             src_cluster_offset + offset_in_cluster,
> > +        if (qcow2_co_encrypt(bs,
> > +                             host_cluster_offset + offset_in_cluster,
> > +                             guest_cluster_offset + offset_in_cluster,
> 
> oops, seems you accidentally fixed the bug, which you are going to fix in the next
> patch, as now correct offsets are given to qcow2_co_encrypt :)
> 
> and next patch no is a simple no-logic-change refactoring, so at least commit message
> should be changed.

Yep :-( I am trying my best in addition to fixing the bug, also clarify the area to
avoid this from happening again.

What do you think that I fold these two patches together after all?
Best regards,
	Maxim Levitsky



