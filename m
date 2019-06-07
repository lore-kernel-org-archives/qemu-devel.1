Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E687CC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7516D208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7516D208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKHE-00049r-Jb
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZK7J-0005Y0-FP
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 15:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZK7H-0003Io-EY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 15:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hZK7C-000379-Nw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 15:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D11493086262;
 Fri,  7 Jun 2019 19:01:17 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F28AC7855E;
 Fri,  7 Jun 2019 19:01:16 +0000 (UTC)
Date: Fri, 7 Jun 2019 20:01:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190607190114.GA2631@work-vm>
References: <20190606013138.13312-1-richardw.yang@linux.intel.com>
 <20190606013138.13312-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606013138.13312-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 19:01:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] migration/xbzrle: cleanup the handling
 cache miss condition
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
> For cache miss condition not in last_stage, we need to insert data into
> cache. When this step succeed, current_data should be updated. While no
> matter these checks pass or not, -1 is returned.
> 
> Based on this, the logic in cache miss handling could be simplified a
> little.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  migration/ram.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 878cd8de7a..67ba075cc4 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1572,15 +1572,14 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>      if (!cache_is_cached(XBZRLE.cache, current_addr,
>                           ram_counters.dirty_sync_count)) {
>          xbzrle_counters.cache_miss++;
> -        if (!last_stage) {
> -            if (cache_insert(XBZRLE.cache, current_addr, *current_data,
> -                             ram_counters.dirty_sync_count) == -1) {
> -                return -1;
> -            } else {
> -                /* update *current_data when the page has been
> -                   inserted into cache */
> -                *current_data = get_cached_data(XBZRLE.cache, current_addr);
> -            }
> +        if (!last_stage &&
> +            !cache_insert(XBZRLE.cache, current_addr, *current_data,
> +                          ram_counters.dirty_sync_count)) {
> +            /*
> +             * update *current_data when the page has been inserted into
> +             * cache
> +             */
> +            *current_data = get_cached_data(XBZRLE.cache, current_addr);

No this change doesn't gain anything and I find the original easier to
read.

This function is really subtle, every time I do anything with it I have
to think really hard about it, so ease of reading is more important.

Dave

>          }
>          return -1;
>      }
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

