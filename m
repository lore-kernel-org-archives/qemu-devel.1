Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFAEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F5420729
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 07:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjx8gMPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F5420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9XI-0002Ss-TB
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 03:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jy9We-0001xy-DJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 03:50:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jy9Wa-00023R-MM
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 03:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595404247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XZ6mxypqj2AxcjBn/cmNvOwu1WlmcIEjXEFuKPMSxic=;
 b=gjx8gMPi/2Vc0iq9mOsPZtXiDWRBECYXtcn+wIN0aeVo3Fd06ETUopWVwKhr1XA1hourI2
 w93KduuOJ2SA6jEDjDeVOAU3HdMJ6k5Ghg3x11b/n5uNC3c+NAe5F68BXICQB66OeGxiye
 bsuCCdbCPBprd5JSDweX18JIONGNRsI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56--LYuELK7NMyI5zn53MP4Lg-1; Wed, 22 Jul 2020 03:50:45 -0400
X-MC-Unique: -LYuELK7NMyI5zn53MP4Lg-1
Received: by mail-ej1-f71.google.com with SMTP id x15so658784ejj.23
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 00:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XZ6mxypqj2AxcjBn/cmNvOwu1WlmcIEjXEFuKPMSxic=;
 b=R1G54RULmKU4tkReUVbraETtIzCjAj4C10y/ryOcLbU2Dhvv5D7furWa4SWtMMhpDA
 sr9eF5s2SAJGdtfilHsr3inkl1AXmDZ9uNKItwGzMCINIlnYe7ElPLz53YIR1JCWYv6Y
 JpOnbuDcq8ihiTd4a76OtSeLGnyJike4Je7Iwawz8EZ+aDpQ77+z5GHQEz4+PCBbtLtT
 EpU02BbVJeoCsSBlUQEG9locNNEdA95S9fSW2W9fppBCdWNHPc7ZakKBuwTPXObLBsVt
 IeuJpH2TCYXahWHgV7WX7janLME9Nv5IgyLb2y70rgnDEO6ptNcf0WjJyXfUBYbR8hb3
 3l4w==
X-Gm-Message-State: AOAM531W2X/44+9r3TIcaQn/ROk4b1UbpH2SdgQaGYzrxqBKeVbanLkR
 YlJaq3eu9SjF76w+Y0n/1Lz10IdFyruJt6fbiaow34ygbIAPE3sMVBjiBU4wU19xGr6Knzz2h2g
 vdhCxp5wMq3hH6Do=
X-Received: by 2002:a17:906:c0d9:: with SMTP id
 bn25mr28405916ejb.176.1595404243444; 
 Wed, 22 Jul 2020 00:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVJdhioaZGiY9eJokh+PeM3AOIZ+CCvPoxHHsLaJTcBgDj8RwaV+XKQNaPWSMl4u7yTwkxEg==
X-Received: by 2002:a17:906:c0d9:: with SMTP id
 bn25mr28405907ejb.176.1595404243247; 
 Wed, 22 Jul 2020 00:50:43 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id aq25sm18588298ejc.11.2020.07.22.00.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 00:50:42 -0700 (PDT)
Subject: Re: [PATCH] ehci: drop pointless warn_report for guest bugs.
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200722072613.10390-1-kraxel@redhat.com>
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
Message-ID: <4b259c5c-3d23-9dfb-2884-0c1db34d0c68@redhat.com>
Date: Wed, 22 Jul 2020 09:50:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722072613.10390-1-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:27:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 9:26 AM, Gerd Hoffmann wrote:
> We have a tracepoint at the same place which can be enabled if needed.
> 
> Buglink: https://bugzilla.redhat.com//show_bug.cgi?id=1859236
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-ehci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 1495e8f7fab1..4266765f8682 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -352,7 +352,6 @@ static void ehci_trace_sitd(EHCIState *s, hwaddr addr,
>  static void ehci_trace_guest_bug(EHCIState *s, const char *message)
>  {
>      trace_usb_ehci_guest_bug(message);
> -    warn_report("%s", message);
>  }
>  
>  static inline bool ehci_enabled(EHCIState *s)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


