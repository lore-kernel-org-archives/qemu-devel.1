Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1609C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8912076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm1Gnqr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8912076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvxv-0008VY-UF
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRvvF-0006cg-BX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRvvB-0005a3-OX
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602501796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Uup127R+90WvjKszLhXKJVfTW75MKOeqHf9ylynE8w=;
 b=Pm1Gnqr7gW0bbWNTRB8pzoOUimkmXSAcioxgm8K/XyZHqBIdEVxB5HaAvLXMyH4QUNOJ9a
 NonMJWcIjVAS+OlbBb7UOpLH7x4+LCd4ruiCMDyhMjocThICIpJY1kjvOrOpMKvCfDsC7t
 t9xbXL9szKoapQhdiqzARbA1S+LSWqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-iTTHhBcRNsWa2odcZVOw9A-1; Mon, 12 Oct 2020 07:23:14 -0400
X-MC-Unique: iTTHhBcRNsWa2odcZVOw9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E396835B4A
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 11:23:13 +0000 (UTC)
Received: from work-vm (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D0DB6EF79;
 Mon, 12 Oct 2020 11:23:09 +0000 (UTC)
Date: Mon, 12 Oct 2020 12:23:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 0/4] migration/postcopy: Sync faulted addresses after
 network recovered
Message-ID: <20201012112307.GA2878@work-vm>
References: <20201002175336.30858-1-peterx@redhat.com>
 <20201007114126.GC22258@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201007114126.GC22258@work-vm>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> Queued

Hi Peter,
  I've had to unqueue this again unfortunately.
There's something going on with big endian hosts; on a PPC BE host,
it reliably hangs in the recovery test with this set.
(Although I can't see anything relevant to eye).

Dave
P.S. I can point you at an installed host

> * Peter Xu (peterx@redhat.com) wrote:
> > v4:
> > - use "void */ulong" instead of "uint64_t" where proper in patch 3/4 [Dave]
> > 
> > v3:
> > - fix build on 32bit hosts & rebase
> > - remove r-bs for the last 2 patches for Dave due to the changes
> > 
> > v2:
> > - add r-bs for Dave
> > - add patch "migration: Properly destroy variables on incoming side" as patch 1
> > - destroy page_request_mutex in migration_incoming_state_destroy() too [Dave]
> > - use WITH_QEMU_LOCK_GUARD in two places where we can [Dave]
> > 
> > We've seen conditional guest hangs on destination VM after postcopy recovered.
> > However the hang will resolve itself after a few minutes.
> > 
> > The problem is: after a postcopy recovery, the prioritized postcopy queue on
> > the source VM is actually missing.  So all the faulted threads before the
> > postcopy recovery happened will keep halted until (accidentally) the page got
> > copied by the background precopy migration stream.
> > 
> > The solution is to also refresh this information after postcopy recovery.  To
> > achieve this, we need to maintain a list of faulted addresses on the
> > destination node, so that we can resend the list when necessary.  This work is
> > done via patch 2-5.
> > 
> > With that, the last thing we need to do is to send this extra information to
> > source VM after recovered.  Very luckily, this synchronization can be
> > "emulated" by sending a bunch of page requests (although these pages have been
> > sent previously!) to source VM just like when we've got a page fault.  Even in
> > the 1st version of the postcopy code we'll handle duplicated pages well.  So
> > this fix does not even need a new capability bit and it'll work smoothly on old
> > QEMUs when we migrate from them to the new QEMUs.
> > 
> > Please review, thanks.
> > 
> > Peter Xu (4):
> >   migration: Pass incoming state into qemu_ufd_copy_ioctl()
> >   migration: Introduce migrate_send_rp_message_req_pages()
> >   migration: Maintain postcopy faulted addresses
> >   migration: Sync requested pages after postcopy recovery
> > 
> >  migration/migration.c    | 49 ++++++++++++++++++++++++++++++++--
> >  migration/migration.h    | 21 ++++++++++++++-
> >  migration/postcopy-ram.c | 25 +++++++++++++-----
> >  migration/savevm.c       | 57 ++++++++++++++++++++++++++++++++++++++++
> >  migration/trace-events   |  3 +++
> >  5 files changed, 146 insertions(+), 9 deletions(-)
> > 
> > -- 
> > 2.26.2
> > 
> > 
> > 
> -- 
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


