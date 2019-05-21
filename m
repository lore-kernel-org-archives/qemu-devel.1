Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB39FC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38042171F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 02:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38042171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45233 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSuXJ-0007Ka-KH
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 22:29:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSuWU-00071h-NE
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSuWT-0005HZ-Tr
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hSuWT-0005H5-OG
	for qemu-devel@nongnu.org; Mon, 20 May 2019 22:29:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B36DC37EE7
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 02:29:00 +0000 (UTC)
Received: from xz-x1 (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA075D9C8;
	Tue, 21 May 2019 02:28:58 +0000 (UTC)
Date: Tue, 21 May 2019 10:28:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190521022856.GQ16681@xz-x1>
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-4-peterx@redhat.com>
	<30752917-8ec0-492c-bba2-e6a31a56e858@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30752917-8ec0-492c-bba2-e6a31a56e858@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 21 May 2019 02:29:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 03/15] migration: No need to take rcu
 during sync_dirty_bitmap
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 12:48:01PM +0200, Paolo Bonzini wrote:
> On 20/05/19 05:08, Peter Xu wrote:
> > cpu_physical_memory_sync_dirty_bitmap() has one RAMBlock* as
> > parameter, which means that it must be with RCU read lock held
> > already.  Taking it again inside seems redundant.  Removing it.
> > Instead comment on the functions about the RCU read lock.
> > 
> > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/exec/ram_addr.h | 5 +----
> >  migration/ram.c         | 1 +
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index 139ad79390..993fb760f3 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -408,6 +408,7 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
> >  }
> >  
> >  
> > +/* Must be with rcu read lock held */
> 
> The usual way to spell this is "Called within RCU critical section.",
> otherwise the patch looks good.

Sure, I'm switching to this with the r-b kept.

Thanks,

-- 
Peter Xu

