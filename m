Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72553C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485D420714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aF74LkpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485D420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07Zq-00079y-Gp
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k07ZE-0006jI-8h
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:09:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41827
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1k07ZB-0000fG-OF
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595873376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPOVXV+SV9Nk0S3iuyGXRzfxApF21JG1jVigVE/jVes=;
 b=aF74LkpRleSIMh2xqe31MnZ9WSrvKm8/KlDPPhPm3xlWfTEDRK74Nf5A6IFGTPKAPMaTKm
 nm6le18lMj/q+SwxIkFqNWe+2iANvy39cS9YjThg5G7YVMVRIE/nr/aOyKK91QCC5nlC1v
 r+qaBJACwQExa4MsqLo1HnwiC2LjedI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-CBQYe_5lMaOhv6g-5Jo-Ow-1; Mon, 27 Jul 2020 14:09:34 -0400
X-MC-Unique: CBQYe_5lMaOhv6g-5Jo-Ow-1
Received: by mail-qt1-f198.google.com with SMTP id d2so8639308qtn.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 11:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=wPOVXV+SV9Nk0S3iuyGXRzfxApF21JG1jVigVE/jVes=;
 b=a7jGNMEG9581cXd6o9VHqfTJvyi5cf2wRFJuxmBUCbFPb0gdhM6jiN3vc9RYWVJfNI
 bmvSJc+/BKob9J6N89CkjhlZd3+G/2ghybBvMlguW9KvDhTdl2c7CdKzHV2iLDu5l4Zv
 e0AU18jnwYAzB497y/E3zDBv4Qt7Z3G/2yvXrYU+l40D+Zo/apjujEksi+eg6fRJZFmV
 UjQVPy74117PDR1J18iFoYvJkH3IGHIzQ61kdeRrbtJKV92yFU9bpnRDRnGQDwKDup47
 GcXPA6XAo78HpNwmxLAYnM49M1VwGBamwBnVT7zFyiuKYaf4oC+eUnMHzpqlBi/mVcq0
 QCMg==
X-Gm-Message-State: AOAM5307BIVFn3MUg2G9+5Dag54kMMHXaDCNRylD+mZIqM2RXQPjhKxo
 D+InSH2zo0MT5gld1B23AeggjjMbASxSUn8MLJ37vD0bZmsKI2p0OO1XHqeR5uNz5fqDajSausI
 eHLGHEU/46hA8CPY=
X-Received: by 2002:a37:b1c4:: with SMTP id
 a187mr14484621qkf.460.1595873374024; 
 Mon, 27 Jul 2020 11:09:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ2sdDwZZhHaC+gufUHXdXu9GXTUqvgyCPhG/YZEft5RPokvLG4NkTNOUrc1DsyjqGU1nX+A==
X-Received: by 2002:a37:b1c4:: with SMTP id
 a187mr14484597qkf.460.1595873373679; 
 Mon, 27 Jul 2020 11:09:33 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c8:6f::1f4f])
 by smtp.gmail.com with ESMTPSA id t127sm19034687qkc.100.2020.07.27.11.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 11:09:32 -0700 (PDT)
Date: Mon, 27 Jul 2020 14:09:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH-for-5.2] memory: Display bigger regions first in 'info
 mtree' output
Message-ID: <20200727180931.GA89946@xz-x1.hitronhub.home>
References: <20200727174543.4219-1-f4bug@amsat.org>
MIME-Version: 1.0
In-Reply-To: <20200727174543.4219-1-f4bug@amsat.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 07:45:43PM +0200, Philippe Mathieu-Daudé wrote:
> When different regions have the same address, we currently
> sort them by the priority. Also sort them by the region
> size.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  softmmu/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index af25987518..c28dcaf4d6 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -2960,7 +2960,8 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>          QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
>              if (new_ml->mr->addr < ml->mr->addr ||
>                  (new_ml->mr->addr == ml->mr->addr &&
> -                 new_ml->mr->priority > ml->mr->priority)) {
> +                 (MR_SIZE(new_ml->mr->size) > MR_SIZE(ml->mr->size) ||
> +                  new_ml->mr->priority > ml->mr->priority))) {
>                  QTAILQ_INSERT_BEFORE(ml, new_ml, mrqueue);
>                  new_ml = NULL;
>                  break;

Note that this change could make the outcome unpredictable... Assuming two
memory regions:

  mr1: addr=0, size=0x1000, pri=2
  mr2: addr=0, size=0x2000, pri=1

Then assuming submr_print_queue only contains these two mrs.  Then when
submr_print_queue has mr1 at head, then when we insert mr2 we'll think it
should be inserted before mr1 (because mr2's size bigger), so the result will be:

  mr2:...
  mr1:...

If submr_print_queue has mr2 at head, then when we insert mr1 we'll think it
should be inserted before mr2 (because mr1's priority higher).  We'll instead
get:

  mr1:...
  mr2:...

Phil, could I ask what's the case to be fixed?

-- 
Peter Xu


