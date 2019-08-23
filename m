Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D56AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C12206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C12206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CQC-0007yX-J6
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1CP4-0007Ws-V0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1CP3-0005MX-LM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:27:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1CP3-0005MD-CU
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:27:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0FCF18DE760;
 Fri, 23 Aug 2019 16:27:04 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F605DD61;
 Fri, 23 Aug 2019 16:27:03 +0000 (UTC)
Date: Fri, 23 Aug 2019 17:27:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190823162701.GQ2784@work-vm>
References: <20190725032722.32271-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725032722.32271-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 23 Aug 2019 16:27:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] migration/postcopy: skip compression
 when postcopy is active
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
> Now postcopy is not compatible with compression. And we disable setting
> these two capability at the same time. While we can still leverage
> compress before postcopy is active, for example at the bulk stage.
> 
> This patch skips compression when postcopy is active instead of
> forbidding setting these capability at the same time.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

So I think this is OK, because ram_save_complete has a call to
flush_compressed_data in it.

However I think we should hold it until you figure out the other series
that really enables compress; the problem is that as soon as you
allow the capability, then there's nothing to distinguish this version
and the version that fully enables it.  So how would you stop this
version being used as the source to the version which fully enables it?

So I think if we do the other series, then you should start off like
this and then remove the capability check right at the end.

Dave

> ---
>  migration/migration.c | 11 -----------
>  migration/ram.c       | 10 ++++++++++
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5a496addbd..33c373033d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -995,17 +995,6 @@ static bool migrate_caps_check(bool *cap_list,
>  #endif
>  
>      if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
> -        if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
> -            /* The decompression threads asynchronously write into RAM
> -             * rather than use the atomic copies needed to avoid
> -             * userfaulting.  It should be possible to fix the decompression
> -             * threads for compatibility in future.
> -             */
> -            error_setg(errp, "Postcopy is not currently compatible "
> -                       "with compression");
> -            return false;
> -        }
> -
>          /* This check is reasonably expensive, so only when it's being
>           * set the first time, also it's only the destination that needs
>           * special support.
> diff --git a/migration/ram.c b/migration/ram.c
> index da12774a24..a0d3bc60b2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2384,6 +2384,16 @@ static bool save_page_use_compression(RAMState *rs)
>          return false;
>      }
>  
> +    /*
> +     * The decompression threads asynchronously write into RAM
> +     * rather than use the atomic copies needed to avoid
> +     * userfaulting.  It should be possible to fix the decompression
> +     * threads for compatibility in future.
> +     */
> +    if (migration_in_postcopy()) {
> +        return false;
> +    }
> +
>      /*
>       * If xbzrle is on, stop using the data compression after first
>       * round of migration even if compression is enabled. In theory,
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

