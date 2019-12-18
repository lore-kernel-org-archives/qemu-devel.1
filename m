Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92895C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1CF205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNyUs5Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1CF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXuY-0000BI-HF
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:54:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihXti-0007dM-FU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihXth-0005d3-9Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihXth-0005aa-2x
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576670021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJeSAlSnpoAf0jGiAI7vCKmrd9hg9xiNdirIMhPvGv4=;
 b=SNyUs5Adj+BAuGB5AJHL+L0+8bTFhEoIfHxxv5oiYO8v6JOL24lgETRO66T1EhtNlTIrBH
 5Kp2aKJBY580W8qp0Uz8tkNTY1HzutcYfrJViDlae3iUe36C3bjrBRySkRWnIcuTP+5xR+
 LX0TPhkQhl8K2HXkCCAK6W2EqceFFoo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-enk6v1lKMyiehZz66CkC_w-1; Wed, 18 Dec 2019 06:53:40 -0500
Received: by mail-wm1-f69.google.com with SMTP id s25so430292wmj.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 03:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FJeSAlSnpoAf0jGiAI7vCKmrd9hg9xiNdirIMhPvGv4=;
 b=ao/jiJdIl0Nc33zObdpSAvSJsOc55VLzflpe01MAEPfp+XWTX9kFPOg/nNzQRPw5vg
 7XEpnJ0F6/pOPlGCXudIpTSvUbQDC5l2TtTx4UMvQHxvG7CNzGQovP+qhqyBrx4RmP1W
 nRpOTMiXlEK6ca0Ha4WQENxZwZ5YV0V/4EVz17svQflnnsmFTrCIOqOC1LAbY/iH08FU
 nMG2TYp66x5rsy303WjY7fvHJUO3IWSPrGC+M1FDdm+Z6PK0zxadc4MZO9I6EjOlNrER
 hEkXEDlZ5Qr8AEqF1KceQD7HXXSqgq7nEp8Wd4LKYSAqdSOWd18u23qmACllJYN+ZiF8
 va/Q==
X-Gm-Message-State: APjAAAWEdOWqo+mmL6bnEw64Ya5R82ZRqf3CH0k1VKTEB/A+kL7a4s5q
 NH8xxZGu6NUwJqQ06jSULTtN12Iy2pj4mpFcLkL7V2O+XsdslfJ8focGvv6Y/iDvzETLUOEbhfv
 NIAeeM8UFBy2VlnY=
X-Received: by 2002:a1c:2355:: with SMTP id j82mr2871882wmj.135.1576670018698; 
 Wed, 18 Dec 2019 03:53:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqykQNPbYXOR2vOkWvp4VLNYFoCed0Npd8ALREylUbbPPLsH2/W2ey0JITGlZ5SbDjN9ttASVQ==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr2871858wmj.135.1576670018366; 
 Wed, 18 Dec 2019 03:53:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id h17sm2399040wrs.18.2019.12.18.03.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 03:53:37 -0800 (PST)
Subject: Re: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
To: Ani Sinha <ani.sinha@nutanix.com>, rth@twiddle.net, ehabkost@redhat.com
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
Date: Wed, 18 Dec 2019 12:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
Content-Language: en-US
X-MC-Unique: enk6v1lKMyiehZz66CkC_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 10:05, Ani Sinha wrote:
> CLZERO CPUID should be passed on to the guests that use EPYC or EPYC-IBPB CPU
> model when the AMD ZEN based host supports it. This change makes it recognize
> this CPUID for guests which use EPYC or EPYC-IBPB CPU model.
> 
> Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> ---
>  target/i386/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 69f518a..55f0691 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3813,6 +3813,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
>              CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
>              CPUID_EXT3_TOPOEXT,
> +        .features[FEAT_8000_0008_EBX] =
> +            CPUID_8000_0008_EBX_CLZERO,
>          .features[FEAT_7_0_EBX] =
>              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
>              CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSEED |
> 

This needs to be done only for newer machine type (or is it CPU model
versions now? need Eduardo to respond).

Paolo


