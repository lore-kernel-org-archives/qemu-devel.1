Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C65C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 10:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EFA2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 10:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EFA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haI1t-0003FO-2Z
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 06:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37682)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1haHy7-0000hy-Lc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1haHy6-00036k-1j
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:56:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1haHy5-00031G-2Z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 06:56:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3894D13AAE;
 Mon, 10 Jun 2019 10:55:59 +0000 (UTC)
Received: from work-vm (ovpn-117-16.ams2.redhat.com [10.36.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B8AA5C207;
 Mon, 10 Jun 2019 10:55:58 +0000 (UTC)
Date: Mon, 10 Jun 2019 11:55:55 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190610105555.GD22439@work-vm>
References: <20190610004159.20966-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610004159.20966-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 10 Jun 2019 10:55:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] migration/xbzrle: update cache and
 current_data in one place
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
> When we are not in the last_stage, we need to update the cache if page
> is not the same.
> 
> Currently this procedure is scattered in two places and mixed with
> encoding status check.
> 
> This patch extract this general step out to make the code a little bit
> easy to read.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
> v2: give more comment on the behavior
> ---
>  migration/ram.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e9b40d636d..17cc9b2b44 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1594,25 +1594,30 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>      encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
>                                         TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
>                                         TARGET_PAGE_SIZE);
> +
> +    /*
> +     * Update the cache contents, so that it corresponds to the data
> +     * sent, in all cases except where we skip the page.
> +     */
> +    if (!last_stage && encoded_len != 0) {
> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
> +        /*
> +         * In the case where we couldn't compress, ensure that the caller
> +         * sends the data from the cache, since the guest might have
> +         * changed the RAM since we copied it.
> +         */
> +        *current_data = prev_cached_page;
> +    }
> +
>      if (encoded_len == 0) {
>          trace_save_xbzrle_page_skipping();
>          return 0;
>      } else if (encoded_len == -1) {
>          trace_save_xbzrle_page_overflow();
>          xbzrle_counters.overflow++;
> -        /* update data in the cache */
> -        if (!last_stage) {
> -            memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
> -            *current_data = prev_cached_page;
> -        }
>          return -1;
>      }
>  
> -    /* we need to update the data in the cache, in order to get the same data */
> -    if (!last_stage) {
> -        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
> -    }
> -
>      /* Send XBZRLE based compressed page */
>      bytes_xbzrle = save_page_header(rs, rs->f, block,
>                                      offset | RAM_SAVE_FLAG_XBZRLE);
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

