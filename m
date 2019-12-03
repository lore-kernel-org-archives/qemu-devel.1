Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137BEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2C4D206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6PtMA+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49161 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1lO-0002Ft-1k
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1hK-0007eT-Tt
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:30:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1hI-0007J4-Na
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:30:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53190
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1hI-0007CJ-Hz
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhgKQ7PSjxzxG+ZCagR/Excy7EMvYaMER9oxDyGY8Kg=;
 b=d6PtMA+7FZ9cwL4NraWM4gcsUo34CoXvkJPNvrfLBAnZXGIQVVAQ8vtg4alBUJBtqfzZcA
 q9mr3VcWjbYjWXTDcYOePMv7Hlad1aTiO2pcwA7qxlWCRoO8Vl3wE4ZRWXdKjXOqmQwwp9
 X0JSNdwPCOJnPTx0m7k6Tehq3Z2Benc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-U0rUqiO0Op-WtpiSmt3s8g-1; Tue, 03 Dec 2019 01:30:05 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so960200wmg.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OGVUA6CUfLD/Wf1tobX3x3tudHKAT+YBlN2TfC/HIGg=;
 b=RD3G/wxlxSNlrjEwwDNJ5ToRwhBDlgvUkGFGnJ4yyr0yhQd9icEFyVEf5BZQn0VVcf
 G8lo2ak86RSU68vjFSRAvKJgEKtbk5C1SC+oHpC4jB0+GKgnBaMVqENCtO95ph10HN8L
 n/w8v7iAaqFbrbtgiRcTFJQpJc54jBwyEh93zow0RJuv7JmDWJXl/zFnxE/pX9JD4E2l
 nfldQfWxNha3jR0cMxPA+1zhfQIq76l4svf0/HyPYQT9ESkKAUk3844jOu8NGPz3tYBC
 U8IG9vfvkncyX/AyDB3nmqRdRjHSg8BluHE01ciAN2gI/DwJjih/YROOTj/B9CIWZdHV
 uvsQ==
X-Gm-Message-State: APjAAAWxcueL7Vr0yDZX8YwC7EiYXiAXoKJCTwiFl3YWETiS3QKuga7Q
 D5xBRYQnry1je+gdphWl9GqqmQgIxjvBLONFQL1Wf8nyhBWAHpaU/0/QCCSFx4nXLY3pKA8Zo6F
 99H7uePOa6Yfmb4s=
X-Received: by 2002:a1c:2745:: with SMTP id n66mr32163729wmn.171.1575354604079; 
 Mon, 02 Dec 2019 22:30:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYW52xpvwLVkbXeJgMCHoUH8NV3MmmR52Y5mB3LuXMeLPr86NAKyLdk4hc2ShchWmzOKOihA==
X-Received: by 2002:a1c:2745:: with SMTP id n66mr32163720wmn.171.1575354603885; 
 Mon, 02 Dec 2019 22:30:03 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id p10sm1766642wmi.15.2019.12.02.22.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:30:03 -0800 (PST)
Subject: Re: [PATCH v4 39/40] target/arm: Use bool for unmasked in
 arm_excp_unmasked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-40-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <205287d7-3562-3d9b-931c-e2841d02119a@redhat.com>
Date: Tue, 3 Dec 2019 07:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203022937.1474-40-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: U0rUqiO0Op-WtpiSmt3s8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 3:29 AM, Richard Henderson wrote:
> The value computed is fully boolean; using int8_t is odd.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   target/arm/cpu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7a1177b883..a366448c6d 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -417,7 +417,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, un=
signed int excp_idx,
>   {
>       CPUARMState *env =3D cs->env_ptr;
>       bool pstate_unmasked;
> -    int8_t unmasked =3D 0;
> +    bool unmasked =3D false;
>  =20
>       /*
>        * Don't take exceptions if they target a lower EL.
> @@ -468,7 +468,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, un=
signed int excp_idx,
>                * don't affect the masking logic, only the interrupt routi=
ng.
>                */
>               if (target_el =3D=3D 3 || !secure) {
> -                unmasked =3D 1;
> +                unmasked =3D true;
>               }
>           } else {
>               /*
> @@ -514,7 +514,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, un=
signed int excp_idx,
>               }
>  =20
>               if ((scr || hcr) && !secure) {
> -                unmasked =3D 1;
> +                unmasked =3D true;
>               }
>           }
>       }
>=20


