Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84641C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59637206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59637206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIuqv-0001zU-IJ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iIuqK-0001aA-An
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iIuqJ-0006mm-A9
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:20:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iIuqJ-0006mX-45
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:20:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 50F073018761
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 13:20:26 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ACBF5D713;
 Fri, 11 Oct 2019 13:20:25 +0000 (UTC)
Date: Fri, 11 Oct 2019 14:20:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v4 0/5] Automatic RCU read unlock
Message-ID: <20191011132022.GB18007@work-vm>
References: <20191007143642.301445-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007143642.301445-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 11 Oct 2019 13:20:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This patch uses glib's g_auto mechanism to automatically free
> rcu_read_lock's at the end of the block.  Given that humans
> have a habit of forgetting an error path somewhere it's
> best to leave it to the compiler.

Queued

> 
> v4
>   Mark the '_rcu_read_auto_' variable as 'unused'
>   to work around a clang bug.
> 
> 
> Dr. David Alan Gilbert (5):
>   rcu: Add automatically released rcu_read_lock variants
>   migration: Fix missing rcu_read_unlock
>   migration: Use automatic rcu_read unlock in ram.c
>   migration: Use automatic rcu_read unlock in rdma.c
>   rcu: Use automatic rc_read unlock in core memory/exec code
> 
>  docs/devel/rcu.txt      |  16 +++
>  exec.c                  | 116 +++++++---------
>  include/exec/ram_addr.h | 138 +++++++++----------
>  include/qemu/rcu.h      |  25 ++++
>  memory.c                |  15 +--
>  migration/ram.c         | 286 +++++++++++++++++++---------------------
>  migration/rdma.c        |  57 ++------
>  7 files changed, 304 insertions(+), 349 deletions(-)
> 
> -- 
> 2.23.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

