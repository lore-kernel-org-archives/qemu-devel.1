Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F9FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA07D217F4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 11:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWzTWK6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA07D217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inhbr-0001mO-6F
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 06:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inhbE-0001EM-2f
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:28:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inhbC-0000X5-TF
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:28:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inhbC-0000VI-Oq
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 06:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578137286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zY2r14brKzCH/2Joyx8/lp4q80uXja67K7+2lcCRcm8=;
 b=ZWzTWK6u/TNzN7qz1Jk5kxyLughNmVRz/Fa/K7fd3b3K3xvQPCpGI77PwqT6gwJ0A/Enyx
 x9KEDpolelqePbT29VoqtUtjrQ90v6iEQ0/Fzp+K7/cVgfh/EAgg41b0X7pSePCsdugOnp
 4d+VIv2n0xmbGScknarRdNCxnKz0s8Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-IJlWs0fVPmCkuVfoWhrO1A-1; Sat, 04 Jan 2020 06:28:00 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so8041657wru.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 03:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E6OUrub1S797wS0E+tSIR/teVgzhyNjwPmtW3u/ASmQ=;
 b=m/2RCcfsfRKn5EbRTO/fhfySjzfmIcEMsIlfxBjUOS6iWjJcJJ085C3evNp95WG7Yo
 2/0pjZVjYfqbc1LV6IDQLiDlM0+b+KrR0VTMl2m2wmaiTjL+OEZJk2DEFxFcfz/h4efr
 DClvIrnXR4xDDvvjZ2bLdFGOI0La3RFRZl0/CiVDUGC3F2sE+bR1xwC4RL/sBxhsQ4Y+
 UjK1+ZOrO+/P5d69QF7VGgIrvKpcbJqhLa9bdXHsG+Sr7osRdqxt62Yxj/Napqi+qGWS
 eIYgu9+MaC6Bg6jY2t6pR2mnR4GJ9OQBVAwTuiluCU+g9tx7hWapNTvIhxfK0ASJXHIg
 47Mw==
X-Gm-Message-State: APjAAAXdxqTVaBmenB0XRCqbznoMUlP881IsV4ygIP0wi6itXYm7xo0B
 5d18XlvumOes7QUdxRgZf5ulMWFCnsSCQq7Z5VTIVJwR868j70R+MWiw+bobdG2Yf27y/9f7PbU
 m0dYlpeTai+RWcNA=
X-Received: by 2002:a1c:a982:: with SMTP id
 s124mr23960490wme.132.1578137279819; 
 Sat, 04 Jan 2020 03:27:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTfGyxwX5tmV2SXhl1vCl6LlWM4ANkepqjPSz/eZFGT4xzhy4n/58EkEVEG8+YMdL1SoPS+g==
X-Received: by 2002:a1c:a982:: with SMTP id
 s124mr23960478wme.132.1578137279623; 
 Sat, 04 Jan 2020 03:27:59 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x11sm15348026wmg.46.2020.01.04.03.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 03:27:58 -0800 (PST)
Subject: Re: [PATCH 3/3] capstone: Add skipdata hook for s390x
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200103212500.14384-1-richard.henderson@linaro.org>
 <20200103212500.14384-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <15f5ba38-65d9-210d-22f8-a538e792a90a@redhat.com>
Date: Sat, 4 Jan 2020 12:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103212500.14384-4-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: IJlWs0fVPmCkuVfoWhrO1A-1
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/3/20 10:25 PM, Richard Henderson wrote:
> Capstone assumes any s390x unknown instruction is 2 bytes.
> Instead, use the ilen field in the first two bits of
> the instruction to stay in sync with the insn stream.
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   disas.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>=20
> diff --git a/disas.c b/disas.c
> index 845c40fca8..1095bad049 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -178,6 +178,39 @@ static int print_insn_od_target(bfd_vma pc, disassem=
ble_info *info)
>      to share this across calls and across host vs target disassembly.  *=
/
>   static __thread cs_insn *cap_insn;
>  =20
> +/*
> + * The capstone library always skips 2 bytes for S390X.
> + * This is less than ideal, since we can tell from the first two bits
> + * the size of the insn and thus stay in sync with the insn stream.
> + */
> +static size_t CAPSTONE_API
> +cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
> +                      size_t offset, void *user_data)
> +{
> +    size_t ilen;
> +
> +    /* See get_ilen() in target/s390x/internal.h.  */
> +    switch (code[offset] >> 6) {
> +    case 0:
> +        ilen =3D 2;
> +        break;
> +    case 1:
> +    case 2:
> +        ilen =3D 4;
> +        break;
> +    default:
> +        ilen =3D 6;
> +        break;
> +    }
> +
> +    return ilen;
> +}
> +
> +static const cs_opt_skipdata cap_skipdata_s390x =3D {
> +    .mnemonic =3D ".byte",
> +    .callback =3D cap_skipdata_s390x_cb
> +};
> +
>   /* Initialize the Capstone library.  */
>   /* ??? It would be nice to cache this.  We would need one handle for th=
e
>      host and one for the target.  For most targets we can reset specific
> @@ -208,6 +241,10 @@ static cs_err cap_disas_start(disassemble_info *info=
, csh *handle)
>  =20
>       /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
>       cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
> +    if (info->cap_arch =3D=3D CS_ARCH_SYSZ) {
> +        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
> +                  (uintptr_t)&cap_skipdata_s390x);
> +    }
>  =20
>       /* Allocate temp space for cs_disasm_iter.  */
>       if (cap_insn =3D=3D NULL) {
>=20


