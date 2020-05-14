Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639972054F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfImiSUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639972054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFGs-0000Tx-IB
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZEsx-0004UE-MT
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:30:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZEsw-0008Sv-Vn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589466653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PH0X7ZuUXlM/l+V6DdyjSkoOU/Xbmk9SZztGaWbY5zU=;
 b=ZfImiSUZO/FeIu6JDZlewGSty6a00B1fs1Tx5Kk7QMIGdyTIihwVtCVTS1H6wMChMSkiNm
 zIjqBi//SyKYQJS4bg3v9aCJ3nc7d2KlXdenjAGC928aTAp6yLjF5E6CqbqcIy7meeiPzl
 jLevV2OQ/8LzJP70T/Rf+DCwemZtlpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-ri4fLjiNOA6m5si2zcoMYA-1; Thu, 14 May 2020 10:30:50 -0400
X-MC-Unique: ri4fLjiNOA6m5si2zcoMYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D577019200C1;
 Thu, 14 May 2020 14:30:48 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A47B5100164D;
 Thu, 14 May 2020 14:30:44 +0000 (UTC)
Date: Thu, 14 May 2020 16:30:43 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Reiter <s.reiter@proxmox.com>
Subject: Re: [RFC PATCH 3/3] block: Assert we're running in the right thread
Message-ID: <20200514143043.GI5518@linux.fritz.box>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <20200512144318.181049-4-kwolf@redhat.com>
 <4d2d9ecd-b921-c9e8-2eb4-066e092e6c1f@proxmox.com>
MIME-Version: 1.0
In-Reply-To: <4d2d9ecd-b921-c9e8-2eb4-066e092e6c1f@proxmox.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.05.2020 um 15:52 hat Stefan Reiter geschrieben:
> On 5/12/20 4:43 PM, Kevin Wolf wrote:
> > tracked_request_begin() is called for most I/O operations, so it's a
> > good place to assert that we're indeed running in the home thread of the
> > node's AioContext.
> > 
> 
> Is this patch supposed to be always correct or only together with nr. 2?
> 
> I changed our code to call bdrv_flush_all from the main AIO context and it
> certainly works just fine (even without this series, so I suppose that would
> be the 'correct' way to fix it you mention on the cover), though of course
> it trips this assert without patch 2.

Yes, I think this is a basic assumption that should always be true.
This series shouldn't fix anything for upstream QEMU (at least I'm not
aware of anything that needs it), so the assertion could be added even
without the other patches.

In fact, I'm currently thinking that committing just patch 1 (because
it's a nice cleanup anyway) and patch 3 (because it will let us know
when we mess up) might make sense.

Kevin

> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/io.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index 7808e8bdc0..924bf5ba46 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -695,14 +695,17 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
> >                                     uint64_t bytes,
> >                                     enum BdrvTrackedRequestType type)
> >   {
> > +    Coroutine *self = qemu_coroutine_self();
> > +
> >       assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
> > +    assert(bs->aio_context == qemu_coroutine_get_aio_context(self));
> >       *req = (BdrvTrackedRequest){
> >           .bs = bs,
> >           .offset         = offset,
> >           .bytes          = bytes,
> >           .type           = type,
> > -        .co             = qemu_coroutine_self(),
> > +        .co             = self,
> >           .serialising    = false,
> >           .overlap_offset = offset,
> >           .overlap_bytes  = bytes,
> > 
> 


