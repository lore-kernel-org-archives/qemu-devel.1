Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20358C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE62217D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE62217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwvs-0006W5-6D
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49988)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hpwvh-00067f-WD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hpwvg-0001We-Ri
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:42:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hpwvg-0001WI-Jc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:42:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4BC0308FBAF;
 Tue, 23 Jul 2019 15:42:15 +0000 (UTC)
Received: from work-vm (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E61F319C58;
 Tue, 23 Jul 2019 15:42:14 +0000 (UTC)
Date: Tue, 23 Jul 2019 16:42:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190723154212.GL2719@work-vm>
References: <20190710081111.10302-1-richardw.yang@linux.intel.com>
 <20190719174128.GI3000@work-vm> <20190722063941.GA2602@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722063941.GA2602@richard>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 23 Jul 2019 15:42:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration/postcopy: use static
 PostcopyDiscardState instead of allocating it for each block
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Fri, Jul 19, 2019 at 06:41:28PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> Even we need to do discard for each RAMBlock, we still can leverage the
> >> same memory space to store the information.
> >> 
> >> By doing so, we avoid memory allocation and deallocation to the system
> >> and also avoid potential failure of memory allocation which breaks the
> >> migration.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/postcopy-ram.c | 16 +++++++---------
> >>  1 file changed, 7 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >> index 9faacacc9e..2e6b076bb7 100644
> >> --- a/migration/postcopy-ram.c
> >> +++ b/migration/postcopy-ram.c
> >> @@ -1377,8 +1377,7 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
> >>   *   asking to discard individual ranges.
> >>   *
> >>   * @ms: The current migration state.
> >> - * @offset: the bitmap offset of the named RAMBlock in the migration
> >> - *   bitmap.
> >> + * @offset: the bitmap offset of the named RAMBlock in the migration bitmap.
> >>   * @name: RAMBlock that discards will operate on.
> >>   *
> >>   * returns: a new PDS.
> >> @@ -1386,13 +1385,14 @@ void postcopy_fault_thread_notify(MigrationIncomingState *mis)
> >>  PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
> >>                                                   const char *name)
> >>  {
> >> -    PostcopyDiscardState *res = g_malloc0(sizeof(PostcopyDiscardState));
> >> +    static PostcopyDiscardState res = {0};
> >
> >Do you think it would be better to make this a static at the top of
> >migration/postcopy-ram.c and then we could remove the pds parameters
> >from postcopy_discard_send_range and friends?
> 
> Just took a look into this one. One problem is not all its friends are in
> migration/postcopy-ram.c
> 
> For example, postcopy_chunk_hostpages_pass() is in migration/ram.c.

But doesn't that just pass teh pds back to postcopy_discard_send_range
which is in postcopy-ram ?

Dave

> Which way do you prefer?
> 
> >If there's only one pds then we don't need to pass the pointer around.
> >
> >Dave
> >
> >> -    if (res) {
> >> -        res->ramblock_name = name;
> >> -    }
> >> +    res.ramblock_name = name;
> >> +    res.cur_entry = 0;
> >> +    res.nsentwords = 0;
> >> +    res.nsentcmds = 0;
> >>  
> >> -    return res;
> >> +    return &res;
> >>  }
> >>  
> >>  /**
> >> @@ -1449,8 +1449,6 @@ void postcopy_discard_send_finish(MigrationState *ms, PostcopyDiscardState *pds)
> >>  
> >>      trace_postcopy_discard_send_finish(pds->ramblock_name, pds->nsentwords,
> >>                                         pds->nsentcmds);
> >> -
> >> -    g_free(pds);
> >>  }
> >>  
> >>  /*
> >> -- 
> >> 2.17.1
> >> 
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

