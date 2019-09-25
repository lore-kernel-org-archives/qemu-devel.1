Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F4C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681B9214D9
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681B9214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4hc-0007UD-HH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD4fq-00068G-9E
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD4fp-00075K-5W
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD4fo-00074u-Rh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23344C057F20;
 Wed, 25 Sep 2019 10:37:28 +0000 (UTC)
Received: from work-vm (ovpn-117-251.ams2.redhat.com [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 605631001B11;
 Wed, 25 Sep 2019 10:37:24 +0000 (UTC)
Date: Wed, 25 Sep 2019 11:37:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com
Subject: Re: [PATCH] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
Message-ID: <20190925103721.GF21544@work-vm>
References: <20190923174942.12182-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923174942.12182-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 25 Sep 2019 10:37:28 +0000 (UTC)
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
Cc: thuth@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Various parts of the migration code do different things when they're
> in postcopy mode; prior to this patch this has been 'postcopy-active'.
> This patch extends 'in_postcopy' to include 'postcopy-paused' and
> 'postcopy-recover'.
> 
> In particular, when you set the max-postcopy-bandwidth parameter, this
> only affects the current migration fd if we're 'in_postcopy';
> this leads to a race in the postcopy recovery test where it increases
> the speed from 4k/sec to unlimited, but that increase can get ignored
> if the change is made between the point at which the reconnection
> happens and it transitions back to active.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
>  migration/migration.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 01863a95f5..5f7e4d15e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1659,7 +1659,14 @@ bool migration_in_postcopy(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> -    return (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    switch (s->state) {
> +    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> +    case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +        return true;
> +    default:
> +        return false;
> +    }
>  }
>  
>  bool migration_in_postcopy_after_devices(MigrationState *s)
> -- 
> 2.21.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

