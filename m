Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4251C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70DB20708
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 23:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPZ7SLN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70DB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ7v-0003YO-Ux
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 19:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIV4-0000jS-5f
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:25:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21001
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtIV0-0001Nq-TX
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594247104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dupB/GBcBJ1yGuAKbEijyxlFkrcAXveCSJLXHMOnpTU=;
 b=XPZ7SLN9zVZFRjK46BOk9bq2EfX6jWR2qe3J5ZwQx6n7WqNwHWvMZ+O6swgUJj4l0imsxQ
 Oxbrn1DokCV7OdQxvk6nr+qHpFOMgp/6H2mRq/tE1/JkF5lRAwnXY9GrNtEQdzCGt8jk9q
 KbJSX+Ue2VuHxPkDdHpivwi2cq0rLLk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-a0nLcjxrP3itSNCddRSGbg-1; Wed, 08 Jul 2020 06:21:40 -0400
X-MC-Unique: a0nLcjxrP3itSNCddRSGbg-1
Received: by mail-wr1-f69.google.com with SMTP id y13so51481354wrp.13
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 03:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dupB/GBcBJ1yGuAKbEijyxlFkrcAXveCSJLXHMOnpTU=;
 b=ikqYxVKrfAqdxUUEbeJEPae2RLXz8Rs/zbkBwrij+5qtI1t5C16Y68paKVhVndD4ob
 HC/HFWparTwNUOlA1YqI4rpq/VgivMc/DSbk5o3Tp0IJ6GZockZLEcQl+/2MEyHOWn+a
 SyVwfxOx9ZwFjAW0Rk6ObNKo/aTLcxMo2fTP3IvSgBZJ0n2EuMDoNSpylQOtNQDm2jkn
 xrAprHA1kTkp+N1ZQlas3takbNfgHhZQq/0JKDpi6bvd/Lepemmf90MBNpzAsFI/f75V
 s+twPdgbUxjbyitEKKUi3ua8XRIZySUFL2UiGtsJcg6Y3wHIlrdhru9KHkqdzARPm5z5
 YWnA==
X-Gm-Message-State: AOAM5326NMMmf1EUj+VjOPNVvT3y4hu15vntm8gwqpcIWDfbL4/n8ppL
 hPGc9gKx2BElSpK6HsVw4e85V3DOX1DI+XBFUp3H4u4vy1cVtL+vuc22anwbotDRhrSgRbo6uSE
 VCV3sv36bUrTvOmA=
X-Received: by 2002:adf:e546:: with SMTP id z6mr53932600wrm.99.1594203699034; 
 Wed, 08 Jul 2020 03:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+zTO/Yonefs+9edHome6uufiYaZrGCmj0c6fXfW5B/eeRZIB8oRp5GzZaEThrYVtjj1kSwA==
X-Received: by 2002:adf:e546:: with SMTP id z6mr53932564wrm.99.1594203698771; 
 Wed, 08 Jul 2020 03:21:38 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 r10sm5322365wrm.17.2020.07.08.03.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 03:21:37 -0700 (PDT)
Date: Wed, 8 Jul 2020 06:21:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH] vhost-vdpa: fix the compile issue without kvm
Message-ID: <20200708062047-mutt-send-email-mst@kernel.org>
References: <20200708084922.21904-1-lulu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200708084922.21904-1-lulu@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
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
Cc: Peter Maydell <peter.maydell@linaro.org>, mhabets@solarflare.com,
 qemu-devel@nongnu.org, rob.miller@broadcom.com, saugatm@xilinx.com,
 hanand@xilinx.com, hch@infradead.org, eperezma@redhat.com, jgg@mellanox.com,
 jasowang@redhat.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, cunming.liang@intel.com,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, zhihong.wang@intel.com, aadam@redhat.com,
 rdunlap@infradead.org, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 08, 2020 at 04:49:22PM +0800, Cindy Lu wrote:
> Fix the compile issue in the system without the kvm support
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Applied, thanks!
Peter if we need this fixed quickly, I pushed out for_upstream
just with this one fix.

Thanks!

> ---
>  hw/virtio/vhost-vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a3d17fe0f9..65d5aaf08a 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -19,8 +19,7 @@
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/vhost-vdpa.h"
>  #include "qemu/main-loop.h"
> -#include <linux/kvm.h>
> -#include "sysemu/kvm.h"
> +#include "cpu.h"
>  
>  static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section)
>  {
> -- 
> 2.21.1


