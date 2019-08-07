Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6919C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C9E722296
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9E722296
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQn5-0006Bm-PD
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvQmi-0005dS-Ap
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvQmh-0007dj-Bl
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:35:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvQmh-0007aq-6I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:35:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C8BFC065119;
 Wed,  7 Aug 2019 18:35:38 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F3355D70D;
 Wed,  7 Aug 2019 18:35:37 +0000 (UTC)
Date: Wed, 7 Aug 2019 19:35:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190807183534.GN27871@work-vm>
References: <20190805053146.32326-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805053146.32326-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 07 Aug 2019 18:35:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] migration/postcopy: use mis->bh instead
 of allocating a QEMUBH
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> For migration incoming side, it either quit in precopy or postcopy. It
> is safe to use the mis->bh for both instead of allocating a dedicated
> QEMUBH for postcopy.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Hi Wei,
  Can you check this, the patchew tests came back with a failure which
seems bh related; I've not tried it, but can you just see if you can
reproduce it?

Dave

> ---
> v3: rebase on latest upstream
> v2: fix a typo in change log
> ---
>  migration/savevm.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 621b6c0465..9bf9d2e5fe 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1867,16 +1867,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      return 0;
>  }
>  
> -
> -typedef struct {
> -    QEMUBH *bh;
> -} HandleRunBhData;
> -
>  static void loadvm_postcopy_handle_run_bh(void *opaque)
>  {
>      Error *local_err = NULL;
> -    HandleRunBhData *data = opaque;
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> +    MigrationIncomingState *mis = opaque;
>  
>      /* TODO we should move all of this lot into postcopy_ram.c or a shared code
>       * in migration.c
> @@ -1908,15 +1902,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
>          runstate_set(RUN_STATE_PAUSED);
>      }
>  
> -    qemu_bh_delete(data->bh);
> -    g_free(data);
> +    qemu_bh_delete(mis->bh);
>  }
>  
>  /* After all discards we can start running and asking for pages */
>  static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>  {
>      PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> -    HandleRunBhData *data;
>  
>      trace_loadvm_postcopy_handle_run();
>      if (ps != POSTCOPY_INCOMING_LISTENING) {
> @@ -1924,9 +1916,8 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> -    data = g_new(HandleRunBhData, 1);
> -    data->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, data);
> -    qemu_bh_schedule(data->bh);
> +    mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
> +    qemu_bh_schedule(mis->bh);
>  
>      /* We need to finish reading the stream from the package
>       * and also stop reading anything more from the stream that loaded the
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

