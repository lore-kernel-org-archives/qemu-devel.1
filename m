Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D0DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35D1206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QED/MzvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35D1206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1gD-00066d-T9
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1ea-000596-T3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1eZ-0002HI-Rh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:27:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1eZ-0002FT-Me
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxBLUfB0sh+dQHqvwrrkXsoAFeGxFKUJUiSZ9VYn4+0=;
 b=QED/MzvI4crtaoRDMqYH9ra1zWD/7d5VLku2eVM20M8WUGaiNhxC1j+MlgLYVb/81nu/Jt
 V1KYcoR7ULJMYU54yo+Qe6QxKho1dCQuXq1MtOGXbWEdYpdXs7ScH/cc/bylF6uHOU6Uxn
 5SF/I91jcsKNw+YMa2PVlqiscBHV/pk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-bUffgAY8Mle2fWwl4jl0Qw-1; Tue, 03 Dec 2019 01:27:17 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so1208338wrm.23
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y0bL3BL6zdEt6o0B9Q5lMqRUmGlrmw5R3Y2yB4RLPxI=;
 b=URLyg4Tjk57nbejoBRMv/jSsb5l0CroF1ROLSQGWA++2YkA+WWqRAmPLUaOxVhF9sG
 BK09T3NwdTRU6d0oVl3y46tZCUMNfRh82MqWcFiII+qcg/uFyix4X3YPaEiuJENTIdw7
 YvSMvyvrEeDkgjRuEUgj/h2J6oVyBK1kMlM0JuN8z8n6/n1g1ByVTuapUyqef8MWGF5A
 rN6AxYfFxf2kwqQHEIsJkn26iDI5Q1yWOOBIy1SlP39QUljOAdBbAnKTMKXhyBBQdzQP
 8bIxAPmFfj1pALWpS6I5u3jmEbnvmkbyhtP2UcJJgVcvSR1zmYA/GN4JLLqI4riIWDnp
 od1A==
X-Gm-Message-State: APjAAAVVfnzuRowyHmT7IcwGVuaGshv1qJ8VEm8AC3NQf/+oiaYWDevj
 JQfCroas42PJdxwY/EDvpbVGgdpnjNzn14MtWs/uoo22eGLhBbgvMDM+NXGdoC2erQSBdwmwrq9
 9BcDYhnf1fLMGDI0=
X-Received: by 2002:adf:90e7:: with SMTP id i94mr3063649wri.47.1575354436870; 
 Mon, 02 Dec 2019 22:27:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoduBj0mpuI+Snm22CsFF4YNa3J2yPOpWCDbWTik7vwq1qgfTkbXqbF41UWVXqCjgLEAixrw==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr3063637wri.47.1575354436709; 
 Mon, 02 Dec 2019 22:27:16 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id b17sm2260660wrx.15.2019.12.02.22.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:27:16 -0800 (PST)
Subject: Re: [PATCH v4 17/40] target/arm: Tidy ARMMMUIdx m-profile definitions
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d9a0d67-e852-8590-8937-090b67e34c55@redhat.com>
Date: Tue, 3 Dec 2019 07:27:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-18-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: bUffgAY8Mle2fWwl4jl0Qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> Replace the magic numbers with the relevant ARM_MMU_IDX_M_* constants.
> Keep the definitions short by referencing previous symbols.

Nice trick :)

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 6ba5126852..015301e93a 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2871,14 +2871,14 @@ typedef enum ARMMMUIdx {
>       ARMMMUIdx_SE0 =3D 4 | ARM_MMU_IDX_A,
>       ARMMMUIdx_SE1 =3D 5 | ARM_MMU_IDX_A,
>       ARMMMUIdx_Stage2 =3D 6 | ARM_MMU_IDX_A,
> -    ARMMMUIdx_MUser =3D 0 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MPriv =3D 1 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MUserNegPri =3D 2 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MPrivNegPri =3D 3 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSUser =3D 4 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSPriv =3D 5 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSUserNegPri =3D 6 | ARM_MMU_IDX_M,
> -    ARMMMUIdx_MSPrivNegPri =3D 7 | ARM_MMU_IDX_M,
> +    ARMMMUIdx_MUser =3D ARM_MMU_IDX_M,
> +    ARMMMUIdx_MPriv =3D ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
> +    ARMMMUIdx_MUserNegPri =3D ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
> +    ARMMMUIdx_MPrivNegPri =3D ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
> +    ARMMMUIdx_MSUser =3D ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
> +    ARMMMUIdx_MSPriv =3D ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
> +    ARMMMUIdx_MSUserNegPri =3D ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
> +    ARMMMUIdx_MSPrivNegPri =3D ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
>       /* Indexes below here don't have TLBs and are used only for AT syst=
em
>        * instructions or for the first stage of an S12 page table walk.
>        */
>=20


