Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6246C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:25:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9382065D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTypJJ16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9382065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCsa-0003Wq-QL
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyCrP-0001nt-S3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:24:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55279
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyCrO-00081o-3J
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K5GQ4/4JyDsHbdLjVNRrWazF9LSUbMv76tabzw1m+aE=;
 b=HTypJJ16vt+yhKSBwkpSzRJQ7FHFgx8LwcV6t6XPJ/qOuSFO5hLhl2SWSupvT4aH6X//TE
 Ggdiyy7E0y6vQLBt4hZkoRSVoDYE8gbiHFQuj79CRcTzSHSvIGNFdWneaifTVY67jCjfOJ
 56VRj73NcqZj6AJDeN8OpL5zv48HtDw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-VRpkzWucPtORgcHjjvkGEw-1; Wed, 22 Jul 2020 07:24:27 -0400
X-MC-Unique: VRpkzWucPtORgcHjjvkGEw-1
Received: by mail-wm1-f71.google.com with SMTP id u68so941018wmu.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K5GQ4/4JyDsHbdLjVNRrWazF9LSUbMv76tabzw1m+aE=;
 b=IVdeZlNlRhP3hdSrbjcpKvMIvKhjqta841kx+zOfIOpO9nIU0pMu/kZeNQ6LIidQHR
 DaKzhJkGY+m8p/FYHcQV+elyFGN6h3BZJpXSoe1VBFNbE3KqwUOUkP5CiNjECkEVoxcq
 BSdos4iaKq1ip/w8CdSYSWMIk2AxyMEFrTz1RQk57oKkcHQxlLNN6/9atOgWRLJbTPfK
 RwLasUW24DXc4xDXtDbeXzqygPY8uuKHkdBOx0/q6azGSs+IUrdAztS0+Y5EM3AMmIVF
 5WZxSfBW9lXrTlgxbryAxJ9+aw6LERf7fDJDiuEsy13XWA9lvudkekR0Rmj2Oy+uaRXk
 h2fw==
X-Gm-Message-State: AOAM5306RrU3FLh3vT1yBpvHg2xZZq5sATfaFRVttTidf7wyUuoqYxgX
 IpjzcwU2VQNM8EMEpsH20wAeyZrSuZ3Y69JrzX4KmLXejeQU6smTVhoGP46myG7wfzsKLIU/fnN
 9GUCAC4RjzyUZBy0=
X-Received: by 2002:a5d:514e:: with SMTP id u14mr3036521wrt.20.1595417066441; 
 Wed, 22 Jul 2020 04:24:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGrl1XLLs5wwNZ65xQEssYPMiyXw/EqiilBK0KBEhlvA+fKdod+oafrZAn5QHAMi5tO1PG5g==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr3036503wrt.20.1595417066183; 
 Wed, 22 Jul 2020 04:24:26 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id t11sm3563803wrs.66.2020.07.22.04.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:24:25 -0700 (PDT)
Date: Wed, 22 Jul 2020 07:24:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH for-5.1] acpi: accept byte and word access to core ACPI
 registers
Message-ID: <20200722072414-mutt-send-email-mst@kernel.org>
References: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
In-Reply-To: <20200720160627.15491-1-mjt@msgid.tls.msk.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Simon John <git@the-jedi.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 20, 2020 at 07:06:27PM +0300, Michael Tokarev wrote:
> All ISA registers should be accessible as bytes, words or dwords
> (if wide enough).  Fix the access constraints for acpi-pm-evt,
> acpi-pm-tmr & acpi-cnt registers.
> 
> Fixes: 5d971f9e67 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> Fixes: afafe4bbe0 (apci: switch cnt to memory api)
> Fixes: 77d58b1e47 (apci: switch timer to memory api)
> Fixes: b5a7c024d2 (apci: switch evt to memory api)
> Buglink: https://lore.kernel.org/xen-devel/20200630170913.123646-1-anthony.perard@citrix.com/T/
> Buglink: https://bugs.debian.org/964793
> BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=964247
> BugLink: https://bugs.launchpad.net/bugs/1886318
> Reported-By: Simon John <git@the-jedi.co.uk>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Queued, thanks!

> ---
>  hw/acpi/core.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index f6d9ec4f13..ac06db3450 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -458,7 +458,8 @@ static void acpi_pm_evt_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_evt_ops = {
>      .read = acpi_pm_evt_read,
>      .write = acpi_pm_evt_write,
> -    .valid.min_access_size = 2,
> +    .impl.min_access_size = 2,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 2,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> @@ -527,7 +528,8 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_tmr_ops = {
>      .read = acpi_pm_tmr_read,
>      .write = acpi_pm_tmr_write,
> -    .valid.min_access_size = 4,
> +    .impl.min_access_size = 4,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 4,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> @@ -599,7 +601,8 @@ static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
>  static const MemoryRegionOps acpi_pm_cnt_ops = {
>      .read = acpi_pm_cnt_read,
>      .write = acpi_pm_cnt_write,
> -    .valid.min_access_size = 2,
> +    .impl.min_access_size = 2,
> +    .valid.min_access_size = 1,
>      .valid.max_access_size = 2,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
> -- 
> 2.20.1


