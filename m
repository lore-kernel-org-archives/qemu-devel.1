Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A093C2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697C92064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zc4fRFBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697C92064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNzb-0005O1-KL
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiNyo-0004pz-0I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiNyl-0005Te-MW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:30:29 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46386)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiNyl-0005QJ-F5
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:30:27 -0500
Received: by mail-wr1-x441.google.com with SMTP id z7so10439679wrl.13
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fVBS/jEpnraqYTazribvXULx/qw9cupenQEeYs0rQqk=;
 b=Zc4fRFBQu/QARyZ5C8MrHqisLy2xA+bm3BuTfeBsjK79+Bvy3cVRuyHemJkArG7rTO
 up5mfwB4sETFZyLtUzzws05Ya0hWIqaGUMe0KuUcA3JtpugEd6ELF7n9GKoPgF7R/wl6
 jOJciaPyANhdixmrCgW+A2EkKupM4a+KAyERjdhsSrM8lVuoDoVcNHW4ZXgVak2fDN7I
 6MMnFQQ96m/FFJZctSmedyOcHrnGXFRKXaVFLSAMXE2tEM3yNQYBc2Daeq6xUXztUALv
 8aBBnO+b1wrMq0agnYmdjQrhClatFVsjeV+RWYHjCR0Xj+0X1CwyvzDGy0Cgi1qGi+yZ
 XAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fVBS/jEpnraqYTazribvXULx/qw9cupenQEeYs0rQqk=;
 b=PpTEDmc8ZwtIUXBsqd153mJ4yaOtFkn9cYcUiAzl4OOM8GXfd72gz5MQatFpprzek5
 XNCjkiCpoqADAm/KctWvzK3HzAq7HvO0j2wQ4lRsDqYYuz87WLye7b1m+HjGoIblhftI
 SRTxKBAy3dQSPQxF8369rklSHYmVt7SGahuWlgak16KG44wxnOb8EVfgeyS8DvXI4sh+
 0guRVOl4ghZMcepM9sYD0RrB/ZHI/ApfiLDGyttDtDTJHpHZYuKI696FmdHTnGiG8cQp
 GYNoFyyyPsMfSvdJ6ca+eAPVAjPk8cjbr4cQbUOwq/Qu2LTzs1oZckZLY2Py/ls+jwiy
 E0qQ==
X-Gm-Message-State: APjAAAVzGm7YN2xINMZIKmOK15ILCM0QckY3s3zIXBos7ofDwjzooiHl
 9L/EzGI5pHAUrh+j5SDg/yH5mg==
X-Google-Smtp-Source: APXvYqxE4Wvrt6myEvAlFuGPgyxuFLbMVgIUyz498KDprEt5hxCqrH9NVEzwl3WnYDJ1HeBTl7Y1gg==
X-Received: by 2002:adf:fbc9:: with SMTP id d9mr17521615wrs.20.1576870226070; 
 Fri, 20 Dec 2019 11:30:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x132sm14603657wmg.0.2019.12.20.11.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 11:30:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1203E1FF87;
 Fri, 20 Dec 2019 19:30:24 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-23-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 22/28] target/xtensa: Remove MMU_MODE{0,1,2,3}_SUFFIX
In-reply-to: <20191216221158.29572-23-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 19:30:24 +0000
Message-ID: <87h81ubxrj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/xtensa/cpu.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index b363ffcf10..f5a7ea48bb 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -685,10 +685,6 @@ static inline uint32_t xtensa_replicate_windowstart(=
CPUXtensaState *env)
>  }
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _ring0
> -#define MMU_MODE1_SUFFIX _ring1
> -#define MMU_MODE2_SUFFIX _ring2
> -#define MMU_MODE3_SUFFIX _ring3
>  #define MMU_USER_IDX 3
>=20=20
>  static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)


--=20
Alex Benn=C3=A9e

