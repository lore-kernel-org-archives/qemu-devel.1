Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CBEC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB92521D7A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDNqoCan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB92521D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFaOn-0004h5-Lr
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFaO9-00048e-UZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:58:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48746
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kFaO8-0004uz-3G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599559086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/MqIlzOjXbEP+byALRvhJcCUytMQyYAcKoWUAPAvJE=;
 b=HDNqoCanYcgwS324I+Ot7dg49ICFPdjMRGBtHw0rur1qMUJ34b0ox1eS88pATnLttWPfiv
 /lRib8iV0Ho/40Wq5xidJLBSAMtKYuvFXByeQrcY8u6wWLZgomsTx8jN8sP1DynMazy42Y
 0eT8gMUiZmUA8BkQZOjdgRJOl7hrzg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-GRDLAgAoOo2ZPpCmGpAxrw-1; Tue, 08 Sep 2020 05:58:05 -0400
X-MC-Unique: GRDLAgAoOo2ZPpCmGpAxrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31DF680F041
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 09:58:04 +0000 (UTC)
Received: from work-vm (ovpn-114-204.ams2.redhat.com [10.36.114.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E84B1002388;
 Tue,  8 Sep 2020 09:58:00 +0000 (UTC)
Date: Tue, 8 Sep 2020 10:57:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/5] migration: Introduce
 migrate_send_rp_message_req_pages()
Message-ID: <20200908095757.GF3295@work-vm>
References: <20200903152646.93336-1-peterx@redhat.com>
 <20200903152646.93336-3-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200903152646.93336-3-peterx@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> This is another layer wrapper for sending a page request to the source VM,

Ah, it's not obvious why this is needed until 4/5 :-)


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 10 ++++++++--
>  migration/migration.h |  2 ++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6761e3f233..6b43ffddbd 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -316,8 +316,8 @@ error:
>   *   Start: Address offset within the RB
>   *   Len: Length in bytes required - must be a multiple of pagesize
>   */
> -int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
> -                              ram_addr_t start)
> +int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> +                                      RAMBlock *rb, ram_addr_t start)
>  {
>      uint8_t bufc[12 + 1 + 255]; /* start (8), len (4), rbname up to 256 */
>      size_t msglen = 12; /* start + len */
> @@ -353,6 +353,12 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
>      return migrate_send_rp_message(mis, msg_type, msglen, bufc);
>  }
>  
> +int migrate_send_rp_req_pages(MigrationIncomingState *mis,
> +                              RAMBlock *rb, ram_addr_t start)
> +{
> +    return migrate_send_rp_message_req_pages(mis, rb, start);
> +}
> +
>  static bool migration_colo_enabled;
>  bool migration_incoming_colo_enabled(void)
>  {
> diff --git a/migration/migration.h b/migration/migration.h
> index ca8dc4c773..f552725305 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -330,6 +330,8 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
>                                ram_addr_t start);
> +int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
> +                                      RAMBlock *rb, ram_addr_t start);
>  void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
>                                   char *block_name);
>  void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


