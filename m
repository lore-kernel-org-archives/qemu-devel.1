Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF7C46466
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE548207EA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azlWjAAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE548207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPUkp-00034G-Uw
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 13:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPUjt-0002W1-UL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kPUjq-0001Dc-Ib
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 13:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601920649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ze0C/DVcbiRiaHhfa4sNq78h7LWTBiuGCch2lXCrZBE=;
 b=azlWjAAkcNjfTMzhPWTt9ze//9o81XVZtNVIoXeZOD/UOO9/r/bB3X8UVeAvT3KErnjTDI
 Ex0YhAKzTHW2uFh6v1NRD82dSYlRR+XZi/MucHvVdjNmP0lrQcEPErmHt4VBRQDsrkEMuX
 NuG+7QmOsEWM1gmofaHQfYQcxgAYFWA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-otx2EDSYOK-45TDZO_H-AQ-1; Mon, 05 Oct 2020 13:57:27 -0400
X-MC-Unique: otx2EDSYOK-45TDZO_H-AQ-1
Received: by mail-wr1-f72.google.com with SMTP id a2so4299429wrp.8
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 10:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=78pmVB4h/dcMlGig4farxYjPAwUL5UZuJXAWiwPuVqg=;
 b=eC1hE0i1wrv0+MHrVvdSD5PEnMt0P1wVbm8sVkXg0fF+/VsqDVnxAfzCquiVF5yMMw
 MN4pR+4jI/Fpt/p6SuFnbRgbuf0IRymEtY+YCkPbgj65CcZXyJPLanSQqWTsTKQk5vJx
 Ng4KGhylzNyXfwwEtZgCHOy7C8hZu1EYTRhskwLogXkYxaGUPXosqIe51moox7D4vi2b
 OtifA3unJBOQ1eyMOd/Bw0H4NvJQ7+7iyx6ywJ62xperYS4o+oJV03JYj/1+cT6IgYrR
 sErE6WsjGhfCrhfwYbX4+UEdc993Mqi8AoEMI3lhgTrjZcpX/7bspj5/Hue9qQhWvC7N
 Z+Ug==
X-Gm-Message-State: AOAM530xfViKePEiL+OWqRkxRg/KtcV634/osA/mWyFPxmstP2/uDiqW
 7XqofCYfUbiLh31vVzzvFSl59OO6dg7ea8K8J/xcttUsx7Am6JcUAVwznb4vNSy+QZ+BkYMgaEA
 OMaWIubD6dxEkXpU=
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr540723wmh.89.1601920646244;
 Mon, 05 Oct 2020 10:57:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgJAu0tJ5FggTGjnAv/rZ1SgBnSG3NxbQrK24dbtbT81cM+nlMV7XqA+JyC2cNn+WeiWd6kA==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr540702wmh.89.1601920645973;
 Mon, 05 Oct 2020 10:57:25 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id i33sm954876wri.79.2020.10.05.10.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 10:57:25 -0700 (PDT)
Date: Mon, 5 Oct 2020 13:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] softmmu/memory: Log invalid memory accesses
Message-ID: <20201005135652-mutt-send-email-mst@kernel.org>
References: <20201005152725.2143444-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201005152725.2143444-1-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 05, 2020 at 05:27:25PM +0200, Philippe Mathieu-Daudé wrote:
> Log invalid memory accesses with as GUEST_ERROR.
> 
> This is particularly useful since commit 5d971f9e67 which reverted
> ("memory: accept mismatching sizes in memory_region_access_valid").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Paolo's tree I assume?

> ---
>  softmmu/memory.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index fa280a19f7..403ff3abc9 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -14,6 +14,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "exec/memory.h"
> @@ -1353,10 +1354,18 @@ bool memory_region_access_valid(MemoryRegion *mr,
>  {
>      if (mr->ops->valid.accepts
>          && !mr->ops->valid.accepts(mr->opaque, addr, size, is_write, attrs)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
> +                                       "0x%" HWADDR_PRIX ", size %u, "
> +                                       "region '%s', reason: rejected\n",
> +                      addr, size, memory_region_name(mr));
>          return false;
>      }
>  
>      if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
> +                                       "0x%" HWADDR_PRIX ", size %u, "
> +                                       "region '%s', reason: unaligned\n",
> +                      addr, size, memory_region_name(mr));
>          return false;
>      }
>  
> @@ -1367,6 +1376,13 @@ bool memory_region_access_valid(MemoryRegion *mr,
>  
>      if (size > mr->ops->valid.max_access_size
>          || size < mr->ops->valid.min_access_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid access at addr "
> +                                       "0x%" HWADDR_PRIX ", size %u, "
> +                                       "region '%s', reason: invalid size "
> +                                       "(min:%u max:%u)\n",
> +                      addr, size, memory_region_name(mr),
> +                      mr->ops->valid.min_access_size,
> +                      mr->ops->valid.max_access_size);
>          return false;
>      }
>      return true;
> -- 
> 2.26.2


