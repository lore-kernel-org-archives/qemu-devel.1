Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA8FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3407D20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcitMga8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3407D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHXZ1-00067I-Bl
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 14:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jHXYH-0005ZX-NG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jHXYF-0002ft-Kb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:48:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jHXYC-0002df-Dy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 14:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585248499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BOe9Mky1sHd/AxUSvoEQSW5fOlSSXd4c12oRfsY5jA=;
 b=YcitMga8h46UhJ2T6ynohlh8mBHg0PN5L/r2oJw3CLDLJxtXAnICHS44IRPwXGtYm1koR8
 mbluXKvRASxDiWZ5mab/RPlPEc5eyLx4fRxcn1EIiBYyo9zvyEZrpUgDvMJeOvGHrAscE7
 tdHgd988ZpLbh5U4xRJ/zzouEAp36uw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-AJdBqJubOFiDbhWmo86YmQ-1; Thu, 26 Mar 2020 14:48:17 -0400
X-MC-Unique: AJdBqJubOFiDbhWmo86YmQ-1
Received: by mail-wr1-f71.google.com with SMTP id h14so3560128wrr.12
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 11:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2BOe9Mky1sHd/AxUSvoEQSW5fOlSSXd4c12oRfsY5jA=;
 b=Fd92j0R8C79mbvuLvM1/vS/oxb15dIjg0377X5dllra7RSEQGwl/s5uEOb1eOMbwCM
 4ImtBp9OcrJCkPUR2MQwKQz+wNer+h5zK3OQcB4Q1S15CAzBmsJAnidfE/NrGx/X00JR
 QUdx4aBSwSzzW21FnONuIx4swgX+GgmP3TRM/SWOqPGg47/2OD3YFgSALRgJsp8y4/CY
 kJxMysgaynhd79amFsd0kAZlsRflshmipwM3FXFe7XYouVFD2QOtod1OMwHKmhaHuhyh
 1XhnKYBcc4vcJMCpfA8DcTqnMsnSUksy5Js/PsKmfb1a2Vj2APuLEzgwWmjl35EPALBz
 qMeQ==
X-Gm-Message-State: ANhLgQ1rwjyrkYLR9F0LOhd2jyVggeuI2ZypX63sywHA+WsAksg+7org
 BueRNdthT8PU1BKjxfarjDNV8wlQlHk4bttetsQTs3pOlYjCRuSJEVcBGyw1i4uXZe2RuVaQAjX
 pfmI+VC6pObsO7SA=
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr1411488wmj.59.1585248495945; 
 Thu, 26 Mar 2020 11:48:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsoAaIf+cenjr5d5sdALqsGvAKAb/+Y2Fyxjb6gV1sieW64ySCM677S/v07UCbd001Hz3dmOQ==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr1411460wmj.59.1585248495638; 
 Thu, 26 Mar 2020 11:48:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac:65bc:cc13:a014?
 ([2001:b07:6468:f312:ac:65bc:cc13:a014])
 by smtp.gmail.com with ESMTPSA id t193sm4836783wmt.14.2020.03.26.11.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 11:48:15 -0700 (PDT)
Subject: Re: [PATCH] i386/cpu: Expand MAX_FIXED_COUNTERS from 3 to 4 to for
 Icelake
To: Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200317055413.66404-1-like.xu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b536e5e3-d102-ff82-4ebc-01114b9a1b7f@redhat.com>
Date: Thu, 26 Mar 2020 19:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317055413.66404-1-like.xu@linux.intel.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/03/20 06:54, Like Xu wrote:
> In the Intel SDM, "Table 18-2. Association of Fixed-Function
> Performance Counters with Architectural Performance Events",
> we may have a new fixed counter 'TOPDOWN.SLOTS' (since Icelake),
> which counts the number of available slots for an unhalted
> logical processor. Check commit 6017608936 in the kernel tree.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  target/i386/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 576f309bbf..ec2b67d425 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1185,7 +1185,7 @@ typedef struct {
>  #define CPU_NB_REGS CPU_NB_REGS32
>  #endif
>  
> -#define MAX_FIXED_COUNTERS 3
> +#define MAX_FIXED_COUNTERS 4
>  #define MAX_GP_COUNTERS    (MSR_IA32_PERF_STATUS - MSR_P6_EVNTSEL0)
>  
>  #define TARGET_INSN_START_EXTRA_WORDS 1
> 

Hi Like, the problem with this patch is that it breaks live migration;
the vmstate_msr_architectural_pmu record hardcodes MAX_FIXED_COUNTERS as
the number of registers.

So it's more complicated, you need to add a new subsection (following
vmstate_msr_architectural_pmu) and transmit it only if the 4th counter
is nonzero (instead of the more complicated check in pmu_enable_needed).
 Just to be safe, I'd make the new subsection hold 16 counters and bump
MAX_FIXED_COUNTERS to 16.

Thanks,

Paolo


