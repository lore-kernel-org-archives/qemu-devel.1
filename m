Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322E3CA9ECF
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF24E2083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQtT1uAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF24E2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQBLn-0004qT-C3
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 10:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQBAJ-0001t0-T5
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQBAG-0002VN-QG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:11:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQBAG-0002Pw-MM
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 10:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572531063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1gaEy9wcqeS02cr9UZs/fS7CG6P4K+IC6I6/NxjPgo=;
 b=dQtT1uATO/hz3YEvVTPIrJyz21wPw2L2rvsAB3dkkOTv236MEyVo4Lr0o9J6bmqkqEsczF
 ceczSRn+pzsTfQEmLhAD5crZdCZ3/wMlFzLwUCMmM6ZEjdnLsfW6Vz81pXFlOK40x2O9yh
 Vsc/kJEzf2UaitGa4iK5xvrbiy3AUUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-b3fpv-wRNSiLGQdkraH9fw-1; Thu, 31 Oct 2019 10:11:01 -0400
Received: by mail-wm1-f72.google.com with SMTP id i23so2516640wmb.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 07:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cXjnbC0nat4frL9KT8PDHBjvOMX3WcGx8DlnuviTmr4=;
 b=YhpRJ0NKD/l8qCs1EvMmNyd5Yg6sM25vSNLCWokmDe/ZmVmN81RcNphFmlwG9p/7bE
 GEpZvNRS7PuRyoB8Y/8xU9fXXWRbrAE3rTEZIl/Arr7E4F8AtAzezJbRlSgs151oDXmb
 2S5HRcIaDuMsAfQrAeOVADmoksnMjeReNvgZ0EOW81w3FlJz3mV2xJpHOMrN2A04iVVB
 1CtKAS5h4dnEk9CrN49oBxHG72Zcjm4+Z8WkulOkOttyHEGhGn4mzF2fp6AHnA94kWXp
 bK/d3XzrRWxl+kZlRPppfesrzKZrwPnVzQPfY6Z34EtxYyh1qRf57tg/NDZ0la07olc5
 lyFQ==
X-Gm-Message-State: APjAAAV9FopAx34FHH/JVLXg+50NNCFbWuQA7y+hzqBEArGDxMPbGXv6
 W3m2gyGpA10nr91tae3CuOCrlFM11ltEXyJPI29l7dIGMbsC9xTI7eGjUcn6DgPuvJNsVuS4AbI
 X5M+/vH6GwBawczA=
X-Received: by 2002:adf:d183:: with SMTP id v3mr5672743wrc.316.1572531060368; 
 Thu, 31 Oct 2019 07:11:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkpxPUcyx2krMHPZCpY0ySt3p+k9RsZ/m7tqxtLcN1LZtkW22Tp7braNOFfRKnMrxfVFKsjA==
X-Received: by 2002:adf:d183:: with SMTP id v3mr5672723wrc.316.1572531060212; 
 Thu, 31 Oct 2019 07:11:00 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id x9sm867027wru.32.2019.10.31.07.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2019 07:10:59 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] hw/arm/boot: Rebuild hflags when modifying
 CPUState at boot
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
 <20191031040830.18800-2-edgar.iglesias@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <637b245d-4d38-6b24-f118-5d4083accc76@redhat.com>
Date: Thu, 31 Oct 2019 15:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191031040830.18800-2-edgar.iglesias@xilinx.com>
Content-Language: en-US
X-MC-Unique: b3fpv-wRNSiLGQdkraH9fw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/19 5:08 AM, Edgar E. Iglesias wrote:
> Rebuild hflags when modifying CPUState at boot.
>=20
> Fixes: e979972a6a
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>   hw/arm/boot.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index c264864c11..ef6724960c 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -786,6 +786,7 @@ static void do_cpu_reset(void *opaque)
>                   info->secondary_cpu_reset_hook(cpu, info);
>               }
>           }
> +        arm_rebuild_hflags(env);
>       }
>   }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


