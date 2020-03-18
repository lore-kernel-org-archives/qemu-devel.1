Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35B6C5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCF72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyN0Knu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCF72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEW0B-0005to-S9
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 06:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEVzT-0005Ui-Bd
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEVzQ-0007BI-Jg
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:31:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEVzQ-00078l-8c
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 06:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584527515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WiApycqOKt9PAZe3ZKRpGr+KSowD5eTMDh6PhXhCW7I=;
 b=FyN0Knu8fEt1JGUnJSelXqCKzdiLaeVoQ6L6P9UvPblB0Jed5vQh+OXhoMKCh/7QPHrKEI
 b4RLqWxBbM8e+TMzKcFOtSEzwJbTNJLvo8arpDKW3llWj4+Mc+JiX+wNK9EJHAFZ5VwHw8
 2N7r4HKKT+t2YOqaIWSMfqlIr55RVgE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-OLlPNCYvPGKJMYjpFXzYig-1; Wed, 18 Mar 2020 06:31:53 -0400
X-MC-Unique: OLlPNCYvPGKJMYjpFXzYig-1
Received: by mail-wr1-f72.google.com with SMTP id v7so2675100wrp.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uDvpPXXMu4Tf9uDcfCRCl3rMHI8aDrXRoEwJ1iRAPvg=;
 b=b2xS54UpaiFzSOkalwrSeD3Teyi5drXhQRF1IHpqLO0WOqpLrj/mmBz1OwOoCVAOIE
 T8qINNuNzdFS3mBnBx2j6DTXkhA8P+o14GS9pIGWPf0Szor7b4z/pQgZZfPV4p+eOyxY
 woZZlr2daFx7aQt/Qjc+9CeKxUR0om285HpJvXxyBkBH1ZY3GlFv1kzMhGyXDuUymJ24
 t7MPTsaW1811N/RmifKPU0qhsFUJBvrYE5rY7t1QmZDJDgCRPOd5CQ4FcUNLv24OxBiR
 IqEy7bHiKdT+08G28+V1ir4XED2hiQyMqHCZTKewJlTM9Tt1nkXA2k2OR5uJ8KQk8AtS
 JzMg==
X-Gm-Message-State: ANhLgQ0KW9UwLGPEANL80J1diwYaIJl9NhlLCnGAbPLTTu5LAZ+7D/PK
 eq37J4qBkQogt977RzW/zfEsvqs3XqvA0HIovvdCR1e8HCvJc3a6k+YwzEUgJLJWGOANYbq5VFV
 i1bhEkKLuFPHeew0=
X-Received: by 2002:adf:f285:: with SMTP id k5mr5110799wro.175.1584527512437; 
 Wed, 18 Mar 2020 03:31:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuQfAv8cH5BD3ftfz6LWmq1LpH+gHcW+8siWIa0Hwo68RxVXO5bBV4L81CKN/0V/z3D7u5WgA==
X-Received: by 2002:adf:f285:: with SMTP id k5mr5110764wro.175.1584527512156; 
 Wed, 18 Mar 2020 03:31:52 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id s7sm8580565wri.61.2020.03.18.03.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 03:31:51 -0700 (PDT)
Subject: Re: [PATCH 09/11] target/mips: Always enable CONFIG_SEMIHOSTING
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-10-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d07835cf-1021-7399-a28d-09a4a4c225ef@redhat.com>
Date: Wed, 18 Mar 2020 11:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-10-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/03/20 13:00, Philippe Mathieu-Daud=C3=A9 wrote:
> diff --git a/default-configs/mips-linux-user-common.mak b/default-configs=
/mips-linux-user-common.mak
> new file mode 100644
> index 0000000000..04947706e8
> --- /dev/null
> +++ b/default-configs/mips-linux-user-common.mak
> @@ -0,0 +1,4 @@
> +# Common mips*-linux-user CONFIG defines
> +
> +# CONFIG_SEMIHOSTING is always required on this architecture
> +CONFIG_SEMIHOSTING=3Dy

If it is always required, it should be select-ed.

Same for patch 10.

Paolo


