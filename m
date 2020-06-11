Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E085C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0690206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axdTQelC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0690206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSPj-0007DD-6M
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 14:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSOi-0006nB-N3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:57:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSOg-0006oI-Sl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 14:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591901873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foDVeQn5KCOQ1Xt8aYp4+DXx9hkDY7JsXwUKMe7doBA=;
 b=axdTQelCTEuM7XxiGvqv5W5TdnjsEA1key+/fV6GS/YIeQfZ1nEvaykRtoVbaSjAEBciRn
 J8MSo1Zf/7Fq1A7asf/IpEVPnDyFDD2UGdAnKCwhgxnoRu4LMeFYeIZTwQATA+EIYcAvFs
 /QgnqTzw9LwVSsFB3z71YH/N2jFl3rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-ihnSYyHFM6Sc6Ua4yI5YiQ-1; Thu, 11 Jun 2020 14:57:51 -0400
X-MC-Unique: ihnSYyHFM6Sc6Ua4yI5YiQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F3A21B18BCE;
 Thu, 11 Jun 2020 18:57:51 +0000 (UTC)
Received: from work-vm (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DC528FF6A;
 Thu, 11 Jun 2020 18:57:50 +0000 (UTC)
Date: Thu, 11 Jun 2020 19:57:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH 7/9] monitor/hmp-cmds: improvements for the 'info migrate'
Message-ID: <20200611185747.GC2969@work-vm>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
 <20200603080904.997083-8-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200603080904.997083-8-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 14:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Mao Zhongyi (maozhongyi@cmss.chinamobile.com) wrote:
> When running:
> 
> (qemu) info migrate
> globals:
> store-global-state: on
> only-migratable: off
> ...
> xbzrle transferred: 640892 kbytes
> xbzrle pages: 16645936 pages
> xbzrle cache miss: 1525426
> xbzrle cache miss rate: 0.09
> xbzrle encoding rate: 91.42
> xbzrle overflow: 40896
> ...
> compression pages: 377710 pages
> compression busy: 0
> compression busy rate: 0.00
> compressed size: 463169457
> compression rate: 3.33
> 
> Add units for 'xbzrle cache miss' and 'compressed size',
> make it easier to read.
> 
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  docs/xbzrle.txt    | 2 +-
>  monitor/hmp-cmds.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/xbzrle.txt b/docs/xbzrle.txt
> index b431bdaf0f..385b4993f8 100644
> --- a/docs/xbzrle.txt
> +++ b/docs/xbzrle.txt
> @@ -112,7 +112,7 @@ is recommended.
>      cache size: H bytes
>      xbzrle transferred: I kbytes
>      xbzrle pages: J pages
> -    xbzrle cache miss: K
> +    xbzrle cache miss: K pages
>      xbzrle overflow: L
>  
>  xbzrle cache-miss: the number of cache misses to date - high cache-miss rate
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index e8cf72eb3a..24f3e8e44d 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -299,7 +299,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->xbzrle_cache->bytes >> 10);
>          monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
>                         info->xbzrle_cache->pages);
> -        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 "\n",
> +        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 " pages\n",
>                         info->xbzrle_cache->cache_miss);
>          monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
>                         info->xbzrle_cache->cache_miss_rate);
> @@ -316,8 +316,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->compression->busy);
>          monitor_printf(mon, "compression busy rate: %0.2f\n",
>                         info->compression->busy_rate);
> -        monitor_printf(mon, "compressed size: %" PRIu64 "\n",
> -                       info->compression->compressed_size);
> +        monitor_printf(mon, "compressed size: %" PRIu64 " kbytes\n",
> +                       info->compression->compressed_size >> 10);
>          monitor_printf(mon, "compression rate: %0.2f\n",
>                         info->compression->compression_rate);
>      }
> -- 
> 2.17.1
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


