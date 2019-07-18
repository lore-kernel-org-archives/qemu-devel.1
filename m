Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F06C76195
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6E021849
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 22:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6E021849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoD3W-0005Mm-F2
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 16:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hoD2o-0004x8-H2
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 16:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hoD2h-0000OR-PZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 16:30:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hoD2h-0000OD-K5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 16:30:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D069B3365A;
 Thu, 18 Jul 2019 20:30:16 +0000 (UTC)
Received: from redhat.com (ovpn-120-147.rdu2.redhat.com [10.10.120.147])
 by smtp.corp.redhat.com (Postfix) with SMTP id 7F4315D71C;
 Thu, 18 Jul 2019 20:30:15 +0000 (UTC)
Date: Thu, 18 Jul 2019 16:30:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-ID: <20190718162958-mutt-send-email-mst@kernel.org>
References: <1563466463-26012-1-git-send-email-wrfsh@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563466463-26012-1-git-send-email-wrfsh@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 18 Jul 2019 20:30:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386/acpi: fix gint overflow in
 crs_range_compare
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 07:14:23PM +0300, Evgeny Yakovlev wrote:
> When very large regions (32GB sized in our case, PCI pass-through of GPUs)
> are compared substraction result does not fit into gint.
> 
> As a result crs_replace_with_free_ranges does not get sorted ranges and
> incorrectly computes PCI64 free space regions. Which then makes linux
> guest complain about device and PCI64 hole intersection and device
> becomes unusable.
> 
> Fix that by returning exactly fitting ranges.
> 
> Also fix indentation of an entire crs_replace_with_free_ranges to make
> checkpatch happy.
> 
> Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>

queued, thanks a lot!

> ---
> v2:
> entire crs_replace_with_free_ranges was indented with 5 spaces, including my change.
> fix that as well
> 
>  hw/i386/acpi-build.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d281ffa..e7b756b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -755,10 +755,16 @@ static void crs_range_set_free(CrsRangeSet *range_set)
>  
>  static gint crs_range_compare(gconstpointer a, gconstpointer b)
>  {
> -     CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
> -     CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
> +    CrsRangeEntry *entry_a = *(CrsRangeEntry **)a;
> +    CrsRangeEntry *entry_b = *(CrsRangeEntry **)b;
>  
> -     return (int64_t)entry_a->base - (int64_t)entry_b->base;
> +    if (entry_a->base < entry_b->base) {
> +        return -1;
> +    } else if (entry_a->base > entry_b->base) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
>  }
>  
>  /*
> -- 
> 2.7.4

