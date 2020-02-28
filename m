Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E2CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF324246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtkhNpNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF324246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dP3-0003Ow-T6
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7dO6-0002pg-Bv
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7dO5-0000SQ-6H
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:00:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23504
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7dO5-0000R5-1R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582887656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfZmSGFNoPSeMpuEFjx9/0pexvj/cvJVsdMXjMUDfnE=;
 b=FtkhNpNTgB1Y1esuGLhit/vglDrsnHdODhfI5gsEV0Ov65deBzQ0vgkPaV1LarUmIywyE6
 SWjl4ygitrKb5+8cPdiu9dItMJLvePdW9W3n7HGAZFqz+TqsT0K04lr7Ku4XcH/OYq2QLs
 lspKuFLJYTsT8PU8Ej3guB3B/W1vuYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-xo-Q0AjYMNm6naWpbvKnYw-1; Fri, 28 Feb 2020 06:00:53 -0500
X-MC-Unique: xo-Q0AjYMNm6naWpbvKnYw-1
Received: by mail-wm1-f70.google.com with SMTP id t17so555316wmi.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jfZmSGFNoPSeMpuEFjx9/0pexvj/cvJVsdMXjMUDfnE=;
 b=HsrSjMLgE4GKYrqLndvYDdmbBT3gyV0f8XGEA/KrFJwBPOCvGlL1kvJdYKvNTDQQEg
 eGVbNN+qBRKUZHeplj+UH4/x2Q7aX93ICZf+lCKAsSP1o3pLtqIiolC/KXKjMSObtkWV
 rrms4cxFae6eGJQkBuT2OjF3eDH+N/9mOKcQkM5K4XcqmER0wEqlZyEMEQTZtV0JZVwo
 yUan+PJya1UQUCYwFcEf9st4PHMDGN+sYpHpDTvKo1Ea5OwGUH5F1qbMaJNlwLITcm/x
 72JqCDfULX3/R7yUf6SaKnM6EUd5zcfokEJha4Bw47X/fH1qTQnIdMIYOMZkU3Q0nU4i
 1j3w==
X-Gm-Message-State: APjAAAXltLZ0HZh+QRomcneFykPbcbIxjt0HyH3hhvDUPanbaAphqzOY
 NOP77Sg/H5RaIzKkrQqLTCCBToUVmUpkeURsOvXiCu5YY4eghZcUVBmBMU3fXKNG+Gyw0mq51H2
 LuBuvxCdvFL6Wg4I=
X-Received: by 2002:a7b:c216:: with SMTP id x22mr4461786wmi.51.1582887652029; 
 Fri, 28 Feb 2020 03:00:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwWw8dbOB0STLUEq7UjBJN1f7pRWXqGPjgsHntMIKXGzkvYp/c5ys8zVacZjYJC+OQqNNyCng==
X-Received: by 2002:a7b:c216:: with SMTP id x22mr4461769wmi.51.1582887651782; 
 Fri, 28 Feb 2020 03:00:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id y7sm15117834wmd.1.2020.02.28.03.00.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 03:00:51 -0800 (PST)
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Colin Xu <colin.xu@intel.com>, qemu-devel@nongnu.org, philmd@redhat.com
References: <20200228012046.6629-1-colin.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c32d7c2-d8af-45c6-4578-34c79bd7a2a0@redhat.com>
Date: Fri, 28 Feb 2020 12:00:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228012046.6629-1-colin.xu@intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-trivial@nongnu.org, wenchao.wang@intel.com, hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/02/20 02:20, Colin Xu wrote:
> HAXM covers below files:
> include/sysemu/hax.h
> target/i386/hax-*
> 
> V2: Add HAXM github page for wiki and issue tracking.
> 
> Cc: Wenchao Wang <wenchao.wang@intel.com>
> Cc: Hang Yuan <hang.yuan@intel.com>
> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
> Signed-off-by: Colin Xu <colin.xu@intel.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df1786db3207..c45f1421eab5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -435,6 +435,17 @@ F: include/hw/block/dataplane/xen*
>  F: include/hw/xen/
>  F: include/sysemu/xen-mapcache.h
>  
> +Guest CPU Cores (HAXM)
> +---------------------
> +X86 HAXM CPUs
> +M: Wenchao Wang <wenchao.wang@intel.com>
> +M: Colin Xu <colin.xu@intel.com>
> +L: haxm-team@intel.com
> +W: https://github.com/intel/haxm/issues
> +S: Maintained
> +F: include/sysemu/hax.h
> +F: target/i386/hax-*
> +
>  Hosts
>  -----
>  LINUX
> 

Queued, thanks.

Paolo


