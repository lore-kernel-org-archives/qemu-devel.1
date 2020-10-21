Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796BFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0B22177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpJk29rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0B22177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJOT-00027n-R8
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 15:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVJHr-0003Dg-IO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kVJHp-0000Fp-2h
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4uvtJuso9ItIBwRyQz/MMjjUFjkmicafahCQi65c1Y=;
 b=MpJk29rQTweI7YzattavTzY0XEuYwoqHHg5NKJCRaKFsAkn5CjrEOq5kuohp/hrLtgQZmu
 ofibZDuIlRBwx38sMtW+L43By4291YgLtYWbxEoJqnZrx/U/zL67h4mot0Me3dQ/VBzugf
 Yc6OalEEMj93GizxgMpbEaoeKH56LHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-5P9HxveFM7ek1Cz6-UH3zg-1; Wed, 21 Oct 2020 14:56:34 -0400
X-MC-Unique: 5P9HxveFM7ek1Cz6-UH3zg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C033E186DD23;
 Wed, 21 Oct 2020 18:56:32 +0000 (UTC)
Received: from work-vm (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AC15C1BD;
 Wed, 21 Oct 2020 18:56:28 +0000 (UTC)
Date: Wed, 21 Oct 2020 19:56:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 5/6] migration/postcopy: Release fd before going into
 'postcopy-pause'
Message-ID: <20201021185625.GH3671@work-vm>
References: <20201019225720.172743-1-peterx@redhat.com>
 <20201019225720.172743-6-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201019225720.172743-6-peterx@redhat.com>
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
> Logically below race could trigger with the old code:
> 
>           test program                        migration thread
>           ------------                        ----------------
>        wait_until('postcopy-pause')
>                                           postcopy_pause()
>                                             set_state('postcopy-pause')
>        do_postcopy_recover()
>          arm s->to_dst_file with new fd
>                                             release s->to_dst_file [1]
> 
> Here [1] could have released the just-installed recoverying channel.  Then the
> migration could hang without really resuming.
> 
> Instead, it should be very safe to release the fd before setting the state into
> 'postcopy-pause', because there's no reason for any other thread to touch it
> during 'postcopy-active'.
> 
> Dave reported a very rare postcopy recovery hang that the migration-test
> program waited for the migration to complete in migrate_postcopy_complete().
> We do suspect it's the same thing that we're gonna fix here.  Hard to tell.
> However since we've noticed this, fix this irrelevant of the hang report.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0b4fcff01f..50df6251b7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3182,9 +3182,6 @@ static MigThrError postcopy_pause(MigrationState *s)
>      while (true) {
>          QEMUFile *file;
>  
> -        migrate_set_state(&s->state, s->state,
> -                          MIGRATION_STATUS_POSTCOPY_PAUSED);
> -
>          /* Current channel is possibly broken. Release it. */
>          assert(s->to_dst_file);
>          qemu_mutex_lock(&s->qemu_file_lock);
> @@ -3195,6 +3192,9 @@ static MigThrError postcopy_pause(MigrationState *s)
>          qemu_file_shutdown(file);
>          qemu_fclose(file);
>  
> +        migrate_set_state(&s->state, s->state,
> +                          MIGRATION_STATUS_POSTCOPY_PAUSED);
> +
>          error_report("Detected IO failure for postcopy. "
>                       "Migration paused.");
>  
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


