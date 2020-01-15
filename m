Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D49C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5442187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 07:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqpilwMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5442187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ird2U-0004cY-EN
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 02:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ird0c-0002xd-LT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ird0b-0002MG-0x
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22145
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ird0a-0002LC-TV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 02:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579072950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TtnTKmCF/n0RyfssLUe4c2gSZcLw/0k/FIaucVGMTY=;
 b=gqpilwMw6EDefCzxCJw5b7TJ89NTJ4t0xLrqzJhAxtHew/bauAiEJRbImlvuCSs7yEojxA
 8YUroENASnvVG/JLUX2tgQBPfP3dky3ps+ELikp3nwx+T2SzPSLMqFtzm20rH3aYjT241H
 XeyIw98fMbXankcgjomc3zlKeoRqeSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-HYQpmy2NOrGTiBuvhFklkw-1; Wed, 15 Jan 2020 02:22:28 -0500
Received: by mail-wr1-f72.google.com with SMTP id y7so7664401wrm.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 23:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kxDXbDE21LEAY7CAG/K4i1vgefOd3ZhiI+ADrTzLRq4=;
 b=GnCDYv/RN4nZTu1jcJQLnyRBpjeYwEFF8oDuw/FBLLDoj0Iozo+M4LpIAAQJBAQeqK
 AnbNgf8KSqypo6WZs9auFv/OjSPcGTKd7+PNPq/GEYrE8QLvxfTP2gWikYGWlrVXkjnv
 o/TFTp8zpcRar1ly6Ei2vm5TjXtmyUa4/eeyxv4cNvXnps5oBYaVZkJ7f+GTOnl6g6Es
 jqpZLXhGK8gBmMmlYc84vriBMzVdgnL5CAHkEqaiaPYQwPC9DhwqrhHRDfjdwNwhZmTE
 vrxs3IBTMVS5SLuiKfP0F3AjsaRZF6zogl/rpoRAiDGVVnBD8wcAsHO7vKHJGl+/VQSk
 zh3w==
X-Gm-Message-State: APjAAAVdlG421Gp3Y7v4yfJKkCM0Aajg4yJzbv9o2biYYOTpfBm50h/H
 EonFsvEC3fmwFPUIMdNQO3896vv0O3qFJefma90+rsG1zraOzIok05f2Lr+5aSKkMn2FoChk29H
 ccfdy3U+l5Erervo=
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr28025410wrw.370.1579072947712; 
 Tue, 14 Jan 2020 23:22:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzG4gbzp2YlY1PuDE2nqHhOQJ8+OmpnE5/d4dEvryMvYIyf4vnE6kfAD7Xkse7NSmXSUKlMrg==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr28025390wrw.370.1579072947503; 
 Tue, 14 Jan 2020 23:22:27 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9?
 ([2a01:cb1d:8a0a:f500:48c1:8eab:256a:caf9])
 by smtp.gmail.com with ESMTPSA id s10sm23194659wrw.12.2020.01.14.23.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 23:22:27 -0800 (PST)
Subject: Re: [PATCH 1/3] target/i386: Renumber EXCP_SYSCALL
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200114210921.11216-1-richard.henderson@linaro.org>
 <20200114210921.11216-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09057971-a6c9-2f92-c1b0-ec3eba2877b3@redhat.com>
Date: Wed, 15 Jan 2020 08:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114210921.11216-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: HYQpmy2NOrGTiBuvhFklkw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: pbonzini@redhat.com, riku.voipio@iki.fi, laurent@vivier.eu,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 10:09 PM, Richard Henderson wrote:
> We are not short of numbers for EXCP_*.  There is no need to confuse thin=
gs
> by having EXCP_VMEXIT and EXCP_SYSCALL overlap, even though the former is
> only used for system mode and the latter is only used for user mode.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/cpu.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 594326a794..164d038d1f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -998,9 +998,8 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
>   #define EXCP11_ALGN=0917
>   #define EXCP12_MCHK=0918
>  =20
> -#define EXCP_SYSCALL    0x100 /* only happens in user only emulation
> -                                 for syscall instruction */
> -#define EXCP_VMEXIT     0x100
> +#define EXCP_VMEXIT     0x100 /* only for system emulation */
> +#define EXCP_SYSCALL    0x101 /* only for user emulation */
>  =20
>   /* i386-specific interrupt pending bits.  */
>   #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


