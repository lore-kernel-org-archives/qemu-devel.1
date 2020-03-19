Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE600C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799E320739
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 11:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPFzDd9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799E320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEtA4-00062x-MV
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 07:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEt92-0005Tv-Uo
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEt91-0007FO-R4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:15:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEt91-0007EX-Nt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 07:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584616523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YHPvCmLID+CEAVQ4/6AcmlTdR88fDjSn3DnnO8KMvU=;
 b=OPFzDd9JIWz+/D+klIYnTpGwFRq4DIkxjwHHERuHsG3g9AJeak3PgEXVfAJR8Ks1/OyQ4J
 uwkLxEEiH/f9/WN+ALvfcaNWuoRfX8nvaKh73/oay0N3qcHdb6Jg0kjJlV5x4GlZD1fUJO
 bWN0gSXhkZ6sjYwzeUtWieTqXDl41F4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-4_rHBBWoM7OH-BwhS4uP2A-1; Thu, 19 Mar 2020 07:15:21 -0400
X-MC-Unique: 4_rHBBWoM7OH-BwhS4uP2A-1
Received: by mail-ed1-f71.google.com with SMTP id p17so1615390edt.20
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 04:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2maYGDADzVdZsRNoaEEgsyBXbBdJWOML0KYXRN+zzmE=;
 b=UaS5QFbUHV8gTxpA1/e/7rL1C3Vo9JMsv+/s+JOGUajSGZTwzO/N0TO8jafJ8snRod
 86noLingQ14DH4QMrO+fFNgfzH4E52UK52pHvgxP1bLjLLFodQZvBW3K0F9TJaZl2dGm
 iYK6FH6zeN12DXOQ3+L85kUbImWfo2FjNTx/r+K20ub9/qafPEU5QKucAADDXO74zS7m
 IJ554JdCyEeUZaptBah/TBrgq06JggF84pHtUxLa3Nv7cg2Qzol/1Gt7ZsS6Ykewng7H
 2QccG8nIWoclXUhsyq8eeE2KuVOjoC0Tj/BOnd9QcYjcfGxe91iFfC0iisuVEcQWGctG
 0NJg==
X-Gm-Message-State: ANhLgQ1GlY0vqb9e6q7zYzGiOHVul+ZvfNiPdZqJhXGeXcs2axyXFywY
 9dxIlfd/ge+5Yej/lpYeADiQXhN1+09StgwXKIrvaBDVgp7+LLuOF+zLnJR37AsGt4E3gTVukKM
 IuPzulNJCwqSIRUY=
X-Received: by 2002:a17:906:1308:: with SMTP id
 w8mr2606442ejb.156.1584616520087; 
 Thu, 19 Mar 2020 04:15:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vteiiZQ6Mk3m6nyoHryXMR5mnZkjF7jLlqh0T6xjQhAbkzOjaAJNvkkBf0AUrEaIZa8qDaiWw==
X-Received: by 2002:a17:906:1308:: with SMTP id
 w8mr2606420ejb.156.1584616519894; 
 Thu, 19 Mar 2020 04:15:19 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b20sm109068edt.93.2020.03.19.04.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 04:15:19 -0700 (PDT)
Subject: Re: [PATCH v2 03/12] tests/Makefile: Only display TCG-related tests
 when TCG is available
To: qemu-devel@nongnu.org
References: <20200315235716.28448-1-philmd@redhat.com>
 <20200315235716.28448-4-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2c06cd8-b5eb-13a5-a9dc-7d0f592d65be@redhat.com>
Date: Thu, 19 Mar 2020 12:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200315235716.28448-4-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch might be worth for 5.0 too.

On 3/16/20 12:57 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/Makefile.include | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 67e8fcddda..99db5eb3e0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -12,8 +12,10 @@ check-help:
>   =09@echo " $(MAKE) check-speed          Run qobject speed tests"
>   =09@echo " $(MAKE) check-qapi-schema    Run QAPI schema tests"
>   =09@echo " $(MAKE) check-block          Run block tests"
> +ifeq ($(CONFIG_TCG),y)
>   =09@echo " $(MAKE) check-tcg            Run TCG tests"
>   =09@echo " $(MAKE) check-softfloat      Run FPU emulation tests"
> +endif
>   =09@echo " $(MAKE) check-acceptance     Run all acceptance (functional)=
 tests"
>   =09@echo
>   =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP tes=
t report"
>=20


