Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17349C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FFE92098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhVspkTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FFE92098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIOt-00060m-Ga
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVI89-0001Ye-66
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVI85-0007BA-EF
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603302148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kq8dSN2DFw31Xq/yOPUrrXkVW9zONSQ+3288eTjfptY=;
 b=OhVspkTmuykmdKHXxj1+KkdExh/s0TgHkRe0IBFy6PbWyhAJHcHYyXf3VnWbZFGdbOdosl
 v7BZbD/t6MR8Bnl40AQ4qD44BLit4HIJ9O/A2cqFFyZB4PP6M9dAwSKhtCmYYBBX0en0em
 kOX0cxZNs4di4bf+Ex6D8ekQNGZVG78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-oBqj0aBNMxi1gc3gpu6Y3Q-1; Wed, 21 Oct 2020 13:42:27 -0400
X-MC-Unique: oBqj0aBNMxi1gc3gpu6Y3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F80804032;
 Wed, 21 Oct 2020 17:42:25 +0000 (UTC)
Received: from work-vm (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 986875C225;
 Wed, 21 Oct 2020 17:42:21 +0000 (UTC)
Date: Wed, 21 Oct 2020 18:42:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 3/6] migration: Maintain postcopy faulted addresses
Message-ID: <20201021174219.GG3671@work-vm>
References: <20201019225720.172743-1-peterx@redhat.com>
 <20201019225720.172743-4-peterx@redhat.com>
 <20201021142345.GC3671@work-vm> <20201021155016.GH200400@xz-x1>
MIME-Version: 1.0
In-Reply-To: <20201021155016.GH200400@xz-x1>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Oct 21, 2020 at 03:23:45PM +0100, Dr. David Alan Gilbert wrote:
> > > @@ -354,8 +368,33 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> > >  }
> > >  
> > >  int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> > > -                              RAMBlock *rb, ram_addr_t start)
> > > +                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
> > >  {
> > > +    void *aligned = (void *)(uintptr_t)(haddr & qemu_real_host_page_mask);
> > 
> > Can you remind me, what happens here for hugepages?
> 
> Sure.  Previously it was:
> 
>   (haddr & (-qemu_target_page_size())
> 
> Now it is:
> 
>   (haddr & qemu_real_host_page_mask)
> 
> Basically we changed the psize alignment from guest to host.
> 
> The bug triggered previously on ppc64 where host_psize=64k, then when guest
> psize is smaller, e.g., 4k, we can have some addr that aligned to 4k rather
> than 64k, so we failed later on checking the host psize alignment (because this
> pointer should point to a host page, so it should align with host psize).

But my question is what happens when we have say a 2MB hugepage?

Dave

> -- 
> Peter Xu
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


