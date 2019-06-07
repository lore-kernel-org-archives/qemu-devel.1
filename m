Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE282C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E00C208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E00C208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52812 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZLK2-0007CF-MR
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58555)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hZK3f-0003cz-OS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hZK3e-0007tV-FN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hZK3e-0007mR-4q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E9D78046D;
 Fri,  7 Jun 2019 18:57:38 +0000 (UTC)
Received: from work-vm (ovpn-116-24.ams2.redhat.com [10.36.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 708626A958;
 Fri,  7 Jun 2019 18:57:37 +0000 (UTC)
Date: Fri, 7 Jun 2019 19:57:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190607185734.GZ2631@work-vm>
References: <20190606013138.13312-1-richardw.yang@linux.intel.com>
 <20190606013138.13312-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606013138.13312-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 07 Jun 2019 18:57:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] migration/xbzrle: update cache and
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

This function is actually quite subtle, and I think your change will
work, but it has changed the behaviour slightly.

When we enter the function the *current_data is pointing at actual guest
RAM and is changing as we're running.
It's critical that the contents of the cache match what was actually
sent, so that in the next cycle the correct delta is generated;
thus the reason for the two memcpy's is actually different.

> ---
>  migration/ram.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e9b40d636d..878cd8de7a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1594,25 +1594,24 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>      encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
>                                         TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
>                                         TARGET_PAGE_SIZE);
> +
> +    /*
> +     * we need to update the data in the cache, in order to get the same data
> +     */
> +    if (!last_stage && encoded_len != 0) {
> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
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

In this case, we've not managed to compress, so we're going to have to
transmit the whole page; but remember the guest is still writing. So we
update the cache, and then update *current_data to point to the cache
so that the caller sends from the cache directly rather than the guest
RAM, this ensures that the thing that's sent matches the cache contents.

However, note the memcpy is from *current_data, not XBZRLE.current_buf,
so it might be slightly newer  - this is the first change you have made;
you might be sending data that's slightly older; but it's safe because
the data sent does match the cache contents.

>      }
>  
> -    /* we need to update the data in the cache, in order to get the same data */
> -    if (!last_stage) {
> -        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
> -    }
> -

This memcpy is slightly different.
Here we've managed to do the compress; so now we update the cache based
on what was compressed (current_buf).  *current_data isn't used by the
caller in this case because it's actually sending the compressed data.
So it's safe for you to update it.

So I think we need to add comments like that, how about:

       /*
        * Update the cache contents, so that it corresponds to the data
        * sent, in allc ases except where we skip the page.
        */
> +    if (!last_stage && encoded_len != 0) {
> +        memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
       /*
        * In the case where we couldn't compress, ensure that the caller
        * sends the data from the cache, since the guest might have
        * changed the RAM since we copied it.
        */

> +        *current_data = prev_cached_page;
> +    }
>      /* Send XBZRLE based compressed page */
>      bytes_xbzrle = save_page_header(rs, rs->f, block,
>                                      offset | RAM_SAVE_FLAG_XBZRLE);

Dave

> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

