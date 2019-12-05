Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87082C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:56:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAEE2464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OBY3Zs+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAEE2464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrcF-0007sM-BW
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:56:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1icrai-0006Ox-Am
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1icraf-00055b-Cb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:54:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1icraf-0004yc-6a
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575554083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ7vG6ET/Ql2qO+V8DcV0Dwq6i+swFDpmn7rFr/MEX8=;
 b=OBY3Zs+1I8YbSK8jjIzzulDLo8gOC6S9zCgmpz1RB4f8KTLCUnoNadKGWcj22VW8rjUYC7
 yqExsW8gJSL7FnLBn+qBzCSW9wGZvyLzJVCkzlENaZoxHbiRgPQOsmFdCtrv3xsw//CeIQ
 +zg4ZXN0mAVXXGvK4wcKFKafS/WIptk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-yuMmZ7P-PtK6Uq2gIeDTSg-1; Thu, 05 Dec 2019 08:54:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAE3E800EB8;
 Thu,  5 Dec 2019 13:54:39 +0000 (UTC)
Received: from redhat.com (ovpn-117-232.ams2.redhat.com [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DF9D6B8D5;
 Thu,  5 Dec 2019 13:54:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Rate limit inside host pages
In-Reply-To: <20191205102918.63294-1-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Thu, 5 Dec 2019 10:29:18 +0000")
References: <20191205102918.63294-1-dgilbert@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 05 Dec 2019 14:54:31 +0100
Message-ID: <87o8wmkhd4.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: yuMmZ7P-PtK6Uq2gIeDTSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, LMa@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When using hugepages, rate limiting is necessary within each huge
> page, since a 1G huge page can take a significant time to send, so
> you end up with bursty behaviour.
>
> Fixes: 4c011c37ecb3 ("postcopy: Send whole huge pages")
> Reported-by: Lin Ma <LMa@suse.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---

Reviewed-by: Juan Quintela <quintela@redhat.com>

I can agree that rate limit needs to be done for huge pages.

> diff --git a/migration/ram.c b/migration/ram.c
> index a4ae3b3120..a9177c6a24 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2616,6 +2616,8 @@ static int ram_save_host_page(RAMState *rs, PageSea=
rchStatus *pss,
> =20
>          pages +=3D tmppages;
>          pss->page++;
> +        /* Allow rate limiting to happen in the middle of huge pages */
> +        migration_rate_limit();
>      } while ((pss->page & (pagesize_bits - 1)) &&
>               offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BIT=
S));
> =20

But is doing the rate limit for each page, no?  Even when not using huge
pages.

Not that it should be a big issue (performance wise).
Have you done any meassuremnet?


Later, Juan.


