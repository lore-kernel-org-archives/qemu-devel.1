Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53315C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C04DC21741
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnhHZP6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C04DC21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFZmw-0007np-NH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFZlf-0006Nc-95
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:18:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFZld-0000HV-EE
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599556700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cRhWHZGMxi7rNLQcj6ZdFavscTq/f5FpHzKS8L8V5Dk=;
 b=UnhHZP6CGDupV+R0bRrsQfBfxHKQ6+TbI8BPotFe8hjvOcQFXUcd2OseKB4UNYltRC8ey1
 S9Jh0S4GF+bDlIUrnoCtc4VI+E/6Duj9toDeEGSJs79ukUeWaAWT7Xjwzu/r+vmMW4fi86
 UPVtlAXtE1xAcjCSQ7BpN68mayJIpwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-MccDWk0vOrGu07_Z_2VggQ-1; Tue, 08 Sep 2020 05:18:18 -0400
X-MC-Unique: MccDWk0vOrGu07_Z_2VggQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BF7801F9A
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 09:18:12 +0000 (UTC)
Received: from work-vm (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F270D7ED85;
 Tue,  8 Sep 2020 09:18:07 +0000 (UTC)
Date: Tue, 8 Sep 2020 10:18:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/5] migration: Rework migrate_send_rp_req_pages() function
Message-ID: <20200908091805.GC3295@work-vm>
References: <20200903152646.93336-1-peterx@redhat.com>
 <20200903152646.93336-2-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903152646.93336-2-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> We duplicated the logic of maintaining the last_rb variable at both callers of
> this function.  Pass *rb pointer into the function so that we can avoid
> duplicating the logic.  Also, when we have the rb pointer, it's also easier to
> remove the original 2nd & 4th parameters, because both of them (name of the
> ramblock when needed, or the page size) can be fetched from the ramblock
> pointer too.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c    | 26 ++++++++++++++++++--------
>  migration/migration.h    |  4 ++--
>  migration/postcopy-ram.c | 24 ++----------------------
>  3 files changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 58a5452471..6761e3f233 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -311,25 +311,35 @@ error:
>      return ret;
>  }
>  
> -/* Request a range of pages from the source VM at the given
> - * start address.
> - *   rbname: Name of the RAMBlock to request the page in, if NULL it's the same
> - *           as the last request (a name must have been given previously)
> +/* Request one page from the source VM at the given start address.
> + *   rb: the RAMBlock to request the page in
>   *   Start: Address offset within the RB
>   *   Len: Length in bytes required - must be a multiple of pagesize
>   */
> -int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char *rbname,
> -                              ram_addr_t start, size_t len)
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
> +                              ram_addr_t start)
>  {
>      uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
>      size_t msglen = 12; /* start + len */
> +    size_t len = qemu_ram_pagesize(rb);
>      enum mig_rp_message_type msg_type;
> +    const char *rbname;
> +    int rbname_len;
>  
>      *(uint64_t *)bufc = cpu_to_be64((uint64_t)start);
>      *(uint32_t *)(bufc + 8) = cpu_to_be32((uint32_t)len);
>  
> -    if (rbname) {
> -        int rbname_len = strlen(rbname);
> +    /*
> +     * We maintain the last ramblock that we requested for page.  Note that we
> +     * don't need locking because this function will only be called within the
> +     * postcopy ram fault thread.
> +     */
> +    if (rb != mis->last_rb) {
> +        mis->last_rb = rb;
> +
> +        rbname = qemu_ram_get_idstr(rb);
> +        rbname_len = strlen(rbname);
> +
>          assert(rbname_len < 256);
>  
>          bufc[msglen++] = rbname_len;
> diff --git a/migration/migration.h b/migration/migration.h
> index ae497bd45a..ca8dc4c773 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -328,8 +328,8 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
>                            uint32_t value);
>  void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
> -int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
> -                              ram_addr_t start, size_t len);
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
> +                              ram_addr_t start);
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                   char *block_name);
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 1bb22f2b6c..11a70441a6 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -684,14 +684,7 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>                                          qemu_ram_get_idstr(rb), rb_offset);
>          return postcopy_wake_shared(pcfd, client_addr, rb);
>      }
> -    if (rb != mis->last_rb) {
> -        mis->last_rb = rb;
> -        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> -                                  aligned_rbo, pagesize);
> -    } else {
> -        /* Save some space */
> -        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
> -    }
> +    migrate_send_rp_req_pages(mis, rb, aligned_rbo);
>      return 0;
>  }
>  
> @@ -986,20 +979,7 @@ retry:
>               * Send the request to the source - we want to request one
>               * of our host page sizes (which is >= TPS)
>               */
> -            if (rb != mis->last_rb) {
> -                mis->last_rb = rb;
> -                ret = migrate_send_rp_req_pages(mis,
> -                                                qemu_ram_get_idstr(rb),
> -                                                rb_offset,
> -                                                qemu_ram_pagesize(rb));
> -            } else {
> -                /* Save some space */
> -                ret = migrate_send_rp_req_pages(mis,
> -                                                NULL,
> -                                                rb_offset,
> -                                                qemu_ram_pagesize(rb));
> -            }
> -
> +            ret = migrate_send_rp_req_pages(mis, rb, rb_offset);
>              if (ret) {
>                  /* May be network failure, try to wait for recovery */
>                  if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


