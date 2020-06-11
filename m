Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3937B206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHF8VIPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3937B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSXd-00061P-Ii
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSWT-0004Uw-B9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:05:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jjSWR-0000DE-LP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591902354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ulzwYtyxHadepsaREFFfmiWCaGMR27Q7uvA0kz5lPc0=;
 b=VHF8VIPCJWHq+ZnbkoJe2YHjA9m1QhOfgb/2kiRH+ikrK8snLVjn+oHFZPUFAxjPvR892v
 dBbm88nOR9BcD0qie/lu45t9MUWsfIJ5oPg62v3LAR3F9fN6soA4+Jji7JpMTHXVdgV0aB
 atIsVAbqbcTFCt3AGCktJYEizH2/zwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-4EmD5WGFOxeBJy0DL3sx-A-1; Thu, 11 Jun 2020 15:05:52 -0400
X-MC-Unique: 4EmD5WGFOxeBJy0DL3sx-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8B6B107ACCD;
 Thu, 11 Jun 2020 19:05:51 +0000 (UTC)
Received: from work-vm (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4413660BF4;
 Thu, 11 Jun 2020 19:05:51 +0000 (UTC)
Date: Thu, 11 Jun 2020 20:05:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Subject: Re: [PATCH 9/9] migration/ram: calculate un/encoded_size only when
 needed.
Message-ID: <20200611190548.GE2969@work-vm>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
 <20200603080904.997083-10-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20200603080904.997083-10-maozhongyi@cmss.chinamobile.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 41cc530d9d..ca20030b64 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -910,14 +910,15 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>          xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
>              rs->xbzrle_cache_miss_prev) / page_count;
>          rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> -        unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
> -                         TARGET_PAGE_SIZE;
> -        encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
>          if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
>              xbzrle_counters.encoding_rate = 0;
> -        } else if (!encoded_size) {
> +        } else if (xbzrle_counters.bytes == rs->xbzrle_bytes_prev) {

No, I don't think this change is worth it - this is really just the same
as 'encoded_size', and then we may as well keep the two together.

Dave

>              xbzrle_counters.encoding_rate = UINT64_MAX;
>          } else {
> +            unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
> +                             TARGET_PAGE_SIZE;
> +            encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
> +
>              xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
>          }
>          rs->xbzrle_pages_prev = xbzrle_counters.pages;
> -- 
> 2.17.1
> 
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


