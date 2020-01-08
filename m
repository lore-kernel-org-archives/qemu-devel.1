Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C9C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F952067D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsxeX40S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F952067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8SQ-0003Az-Na
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ip8RW-0002RN-8g
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ip8RV-0006Hc-5p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:20:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ip8RV-0006HJ-29
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578478800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RyBoWiJBCGcCVZtfCvXOgqZ1bALhwvzfRBQWkDGDhZ0=;
 b=TsxeX40S/FJOqXqmbQ1obOUBAXK637bydsrmRmtT667891kIzTpsaUtStdyH0aTenMwxnM
 fVnkbhj7T6UoJTPHt9y0Ic/1+9zwsgWWEGDFTejrEprYqf3h0BZ+fuRjxMfzNUFSBupAxV
 lZkmGsoR0/TR7KSbna1mAaPpf0ms8R8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-26fmUdDmPqqESjMgw97oXw-1; Wed, 08 Jan 2020 05:19:58 -0500
Received: by mail-wr1-f72.google.com with SMTP id j13so1232732wrr.20
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MGh33mR6NswKUUpxwqC4QRAUC3uTpwR2Lqx2wgrWhLE=;
 b=aipNKrNY+jlcbTfE1opCnjgaPDjgSIWU+ckhjc6SJiNVEykosg1pePRANLxZY39eTI
 X/oViZi6WFqsIMSuiwnXnArXKy7VE2gutNPPqoGs9SK8I6lvjtWix8vAiZJQbWUKm4Vq
 81A6ry8KbHutPvo11UYCszCacAyfu1R0ZqvhB5uceo/FHHVvYaYTXfPXwiMWBSPHJ06T
 VpzkbRRy94/6xbZharpfb68l7JBmhYs9GHzlmnFdzBqD6lJPhZ/hc05J73s7f8TBa4ya
 ZayVx9IiPu3z/Czqsqc7WDKVHjFTD20Fqq9TybTvYOwxtGvttO55gNK2NHIZytVefHIo
 7vVQ==
X-Gm-Message-State: APjAAAXd5PAeNfSP5ouPxYg2GTRG8yUfrHmGos8LdUaRFPocywqxp+tl
 L7PrXxWKYjTEX5rGVrCpFZcbhQSP4kJ8DziSeRX3VAsLqEddPx10LJRHdQF42vFzhPlbwLBvtvR
 3reaHV2ZbRHiLJaM=
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2850865wmg.92.1578478797630; 
 Wed, 08 Jan 2020 02:19:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqw09wPkTE7qbwqVzc4YyGvTHKXy7oGU+OhfLnJBBVagVDaTCu839U3u/J3EnPMGTyLSfevqcg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id
 19mr2850840wmg.92.1578478797423; 
 Wed, 08 Jan 2020 02:19:57 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id k13sm3535273wrx.59.2020.01.08.02.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 02:19:56 -0800 (PST)
Subject: Re: [PATCH v2] arm/translate-a64: fix uninitialized variable warning
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200108023915.52288-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d15cbc0a-d2c6-d845-0d8b-6846d66f4c1c@redhat.com>
Date: Wed, 8 Jan 2020 11:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108023915.52288-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: 26fmUdDmPqqESjMgw97oXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 3:39 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> Fixes:
> target/arm/translate-a64.c: In function 'disas_crypto_three_reg_sha512':
> target/arm/translate-a64.c:13625:9: error: 'genfn' may be used uninitiali=
zed in this function [-Werror=3Dmaybe-uninitialized]
>      genfn(tcg_rd_ptr, tcg_rn_ptr, tcg_rm_ptr);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> qemu/target/arm/translate-a64.c:13609:8: error: 'feature' may be used uni=
nitialized in this function [-Werror=3Dmaybe-uninitialized]
>      if (!feature) {
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - add a default label to fix uninitialized warnings(suggested by Richard =
Henderson)
> ---
>   target/arm/translate-a64.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index d4bebbe629..63a3d26687 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -13585,6 +13585,8 @@ static void disas_crypto_three_reg_sha512(DisasCo=
ntext *s, uint32_t insn)
>               feature =3D dc_isar_feature(aa64_sha3, s);
>               genfn =3D NULL;
>               break;
> +        default:
> +            g_assert_not_reached();
>           }
>       } else {
>           switch (opcode) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


