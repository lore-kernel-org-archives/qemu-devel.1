Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB05C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AA2620774
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF6BIFCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA2620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFYC-0000ia-Lf
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqFT6-0001WT-IT
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59802
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqFT4-0004Dt-PG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IjMJuEgYsSN0eOpc2ZLoRi3yLlgvU7cc2ZvlJtTYZGI=;
 b=EF6BIFCK8vNQpa0yZALZGvwype3Ffzdx6QZtD3Qpup6nX8vkvKN977plaLBd52WwFocegg
 6fJzGPUxm99rRqWBrgGlp5suFEJQiq0fbgWutKEE+l9ksl2wzbGTV1sFDm0GzJThHtwz0n
 2xjhBN/gYl/0LSvTlY3SqVMLc0AtF2k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Q9Dr6A9XNVy8k-F39hDbtw-1; Tue, 30 Jun 2020 08:34:28 -0400
X-MC-Unique: Q9Dr6A9XNVy8k-F39hDbtw-1
Received: by mail-ed1-f71.google.com with SMTP id y92so12277385eda.12
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IjMJuEgYsSN0eOpc2ZLoRi3yLlgvU7cc2ZvlJtTYZGI=;
 b=M4gJcgZMs13WW/CiFu411McHsghtyiYDrxKQKuRKAzJ1/GmfVT7g6lOEMR57TP7TV7
 4B9fDsFmP9Os645Yl6pJ1eMpDVy/ROfVSkUGlVEXvSokRTylvJxii7eug/9fxqOdu6R9
 Bwns5uCPgLW3AbwbAZ+9ZJuZZTl/7cT4MRssbDLPA2UpeNHNPYOf/u0olHLbTPPGdMzR
 gDbZTdyFzfCXgbVksdU8+NNq/fblbV8XM8Kadls7gO3VXzWH8VY/yPunGIU9KJEA0pty
 pFw7KPWFisLWru9Bi+TMVQMBoFm2LmCPa/aI45GYnCbDIr2XhUNM6MAK0cQAWOS+6wyq
 UZKg==
X-Gm-Message-State: AOAM530zOCPondDi8a8/2La80Y9/U1yfJJF3V6JERrtBGeGoXvGViOQA
 nLG/z5XuwdkAoLMk0evkEN6wLKcEF1z72kvFuR/7cmanumqwt8ZPAKL7xlaRFvFBPFZfcfdTou9
 wW5W4gzVctETjcTE=
X-Received: by 2002:a05:6402:cb9:: with SMTP id
 cn25mr10668448edb.247.1593520467390; 
 Tue, 30 Jun 2020 05:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/fGJM+FT4Irhtqe/T0LJwdC2tcpm5EpPctLncpdS2BYUb+wHDH9s3d2EZDOa+wPFJluCqig==
X-Received: by 2002:a05:6402:cb9:: with SMTP id
 cn25mr10668432edb.247.1593520467218; 
 Tue, 30 Jun 2020 05:34:27 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d2sm2744011edk.4.2020.06.30.05.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 05:34:26 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] tz-ppc: add dummy read/write methods
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-8-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ca90d458-cb57-8ed2-91f3-fbcb63c7cd1b@redhat.com>
Date: Tue, 30 Jun 2020 14:34:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630122710.1119158-8-ppandit@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 2:27 PM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Add tz-ppc-dummy mmio read/write methods to avoid assert failure
> during initialisation.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/misc/tz-ppc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> Update v3: use g_assert_not_reached()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09451.html
> 
> diff --git a/hw/misc/tz-ppc.c b/hw/misc/tz-ppc.c
> index 6431257b52..36495c68e7 100644
> --- a/hw/misc/tz-ppc.c
> +++ b/hw/misc/tz-ppc.c
> @@ -196,7 +196,21 @@ static bool tz_ppc_dummy_accepts(void *opaque, hwaddr addr,
>      g_assert_not_reached();
>  }
>  
> +static uint64_t tz_ppc_dummy_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static void tz_ppc_dummy_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    g_assert_not_reached();
> +}
> +
>  static const MemoryRegionOps tz_ppc_dummy_ops = {
> +    /* define r/w methods to avoid assert failure in memory_region_init_io */
> +    .read = tz_ppc_dummy_read,
> +    .write = tz_ppc_dummy_write,
>      .valid.accepts = tz_ppc_dummy_accepts,
>  };
>  
> 


