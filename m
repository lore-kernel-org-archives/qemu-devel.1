Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C9C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FE72186A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 18:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FE72186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoXHl-0006WM-CA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 14:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33142)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hoXHb-00067a-IK
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hoXHZ-00030D-MM
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hoXHZ-0002xT-7r
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 14:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B2A893CA16;
 Fri, 19 Jul 2019 18:06:55 +0000 (UTC)
Received: from work-vm (ovpn-117-245.ams2.redhat.com [10.36.117.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 523FF63F66;
 Fri, 19 Jul 2019 18:06:54 +0000 (UTC)
Date: Fri, 19 Jul 2019 19:06:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190719180651.GM3000@work-vm>
References: <20190712032704.7826-1-richardw.yang@linux.intel.com>
 <20190719175400.GJ3000@work-vm>
 <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fd200f7-ad92-d753-23ca-8c89a27fd346@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 19 Jul 2019 18:06:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: check length directly to make
 sure the range is aligned
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 19/07/19 19:54, Dr. David Alan Gilbert wrote:
> >> -        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
> >> -            error_report("ram_block_discard_range: Unaligned end address: %p",
> >> -                         host_endaddr);
> >> +        if (length & (rb->page_size - 1)) {
> >> +            error_report("ram_block_discard_range: Unaligned length: %lx",
> >> +                         length);
> > Yes, I *think* this is safe, we'll need to watch out for any warnings;
> 
> Do you mean compiler or QEMU warning?

No, I mean lots of these error reports being printed out in some common
case.

Dave

  The patch is safe since there's an
> 
>     if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
>         error_report("ram_block_discard_range: Unaligned start address: %p",
>                      host_startaddr);
>         goto err;
>     }
> 
> just before this context.
> 
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

