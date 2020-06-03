Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D94C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4671B2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3hHpGlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4671B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOZT-0001zz-EH
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgOYk-000139-47
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:15:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57520
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jgOYi-0001J2-Dy
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591172135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fZNYOWlnPjLISRcoEMn7Aqi8pXw87An44zrYXNQzB+4=;
 b=S3hHpGlGiykINr8ovIYtAl9IPQbimHedjM7UmArPF1lpIOQn+TREmQFypDd14Z1gjqxbOb
 mTVHccMRYRJz6LolhSsbREuO+wkcRz5wpfPUpXMtGBr5KAPeB4a3jptpkm5O3HvjvMGdY2
 0oPlTzVdL0i85MVHcB5YMjGpmDa34LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-Xv1AqPfdMMWCV2IHFoDolQ-1; Wed, 03 Jun 2020 04:15:31 -0400
X-MC-Unique: Xv1AqPfdMMWCV2IHFoDolQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 188C5461;
 Wed,  3 Jun 2020 08:15:30 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-187.ams2.redhat.com [10.36.112.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0C1A78EFD;
 Wed,  3 Jun 2020 08:15:28 +0000 (UTC)
Date: Wed, 3 Jun 2020 10:15:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [PATCH v2] icount: make dma reads deterministic
Message-ID: <20200603081527.GA5127@linux.fritz.box>
References: <158823737122.27545.13132967751052120169.stgit@pasha-ThinkPad-X280>
 <20200602155440.GK5940@linux.fritz.box>
 <ed02a968-88f1-edc4-46f9-1b69c1e06d70@ispras.ru>
MIME-Version: 1.0
In-Reply-To: <ed02a968-88f1-edc4-46f9-1b69c1e06d70@ispras.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 23:55:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, pavel.dovgaluk@ispras.ru,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.06.2020 um 07:57 hat Pavel Dovgalyuk geschrieben:
> 
> On 02.06.2020 18:54, Kevin Wolf wrote:
> > Am 30.04.2020 um 11:02 hat Pavel Dovgalyuk geschrieben:
> > > From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
> > > 
> > > Windows guest sometimes makes DMA requests with overlapping
> > > target addresses. This leads to the following structure of iov for
> > > the block driver:
> > > 
> > > addr size1
> > > addr size2
> > > addr size3
> > > 
> > > It means that three adjacent disk blocks should be read into the same
> > > memory buffer. Windows does not expects anything from these bytes
> > > (should it be data from the first block, or the last one, or some mix),
> > > but uses them somehow. It leads to non-determinism of the guest execution,
> > > because block driver does not preserve any order of reading.
> > > 
> > > This situation was discusses in the mailing list at least twice:
> > > https://lists.gnu.org/archive/html/qemu-devel/2010-09/msg01996.html
> > > https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05185.html
> > > 
> > > This patch makes such disk reads deterministic in icount mode.
> > > It splits the whole request into several parts. Parts may overlap,
> > > but SGs inside one part do not overlap.
> > > Parts that are processed later overwrite the prior ones in case
> > > of overlapping.
> > > 
> > > Examples for different SG part sequences:
> > > 
> > > 1)
> > > A1 1000
> > > A2 1000
> > > A1 1000
> > > A3 1000
> > > ->
> > > One request is split into two.
> > > A1 1000
> > > A2 1000
> > > --
> > > A1 1000
> > > A3 1000
> > > 
> > > 2)
> > > A1 800
> > > A2 1000
> > > A1 1000
> > > ->
> > > A1 800
> > > A2 1000
> > > --
> > > A1 1000
> > > 
> > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > > 
> > > --
> > > 
> > > v2:
> > >   - Rewritten the loop to split the request instead of skipping the parts
> > >     (suggested by Kevin Wolf)
> > > ---
> > >   dma-helpers.c |   20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/dma-helpers.c b/dma-helpers.c
> > > index e8a26e81e1..a49f9a0e34 100644
> > > --- a/dma-helpers.c
> > > +++ b/dma-helpers.c
> > > @@ -13,6 +13,8 @@
> > >   #include "trace-root.h"
> > >   #include "qemu/thread.h"
> > >   #include "qemu/main-loop.h"
> > > +#include "sysemu/cpus.h"
> > > +#include "qemu/range.h"
> > >   /* #define DEBUG_IOMMU */
> > > @@ -142,6 +144,24 @@ static void dma_blk_cb(void *opaque, int ret)
> > >           cur_addr = dbs->sg->sg[dbs->sg_cur_index].base + dbs->sg_cur_byte;
> > >           cur_len = dbs->sg->sg[dbs->sg_cur_index].len - dbs->sg_cur_byte;
> > >           mem = dma_memory_map(dbs->sg->as, cur_addr, &cur_len, dbs->dir);
> > > +        /*
> > > +         * Make reads deterministic in icount mode. Windows sometimes issues
> > > +         * disk read requests with overlapping SGs. It leads
> > > +         * to non-determinism, because resulting buffer contents may be mixed
> > > +         * from several sectors. This code splits all SGs into several
> > > +         * groups. SGs in every group do not overlap.
> > > +         */
> > > +        if (use_icount && dbs->dir == DMA_DIRECTION_FROM_DEVICE) {
> > > +            int i;
> > > +            for (i = 0 ; i < dbs->iov.niov ; ++i) {
> > > +                if (ranges_overlap((intptr_t)dbs->iov.iov[i].iov_base,
> > > +                                   dbs->iov.iov[i].iov_len, (intptr_t)mem,
> > > +                                   cur_len)) {
> > > +                    mem = NULL;
> > Doesn't this leak mem, i.e. should we call dma_memory_unmap()?
> 
> Thanks, I missed, that the memory is unmapped on request finish.
> 
> > Did you verify that it is guaranteed that mapping the same guest memory
> > twice results in the same host address? v1 compared the SG list (which
> > has guest addresses) rather than the resulting QEMUIOVector (which has
> > host addresses).
> 
> We don't need the host addresses to be equivalent in different runs.
> 
> The order of the SG list entries is deterministic. This is enough for
> successful exclusion of the duplicate entries.

I'm not talking about different runs, but just a single one. You only
correctly detect an overlap if mapping the same guest address returns
the same host address for both entries.

Let me see...

address_space_map() has a path where it allocates a bounce buffer rather
than directly mapping guest memory. We're lucky there because it has
only one global bounce buffer and if it's already in use, it returns
NULL instead, which means that we split the request. This is good, but
if it ever changes to allow more than one bounce buffer, the code would
break. If we rely on it, maybe better add a comment to the bounce.in_use
code in address_space_map().

The other code path just translates according to the FlatView of the
AddressSpace. Do we need some kind of locking to make sure that the
FlatView doesn't change between both dma_memory_map() calls? On the
other hand, use_icount is probably not something that you would use
together with iothreads, so maybe running in the main thread is enough
to protect it.

> > 
> > > +                    break;
> > > +                }
> > > +            }
> > > +        }
> > >           if (!mem)
> > >               break;

Now that I talked about how a NULL return saves us, I wonder, shouldn't
this check actually come before the overlap checking?

Kevin


