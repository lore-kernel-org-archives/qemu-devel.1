Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E9C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F422064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtExyL1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F422064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7tg-0003uc-8V
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQ7pG-0000Ob-40
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kQ7pA-0008DH-Bo
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602070895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ws1qy7UU3+UoFf200L4nWA46O/C64WiGbmlL5PTiNQY=;
 b=FtExyL1nhVkpMv8QK+VOCYzs6qm8QCx/aXPj5n9V+n0Z2qgGnFiJUhBOFDQT1fzF5x2zEu
 L4CF3JPQ2i+D9FjHlla2QU4yXPgMGQH1g4rFLJZY5B6Do8019LNywW+mFqZquIWoB1mE7V
 r77yqeGK9giMurr6OIFPYuBWKuuDKJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-m1sWEPByO9uqdtvgi-Lzhw-1; Wed, 07 Oct 2020 07:41:33 -0400
X-MC-Unique: m1sWEPByO9uqdtvgi-Lzhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8021005E64
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 11:41:32 +0000 (UTC)
Received: from work-vm (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98CB56EF43;
 Wed,  7 Oct 2020 11:41:28 +0000 (UTC)
Date: Wed, 7 Oct 2020 12:41:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 0/4] migration/postcopy: Sync faulted addresses after
 network recovered
Message-ID: <20201007114126.GC22258@work-vm>
References: <20201002175336.30858-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201002175336.30858-1-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued

* Peter Xu (peterx@redhat.com) wrote:
> v4:
> - use "void */ulong" instead of "uint64_t" where proper in patch 3/4 [Dave]
> 
> v3:
> - fix build on 32bit hosts & rebase
> - remove r-bs for the last 2 patches for Dave due to the changes
> 
> v2:
> - add r-bs for Dave
> - add patch "migration: Properly destroy variables on incoming side" as patch 1
> - destroy page_request_mutex in migration_incoming_state_destroy() too [Dave]
> - use WITH_QEMU_LOCK_GUARD in two places where we can [Dave]
> 
> We've seen conditional guest hangs on destination VM after postcopy recovered.
> However the hang will resolve itself after a few minutes.
> 
> The problem is: after a postcopy recovery, the prioritized postcopy queue on
> the source VM is actually missing.  So all the faulted threads before the
> postcopy recovery happened will keep halted until (accidentally) the page got
> copied by the background precopy migration stream.
> 
> The solution is to also refresh this information after postcopy recovery.  To
> achieve this, we need to maintain a list of faulted addresses on the
> destination node, so that we can resend the list when necessary.  This work is
> done via patch 2-5.
> 
> With that, the last thing we need to do is to send this extra information to
> source VM after recovered.  Very luckily, this synchronization can be
> "emulated" by sending a bunch of page requests (although these pages have been
> sent previously!) to source VM just like when we've got a page fault.  Even in
> the 1st version of the postcopy code we'll handle duplicated pages well.  So
> this fix does not even need a new capability bit and it'll work smoothly on old
> QEMUs when we migrate from them to the new QEMUs.
> 
> Please review, thanks.
> 
> Peter Xu (4):
>   migration: Pass incoming state into qemu_ufd_copy_ioctl()
>   migration: Introduce migrate_send_rp_message_req_pages()
>   migration: Maintain postcopy faulted addresses
>   migration: Sync requested pages after postcopy recovery
> 
>  migration/migration.c    | 49 ++++++++++++++++++++++++++++++++--
>  migration/migration.h    | 21 ++++++++++++++-
>  migration/postcopy-ram.c | 25 +++++++++++++-----
>  migration/savevm.c       | 57 ++++++++++++++++++++++++++++++++++++++++
>  migration/trace-events   |  3 +++
>  5 files changed, 146 insertions(+), 9 deletions(-)
> 
> -- 
> 2.26.2
> 
> 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


