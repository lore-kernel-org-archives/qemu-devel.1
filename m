Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7743CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDB320650
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 13:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDB320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6EPl-0008V1-FL
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i6EOu-0007eA-Og
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i6EOt-00012M-Ln
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14818)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1i6EOt-00011c-Ga
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 09:35:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25ACB1918644
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 13:35:42 +0000 (UTC)
Received: from redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36E565C1D8;
 Fri,  6 Sep 2019 13:35:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
In-Reply-To: <20190906130103.20961-1-peterx@redhat.com> (Peter Xu's message of
 "Fri, 6 Sep 2019 21:01:03 +0800")
References: <20190906130103.20961-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Fri, 06 Sep 2019 15:35:33 +0200
Message-ID: <87sgp9k0nu.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 06 Sep 2019 13:35:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Fix postcopy bw for recovery
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
Cc: Laurent Vivier <lvivier@redhat.com>, Xiaohui Li <xiaohli@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> wrote:
> We've got max-postcopy-bandwidth parameter but it's not applied
> correctly after a postcopy recovery so the recovered migration stream
> will still eat the whole net bandwidth.  Fix that up.
>
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Juan Quintela <quintela@redhat.com>

> diff --git a/migration/migration.c b/migration/migration.c
> index 8b9f2fe30a..b307813aa3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3327,7 +3327,8 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>  
>      if (resume) {
>          /* This is a resumed migration */
> -        rate_limit = INT64_MAX;
> +        rate_limit = s->parameters.max_postcopy_bandwidth /
> +            XFER_LIMIT_RATIO;
>      } else {
>          /* This is a fresh new migration */
>          rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;

I was confused thinking that the two assignations were the same O:-)

