Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 222C420728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3PORlAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222C420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZasA-0005kE-95
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZarb-0005H4-Fu
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:58:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jZara-0006W2-8E
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589551136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YC0+HeJZZLS3s6YpYlY6qQx+znWjeBMmEoJi+7Lxseo=;
 b=E3PORlAF4d6NFs1gHhSHIasxHJs3LQ7HsNZWVnv6F+PRVK1hvx4eqmDQycyjk7DR2LkcCf
 nMjpIxKKPtNOIpY3y5tvSm2icjuWGI5Khdgz7q/aNa6PJ6CYqM59AeKsWyMZKxVl7LbrtD
 qr6a+JmugnGj7EluiJYYpthoCSjV9wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-16WZiDSCP0-pzg4_PF_kQQ-1; Fri, 15 May 2020 09:58:55 -0400
X-MC-Unique: 16WZiDSCP0-pzg4_PF_kQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B46BE1005510;
 Fri, 15 May 2020 13:58:53 +0000 (UTC)
Received: from work-vm (ovpn-114-149.ams2.redhat.com [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 728C41943D;
 Fri, 15 May 2020 13:58:43 +0000 (UTC)
Date: Fri, 15 May 2020 14:58:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1 08/17] migration/colo: Use
 ram_block_discard_set_broken()
Message-ID: <20200515135841.GF2954@work-vm>
References: <20200506094948.76388-1-david@redhat.com>
 <20200506094948.76388-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506094948.76388-9-david@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* David Hildenbrand (david@redhat.com) wrote:
> COLO will copy all memory in a RAM block, mark discarding of RAM broken.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/migration/colo.h |  2 +-
>  migration/migration.c    |  8 +++++++-
>  migration/savevm.c       | 11 +++++++++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 1636e6f907..768e1f04c3 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
>  bool migration_in_colo_state(void);
>  
>  /* loadvm */
> -void migration_incoming_enable_colo(void);
> +int migration_incoming_enable_colo(void);
>  void migration_incoming_disable_colo(void);
>  bool migration_incoming_colo_enabled(void);
>  void *colo_process_incoming_thread(void *opaque);
> diff --git a/migration/migration.c b/migration/migration.c
> index 177cce9e95..f6830e4620 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -338,12 +338,18 @@ bool migration_incoming_colo_enabled(void)
>  
>  void migration_incoming_disable_colo(void)
>  {
> +    ram_block_discard_set_broken(false);
>      migration_colo_enabled = false;
>  }
>  
> -void migration_incoming_enable_colo(void)
> +int migration_incoming_enable_colo(void)
>  {
> +    if (ram_block_discard_set_broken(true)) {
> +        error_report("COLO: cannot set discarding of RAM broken");

I'd prefer 'COLO: cannot disable RAM discard'

'broken' suggests the user has to go and fix something or report a bug
or something.

Other than that:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> +        return -EBUSY;
> +    }
>      migration_colo_enabled = true;
> +    return 0;
>  }
>  
>  void migrate_add_address(SocketAddress *address)
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c00a6807d9..19b4f9600d 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2111,8 +2111,15 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>  
>  static int loadvm_process_enable_colo(MigrationIncomingState *mis)
>  {
> -    migration_incoming_enable_colo();
> -    return colo_init_ram_cache();
> +    int ret = migration_incoming_enable_colo();
> +
> +    if (!ret) {
> +        ret = colo_init_ram_cache();
> +        if (ret) {
> +            migration_incoming_disable_colo();
> +        }
> +    }
> +    return ret;
>  }
>  
>  /*
> -- 
> 2.25.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


