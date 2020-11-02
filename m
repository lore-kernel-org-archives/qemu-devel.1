Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30604C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A4922243
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLpNCUgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A4922243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeYR-00039z-Rb
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZeVr-0008QU-1i
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kZeVp-0007OM-6J
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604341500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sz2tHExiCaTwr7JNj8W9VMc3FH9XKSMf0xQ8qFGNOu4=;
 b=NLpNCUgxSwRF/Y3zrjT6zI+hwii8rxgFsS772TIj0rq8advUTz+Xk3K4d570fUaDI7tIk6
 8UkqMyBFHrzKh0uCRPQGLAsVmEcHOPvTlfEMcOhkx/E/mbqwlSQ83aiUikPfklHHLyyxsS
 ++DhpKwMp5KprnAjExSMQeKglW8+J9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-y0XfeFFyN9O4O4M51VpHpA-1; Mon, 02 Nov 2020 13:24:56 -0500
X-MC-Unique: y0XfeFFyN9O4O4M51VpHpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4924C1006C8D;
 Mon,  2 Nov 2020 18:24:55 +0000 (UTC)
Received: from work-vm (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4442C68431;
 Mon,  2 Nov 2020 18:24:50 +0000 (UTC)
Date: Mon, 2 Nov 2020 18:24:48 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] migration: Postpone the kick of the fault thread
 after recover
Message-ID: <20201102182448.GL3673@work-vm>
References: <20201102153010.11979-1-peterx@redhat.com>
 <20201102153010.11979-3-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102153010.11979-3-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> The new migrate_send_rp_req_pages_pending() call should greatly improve
> destination responsiveness because it will resync faulted address after
> postcopy recovery.  However it is also the 1st place to initiate the page
> request from the main thread.
> 
> One thing is overlooked on that migrate_send_rp_message_req_pages() is not
> designed to be thread-safe.  So if we wake the fault thread before syncing all
> the faulted pages in the main thread, it means they can race.
> 
> Postpone the wake up operation after the sync of faulted addresses.
> 
> Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
> Tested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e8834991ec..5f937a2762 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2069,12 +2069,9 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>  
>      /*
>       * This means source VM is ready to resume the postcopy migration.
> -     * It's time to switch state and release the fault thread to
> -     * continue service page faults.
>       */
>      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
>                        MIGRATION_STATUS_POSTCOPY_ACTIVE);
> -    qemu_sem_post(&mis->postcopy_pause_sem_fault);
>  
>      trace_loadvm_postcopy_handle_resume();
>  
> @@ -2095,6 +2092,14 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>       */
>      migrate_send_rp_req_pages_pending(mis);
>  
> +    /*
> +     * It's time to switch state and release the fault thread to continue
> +     * service page faults.  Note that this should be explicitly after the
> +     * above call to migrate_send_rp_req_pages_pending().  In short:
> +     * migrate_send_rp_message_req_pages() is not thread safe, yet.
> +     */
> +    qemu_sem_post(&mis->postcopy_pause_sem_fault);
> +
>      return 0;
>  }
>  
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


