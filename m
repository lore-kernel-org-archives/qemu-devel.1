Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D964D206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt4n9pRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D964D206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDyy-0005Ac-72
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiDyJ-0004l9-Sl
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:21:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50301
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiDyI-0007Tq-Qu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591608093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wiXGr5KF5exitJ4hpszUbZLZE0rDmFa9/IL9mQIMw6w=;
 b=Nt4n9pRpdGfFIVYR6cHDTUJHW+cn2ezrNcG+ILwGT+idG0A4XrpHR8PVEuTsI8w0cEPsNU
 seEPvex7XOvzGCKFWtF18q+5K4w6faJwFypMMzTMh/mwegYtY4bRPUSQnQ4kl5XNl/e4Ga
 lSDXlqbjYFNdDj2sVNl3rcJ83xs7GjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-h5RjB0l7MFOU0zg3PnYfdw-1; Mon, 08 Jun 2020 05:21:31 -0400
X-MC-Unique: h5RjB0l7MFOU0zg3PnYfdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8468EC1A8;
 Mon,  8 Jun 2020 09:21:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA6A45C1D6;
 Mon,  8 Jun 2020 09:21:28 +0000 (UTC)
Date: Mon, 8 Jun 2020 11:21:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH RFC v2 1/5] block: add bitmap-populate job
Message-ID: <20200608092127.GB6419@linux.fritz.box>
References: <20200604091651.GF2995787@angien.pipo.sk>
 <20200604113145.GE4512@linux.fritz.box>
 <20200604162237.GA22354@angien.pipo.sk>
 <20200605090123.GD5869@linux.fritz.box>
 <20200605092403.GB22354@angien.pipo.sk>
 <20200605094407.GG5869@linux.fritz.box>
 <20200605095810.GC22354@angien.pipo.sk>
 <20200605100747.GH5869@linux.fritz.box>
 <20200605105902.GD22354@angien.pipo.sk>
 <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <e0d889a2-2a52-1c3f-89fb-55a41dc6d226@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Krempa <pkrempa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.06.2020 um 08:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 05.06.2020 13:59, Peter Krempa wrote:
> > On Fri, Jun 05, 2020 at 12:07:47 +0200, Kevin Wolf wrote:
> > > Am 05.06.2020 um 11:58 hat Peter Krempa geschrieben:
> > > > On Fri, Jun 05, 2020 at 11:44:07 +0200, Kevin Wolf wrote:
> > 
> > [...]
> > 
> > > > The above was actually inspired by a very recent problem I have in my
> > > > attempt to use the dirty bitmap populate job to refactor how libvirt
> > > > handles bitmaps. I've just figured out that I need to shuffle around
> > > > some stuff as I can't run the dirty-bitmap-populate job while an active
> > > > layer commit is in synchronised phase and I wanted to do the merging at
> > > > that point. That reminded me of a possible gotcha in having to sequence
> > > > the blockjobs which certainly would be more painful.
> > > 
> > > It would probably be good to have not only an iotests case that tests
> > > the low-level functionality of the block job, but also one that
> > > resembles the way libvirt would actually use it in combination with
> > > other jobs.
> > 
> 
> Hi! Sorry me missing the discussion for a long time.
> 
> About new job semantics: if you create temporary bitmaps anyway, I do
> think that we should allow to populate into target bitmap directly,
> without creating any internal temporary bitmaps. I suggested it when
> reviewing v1, John argued for more transaction-like semantics to look
> like other jobs. Still, we can support both modes if we want.

But don't all other jobs allow you to see intermediate states? Like,
when you look at the target node in the middle of a mirror job, you'll
see a half-updated target image.

If we have an actual use case for both modes, we can certainly support
that, but do we have one?

> Allowing to use one target for several populating job is an
> interesting idea. Current series does
> "bdrv_dirty_bitmap_set_busy(target_bitmap, true);", which forbids it..
> Hmm. If we just drop it, nothing prevents user just remove target
> bitmap during the job. So, we'll need something like collective-busy
> bitmap..

I'm not sure for what the busy flag is used in detail, but if this is
the problem, maybe it's possible to just replace it with a counter?

Kevin


