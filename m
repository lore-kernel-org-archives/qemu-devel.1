Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD21C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5808B2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SalQiKEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5808B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkjdZ-000870-Hi
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjcc-00072e-QI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:33:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29189
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkjca-0005da-8Q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 03:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592206411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sz0yD3myTTItbke3YYrKtCTmNyc7L6MO/x+kUk2UXbI=;
 b=SalQiKEJLx1878xQzrucg3A5Fl6yQUS1dfWwJCxyLPHtGOj/+wb14f0YTxCLehQY8xjmMW
 FahIOamOf4zkI81q5eIIDcfQXu7LFjqiiZ2rVdgVkUTrXiJPF9ZaXntgbI1fL6uDce8ery
 H3tpw/m/FYPhtuaY9XWow6U/UVsIVuI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-jvFO8iF6P6-7MUE5KeQ96g-1; Mon, 15 Jun 2020 03:33:27 -0400
X-MC-Unique: jvFO8iF6P6-7MUE5KeQ96g-1
Received: by mail-wm1-f71.google.com with SMTP id a7so4657422wmf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 00:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Sz0yD3myTTItbke3YYrKtCTmNyc7L6MO/x+kUk2UXbI=;
 b=qXhiBACFBjphTh/cel5S1F5RdScvwytmMkDqCreGigaBfJh10Ol8jIhEM2kHyTfI3b
 xCmNru25dT/38v9USGw/2qeKOwkas8IIkJaz3SIQxrZfVdkWSni2OwOOjmWktjh9ZP0u
 ZHXv8diTBYXNRlWkSatIHYn95+TKYz0RbF2nhdzPBU/fOUAUxbz/4n48A+ipw3A2a6K4
 win7j/ArVDBSV6jlzdyj9iW4ZSaihCGqmwrUL907TYD7QKBzIaApMF0SB6Kz8/etp9hq
 6QcvMxLLBUtOZ3FhieepjrUeQ4EwimMGX6fW99RcVy7k6kz7LNbK/XobiHbRlUXSaVQN
 gU3A==
X-Gm-Message-State: AOAM530O9HEywEoWK2e2ofb6ggzE6yefmg6AYIaYjkT0/UNOF0dd54sd
 RtjTd76tz1lHuodxsHzB9kOxo9eeuaBEmsQ55e1LgmaNBu3DEVDw12aR1wK4T2qvxoJI9Xr3VXR
 a3w6NMmZQBhVEjws=
X-Received: by 2002:adf:f789:: with SMTP id q9mr25010686wrp.251.1592206406633; 
 Mon, 15 Jun 2020 00:33:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTLoJsg/yByRsES5e2sasLDxxurKbViuErnaV78f8deFhAiEvh8hOUDmlGuClJJESWNalDhg==
X-Received: by 2002:adf:f789:: with SMTP id q9mr25010665wrp.251.1592206406418; 
 Mon, 15 Jun 2020 00:33:26 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o18sm22162120wme.19.2020.06.15.00.33.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 00:33:25 -0700 (PDT)
Subject: Re: [PATCH v3 00/11] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
To: qemu-devel@nongnu.org
References: <20200605102230.21493-1-philmd@redhat.com>
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
Message-ID: <50fc9467-205d-1ee1-d325-b26e95812084@redhat.com>
Date: Mon, 15 Jun 2020 09:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 12:22 PM, Philippe Mathieu-Daudé wrote:
> Patches 2 & 3 fix CVE-2020-13253.

Ping for the CVE fix?...

> The rest are (accumulated) cleanups.
> 
> Supersedes: <20200604182502.24228-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (11):
>   MAINTAINERS: Cc qemu-block mailing list
>   hw/sd/sdcard: Update coding style to make checkpatch.pl happy
>   hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
>   hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
>   hw/sd/sdcard: Update the SDState documentation
>   hw/sd/sdcard: Simplify cmd_valid_while_locked()
>   hw/sd/sdcard: Constify sd_crc*()'s message argument
>   hw/sd/sdcard: Make iolen unsigned
>   hw/sd/sdcard: Correctly display the command name in trace events
>   hw/sd/sdcard: Display offset in read/write_data() trace events
>   hw/sd/sdcard: Simplify realize() a bit
> 
>  hw/sd/sd.c         | 122 +++++++++++++++++++++++++++++----------------
>  MAINTAINERS        |   1 +
>  hw/sd/trace-events |   4 +-
>  3 files changed, 83 insertions(+), 44 deletions(-)
> 


