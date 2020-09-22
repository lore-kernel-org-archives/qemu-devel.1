Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D02FC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2982396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvAlXej8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2982396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhBG-0007sF-Ve
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKh9L-0006o3-Tr
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kKh9F-0005tI-Si
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600776712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnsmXgUsIUagWbwuzv1HFJFE5WlQIEnCfhK+UduS9V4=;
 b=gvAlXej8WpU0tpASZju33BuphPigZUp7hGWPv6bVNHh036CwtQvvm8NzMBeBqSQsWp5rS6
 ZFGN8RCaBl7n6kQ84/hWrT5GLAAKLiXErUHY9QF+n3/B/ZDpKnPB/w+Zs2SfyorUCN8tls
 FGJBaHS84Fq2YLhgY52YWIgTvXtkaEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-CNt4ySJyNzm8qqjYWaxv0A-1; Tue, 22 Sep 2020 08:11:49 -0400
X-MC-Unique: CNt4ySJyNzm8qqjYWaxv0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C32195D561;
 Tue, 22 Sep 2020 12:11:47 +0000 (UTC)
Received: from work-vm (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1823F78826;
 Tue, 22 Sep 2020 12:11:45 +0000 (UTC)
Date: Tue, 22 Sep 2020 13:11:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] migration: increase max-bandwidth to 128 MiB/s (1 Gib/s)
Message-ID: <20200922121143.GG2836@work-vm>
References: <20200921144957.979989-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921144957.979989-1-lvivier@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, Andrea Bolognani <abologna@redhat.com>,
 David Gibson <dgibson@redhat.com>, Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Laurent Vivier (lvivier@redhat.com) wrote:
> max-bandwidth is set by default to 32 MiB/s (256 Mib/s)
> since 2008 (5bb7910af031c).
> 
> Most of the CPUs can dirty memory faster than that now,
> and this is clearly a problem with POWER where the page
> size is 64 kiB and not 4 KiB.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

in another 12 years we can increase it by 8x again!

> ---
>  migration/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 58a5452471f9..1c4174947181 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -57,7 +57,7 @@
>  #include "qemu/queue.h"
>  #include "multifd.h"
>  
> -#define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
> +#define MAX_THROTTLE  (128 << 20)      /* Migration transfer speed throttling */
>  
>  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
>   * data. */
> -- 
> 2.26.2
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


