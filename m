Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66954C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C498120758
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 18:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ16XDpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOPsy-0006f3-OT
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 14:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kOPrh-0005zj-Dk
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kOPrf-0001It-Fy
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 14:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601663586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VJshZe7ZGF8camxMiV4Y8ljGgXjLh4nIKoOOKHHMnRI=;
 b=LQ16XDpugwEmedjgPKPiCY5b3NXC7398zdiPutkWGlvClhhRcSDbSFF2AxzdAAKVufW5AP
 rNMQ4Toz6jJTRajoIhEBENs4qTVTvlvb7u9A6U5+qlggCGsT0PUfNZ3ZxyP6R66Crs2yLU
 jiA6FVp/aVqK1TJ0zZN0VkicqH6gtEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-6A1G3vNCNyOIPNx5mjoUqg-1; Fri, 02 Oct 2020 14:33:04 -0400
X-MC-Unique: 6A1G3vNCNyOIPNx5mjoUqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA6964089
 for <qemu-devel@nongnu.org>; Fri,  2 Oct 2020 18:33:03 +0000 (UTC)
Received: from work-vm (ovpn-114-192.ams2.redhat.com [10.36.114.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E72878831;
 Fri,  2 Oct 2020 18:32:59 +0000 (UTC)
Date: Fri, 2 Oct 2020 19:32:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v4 4/4] migration: Sync requested pages after postcopy
 recovery
Message-ID: <20201002183257.GN3286@work-vm>
References: <20201002175336.30858-1-peterx@redhat.com>
 <20201002175336.30858-5-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201002175336.30858-5-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Xiaohui Li <xiaohli@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> We synchronize the requested pages right after a postcopy recovery happens.
> This helps to synchronize the prioritized pages on source so that the faulted
> threads can be served faster.
> 
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
>  migration/trace-events |  1 +
>  2 files changed, 58 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 34e4b71052..1dc021ee53 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2011,6 +2011,49 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
>      return LOADVM_QUIT;
>  }
>  
> +/* We must be with page_request_mutex held */
> +static gboolean postcopy_sync_page_req(gpointer key, gpointer value,
> +                                       gpointer data)
> +{
> +    MigrationIncomingState *mis = data;
> +    void *host_addr = (void *) key;
> +    ram_addr_t rb_offset;
> +    RAMBlock *rb;
> +    int ret;
> +
> +    rb = qemu_ram_block_from_host(host_addr, true, &rb_offset);
> +    if (!rb) {
> +        /*
> +         * This should _never_ happen.  However be nice for a migrating VM to
> +         * not crash/assert.  Post an error (note: intended to not use *_once
> +         * because we do want to see all the illegal addresses; and this can
> +         * never be triggered by the guest so we're safe) and move on next.
> +         */
> +        error_report("%s: illegal host addr %p", __func__, host_addr);
> +        /* Try the next entry */
> +        return FALSE;
> +    }
> +
> +    ret = migrate_send_rp_message_req_pages(mis, rb, rb_offset);
> +    if (ret) {
> +        /* Please refer to above comment. */
> +        error_report("%s: send rp message failed for addr %p",
> +                     __func__, host_addr);
> +        return FALSE;
> +    }
> +
> +    trace_postcopy_page_req_sync(host_addr);
> +
> +    return FALSE;
> +}
> +
> +static void migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
> +{
> +    WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
> +        g_tree_foreach(mis->page_requested, postcopy_sync_page_req, mis);
> +    }
> +}
> +
>  static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>  {
>      if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> @@ -2033,6 +2076,20 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>      /* Tell source that "we are ready" */
>      migrate_send_rp_resume_ack(mis, MIGRATION_RESUME_ACK_VALUE);
>  
> +    /*
> +     * After a postcopy recovery, the source should have lost the postcopy
> +     * queue, or potentially the requested pages could have been lost during
> +     * the network down phase.  Let's re-sync with the source VM by re-sending
> +     * all the pending pages that we eagerly need, so these threads won't get
> +     * blocked too long due to the recovery.
> +     *
> +     * Without this procedure, the faulted destination VM threads (waiting for
> +     * page requests right before the postcopy is interrupted) can keep hanging
> +     * until the pages are sent by the source during the background copying of
> +     * pages, or another thread faulted on the same address accidentally.
> +     */
> +    migrate_send_rp_req_pages_pending(mis);
> +
>      return 0;
>  }
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index e4d5eb94ca..0fbfd2da60 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -49,6 +49,7 @@ vmstate_save(const char *idstr, const char *vmsd_name) "%s, %s"
>  vmstate_load(const char *idstr, const char *vmsd_name) "%s, %s"
>  postcopy_pause_incoming(void) ""
>  postcopy_pause_incoming_continued(void) ""
> +postcopy_page_req_sync(void *host_addr) "sync page req %p"
>  
>  # vmstate.c
>  vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


