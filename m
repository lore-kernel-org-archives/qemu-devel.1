Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC02C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:23:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCC8206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 06:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JffbXhAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCC8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic1ae-0002w5-8u
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 01:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic1Xt-0001Aq-5n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic1Xp-0007np-Ny
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:20:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic1Xp-0007mB-GE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 01:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575354020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IowVLIFpCNfUQQivs6ggVTO0eknpK2SZq4cU1OclQ1k=;
 b=JffbXhAvUNts6fNq377ARovhgB6NVTUXmx+2cmwkeSisLYg5Ua+wBZixg0CV0O/J9Cs2La
 ABEFwLBMmdptFr/69+iVxboiAXa7CWODICd00T//+nCxg2RI0Npdk1qg8rAgYilechV9+x
 bcaNzEI4vA47rX79fGPdLkO+Pq0sGs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-309Q-53pPfGpfCkvBI0CJw-1; Tue, 03 Dec 2019 01:20:19 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so1203432wrm.18
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 22:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jWwm6mWogocAZy961+vligZwjtpQocl6XWYfy+GpYlc=;
 b=Yx5TUGFrYLsf3hlIxskpKubQX5MnlLc3K60q3YQFoQVuOOIKuzlAZ2lOgtrDxhr/Xe
 oM8WiUEQJb64kdghslSRqHlisP20lpaeQrCrvrwLhVnksHarLXA0qYrXqKuNyezmogaM
 z0tUJBvTLpywTEm59sIIpKylmzI5YQIAwFa+xHfpVMeJ029Ro4f32x2rhDljVjFn/E0v
 jSHj7wzfCg296ix6NAkh78jEcjaVhfbVQqvvxgkE2RZ/WF98awsD20uqu2xCj9oW5D6s
 pgn2cbEUhXscfG+LmdqHNMuyDcTDKtgXSJ5GJu6xZwvDglqRF4mkTN5HSylcg4//wJ7R
 WEFA==
X-Gm-Message-State: APjAAAW1YuJqMejKmp/5gERvpxKg2n9w0UoAMGI9KRzHPJ6ITMmwyy0l
 wwY66yg+CWWuxUwjVYDv6yW0YOBbxCyH1wa7PeJEuEW4Iv32dvXco2PNLLkK4o02vyycdN6qApC
 ZePEf02LcoWBFkCQ=
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr30580693wmh.74.1575354017991; 
 Mon, 02 Dec 2019 22:20:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwN1jz6yqI+WQVL3MT0+k3G6FtfSDcpVXQfPQzBPl0jYYLp6j276JLlUVaz7J+rocY9z3GN1A==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr30580675wmh.74.1575354017742; 
 Mon, 02 Dec 2019 22:20:17 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x7sm2157117wrq.41.2019.12.02.22.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 22:20:17 -0800 (PST)
Subject: Re: [PATCH v2 4/4] ast2600: Configure CNTFRQ at 1125MHz
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
References: <20191203041440.6275-1-andrew@aj.id.au>
 <20191203041440.6275-5-andrew@aj.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb5b731d-0247-2427-60cf-35b9166f8de7@redhat.com>
Date: Tue, 3 Dec 2019 07:20:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203041440.6275-5-andrew@aj.id.au>
Content-Language: en-US
X-MC-Unique: 309Q-53pPfGpfCkvBI0CJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: joel@jms.id.au, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 5:14 AM, Andrew Jeffery wrote:
> This matches the configuration set by u-boot on the AST2600.
>=20
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed_ast2600.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931887ac681f..5aecc3b3caec 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -259,6 +259,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>           object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinit=
y(i),
>                                   "mp-affinity", &error_abort);
>  =20
> +        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq"=
,
> +                                &error_abort);
> +
>           /*
>            * TODO: the secondary CPUs are started and a boot helper
>            * is needed when using -kernel
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


