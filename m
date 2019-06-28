Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B35BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81002086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81002086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtwx-0004V1-0T
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hgsbp-0003Zw-Cw
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hgsbm-0006Xv-G0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hgsbm-0006LV-9G
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E4F89C05B1CD;
 Fri, 28 Jun 2019 15:15:51 +0000 (UTC)
Received: from work-vm (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D2F5D704;
 Fri, 28 Jun 2019 15:15:49 +0000 (UTC)
Date: Fri, 28 Jun 2019 16:15:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190628151547.GH2922@work-vm>
References: <20190627020822.15485-1-richardw.yang@linux.intel.com>
 <20190627020822.15485-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627020822.15485-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 28 Jun 2019 15:15:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] migration/postcopy: break the loop
 when there is no more page to discard
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
> When one is equal or bigger then end, it means there is no page to
> discard. Just break the loop in this case instead of processing it.
> 
> No functional change, just refactor it a little.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b78169e811..b41b58ee54 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2776,23 +2776,23 @@ static int postcopy_send_discard_bm_ram(MigrationState *ms,
>  
>      for (current = 0; current < end; ) {
>          unsigned long one = find_next_bit(unsentmap, end, current);
> +        unsigned long zero, discard_length;
>  
> -        if (one < end) {
> -            unsigned long zero = find_next_zero_bit(unsentmap, end, one + 1);
> -            unsigned long discard_length;
> +        if (one >= end) {
> +            break;
> +        }
>  
> -            if (zero >= end) {
> -                discard_length = end - one;
> -            } else {
> -                discard_length = zero - one;
> -            }
> -            if (discard_length) {
> -                postcopy_discard_send_range(ms, pds, one, discard_length);
> -            }
> -            current = one + discard_length;
> +        zero = find_next_zero_bit(unsentmap, end, one + 1);
> +
> +        if (zero >= end) {
> +            discard_length = end - one;
>          } else {
> -            current = one;
> +            discard_length = zero - one;
> +        }
> +        if (discard_length) {
> +            postcopy_discard_send_range(ms, pds, one, discard_length);
>          }
> +        current = one + discard_length;
>      }
>  
>      return 0;
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

