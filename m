Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C23C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 846EE21527
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 17:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnIYxi3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846EE21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeioJ-0002ES-Mf
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 13:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jeinS-0001kl-FF
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:27:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34089
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jeinQ-0001IZ-R1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 13:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590773271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ivkkl+oeW4gF8uJxiPZGJin6Xqfi/E0jM2zHLa5QQ0Q=;
 b=PnIYxi3WDsEwIs8msl8GD4wbA5PQYip0KtY3XOLl/zHiuZDiefyBISdSp0iOsk4Qwy+TBN
 6p1hRCyWUlyMTBQN2ep+HxuBBgkpqCnTQnm+SxngxWCVYVK+YLNiqvR21E0N/hpyB0Lq7R
 4k2m5pwFetEssGaDw+1n82uRLt1M2s8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-1cS0dVmyOJijGgo5dfBmXw-1; Fri, 29 May 2020 13:27:49 -0400
X-MC-Unique: 1cS0dVmyOJijGgo5dfBmXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E162474;
 Fri, 29 May 2020 17:27:48 +0000 (UTC)
Received: from work-vm (ovpn-113-111.ams2.redhat.com [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD3AD62A10;
 Fri, 29 May 2020 17:27:46 +0000 (UTC)
Date: Fri, 29 May 2020 18:27:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pan Nengyuan <pannengyuan@huawei.com>
Subject: Re: [PATCH 2/2] migration/rdma: cleanup rdma context before g_free
 to avoid memleaks
Message-ID: <20200529172744.GQ2856@work-vm>
References: <20200508100755.7875-1-pannengyuan@huawei.com>
 <20200508100755.7875-3-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200508100755.7875-3-pannengyuan@huawei.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, euler.robot@huawei.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pan Nengyuan (pannengyuan@huawei.com) wrote:
> When error happen in initializing 'rdma_return_path', we should cleanup rdma context
> before g_free(rdma) to avoid some memleaks. This patch fix that.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>

Queued.

> ---
>  migration/rdma.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 72e8b1c95b..ec45d33ba3 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4094,20 +4094,20 @@ void rdma_start_outgoing_migration(void *opaque,
>          rdma_return_path = qemu_rdma_data_init(host_port, errp);
>  
>          if (rdma_return_path == NULL) {
> -            goto err;
> +            goto return_path_err;
>          }
>  
>          ret = qemu_rdma_source_init(rdma_return_path,
>              s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp);
>  
>          if (ret) {
> -            goto err;
> +            goto return_path_err;
>          }
>  
>          ret = qemu_rdma_connect(rdma_return_path, errp);
>  
>          if (ret) {
> -            goto err;
> +            goto return_path_err;
>          }
>  
>          rdma->return_path = rdma_return_path;
> @@ -4120,6 +4120,8 @@ void rdma_start_outgoing_migration(void *opaque,
>      s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
>      migrate_fd_connect(s, NULL);
>      return;
> +return_path_err:
> +    qemu_rdma_cleanup(rdma);
>  err:
>      g_free(rdma);
>      g_free(rdma_return_path);
> -- 
> 2.18.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


