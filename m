Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A9BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3521A206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3521A206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPF3-0002bf-3m
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jKPEP-00026f-3Y
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jKPEO-0002GM-2H
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:31:45 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:51303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jKPEK-00020n-Eu; Fri, 03 Apr 2020 12:31:41 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8B4464297A;
 Fri,  3 Apr 2020 18:31:37 +0200 (CEST)
Date: Fri, 3 Apr 2020 18:31:35 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <1466731307.175.1585931495885@webmail.proxmox.com>
In-Reply-To: <20200403084729.GB5336@linux.fritz.box>
References: <20200401181256.GB27663@linux.fritz.box>
 <1403939459.52.1585765681569@webmail.proxmox.com>
 <20200401184431.GD27663@linux.fritz.box>
 <903538836.29.1585818619688@webmail.proxmox.com>
 <20200402121403.GB4006@linux.fritz.box>
 <20200402142524.GD4006@linux.fritz.box>
 <1043934808.59.1585842050330@webmail.proxmox.com>
 <20200402164744.GE4006@linux.fritz.box>
 <20200402171007.GF4006@linux.fritz.box>
 <2091214547.43.1585902379938@webmail.proxmox.com>
 <20200403084729.GB5336@linux.fritz.box>
Subject: Re: bdrv_drained_begin deadlock with io-threads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev23
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On April 3, 2020 10:47 AM Kevin Wolf <kwolf@redhat.com> wrote:
> 
>  
> Am 03.04.2020 um 10:26 hat Dietmar Maurer geschrieben:
> > > With the following patch, it seems to survive for now. I'll give it some
> > > more testing tomorrow (also qemu-iotests to check that I didn't
> > > accidentally break something else.)
> > 
> > Wow, that was fast! Seems your patch fixes the bug!
> > 
> > I wonder what commit introduced that problem, maybe:
> > 
> > https://github.com/qemu/qemu/commit/cf3129323f900ef5ddbccbe86e4fa801e88c566e#diff-7cb66df56045598b75a219eebc27efb6
> > 
> > If so, version 4.1.X in not affected by this bug, but 4.2.0 and later?
> 
> Yes, I'm pretty sure that's the one.

I also wonder if we can loose an aio_wait_kick() by directly accessing blk->in_flight.
I thought this should use atomic_mb_read()?

diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0..48f3721505 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2275,7 +2275,7 @@ static bool blk_root_drained_poll(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
     assert(blk->quiesce_counter);
-    return !!blk->in_flight;
+    return !!atomic_mb_read(&blk->in_flight);
 }
 
 static void blk_root_drained_end(BdrvChild *child, int *drained_end_counter)


