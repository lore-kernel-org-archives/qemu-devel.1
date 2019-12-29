Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F1C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC7B20748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnJKksoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC7B20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iliND-0005ow-2w
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 18:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iliMe-0005PB-18
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iliMc-0007fS-0e
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:52:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iliMb-0007eU-Tp
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577663568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+2Yas9xqSHb6D8u9yrH9wo6+ya0+H7KfSp6XGGRNeM=;
 b=MnJKksoAJ1jm7XJ1MsnC9XOit1DEi3zbNJ4mh09qAxp13D+ravqB362rjFum0YknUm2m/w
 nt2xJ12T6HMud5fr8oxcFMhoscPdx1I+z6JsmHc1d7yHrmnYsc32GuRl01ur2hWUExEEjd
 VS5lTdMmyVIB1Nfv9/IP7LCnURvP5Bo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-9e0vlmVEMji2WfND4-wkHg-1; Sun, 29 Dec 2019 18:52:47 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so17024770wrs.4
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 15:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g1GpLA7YPLlllpLQquSl1hTI/iBvS3dARVLueEWslRU=;
 b=fSf7/OEKyXccJiaCy7QnMhSxgpXk91V1ZomiFZnHBQyXnkagVuYMhzBbYi5bNmZ7ZN
 8jDtuAZHpZw8ZUYBjMohiHefbkwVy7QTdFASjfUwPq+MgJRYYdRMmc90sV2+dBOqtUXL
 Iy+AEtkFQ+53X/z0NClKTLHw35Ohz7Y34/H+2tW32twNeFhT19HYJV96QiJH8ihc/vEB
 PcpRQsvbhhy4jJ72Foo9naYAhcSeogM0A46/TUkwNQOPygSs1kAXYgaKSnUB0+TOboaF
 GWTwe7Wmzpe4pQ5Cs/nZZ8MxRb4/p5Ppx8JdlSsrzdpJKsIiy62NXcHIOlABP1Ccc85I
 8wRQ==
X-Gm-Message-State: APjAAAWPD/FjccBib+4AkK1XVewxU930K9ilcWIGj2WoR9oc3DT6scDO
 OKzsgjiiR5rVOKsQ1zpfYm0j7+8B2VZP2seb6pTOXYRaS5B8wuINGuptM0HrbNqA+6I29T7i4eV
 VuFdsKIV4XhhvSWY=
X-Received: by 2002:a1c:5401:: with SMTP id i1mr29902771wmb.99.1577663566046; 
 Sun, 29 Dec 2019 15:52:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDnn3tfb7pUMbdzg40cRRjwXxuszrDMFvO4BygMBxisoC9fbjlg/sCgkg26PIF+raA2T0qcA==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr29902759wmb.99.1577663565838; 
 Sun, 29 Dec 2019 15:52:45 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p17sm43983207wrx.20.2019.12.29.15.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Dec 2019 15:52:45 -0800 (PST)
Subject: Re: [PATCH v3 08/29] linux-user: Include trace-root.h in
 syscall-trace.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191228231124.18307-1-richard.henderson@linaro.org>
 <20191228231124.18307-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <559d8ca6-7bd5-1927-07e5-a212bbf1dece@redhat.com>
Date: Mon, 30 Dec 2019 00:52:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191228231124.18307-9-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: 9e0vlmVEMji2WfND4-wkHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/29/19 12:11 AM, Richard Henderson wrote:
> Code movement in an upcoming patch will show that this file
> was implicitly depending on trace-root.h being included beforehand.

The inlined functions call trace_guest_user_syscall[_ret] which are=20
indeed declared in the root trace-events file:

trace-events:174:vcpu guest_user_syscall(uint64_t num, ...
trace-events:183:vcpu guest_user_syscall_ret(uint64_t num, ...

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/syscall-trace.h | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
> index 9e60473643..79fd3e5aa9 100644
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -10,6 +10,8 @@
>   #ifndef _SYSCALL_TRACE_H_
>   #define _SYSCALL_TRACE_H_
>  =20
> +#include "trace-root.h"
> +
>   /*
>    * These helpers just provide a common place for the various
>    * subsystems that want to track syscalls to put their hooks in. We
>=20


